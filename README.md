# Dotfiles (adopted from Nicolas Gallagher)

I forked Nicolas Gallagher's [dotfiles](https://github.com/necolas/dotfiles),
and merged them with Zach Holman's [dotfiles](https://github.com/holman/dotfiles)
which is a more component based approach.


## How to install

The installation step requires the [XCode Command Line
Tools](https://developer.apple.com/downloads) and may overwrite existing
dotfiles in your HOME and `.vim` directories.

```bash
$ bash -c "$(curl -fsSL raw.github.com/michaelxor/dotfiles/master/bin/dotfiles)"
```

N.B. If you wish to fork this project and maintain your own dotfiles, you must
substitute my username for your own in the above command and the 2 variables
found at the top of the `bin/dotfiles` script.

## How to update

You should run the update when:

* You make a change to `~/.dotfiles/git/gitconfig` (the only file that is
  copied rather than symlinked).
* You want to pull changes from the remote repository.
* You want to update Homebrew formulae, Node packages, or Python packages.

Run the dotfiles command:

```bash
$ dotfiles
```

Options:

<table>
    <tr>
        <td><code>-h</code>, <code>--help</code></td>
        <td>Help</td>
    </tr>
    <tr>
        <td><code>-l</code>, <code>--list</code></td>
        <td>List of tools installed by the dotfiles script</td>
    </tr>
    <tr>
        <td><code>--no-sync</code></td>
        <td>Suppress pulling from the remote repository</td>
    </tr>
    <tr>
        <td><code>--no-packages</code></td>
        <td>Suppress Homebrew package updates</td>
    </tr>
    <tr>
        <td><code>--no-cask</code></td>
        <td>Suppress Homebrew Cask intall</td>
    </tr>
    <tr>
        <td><code>--no-node</code></td>
        <td>Suppress Node.js install &amp; npm package updates</td>
    </tr>
    <tr>
        <td><code>--no-py</code></td>
        <td>Suppress Python install &amp; pip package updates</td>
    </tr>
    <tr>
        <td><code>--no-ruby</code></td>
        <td>Suppress RVM/Ruby install &amp; gem updates</td>
    </tr>
    <tr>
        <td><code>--no-php</code></td>
        <td>Suppress PHP install</td>
    </tr>
</table>


## Components

Each component has an associated <code>requirements.txt</code> file.
Add or remove packages from these files and the associated package
manager will install and update accordingly.

Any file named <code>*.bash</code> inside of a component folder will be
automatically picked up loaded into your environment.  I'm following [Zach Holman's approach](https://github.com/holman/dotfiles#components) as follows:

* **component/\*.bash**: Any files ending in `.bash` get loaded into your
  environment.
* **component/path.bash**: Any file named `path.bash` is loaded first and is
  expected to setup `$PATH` or similar.
* **component/completion.bash**: Any file named `completion.bash` is loaded
  last and is expected to setup autocomplete.
* **component/\*.symlink**: Will be symlinked to your home directory minus
  the .symlink suffix.

### Homebrew

Homebrew is recommended as most of the other components depend on utilities
installed during this step.

* [GNU core utilities](http://www.gnu.org/software/coreutils/)
* [git](http://git-scm.com/)
* [svn](http://subversion.apache.org/)
* [ack](http://betterthangrep.com/)
* bash (latest version)
* [bash-completion](http://bash-completion.alioth.debian.org/)
* [ffmpeg](http://ffmpeg.org/)
* [graphicsmagick](http://www.graphicsmagick.org/)
* jpeg
* [macvim](http://code.google.com/p/macvim/)
* [optipng](http://optipng.sourceforge.net/)
* [phantomjs](http://phantomjs.org/)
* rsync (latest version, rather than the out-dated OS X installation)
* [tree](http://mama.indstate.edu/users/ice/tree/)
* [wget](http://www.gnu.org/software/wget/)
* [grc](http://korpus.juls.savba.sk/~garabik/software/grc.html)

Homebrew also installs each of the following unless their respective
component is suppressed:

* [cask](https://github.com/phinze/homebrew-cask/)
* [node](http://nodejs.org/)
* [python](http://www.python.org/)
* python3

### Homebrew Cask

Homebrew Cask can install Mac GUI applications.  Apps installed this way
are collected in <code>/opt/homebrew-cask/Caskroom</code> instead of
<code>/Applications</code> or <code>~/Applications</code>.  If Alfred is
installed, the Caskroom directory is automatically linked to Alfred so these apps will be indexed.

* [google-chrome](https://www.google.com/intl/en/chrome/browser/)
* [google-chrome-canary](https://www.google.com/intl/en/chrome/browser/canary.html)
* [firefox](https://www.mozilla.org/en-US/firefox/new/)
* [firefox-aurora](http://www.mozilla.org/en-US/firefox/aurora/)
* [alfred](http://www.alfredapp.com/)
* [dropbox](https://www.dropbox.com)
* [droplr](https://droplr.com/)
* [iterm2](http://www.iterm2.com/)
* [dash](http://kapeli.com/dash)
* [sublime-text3](http://www.sublimetext.com/3)
* [sequel-pro](http://www.sequelpro.com/)
* [skype](http://www.skype.com/en/)

As well as some really handy [Quick Look Plugins from Sindre Sorhus](https://github.com/sindresorhus/quick-look-plugins).

* [qlcolorcode](https://code.google.com/p/qlcolorcode/)
* [qlstephen](http://whomwah.github.io/qlstephen/)
* [qlmarkdown](https://github.com/toland/qlmarkdown)
* [quicklook-json](http://www.sagtau.com/quicklookjson.html)
* [qlprettypatch](https://github.com/atnan/QLPrettyPatch)
* [quicklook-csv](https://github.com/p2/quicklook-csv)
* [betterzipql](http://macitbetter.com/BetterZip-Quick-Look-Generator/)
* [webp-quicklook](https://github.com/dchest/webp-quicklook)
* [suspicious-package](http://www.mothersruin.com/software/SuspiciousPackage/)

### Node

Node packages are installed via npm.  The packages in this list are
installed globally, so you may want to keep this list to things you
plan on using from the command line.

* [bower](http://bower.io/)
* [gify](https://github.com/visionmedia/node-gify)
* [grunt-cli](http://gruntjs.com/)
* [jshint](http://www.jshint.com/)
* [karma](http://karma-runner.github.io/)
* [yo](http://yeoman.io/)

### Python

The latest Python 2.x and 3.x branches are installed via Homebrew, and
they are bundled with pip. <code>virtualenv</code>,
<code>virtualenv-clone</code>, and <code>pew</code> are installed
globally via pip.  The contents of <code>requirements.txt</code> are
then installed via pip to a new clean virtualenv.

For those unfamiliar with pew, it is an alternative to
virtualenvwrapper for managing multiple virtualenvs.  It also
provides an [alternative method](https://gist.github.com/datagrok/2199506) to activate virtual environments
instead of the traditional activate/deactivate.

pip and pew are both configured to use ~/.virtualenvs as
the default for new virtual environments.

* [virtualenv](http://www.virtualenv.org/en/latest/)
* [virtualenv-clone](https://github.com/edwardgeorge/virtualenv-clone)
* [pew](https://github.com/berdario/invewrapper)

These are installed into your default virtualenv:

* [django](https://www.djangoproject.com/)
* [ipython](http://ipython.org/)

*Functions*
```bash
$ check_virtualenv
```
Checks the current directory for existence of a .venv file. If
it exists and its contents name an exsiting virtualenv, that
virtualenv will be activated

```bash
$ venv_cd <path>
```
Performs a cd and then calls check_virtualenv

### Ruby

The latest stable RVM is installed with the latest Ruby.  The contents
of <code>requirements.txt</code> are assumed to be gems and are installed
to the default rvm environment.

* [sass](http://sass-lang.com/)

### PHP

The latest PHP 5.5.x and 5.6.x branches are installed.  php-versions
is included to make switching between multiple versions of PHP easier.

* [php56](http://php.net/)
* [php56-xdebug](http://xdebug.org/)
* [php56-mcrypt](http://php.net/manual/en/book.mcrypt.php)
* [php56-memcached](http://pecl.php.net/package/memcached)
* php55
* php55-xdebug
* php55-mcrypt
* php55-memcached
* [php-version](https://github.com/wilmoore/php-version#simple-php-version-switching)
* [phpunit](http://phpunit.de/manual/current/en/)

*Functions*
```bash
$ switch_php <version>
```
Updates the command line PHP and PEAR commands as well as the currently loaded apache php module.
```bash
$ getcomposer [<dir>]
```
Installs composer to the current working directory, or to the
directory specified if it exists.

## Other Features

### Vim plugins

* [ctrlp.vim](https://github.com/kien/ctrlp.vim)
* [html5.vim](https://github.com/othree/html5.vim)
* [mustache.vim](https://github.com/juvenn/mustache.vim)
* [syntastic](https://github.com/scrooloose/syntastic)
* [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
* [vim-git](https://github.com/tpope/vim-git)
* [vim-haml](https://github.com/tpope/vim-haml)
* [vim-javascript](https://github.com/pangloss/vim-javascript)
* [vim-less](https://github.com/groenewege/vim-less)
* [vim-markdown](https://github.com/tpope/vim-markdown)
* [vim-pathogen](https://github.com/tpope/vim-pathogen)

### Custom OS X defaults

Custom OS X settings can be applied during the `dotfiles` process. They can
also be applied independently by running the following command:

If an environment variable called `$MACHINE_NAME` is present, your machine
will be renamed to the value stored in this variable.

```bash
$ osxdefaults
```

### Bootable backup-drive script

These dotfiles include a script that uses `rsync` to incrementally back up your
data to an external, bootable clone of your computer's internal drive. First,
make sure that the value of `DST` in the `bin/backup` script matches the name
of your backup-drive. Then run the following command:

```bash
$ backup
```

For more information on how to setup your backup-drive, please read the
preparatory steps in this post on creating a [Mac OS X bootable backup
drive](http://nicolasgallagher.com/mac-osx-bootable-backup-drive-with-rsync/).

### Custom bash prompt

I use a custom bash prompt based on the Solarized color palette and influenced
by @gf3's and @cowboy's custom prompts. For best results, you should install
iTerm2 and import [Solarized
Dark.itermcolors](https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized).

When your current working directory is a Git repository, the prompt will
display the checked-out branch's name (and failing that, the commit SHA that
HEAD is pointing to). The state of the working tree is reflected in the
following way:

<table>
    <tr>
        <td><code>+</code></td>
        <td>Uncommitted changes in the index</td>
    </tr>
    <tr>
        <td><code>!</code></td>
        <td>Unstaged changes</td>
    </tr>
    <tr>
        <td><code>?</code></td>
        <td>Untracked files</td>
    </tr>
    <tr>
        <td><code>$</code></td>
        <td>Stashed files</td>
    </tr>
</table>

When your current working directory is an SVN repository, the prompt will
display the checked-out branch's name. The state of the working tree is reflected in the
following way:

<table>
    <tr>
        <td><code>A</code></td>
        <td>Local added files</td>
    </tr>
    <tr>
        <td><code>M</code></td>
        <td>Local modifications</td>
    </tr>
    <tr>
        <td><code>D</code></td>
        <td>Local deleted files</td>
    </tr>
    <tr>
        <td><code>?</code></td>
        <td>Untracked files</td>
    </tr>
    <tr>
        <td><code>!</code></td>
        <td>Conflicted files</td>
    </tr>
</table>

Further details are in the `bash_prompt` file.

Screenshot:

![](http://i.imgur.com/DSJ1G.png)

### Local/private Bash and Vim configuration

Any special-case Vim directives local to a machine should be stored in a
`~/.vimrc.local` file on that machine. The directives will then be automatically
imported into your master `.vimrc`.

Any private and custom Bash commands and configuration should be placed in a
`~/.bash_profile.local` file. This file will not be under version control or
committed to a public repository. If `~/.bash_profile.local` exists, it will be
sourced for inclusion in `bash_profile`.

Here is an example `~/.bash_profile.local`:

```bash
# PATH exports
PATH=$PATH:~/.gem/ruby/1.8/bin
export PATH

# Git credentials
# Not under version control to prevent people from
# accidentally committing with your details
GIT_AUTHOR_NAME="Michael Hofer"
GIT_AUTHOR_EMAIL="michael@example.com"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
# Set the credentials (modifies ~/.gitconfig)
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Aliases
alias code="cd ~/Code"
```

N.B. Because the `git/gitconfig` file is copied to `~/.gitconfig`, any private
git configuration specified in `~/.bash_profile.local` will not be committed to
your dotfiles repository.

### Custom location for Homebrew installation

If your Homebrew installation is not in `/usr/local` then you must prepend your
custom installation's `bin` to the PATH in a file called `~/.dotfilesrc`:

```bash
# Add `brew` command's custom location to PATH
PATH="/opt/acme/bin:$PATH"
```


## Adding new git submodules

If you want to add more git submodules, e.g., Vim plugins to be managed by
pathogen, then follow these steps while in the root of the superproject.

```bash
# Add the new submodule
git submodule add https://example.com/remote/path/to/repo.git vim/bundle/one-submodule
# Initialize and clone the submodule
git submodule update --init
# Stage the changes
git add vim/bundle/one-submodule
# Commit the changes
git commit -m "Add a new submodule: one-submodule"
```


## Updating git submodules

Updating individual submodules within the superproject:

```bash
# Change to the submodule directory
cd vim/bundle/one-submodule
# Checkout the desired branch (of the submodule)
git checkout master
# Pull from the tip of master (of the submodule - could be any sha or pointer)
git pull origin master
# Go back to main dotfiles repo root
cd ../../..
# Stage the submodule changes
git add vim/bundle/one-submodule
# Commit the submodule changes
git commit -m "Update submodule 'one-submodule' to the latest version"
# Push to a remote repository
git push origin master
```

Now, if anyone updates their local repository from the remote repository, then
using `git submodule update` will update the submodules (that have been
initialized) in their local repository. N.B This will wipe away any local
changes made to those submodules.


## Acknowledgements

Inspiration and code was taken from many sources, including:

* [@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens)
  [https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [@tejr](https://github.com/tejr) (Tom Ryder)
  [https://github.com/tejr/dotfiles](https://github.com/tejr/dotfiles)
* [@gf3](https://github.com/gf3) (Gianni Chiappetta)
  [https://github.com/gf3/dotfiles](https://github.com/gf3/dotfiles)
* [@cowboy](https://github.com/cowboy) (Ben Alman)
  [https://github.com/cowboy/dotfiles](https://github.com/cowboy/dotfiles)
* [@alrra](https://github.com/alrra) (Cãtãlin Mariş)
  [https://github.com/alrra/dotfiles](https://github.com/alrra/dotfiles)
* [@holman](https://github.com/holman) (Zach Holman)
  [https://github.com/holman/dotfiles](https://github.com/holman/dotfiles)
* [@sindresorhus](https://github.com/sindresorhus) (Sindre Sorhus)
  [https://github.com/sindresorhus/quick-look-plugins](https://github.com/sindresorhus/quick-look-plugins)
