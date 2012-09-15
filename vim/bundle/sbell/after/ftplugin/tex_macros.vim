" Shortcuts
call IMAP(',w', '\omega', 'tex')
call IMAP(',o', '\omicron', 'tex')
call IMAP('\ig ', '\includegraphics[width=<++>\textwidth]{fig/<++>}', 'tex')

" Reformat lines (getting the spacing correct) {{{
" Note that this clears marks on the current line and eats mark q
" Adapted from: http://tex.stackexchange.com/questions/1548/intelligent-paragraph-reflowing-in-vim
fun! TeX_hardwrap()
	if (getline(".") != "")
		exe "normal mq"

		let op_wrapscan = &wrapscan
		set nowrapscan
		let par_begin = '^\(%D\)\=\s*\($\|%\|\$\$\|\\begin\|\\end\|\\\[\|\\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
		let par_end   = '^\(%D\)\=\s*\($\|%\|\$\$\|\\begin\|\\end\|\\\[\|\\\]\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
		try
			exe '?'.par_begin.'?+'
		catch /E384/
			1
		endtry
		norm V
		try
			exe '/'.par_end.'/-'
		catch /E385/
			$
		endtry
		norm gq
		let &wrapscan = op_wrapscan

		exe "normal `q"
		":ShowMarksClearMark
	endif
endfun

nmap Q <esc>:call TeX_hardwrap()<cr>
" }}}
