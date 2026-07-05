let &packpath = &runtimepath

" let g:python2_host_prog = '/usr/bin/python'
" let g:python3_host_prog = '/Users/lance/.pyenv/versions/3.9.11/bin/python'

let mapleader = ","
let maplocalleader = ","
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
set background=light
" set background=dark
set noshowmode
set termguicolors

syntax enable

filetype plugin indent on



" Display indent helpers
" Group Names: Comment Constant Identifier Statement
" 	PreProc Type Special Underlined Error Normal
" DISPLAY SOME SPECIAL CHARS
" tab, trail(ing spaces), eol
set list
set listchars=tab:.\ ,trail:~
" Some color preferences
hi NonText ctermfg=DarkGray

"====== lazy.nvim Plugins =======
" Bootstrap lazy.nvim and load the plugin spec from ~/.config/nvim/lua/plugins.lua.
" mapleader is set above, before setup, as lazy.nvim requires.
lua << EOF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("plugins"))
EOF

" Run this setup after all plugins are loaded.
" Lives at ~/.config/nvim/lua/init.lua (nvim-treesitter config)
lua require('init')

" ============ neoformat ============="
" Try to run local prettier
let g:neoformat_try_node_exe = 1


" ============ quick-scope =================="
"
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" ============ FZF =================="
nnoremap <silent> <c-p> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>T        :Tags<CR>
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
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gt <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Search current project symbols
nnoremap <silent> <leader>ds :<C-u>CocList -I -N --top symbols<CR>

" coc-snippet stuff
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


" Current date isofmt
:nnoremap <F5> "=strftime("%Y-%m-%d")<CR>P
:inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>


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
" Elixir outline: Tagbar ships no built-in type, but Universal Ctags has a
" full Elixir parser. Map its kinds (see `ctags --list-kinds=Elixir`) so the
" tagviewer nests functions/types under their module/protocol/impl scope.
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'p:protocols',
        \ 'm:modules',
        \ 'e:exceptions',
        \ 'y:types',
        \ 'd:delegates',
        \ 'f:functions',
        \ 'c:callbacks',
        \ 'a:macros',
        \ 't:tests',
        \ 'i:implementations',
        \ 'o:operators',
        \ 'r:records',
        \ 'g:guards',
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'p' : 'protocol',
        \ 'i' : 'implementation',
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'protocol' : 'p',
        \ 'implementation' : 'i',
    \ },
\ }

"NERDtree
"" Show hidden files/directories
let g:NERDTreeShowHidden = 1

map <leader>f :NERDTreeToggle<CR>

noremap <leader>y :let @+=@"<CR>

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

" SnipMate
" let g:snipMate = {}
" let g:snipMate.snippet_version = 1
" Ultisnips
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-l>"
"

" Firenvim - font size adjust 
if exists('g:started_by_firenvim')
  nnoremap <leader>font :set guifont=SauceCodeProNF:h10<CR>
endif
" function! OnUIEnter(event) abort
"   if s:IsFirenvimActive(a:event)
"     nnoremap <space> :set lines=28 columns=110 <CR>

"     let s:fontsize = 10
"     function! AdjustFontSizeF(amount)
"       let s:fontsize = s:fontsize+a:amount
"       execute "set guifont=SauceCodeProNF:h" . s:fontsize
"       call rpcnotify(0, 'Gui', 'WindowMaximized', 1)
"     endfunction

"     noremap  <C-=> :call AdjustFontSizeF(1)<CR>
"     noremap  <C--> :call AdjustFontSizeF(-1)<CR>
"     inoremap <C-=> :call AdjustFontSizeF(1)<CR>
"     inoremap <C--> :call AdjustFontSizeF(-1)<CR>
" endif
" endfunction
" autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

" Terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

let g:coc_filetype_map = {
  \ 'selmer': 'htmldjango',
  \ }
"
	augroup vimrcEx
        filetype plugin indent on
        " Python
        autocmd FileType htmldjango setlocal commentstring={#\ %s\ #} ts=2 sw=2
        autocmd FileType python execute "compiler pytest"
        autocmd BufWritePre *.py Black

        " Vue
        autocmd BufNewFile,BufReadPost *.vue setlocal filetype=vue
        " autocmd BufWritePre *.js,*.vue,*.ts Neoformat

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text,python setlocal textwidth=88
        " No completion for markdown
        autocmd FileType markdown,text let b:coc_suggest_disable=1 | setlocal wrap

        " Two-space tabs
        autocmd FileType javascript,vue,yaml,html,rust,json,typescript setlocal et ts=2 sw=2
        autocmd FileType javascript,vue setlocal textwidth=100 commentstring=//%s

        autocmd FileType clojure call RainbowToggle


        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                  \ if line("'\"") > 0 && line("'\"") <= line("$") |
                  \   exe "normal! g`\"" |
                  \ endif

        " Terraform comments for vim-commentary
        autocmd FileType terraform setlocal commentstring=#%s
        au BufRead,BufNewFile *.go.html set filetype=gohtmltmpl
	augroup END


    " CoC Documentation on hover
    " augroup hover
    "     autocmd!
    "     autocmd CursorHold * if ! coc#float#has_float()
    "         \| silent call CocAction('doHover') | call CocActionAsync('highlight')
    "     \| endif
    "     autocmd CursorHoldI * if CocAction('ensureDocument')
    "         \|silent call CocAction('showSignatureHelp')
    "     \| endif
    " augroup end
    "

" ============ Cursor: blink + contrast that follows the scheme ==========
" Blink every mode (default only blinks the terminal cursor); block in
" normal/visual, bar in insert, underline in replace. All editor modes use
" the Cursor highlight, which s:CursorContrast() recolors below. Keep the
" terminal-mode entry so :terminal stays as Neovim ships it.
set guicursor=n-v-c-sm:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor,a:blinkwait350-blinkoff250-blinkon350,t:block-blinkon500-blinkoff500-TermCursor

" Pick a high-contrast cursor from the *actual* Normal background luminance
" rather than &background (which is pinned to 'light' here and never tracks
" the loaded scheme). Dark bg -> bright cursor; light bg -> dark cursor.
function! s:CursorContrast() abort
  let l:bg = synIDattr(synIDtrans(hlID('Normal')), 'bg#')
  if l:bg =~? '^#\x\{6}$'
    let l:lum = (str2nr(l:bg[1:2], 16) * 299
          \    + str2nr(l:bg[3:4], 16) * 587
          \    + str2nr(l:bg[5:6], 16) * 114) / 1000
    let l:dark = l:lum < 128
  else
    let l:dark = &background ==# 'dark'
  endif
  if l:dark
    highlight Cursor  gui=NONE cterm=NONE guifg=#101010 guibg=#f2e750 ctermfg=16 ctermbg=226
    highlight lCursor gui=NONE cterm=NONE guifg=#101010 guibg=#8ec07c ctermfg=16 ctermbg=114
  else
    highlight Cursor  gui=NONE cterm=NONE guifg=#f6f6f6 guibg=#d33682 ctermfg=231 ctermbg=125
    highlight lCursor gui=NONE cterm=NONE guifg=#f6f6f6 guibg=#268bd2 ctermfg=231 ctermbg=32
  endif
endfunction

augroup CursorContrast
  autocmd!
  autocmd ColorScheme * call s:CursorContrast()
augroup END

color base16-tomorrow-night-eighties
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
noremap <CR> :bn<CR>
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
nmap <leader>o :copen<CR>
nmap <leader>a :lopen<CR>
" Light/dark switching
nmap <leader>cl :color solarized<CR>
nmap <leader>cd :color base16-tomorrow-night-eighties<CR>
