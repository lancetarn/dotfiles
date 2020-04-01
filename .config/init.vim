set runtimepath^=~/.vim runtimepath+=~/.vim/after
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

":colorscheme solarized
:filetype plugin on
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
  "call dein#add('Shougo/deoplete.nvim')
  "call dein#add('carlitux/deoplete-ternjs')
  call dein#add('neoclide/coc.nvim', { 'rev': 'release' })
  "call dein#add('Shougo/denite.nvim')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('scrooloose/nerdtree')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-commentary')
  call dein#add('justinmk/vim-sneak')
  call dein#add('majutsushi/tagbar')
  call dein#add('vim-airline/vim-airline')
  " call dein#add('autozimu/LanguageClient-neovim', {
  "   \ 'rev': 'next',
  "   \ 'build': 'bash install.sh',
  "   \ })


  " Required:
  call dein#end()
  call dein#save_state()

  " Install not installed plugins on startup.
  if dein#check_install()
    call dein#install()
  endif

  " let g:deoplete#enable_at_startup = 1
  " let g:deoplete#sources#ternjs#filetypes = [
  "               \ 'jsx',
  "               \ 'javascript.jsx',
  "               \ 'vue',
  "               \ ]
  "

endif

" ============ FZF =================="
nnoremap <silent> <c-p> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
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
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Search current project symbols
nnoremap <silent> <leader>ds :<C-u>CocList -I -N --top symbols<CR>

" === Denite setup ==="
"try
"" Use ripgrep for searching current directory for files
"" By default, ripgrep will respect rules in .gitignore
""   --files: Print each file that would be searched (but don't search)
""   --glob:  Include or exclues files for searching that match the given glob
""            (aka ignore .git files)
""
"call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

"" Use ripgrep in place of "grep"
"call denite#custom#var('grep', 'command', ['rg'])

"" Custom options for ripgrep
""   --vimgrep:  Show results with every match on it's own line
""   --hidden:   Search hidden directories and files
""   --heading:  Show the file name above clusters of matches from each file
""   --S:        Search case insensitively if the pattern is all lowercase
"call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

"" Recommended defaults for ripgrep via Denite docs
"call denite#custom#var('grep', 'recursive_opts', [])
"call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
"call denite#custom#var('grep', 'separator', ['--'])
"call denite#custom#var('grep', 'final_opts', [])

"" Remove date from buffer list
"call denite#custom#var('buffer', 'date_format', '')

"catch
"  echo 'Denite not installed.'
"endtry

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>d - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>d :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction


" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" racer-vim
" augroup Racer
"     autocmd!
"     autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
"     autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
"     autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
"     autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
"     autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
" augroup END

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

"set background=light
:colorscheme Tomorrow-Night
":colorscheme molokai
