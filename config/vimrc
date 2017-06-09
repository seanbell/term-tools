" VIM configuration
" Sean Bell 2014
"
" Read the various sections to see all the command mappings.
" Many (but not all) of the plugins have mini-documentation
" where they are configured.
"

" MUST BE FIRST: Environment {{{

	" Must be first since this sets some options as a side effect
	set nocompatible

	" UTF-8 encoding (default is latin1)
	scriptencoding utf-8
	set encoding=utf-8
	set termencoding=utf-8

	" Pathogen -- plugin package manager
	filetype off
	call pathogen#infect()
	call pathogen#helptags()
	filetype plugin indent on

" }}}

" General {{{

	" Dark mode unless there is a flag file
	" (useful for when you toggle modes often)
	if filereadable($HOME . "/.vim-light")
		set background=light
	else
		set background=dark
	endif

	" Color scheme -- Solarized, toggle with F6
	set t_Co=16
	syntax on
	colorscheme solarized
	call togglebg#map("<F6>")

	" Use , instead of \ for leader key (must be defined first)
	let mapleader=','

	" Misc
	let is_bash=1          " we are using bash
	set autoread           " auto-reload modified files (with no local changes)
	set undolevels=65536   " lots of undo (default 1000)
	set history=1024       " lots of history (default 20)
	set mouse=nicr         " enable mouse (set mouse= to disable mouse)
	set foldmethod=syntax  " fold using syntax by default
	set foldminlines=4     " require a medium size to fold
	set foldnestmax=3      " max 3 fold levels for syntax/indent folding
	set hidden             " allow un-saved buffers in background
	set lazyredraw         " no redraws in macros
	set confirm            " dialog when :q, :w, :x, :wq fails
	set title              " change terminal title
	set nostartofline      " don't move cursor when switching buffers/files
	set nobackup           " that's what git is for
	set ttyfast            " smoother changes

	" Appearance
	set number             " enable line numbers
	set scrolloff=8        " keep 8 lines below and above cursor
	set linebreak          " show wrap at word boundaries
	set showbreak=\ ↪\     " prefix wrap with ↪

	" Autocompletion
	set wildmenu                 " completion with menu
	set wildmode=list:longest    " list instead of fill in options
	set wildignore=*~,*.o,*.d,*.obj,*.class,*.pyc,*.bak,*.swp,.svn,.git,.hg
	set suffixes=~,.o,.d,.obj,.class,.bak,.swp,.pyc
	set completeopt=longest,menuone

	" Indentation -- width of 4 spaces
	set autoindent     " automatic indentation
	set copyindent     " indent new lines by current indent
	set nosmartindent  " disable C-style indenting by default (only useful for C/C++)
	set tabstop=4      " Number of spaces that a <Tab> in the file counts for (default 8)
	set shiftwidth=4   " Number of spaces to use for each step of (auto)indent.
	set textwidth=0    " no hard wrapping by default

	" Better search
	set incsearch      " incremental search
	set ignorecase     " ignore case in search
	set smartcase      " override ignorecase if uppercase is used in search string
	set hlsearch       " enable search highlighting (change to nohlsearch to disable)
					" clear highlight with :noh

	" Show more things
	set cursorline     " highlight current line
	set showmode       " show which mode we are in
	set showcmd        " show state of keyboard input
	set showmatch      " show brace match
	set matchtime=2    " faster brace match
	set report=0       " report all changes
	set ruler          " show position in bottom right

	" Share X windows clipboard
	if has('unnamedplus')
		set clipboard=unnamedplus
	endif

	" STFU
	set noerrorbells visualbell t_vb=
	autocmd GUIEnter * set visualbell t_vb=

	" Open folds by default
	autocmd BufWinEnter * normal zR

	" Detect file changes when idle or siwtching windows
	autocmd CursorHold * checktime
	autocmd WinEnter * checktime

	" Store swapfiles in a central location
	set backup
	set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
	set backupskip=/tmp/*,/private/tmp/*
	set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
	set writebackup

	" Fix tmux ctrl-arrows
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"

" }}}

" Windows and tab commands {{{

	" Quit vim
	noremap <leader>qa <esc>:qa<cr>

	" Left/right or c-h/c-l -- switch tabs
	noremap <left>  gT
	noremap <c-h>   gT
	noremap <right> gt
	noremap <c-l>   gt
	inoremap <left>  <esc>gT
	inoremap <right> <esc>gt

	" Up/down -- switch windows
	noremap <down> <c-w>w
	noremap <c-j>  <c-w>w
	noremap <up>   <c-w>W
	noremap <c-k>  <c-w>W
	inoremap <down> <esc><c-w>w
	inoremap <up>   <esc><c-w>W

	" Ctrl+left/right -- move tabs
	noremap <c-left>  :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
	noremap <c-right> :execute 'silent! tabmove ' . tabpagenr()<cr>

	" Ctrl+up/down -- move windows
	noremap <c-down> <c-w>r
	noremap <c-up>   <c-w>R

	" Ctrl+shift+left/right -- move window into new tab left or right
	map <c-s-left>  <c-w>T<c-left>
	map <c-s-right> <c-w>T<c-right>

	let g:lasttab = 1
	au TabLeave * let g:lasttab = tabpagenr()
	nnoremap <leader>tt <esc>:exe 'tabn '.g:lasttab<cr> " Move to previous tab

	" Managing tabs
	noremap <leader>tn :tabnew<cr>
	noremap <leader>to :tabonly<cr>
	noremap <leader>tc :tabclose<cr>
	noremap <leader>tf :tabnew<cr>:CtrlP<cr>
	noremap <leader>ts :tab split

	" Navigating windows
	noremap <leader>ww <c-w>w " move below/right in a cycle
	noremap <leader>wt <c-w>t " move to top/left
	noremap <leader>wb <c-w>b " move to bottom/right
	noremap <leader>wp <c-w>p " move to previous window
	noremap <leader>wl <c-w>l " move right a window
	noremap <leader>wh <c-w>h " move left a window
	noremap <leader>wj <c-w>j " move down a window
	noremap <leader>wk <c-w>k " move up a window

	" Managing windows
	noremap <leader>wt <c-w>T " move window to its own tab
	noremap <leader>wn <c-w>n " create a new window with empty file
	noremap <leader>ws <c-w>s " split current window
	noremap <leader>wv <c-w>v " split current window vertically
	noremap <leader>wq <c-w>q " quit current window
	noremap <leader>wc <c-w>c " close current window
	noremap <leader>wo <c-w>o " make current window only one on screen

	noremap <leader>wH <c-w>H " move window to left
	noremap <leader>wL <c-w>L " move window to right
	noremap <leader>wJ <c-w>J " move window to bottom
	noremap <leader>wK <c-w>K " move window to topw

	" Edit file in current window
	noremap <leader>ew :e<space>
	noremap <leader>we :e<space>
	" Edit file in split (horizontal)
	noremap <leader>es :sp<space>
	noremap <leader>se :sp<space>
	" Edit file in split (vertical)
	noremap <leader>ev :vsp<space>
	noremap <leader>ve :vsp<space>
	" Edit file new tab
	noremap <leader>et :tabe<space>
	noremap <leader>te :tabe<space>

	" New buffer in split
	nnoremap <leader>sn <esc>:below new<cr>
	nnoremap <leader>vn <esc>:vert belowright new<cr>

	" Merge current window ino a vert-split with prev/next tab
	" (defined in ~/.vim/bundle/sbell/plugin/sbell.vim
	nnoremap <leader>tj <esc>:call MoveToNextTab()<cr>
	nnoremap <leader>tk <esc>:call MoveToPrevTab()<cr>

	" Another shortcut for move left/right tab (for symmetry with window commands)
	nnoremap <leader>th gT
	nnoremap <leader>tl gt

	" Quickfix window -- open/close
	nnoremap <leader>qo <esc>:cope<cr>
	nnoremap <leader>qc <esc>:ccl<cr>
	" jump to next/previous error
	nnoremap <leader>qn <esc>:cn<cr>
	nnoremap <leader>qp <esc>:cp<cr>
	" jump to errors in next file
	nnoremap <leader>qf <esc>:cnf<cr>

	" Location list window -- open/close
	nnoremap <leader>lo <esc>:lop<cr>
	nnoremap <leader>lc <esc>:lcl<cr>
	" jump to next/previous error
	nnoremap <leader>ln <esc>:lne<cr>
	nnoremap <leader>lp <esc>:lp<cr>
	" jump to errors in next file
	nnoremap <leader>lf <esc>:lnf<cr>

" }}}

" Command (re)mapings {{{

	" Make Y more consistent with C and D
	call yankstack#setup()
	nmap Y y$

	" Move by displayed lines, not physical lines
	noremap j gj
	noremap k gk

	" Scroll slightly faster
	noremap <c-e> <c-e><c-e>
	noremap <c-y> <c-y><c-y>

	" Indent with tab, unindent with shift-tab
	nnoremap <tab> >>
	vnoremap <tab> >
	nnoremap <s-tab> <<
	vnoremap <s-tab> <

	" Also indent with space
	nnoremap <space> >>
	vnoremap <space> >

	" Reflow paragraph with Q in normal and visual mode
	nnoremap Q gwap
	vnoremap Q gw

	" <F2>: enter paste mode (while in insert mode) to paste from outside vim safely
	noremap <F2> :set invpaste paste?<cr>
	set pastetoggle=<F2>

	"" Switch CWD to the directory of the open buffer
	noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

	" <leader>sp : toggle check SPelling
	noremap <leader>sp <esc>:setlocal spell!<cr>

	" // : clear search
	noremap // <esc>:noh<cr>

	" ctrl+s : save (you have to enable passing ctrl+s from the terminal)
	nmap <c-s> <esc>:w<cr>

	" :w!! : Save with sudo
	cmap w!! w !sudo tee % >/dev/null

	" <leader>sa : select all
	nnoremap <leader>sa 1GVG

	" <leader>mk : run make
	noremap <leader>mk :make<cr>

	" Map :W --> :w etc (caps lock errors)
	command! W :w
	command! Wq :wq
	command! WQ :wq
	command! E :e

	" <leader>l -- lint code (format and then show errors)
	"    C/C++  -- ANSI style (A1), with tabs
	"    Python  -- PEP8 style
	"    Coffee
	autocmd FileType coffee nnoremap <leader>l <esc>:CoffeeLint\|cwindow<cr>
	autocmd FileType python nnoremap <leader>l <esc>:retab<cr><esc>:Isort<cr><esc>:PymodeLintAuto<cr><esc>:PymodeLint<cr>
	autocmd FileType c,cpp,h,hpp nnoremap <leader>l <esc>:%!astyle -A2 -t<cr>

	" <leader>r -- run/compile code
	"     C/C++  -- run make
	"     Coffee -- watch live compilation
	"     Python -- setup by python-mode
	autocmd FileType c,cpp,h,hpp nnoremap <leader>r <esc>:w<cr><esc>:make<cr>
	autocmd FileType coffee nnoremap <leader>r <esc>:w<cr><esc>:CoffeeCompile watch<cr>

	" Save file
	nnoremap <leader>sf <esc>:w<cr>

	" <leader>dw -- delete trailing white space
	fun! DeleteTrailingWS()
		" save last search and cursor
		let l:_s=@/
		let l:saved_pos = getpos('.')
		" delete with regex
		silent! %s/\s\+$//ge
		" restore search and cursor
		let @/=l:_s
		call setpos('.', l:saved_pos)
	endfun
	nnoremap <leader>dw <esc>:call DeleteTrailingWS()<cr>
	autocmd FileType c,cpp,python,ruby,java autocmd BufWritePre <buffer> :call DeleteTrailingWS()

" }}}

" Global fixes {{{

	" Faster timeout for some actions
	set timeout timeoutlen=1000 ttimeoutlen=100

	" Re-adjust windows on window resize
	autocmd VimResized * wincmd =

	" Insert mode -- don't undo folds when typing
	autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
	autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

	" Remove the toolbar if we're running under a GUI
	if has("gui_running")
	set guioptions=-t
	endif

	" Fix backspaces
	set backspace=indent,eol,start
	if has('mac')
		fixdel
	endif

	" Backspace in normal mode
	nmap <bs> X

	" Jump to last known line when opening a file (change ' to ` to do column too)
	autocmd BufReadPost *
	\ if &ft !~ 'COMMIT_EDITMSG' |
	\   if line("'\"") > 0 && line("'\"") <= line("$") |
	\     exe "normal g`\"" |
	\     if foldlevel('.') > 0 |
	\       exe "normal zO" |
	\     endif |
	\   endif |
	\ endif

	" Highlight trailing whitespace in the most annoying way possible.
	if g:colors_name == "solarized"
		exe "hi! ExtraWhitespace" .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_red'] .g:solarized_vars['bg_red']
	else
		hi! ExtraWhitespace ctermbg=red guibg=red
	endif
	match ExtraWhitespace /\s\+$/
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" }}}

" FileType tabs, folding, wrapping, spelling {{{

	" Enable spell-check on text-like filetypes
	autocmd FileType txt,tex,html,rst,markdown set spell

	" Python -- whitespace sensitive
	autocmd FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4

	" Latex -- 2-space tabs and 80-character hard wrapping
	autocmd FileType tex setlocal expandtab shiftwidth=2 tabstop=2 textwidth=80

	" Vimrc -- fold with markers
	autocmd FileType vim setlocal foldmethod=marker

	" Crontab -- save a backup
	autocmd FileType crontab setlocal backupcopy=yes

	" C/C++ -- smart indentation
	autocmd FileType c,cpp,h,hpp,cuda setlocal smartindent cindent shiftwidth=2 tabstop=2 softtabstop=2 expandtab

	" Coffeescript -- 2-space tabs
	autocmd FileType coffee setl expandtab shiftwidth=2 tabstop=2 softtabstop=2

	" Javascript -- 2-space tabs
	autocmd FileType javascript setl expandtab shiftwidth=2 tabstop=2 softtabstop=2

	" Markdown
	au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.md  set filetype=markdown

	" Config files
	au BufNewFile,BufRead /etc/nginx/*   set filetype=nginx
	au BufNewFile,BufRead /etc/apache2/* set filetype=apache
	au BufNewFile,BufRead /etc/hosts     set filetype=hostconf

	" Django: template-aware html
	au BufNewFile,BufRead *.html  set filetype=htmldjango

" }}}

" Plugin config {{{

	" Solarized {{{

		if g:colors_name == "solarized"
			" LaTeX uses way too much red --> replace it with blue
			autocmd FileType tex exe "hi! Special" .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_blue'] .g:solarized_vars['bg_none']
		endif

	" }}}

	" Powerline -- fancy status line {{{

		" let g:Powerline_symbols = 'fancy'
		set laststatus=2  " 2 means always show status

	" }}}

	" Startify (home screen) {{{

		" Startify -- don't change to file's directory
		let g:startify_change_to_dir = 0
		" Startify -- fix colors
		if g:colors_name == "solarized"
			exe "hi! StartifyHeader"  .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_yellow'] .g:solarized_vars['bg_none']
			exe "hi! StartifySection" .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_yellow'] .g:solarized_vars['bg_none']
			exe "hi! StartifyPath"    .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_base00'] .g:solarized_vars['bg_none']
			exe "hi! StartifySlash"   .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_base00'] .g:solarized_vars['bg_none']
			exe "hi! StartifyBracket" .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_base0']  .g:solarized_vars['bg_none']
			exe "hi! StartifySpecial" .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_base0']  .g:solarized_vars['bg_none']
		endif
		" Startify -- start NERDTree
		"autocmd VimEnter *
			"\ if !argc() |
			"\   Startify |
			"\   NERDTree |
			"\   execute "normal \<c-w>w" |
			"\ endif
		" Startify -- unimportant files
		let g:startify_skiplist = [
			\ 'COMMIT_EDITMSG',
			\ $VIMRUNTIME .'/doc',
			\ 'bundle/.*/doc',
			\ '\.DS_Store'
			\ ]
		" Startify -- header
		if executable('fortune') && executable('cowsay')
			" show a random character with a random fortune (if installed)
			let g:startify_custom_header =
			\ map(split(system("fortune -asn 320 | cowsay -f $(cowsay -l | tail -n +2 | tr ' ' '\n' | shuf -n1) | sed -r 's/\\s+$//g' | sed '/^$/d'"), '\n'), '"   ". v:val') + ['','']
		else
			" default header
			let g:startify_custom_header = [
				\ '   __      ___',
				\ '   \ \    / (_)',
				\ '    \ \  / / _ _ __ ___',
				\ '     \ \/ / | | ''_ ` _ \',
				\ '      \  /  | | | | | | |',
				\ '       \/   |_|_| |_| |_|',
				\ '',
				\ '',
				\ ]
		endif

	" }}}

	" YankStack -- paste older items on stack {{{

		nmap <leader>p <Plug>yankstack_substitute_older_paste
		nmap <leader>P <Plug>yankstack_substitute_newer_paste

	" }}}

	" NERDCommenter {{{

		" use default mappings; some of them are:
		" -- <leader>ci : toggle comment
		" -- <leader>cc : comment;
		" -- <leader>cs : comment 'sexily';

	" }}}

	" Surround {{{

		" This plugin adds/modifies 'surroundings', some of them are:
		" -- ds.  : delete .
		" -- cs., : change . to ,
		" -- S. (visual) : wrap with .

	" }}}

	" Motion {{{

		" EasyMotion -- map to <leader><leader> (then the usual movement keys: w, b, f, k, j ...)
		let g:EasyMotion_leader_key = '<leader><leader>'

		" EasyMotion -- jump repeatedly if inside NERDTree
		" (custom function in plugins/sbell.vim)
		nmap <leader>j <esc>:call EMNerd(0)<cr>
		nmap <leader>k <esc>:call EMNerd(1)<cr>

		" EasyMotion & Solarized fix
		hi link EasyMotionShade  Comment
		hi link EasyMotionTarget WarningMsg
		hi link EasyMotionTarget2First DiffAdd
		hi link EasyMotionTarget2Second DiffChange

		" FSwitch -- <leader>h or H
		"   -- <leader>h -- open in vertical split
		"   -- <leader>H -- open in current window (in place of current file)
		"   -- (custom wrappers I wrote in plugins/sbell.vim)
		noremap <leader>h <esc>:call FSSplitSmart()<cr>
		noremap <leader>H <esc>:call FSNerd(":FSHere")<cr>

		" Seek
		"  -- s -- expects 2 characters: seek to that pair of characters
		"  -- works like f or t

	" }}}

	" TabMan -- fancy tab manager {{{

		let g:tabman_toggle = '<leader>tm'
		let g:tabman_focus  = '<leader><leader>tm'

	" }}}

	" GUndo {{{

		" GUndo -- <leader>u : show undo tree in right-hand window
		nnoremap <leader>u :GundoToggle<cr>
		let g:gundo_right = 1

	" }}}

	" TagBar -- ctags on right (mnemonic: tagBar) {{{

		"   -- bt : toggle
		"   -- bo : open
		"   -- bf : find
		"   -- bc : close
		nnoremap <leader>bt <esc>:TagbarToggle<cr>
		nnoremap <leader>bo <esc>:TagbarOpen fj<cr>
		nnoremap <leader>bf <esc>:TagbarOpen fj<cr>2H:call EasyMotion#JK(0, 0)<cr>
		nnoremap <leader>bc <esc>:TagbarClose<cr>

		let g:tagbar_width = 30
		let g:tagbar_sort = 0
		let g:tagbar_compact = 1
		let g:tagbar_autofocus = 1
		let g:tagbar_autoclose = 0
		let g:tagbar_foldlevel = 0
		let g:tagbar_autoshowtag = 1
		let g:tagbar_systemenc = 'utf-8'

	" }}}

	" NERDTree -- file browser on left (mnemonic: All files) {{{

		"   -- ao : open (custom function in plugins/sbell.vi)
		"   -- ac : close
		"   -- at : toggle
		noremap <leader>ao <esc>:call NERDTreeTabsFind()<cr><c-w>=
		noremap <leader>ac <esc>:NERDTreeTabsClose<cr><c-w>=
		noremap <leader>at <esc>:NERDTreeTabsToggle<cr><c-w>=

		" NERDTree -- set width to 30
		let g:NERDTreeWinSize = 30

		" NERDTree -- don't ask to confirm buffer issues when renaming/deleting
		let NERDTreeAutoDeleteBuffer=1

		" NERDTree -- hide files
		let NERDTreeIgnore=['\.swp$', '\.pyc$', '\.o$', '\.class$', '\~$', '\.aux$', '\.bbl$', '\.aux$', '\.blg$', '\.fdb_latexmk$']

		" NERDTree -- open horiz/vert
		let g:NERDTreeMapOpenSplit = 's'
		let g:NERDTreeMapOpenVSplit = 'v'

		" NERDTree -- I want to use C-j and C-k to jump windows, so re-map these:
		let g:NERDTreeMapJumpNextSibling = 'J'
		let g:NERDTreeMapJumpPrevSibling = 'K'
		let g:NERDTreeMapJumpFirstChild = ''
		let g:NERDTreeMapJumpLastChild = ''

		" NERDTree -- Close all open buffers on entering a window if the only buffer
		" that's left is the NERDTree buffer
		" (https://github.com/scrooloose/nerdtree/issues/21)
		"autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
		"function! s:CloseIfOnlyNerdTreeLeft()
		"if exists("t:NERDTreeBufName")
			"if bufwinnr(t:NERDTreeBufName) != -1
			"if winnr("$") == 1
				"q
			"endif
			"endif
		"endif
		"endfunction

		" NERDTreeTabs
		let g:nerdtree_tabs_focus_on_files = 1

	" }}}

	" CtrlP (searching files/buffers/tags/etc) {{{

		" CtrlP -- searching files/buffers/tags/etc
		"   -- when selecting a result:
		"     -- enter: open in current window
		"     -- ctrl+t: open in new ab
		"     -- ctrl+v: open in vert split
		"     -- ctrl+s: open in horiz split
		noremap <leader>ff <esc>:CtrlP<cr>            " find file
		noremap <leader>ft <esc>:CtrlPBufTagAll<cr>   " find tag
		noremap <leader>fr <esc>:CtrlPMRUFiles<cr>    " find recently used file
		noremap <leader>fb <esc>:CtrlPBuffer<cr>      " find buffer
		noremap <leader>fq <esc>:CtrlPQuickfix<cr>    " find in quickfix
		noremap <leader>fu <esc>:CtrlPUndo<cr>        " find in undo
		noremap <leader>fl <esc>:CtrlPLine<cr>        " find in file (by line)

		" CtrlP -- ignore files
		let g:ctrlp_custom_ignore = {
			\ 'dir':  '\.git$\|\.hg$\|\.svn$',
			\ 'file': '\.exe$\|\.so$\|\.os$\|\.dll$\|\.o$\|\.d$\|\.pyc$\|\.swp$\|\.jpg$\|\.png$\|\.gif$',
			\ }

		" CtrlP -- only search current directory
		let g:ctrlp_working_path_mode = ''

		" CtrlP -- refresh file tree on write or focus change
		augroup CtrlPExtension
		autocmd!
		autocmd FocusGained * ClearCtrlPCache
		autocmd BufWritePost * ClearCtrlPCache
		augroup END

	" }}}

	" Syntastic -- inline syntax errors {{{

		" fancy warning symbols
		"let g:syntastic_error_symbol = '✗'
		"let g:syntastic_warning_symbol = ' ⚠'

		" turn off default checking for c/c++
		let g:syntastic_mode_map = {
			\ 'mode': 'active',
			\ 'active_filetypes': [],
			\ 'passive_filetypes': ['c', 'cpp', 'h', 'hpp'] }

	" }}}

	" Signify (+/-/~ signs) {{{

		"  -- <leader>gh -- toggle line highlighting
		"  -- fix the default colors: make the background match the gutter
		"  -- change the modify sign from ! to ~
		"  -- only handle git and hg (exclude all other VCS)
		if g:colors_name == "solarized"
			exe "hi! SignifySignAdd"    .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_green']  .g:solarized_vars['bg_none']
			exe "hi! SignifySignDelete" .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_red']    .g:solarized_vars['bg_none']
			exe "hi! SignifySignChange" .g:solarized_vars['fmt_none'] .g:solarized_vars['fg_yellow'] .g:solarized_vars['bg_none']
		endif
		let g:signify_sign_change = '~'
		let g:signify_vcs_list = [ 'git', 'hg' ]

	" }}}

	" Fugutive (git) {{{

		noremap <leader>gb <esc>:Gblame<cr>
		noremap <leader>gs <esc>:Gstatus<cr>
		noremap <leader>gd <esc>:Gdiff<cr>
		noremap <leader>gl <esc>:Glog<cr>
		noremap <leader>gc <esc>:Gcommit<cr>
		noremap <leader>gp <esc>:Gpush<cr>

	" }}}

	" ShowMarks {{{

		"   -- enable with <leader>mo
		"   -- close  with <leader>mc
		"   -- toggle with <leader>mt
		noremap <leader>mc <esc>:ShowMarksClearAll<cr>

		" ShowMarks fixes
		"  -- only include letters (I'm not sure what 0123456789.'`^<>[]{}()\" refers to but they
		"     don't seem to match up with what ShowMarks shows in the side bar)
		"  -- fix the default colors (default has foreground == background for me)
		let g:showmarks_include='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
		if g:colors_name == "solarized"
			exe "hi! ShowMarksHLl" .g:solarized_vars['fmt_bold'] .g:solarized_vars['fg_base1'] .g:solarized_vars['bg_none']
			exe "hi! ShowMarksHLu" .g:solarized_vars['fmt_bold'] .g:solarized_vars['fg_base1'] .g:solarized_vars['bg_none']
			exe "hi! ShowMarksHLo" .g:solarized_vars['fmt_bold'] .g:solarized_vars['fg_base1'] .g:solarized_vars['bg_none']
			exe "hi! ShowMarksHLm" .g:solarized_vars['fmt_bold'] .g:solarized_vars['fg_base1'] .g:solarized_vars['bg_none']
		endif

	" }}}

	" Vimux {{{

		" Prompt for a command to run
		nnoremap <Leader>rp <esc>:VimuxPromptCommand<CR>

		" Run last command executed by VimuxRunCommand
		nnoremap <Leader>rl <esc>:VimuxRunLastCommand<CR>

		" Yank from runner pane (enter tmux copy mode in the other window)
		nnoremap <Leader>ry <esc>:VimuxInspectRunner<CR>

		" Close all other tmux panes in current window
		nnoremap <Leader>rx <esc>:VimuxClosePanes<CR>

		" Close vim tmux runner opened by VimuxRunCommand
		nnoremap <Leader>rc <esc>:VimuxCloseRunner<CR>

		" Stop (interrupt) any command running in the runner pane
		nnoremap <Leader>rs <esc>:VimuxInterruptRunner<CR>

		" Git (commit and) push current progress, repeating the last commit message
		nnoremap <Leader>rgp <esc>:w<CR>:call VimuxRunCommand('clear; git add --all . && git commit -a -m "$(git log -1 --pretty=%B)" && git push && exit')<CR>:w<CR>

		" defaults, but here for reference:
		"let g:VimuxOrientation = "v"
		"let g:VimuxHeight = "20"

	" }}}

	" HTML {{{

		" html indentation + vim javascript
		let g:html_indent_inctags = "html,body,head,tbody"
		let g:html_indent_script1 = "inc"
		let g:html_indent_style1 = "inc"

		" CloseTag -- close html tags automagically
		autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
		autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

	" }}}

	" Python {{{

		" Don't use syntastic for python (use python-mode instead)
		let g:syntastic_python_checkers = []

		" python-mode
		let g:pymode_options = 0
		let g:pymode_doc = 0
		let g:pymode_lint_on_fly = 0
		let g:pymode_lint_checkers = ['pyflakes', 'pylint', 'pep8', 'mccabe']
		let g:pymode_lint_ignore = "R0912,W0401,W0511,W0622,W0702,W0704,E309,E501,R0914,R0911,C901,E265,E114,E116,E266,W391,E731,C0111,F0401,W0102,E1002,C1001,W0201,W0603,W0703"
		let g:pymode_lint_jump = 0
		let g:pymode_breakpoint_key = '<leader>bp'
		let g:pymode_rope = 0
		let g:pymode_rope_completion = 0
		let g:pymode_folding = 1
		"let g:pymode_lint_error_symbol = '✗'
		"let g:pymode_lint_todo_symbol = '⚠'
		"let g:pymode_lint_comment_symbol = '⚠'
		"let g:pymode_lint_visual_symbol = '⚠'
		"let g:pymode_lint_info_symbol = '⚠'
		"let g:pymode_lint_pyflakes_symbol = '⚠'

		" Python jedi
		"   (jedi#auto_vim_configuration sets completeopt to include a pesky window at
		"   the top which I don't want)
		"   <ctrl+space> or <tab> -- autocomplete
		"   <enter>         -- jump to declaration
		"   <leader><enter> -- jump to definition
		"   <leader>rn      -- rename
		let g:jedi#auto_vim_configuration = 0
		let g:jedi#goto_assignments_command = "<cr>"
		let g:jedi#goto_definitions_command = "<leader><cr>"
		let g:jedi#rename_command = "<leader>rn"

		" Isort
		"   <leader>i -- sort imports (either whole file or selection)
		autocmd FileType python nnoremap <leader>i <esc>:Isort<cr>
		let g:vim_isort_map = '<leader>i'

		" Django (django-support)
		" -- Automatically sets DJANGO_SETTINGS_MODULE
		"

		" Helper to show what the current highlight group is.  Press F9 over a
		" token to print the current highlight group to the status bar.
		autocmd FileType tex map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
			\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

	" }}}

	" C/C++ {{{

		" Eclim -- eclipse + vim (thanks Tim)
		"   -- ctrl+space : code autocomplete
		"   -- enter : search context
		"   -- <leader>vc : validate c++ code
		"   -- <leader>fc : find c++ tag
		inoremap <nul> <C-x><C-u><C-n>
		inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"
		inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<cr>'
		inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<cr>'
		nnoremap <leader>vc <esc>:Validate<cr>
		nnoremap <leader>fc <esc>:CSearch<space>
		autocmd FileType c,cpp,h,hpp nnoremap <cr> <esc>:CSearchContext<cr>zO
		autocmd FileType c,cpp,h,hpp nnoremap <C-LeftMouse> <LeftMouse><esc>:CSearchContext<cr>zO

		" Automatically insert C++ header gates for new h/hpp files
		function! s:insert_gates()
		let gatename = '__' . substitute(toupper(expand("%:t")), "\\.", "_", "g")
		execute "normal! i#ifndef " . gatename
		execute "normal! o#define " . gatename
		execute "normal! Go#endif /* " . gatename . " */"
		execute "normal! ggo"
		endfunction
		autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

	" }}}

	" Latex {{{

		" Show symbol for accents, delimiters, greek, and math symbols
		" --> see ~/.vim/ftplugin/tex.vim

		" Replace latex with their math symbol
		" --> see ~/.vim/syntax/tex.vim

		" Disable the <++> that normally gets inserted with this latex plugin
		let g:Imap_UsePlaceHolders = 0

		" Treat \ and : like a word character
		" Note: if you write your \label's as \label{fig:something}, then if you
		" type in \ref{fig: and press <C-n> you will automatically cycle through
		" all the figure labels. Very useful!
		autocmd FileType tex setlocal iskeyword+=\\
		autocmd FileType tex setlocal iskeyword+=:

		" BUGFIX: Vim7 has a problem detecting the filetype correctly when editing a new
		" LaTex document
		let g:tex_flavor='latex'

		" BUGFIX: grep will sometimes skip displaying the file name if you
		" search in a singe file. This will confuse latex-suite. Set your grep
		" program to alway generate a file-name.
		set grepprg=grep\ -nH\ $*

		" Latex leader: use , instead of `
		let g:Tex_Leader=','

		" Don't fold paragraphs or subsubsections
		" (add ,subsubsection,paragraph to end of list to fold those too)
		let g:Tex_FoldedSections='part,chapter,section,%%fakesection,subsection'

		" Don't fold \item
		" (add item, to the start of list to fold it too)
		let g:Tex_FoldedMisc='preamble,<<<'

		" Directory to scan for latex figure images
		let g:Tex_ImageDir='.'

		" Don't map <c-j> to jump to next <++>
		" (unfortunately we have to give it a bogus mapping)"
		nnoremap <SID>I_won’t_ever_type_this <Plug>IMAP_JumpForward

		" Use PDF instead of DVI by default
		let g:Tex_DefaultTargetFormat='pdf'
		let g:Tex_CompileRule_pdf='rubber --pdf $*'
		if has('unix') && system("uname") == "Darwin\n"  "(mac)
			let g:Tex_ViewRule_pdf='open $*.pdf'
		else
			let g:Tex_ViewRule_pdf='evince'
		endif

	" }}}

" }}}

" MUST BE LAST: Project-specific ~/.vimrc files {{{

    set exrc
    set secure

" }}}
