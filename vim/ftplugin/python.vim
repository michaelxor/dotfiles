map <silent> <LocalLeader>ra :wa<CR> :TestSuite<CR>
map <silent> <LocalLeader>rb :wa<CR> :TestFile<CR>
map <silent> <LocalLeader>rf :wa<CR> :TestNearest<CR>

let b:ale_linters = ['flake8', 'pylint']
let b:ale_fixers = ['black']
