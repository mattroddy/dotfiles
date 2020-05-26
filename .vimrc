"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " required, turn off vi compatibility
filetype off                  " required by vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, (required)
Plugin 'gmarik/Vundle.vim'
" Enable folding with the spacebar
nnoremap <space> za

set encoding=utf-8
""python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF
Plugin 'tpope/vim-sensible'
Plugin 'valloric/youcompleteme'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'benmills/vimux'
Plugin 'dense-analysis/ale'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive' " the ultimate git helper
Plugin 'tpope/vim-commentary' " comment/uncomment lines with gcc or gc in visual mode
Plugin 'tpope/vim-repeat' " enable repeating supported plugins
Plugin 'lokaltog/vim-powerline'
Plugin 'tpope/vim-obsession'
Plugin 'vim-airline/vim-airline'
Plugin 'Yggdroot/indentLine'
Plugin 'raimondi/delimitmate'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plugin 'junegunn/fzf.vim'
call vundle#end()            " required


filetype plugin indent on    " required

" Code folding settings
set foldmethod=indent
set foldlevel=99

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros

set magic " Set magic on, for regex

set showmatch " show matching braces
set mat=2 " how many tenths of a second to blink
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Quickly insert an empty new line without entering insert mode
" noremap <Leader>o o<Esc>
noremap <Leader>o O<Esc>

au BufNewFile,BufRead *.py
    \   set tabstop=4
    \ | set softtabstop=4
    \ | set shiftwidth=4
    \ | set textwidth=79
    \ | set expandtab
    \ | set autoindent
    \ | set fileformat=unix

au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4


let python_highlight_all=1
syntax on

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif


let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
nmap <C-n> :NERDTreeToggle<CR>

" Switch between hybrid and relative numbering automatically
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

set background=dark
set t_Co=256
set clipboard+=unnamedplus
let g:ale_linters = {'python':['flake8','pydocstyle','bandit','mypy']}
let g:ale_fixers = {'*':[], 'python':['autopep8','black','isort','reorder-python-imports']}
let g:ale_fix_on_save = 1

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

set scroll=5

" VIMUX bindings
" Run the current file with rspec
map <Leader>rb :call VimuxRunCommand("clear; python " . bufname("%"))<CR>
map <F5> :call VimuxRunCommand("clear; python " . bufname("%"))<CR>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

:set listchars=tab:\|\ 
:set list

" FZF stuff
if has("nvim")
    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
endif
nnoremap <Leader>rg :Rg<Space>
nnoremap <Leader>RG :Rg!<Space>
" YCM stuff
let g:ycm_python_binary_path = 'python'
" let g:ycm_server_python_interpreter = '/home/matt/anaconda3/bin/python'
