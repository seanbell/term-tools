" Sean's Vim functions

" FSHere -- always open header on left and source on right
"   -- don't open again if already open
function FSSplitSmart()
	" Right now fswitch doesn't work with tagbar open, so close it
	exec ":TagbarClose"
    if !exists("b:fswitchdst") || strlen(b:fswitchdst) == 0
        throw 'Not a recognized header/source type (read :help fswitch)'
    endif

	let hn = FSReturnReadableCompanionFilename('%')
	echo hn
	let s:winlist = []
	windo let s:winlist += [[ winnr(), expand('%:p') ]]
	for b in s:winlist
		if hn == b[1]
			" file is open -- go to it
			call FSNerd(b[0] . "wincmd w")
			return
		endif
	endfor
	" file is closed -- open it split-screen
	let e = expand('%:e')
	if e  == 'h' || e == 'hpp'
		call FSNerd(":FSSplitRight")
	else
		call FSNerd(":FSSplitLeft")
	endif
endfunction

" This function keeps the NERDTree synchronized with FSwitch
function FSNerd(cmd)
	" Right now fswitch doesn't work with tagbar open, so close it
	exec ":TagbarClose"
    if !exists("b:fswitchdst") || strlen(b:fswitchdst) == 0
        throw 'Not a recognized header/source type (read :help fswitch)'
    endif

	if exists("t:NERDTreeBufName")
		let ntbn_id = bufwinnr(t:NERDTreeBufName)
		if ntbn_id == winnr()
			" inside the NERDTree
			silent exe ":NERDTreeToggle"
			exe a:cmd
			silent exe ":NERDTreeFind"
		elseif ntbn_id != -1
			" NERDTree is open but we're not in it
			exe a:cmd
			silent exe ":NERDTreeFind"
			wincmd p
		else
			" NERDTree is closed
			exe a:cmd
		endif
	else
		" NERDTree is closed
		exe a:cmd
	endif
endfunction

"" EasyMotion -- jump repeatedly if inside NERDTree (dir=0 : down, 1 : up)
"function EMNerd(dir)
	"let orig_pos = [line('.'), col('.')]
	"call EasyMotion#JK(0, a:dir)
	"let new_pos = [line('.'), col('.')]
	"if orig_pos != new_pos && exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) == winnr()
		"silent exec 'normal o'
		"if a:dir == 0 && exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) == winnr()
			"call EMNerd(a:dir)
		"endif
	"endif
"endfunction

"" NERDTree -- open files from file tree with <leader>ao
"function NERDOpenEM()
	"call NERDTreeFocus()
	"exec 'normal 2H'
	"wincmd =
	"call EMNerd(0)
"endfunction

function NERDTreeTabsFind()
	silent NERDTreeTabsOpen
	silent NERDTreeSteppedClose
	silent NERDTreeFind
endfunction

" Move a window (if more than one window) to the previous/next tab
" Adapted from: http://vim.wikia.com/wiki/Move_current_window_between_tabs
function MoveToPrevTab()
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    vsp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
function MoveToNextTab()
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    vsp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
