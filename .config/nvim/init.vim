let &packpath = &runtimepath

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/Users/lanceerickson/.virtualenvs/nvim/bin/python3.7'

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let mapleader = ","
set nocompatible         " don't worry about being compatible with vi
set backspace=indent,eol,start
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set nohlsearch
set number
set visualbell
set ignorecase smartcase
set guioptions=aegtc
set mouse=a
set wildmode=list:longest
set nobackup
set nowrap
set hidden
set cpo+=d            " use tags file relative to CWD, not file
set tags=./tags/all   " use exuberant ctags for completion, lookup
set gdefault
set ts=4
set shiftwidth=4
set expandtab
set background=dark
set pastetoggle=<leader>p
set noshowmode
set termguicolors

syntax enable

filetype plugin on
" map CTRL-e to EOL (insert)
imap <C-e> <esc>$i<right>
" Toggle line numbering
noremap <F7> :set nu!<CR>:set nu?<CR>
" Horizontal split nav
map <C-J> <C-W>j
map <C-K> <C-W>k
" Vertical split nav
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
" Buffer nav, C-n/m
noremap <C-m> :bn<CR>
noremap <C-n> :bp<CR>
" Quick escape = vv
inoremap vv <ESC>
" Quickly edit/reload the .vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" Tab jumps to matching brackets
nnoremap <tab> %
vnoremap <tab> %
" Close/open location windows
nmap <leader>q :cclose<CR>
nmap <leader>l :lclose<CR>
nmap <leader>o :copen

" Display indent helpers
" Group Names: Comment Constant Identifier Statement
" 	PreProc Type Special Underlined Error Normal
" DISPLAY SOME SPECIAL CHARS
" tab, trail(ing spaces), eol
set list
set listchars=tab:.\ ,trail:~
" Some color preferences
hi NonText ctermfg=DarkGray

"====== Dein Plugins =======
" Required:
if dein#load_state('/Users/lanceerickson/.cache/dein')
  call dein#begin('/Users/lanceerickson/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/lanceerickson/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('5long/pytest-vim-compiler')
  call dein#add('digitaltoad/vim-pug', {'on_ft': 'vue'})
  call dein#add('godlygeek/tabular')
  call dein#add('hashivim/vim-terraform')
  call dein#add('honza/vim-snippets')
  call dein#add('joshdick/onedark.vim')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('justinmk/vim-sneak')
  call dein#add('kkoomen/vim-doge')
  call dein#add('majutsushi/tagbar')
  call dein#add('morhetz/gruvbox')
  call dein#add('neoclide/coc.nvim', { 'rev': 'release' })
  call dein#add('pangloss/vim-javascript', {'on_ft': 'javascript', 'rev': 'db595656304959dcc3805cf63ea9a430e3f01e8f'})
  call dein#add('posva/vim-vue', {'on_ft': 'vue'})
  call dein#add('romainl/flattened')
  call dein#add('rust-lang/rust.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('scrooloose/syntastic')
  call dein#add('SirVer/ultisnips', {'depends': 'vim-snippets'})
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-dispatch')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')
  call dein#add('vim-airline/vim-airline')

  " Required:
  call dein#end()
  call dein#save_state()

  " Install not installed plugins on startup.
  if dein#check_install()
    call dein#install()
  endif

endif

" ============ FZF =================="
nnoremap <silent> <c-p> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
nnoremap <silent> <Leader>`        :Marks<CR>

" ============ Lots of coc stuff below ===============
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position.
" " Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Make it easy to set interpreter
nmap <leader>s :CocCommand python.setInterpreter<CR>
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Search current project symbols
nnoremap <silent> <leader>ds :<C-u>CocList -I -N --top symbols<CR>

let g:gruvbox_italics = 1
colorscheme gruvbox

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" Airline
let g:airline#extensions#tabline#enabled = 1

" DoGe
let g:doge_filetype_aliases = {'javascript': ['vue']}

" FZF use ag to respect .gitignore, show hidden
let $FZF_DEFAULT_COMMAND='ag --nocolor --hidden --ignore .git -g ""'

"Tagbar
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_sort = 0
let g:tagbar_foldlevel = 0
let g:tagbar_width = 40
let g:tagbar_ctags_bin = 'ctags'

"NERDtree
"" Show hidden files/directories
let g:NERDTreeShowHidden = 1

map <leader>f :NERDTreeToggle<CR>

"Clipper - send to Mac clipboard
noremap <leader>y :call system('nc localhost 21212', @0)<CR>

" vim-javascript
let g:javascript_plugin_jsdoc = 1

" Rust format buffer on save
let g:rustfmt_autosave = 1

"Syntastic
"let g:syntastic_php_checkers=['php']
let g:syntastic_python_checkers=['flake8']
"let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_auto_loc_list = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 0

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-l>"

" Terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

"
	augroup vimrcEx
        filetype plugin indent on
        " Python
        autocmd FileType python execute "compiler pytest"

        " Vue
        autocmd BufNewFile,Bufread *.vue setlocal filetype=vue

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text,python,markdown setlocal textwidth=78

        " Two-space tabs
        autocmd FileType javascript,vue,yaml,html,rust setlocal et ts=2 sw=2
        autocmd FileType javascript,vue setlocal textwidth=90
        autocmd FileType vue setlocal commentstring=//%s


        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                  \ if line("'\"") > 0 && line("'\"") <= line("$") |
                  \   exe "normal! g`\"" |
                  \ endif

        " Terraform comments for vim-commentary
        autocmd FileType terraform setlocal commentstring=#%s
	augroup END
