"" dkeg vimrc

"" Environment {{
     " Basics {
         set nocompatible        " must be first line
         "set background=dark     " Assume a dark background
         call togglebg#map("<f5>")
         "Jump to the last position when reopening a file
         if has("autocmd")
            au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
         endif
         "Automatic reloading of .vimrc
         au BufWritePost .vimrc so ~/.vimrc

         if has("multi_byte")
               if &termencoding == ""
                       let &termencoding = &encoding
               endif
                       set encoding=utf-8
                       setglobal fileencoding=utf-8
                       "setglobal bomb
                       set fileencodings=ucs-bom,utf-8,latin1
               endif


     scriptencoding utf-8
     set encoding=utf-8
     " }
"" }}

"" Color Options {{
    colorscheme shblah 
    set background=dark
"" }}

"" General Settings {{
    "set background=dark
    set t_Co=16 
    "set tw=79 " Width of document
    let mapleader=" "	
    "set nocompatible
	"filetype plugin on
  filetype off
	syntax on
	"set nonumber
	set norelativenumber
	set tabstop=2
	set shiftwidth=2
	set nowrap
  set expandtab
	set autoindent
	set smartindent
	set incsearch
	set hlsearch
	set cursorline
	set novisualbell
	set colorcolumn=80
  "set list 
  set listchars=tab:»\ ,eol:¬,trail:·,extends:→,precedes:←  "
    "set showbreak=~ 
	filetype plugin indent on
	set noswapfile                 		" Don't create a swap file
	set smartcase                  		" Search becomes case sensitive if caps used
    set pastetoggle=<F10>
    let g:Powerline_symbols = 'fancy'
    "set showmatch
    "When splitting windows, auto show num on focus
    "au WinEnter * setlocal number
    "au WinLeave * setlocal nonumber
    "set statusline=\ %t\ %w%m%r%=[%{strlen(&ft)?&ft:'no\ ft'}]\ %l:%v\
    "statusline
"" }}

"" Highlighting {{
	let g:brightest#highlight = {"group": "BrightestUnderline"}
	"highlight OverLength ctermbg=232 ctermfg=240
	"match OverLength /\%81v.\+/    		" Highlight text exceeding 80 character limit
    " indent guide coloring
    hi IndentGuidesOdd ctermbg=234
    hi IndentGuidesEven ctermbg=231
    "autocmd CursorMoved * exe printf('match WordUnder /\V\<%s\>/', escape(expand('<cword>'), '/\'))
"" }}

"" Code Folding {{{
	set foldenable                		    " Enable code folding
	set foldmethod=manual          	   	    " But do it manually
    autocmd BufWinLeave * mkview            " Auto save folds
    autocmd BufWinEnter * silent loadview   " Auto load saved folds
" }}}

"" Extras {{
    inoremap qq <Esc>                   " remap the ESC key	
    nnoremap H :set cursorline! cursorcolumn!<CR>
    map <C-t> :NERDTreeToggle<CR>
    let g:NERDTreeDirArrows=0
    "noremap <C-n> :call NumberToggle()<CR>
    map <C-n> :set number!<CR>
    map <C-m> :set relativenumber!<CR>
    ":au FocusLost * :set number
    ":au FocusGained * :set relativenumber
    map <C-c> :%s/\s\+$//<CR>
    map <tab> %
    cmap w!! w !sudo tee % > /dev/null %	" save read only files when forget to use sudo
    "cmap w !sudo cat >%	 "save file without needed permissions
    let $GROFF_NO_SGR=1
	source $VIMRUNTIME/ftplugin/man.vim
	nmap K :Man <cword><CR>
	au BufLeave,FocusLost * silent! update  " buffer auto save

"" Paren highlighting
" A massively simplified take on
" https://github.com/chreekat/vim-paren-crosshairs
" A massively simplified take on https://github.com/chreekat/vim-paren-crosshairs
func! s:matchparen_cursorcolumn_setup()
  augroup matchparen_cursorcolumn
    autocmd!
    autocmd CursorMoved * if get(w:, "paren_hl_on", 0) | set cursorcolumn | else | set nocursorcolumn | endif
    autocmd InsertEnter * set nocursorcolumn
  augroup END
endf
if !&cursorcolumn
  augroup matchparen_cursorcolumn_setup
    autocmd!
    " - Add the event _only_ if matchparen is enabled.
    " - Event must be added _after_ matchparen loaded (so we can react to w:paren_hl_on).
    autocmd CursorMoved * if exists("#matchparen#CursorMoved") | call <sid>matchparen_cursorcolumn_setup() | endif
          \ | autocmd! matchparen_cursorcolumn_setup
  augroup END
endif
"" }} 

"" Plugins {{
	call plug#begin('~/.vim/plugged')     	" use for plug.vim
	Plug 'junegunn/seoul256.vim'
	Plug 'junegunn/vim-easy-align'
	Plug 'junegunn/goyo.vim'
    Plug 'jaxbot/semantic-highlight.vim'
	call plug#end()
	" Panthogen
    execute pathogen#infect()

    "autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endi
    " by default vim-airline only shows when split. This changes that setting
    Plug 'itchyny/lightline.vim' 
    let g:lightline = {
          \ 'colorscheme': 'genx',
          \ }
    "set laststatus=2
"" }}

