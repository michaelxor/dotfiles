#!/bin/bash
#
# Tails - The Amnesic Incognito Live System
#
# This script will grab the tails iso image, attempt to verify
# its authenticity, and write the image to an available USB
# flash drive.

run_tails() {
    # this will require gpg to verify the authenticity of tails download
    if ! type_exists 'gpg2'; then
        if type_exists 'brew'; then
            e_header "Installing GnuPG2..."
            brew install gpg2
        else
            printf "\n"
            e_error "Error: GnuPG and Homebrew not found."
            printf "Aborting...\n"
            exit
        fi
    fi

    # we'll just do this all in a tails dir for now
    TAILS_DIR=${HOME}/tails
    if [[ ! -e ${TAILS_DIR} ]]; then
        mkdir ${TAILS_DIR}
    fi
    cd ${TAILS_DIR}

    # grab the tails iso and other resources if necessary
    TAILS_VERSION=0.22
    ISO_URL_BASE=http://dl.amnesia.boum.org/tails/stable/tails-i386-${TAILS_VERSION}/tails-i386-${TAILS_VERSION}.iso
    SIG_URL_BASE=https://tails.boum.org/torrents/files/tails-i386-${TAILS_VERSION}.iso.sig
    KEY_URL_BASE=https://tails.boum.org/tails-signing.key

    if [[ ! -e tails-i386-${TAILS_VERSION}.iso ]]; then
        e_header "Downloading Tails ${TAILS_VERSION}..."
        curl -LO $ISO_URL_BASE
    fi

    if [[ ! -e tails-i386-${TAILS_VERSION}.iso.sig ]]; then
        e_header "Downloading Tails ${TAILS_VERSION} Signature..."
        curl -LO $SIG_URL_BASE
    fi

    if [[ ! -e tails-signing.key ]]; then
        e_header "Downloading Tails Signing Key..."
        curl -LO $KEY_URL_BASE
    fi

    e_header "Importing Tails Signing Key..."
    cat tails-signing.key | gpg2 --keyid-format long --import

    e_header "Verfiying Tails ${TAILS_VERSION} ISO..."
    gpg2 --keyid-format long --verify tails-i386-${TAILS_VERSION}.iso.sig tails-i386-${TAILS_VERSION}.iso

    seek_confirmation "Would you like to continue with this ISO?"

    if is_confirmed; then
        if [[ ! -e tails-i386-${TAILS_VERSION}.dmg ]]; then
            e_header "Converting ISO to IMG"
            hdiutil convert tails-i386-${TAILS_VERSION}.iso -format UDRW -o tails-i386-${TAILS_VERSION}
        fi

        e_header "Listing Drives:"
        diskutil list

        printf "\n"
        read -p "Which is your USB flash drive? Type the number only (/dev/diskN): " -n 1 num
        DRIVE="/dev/disk${num}"

        seek_confirmation "Preparing to use ${DRIVE}..."

        if is_confirmed; then
            e_header "Unmounting drive..."
            diskutil unmountDisk ${DRIVE}

            e_header "Copying Tails ${TAILS_VERSION} image to drive..."
            sudo dd if=tails-i386-${TAILS_VERSION}.dmg of=${DRIVE} bs=1m

            e_header "Ejecting drive..."
            diskutil eject ${DRIVE}

            [[ $? ]] && e_success "Done"
        else
            printf "Aborting USB image creation...\n"
        fi
    else
        printf "Skipped USB Drive formatting..."
    fi
}

source ${HOME}/.dotfiles/lib/utils

run_tails
