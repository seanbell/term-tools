if has('conceal')
	syn match texMathSymbol '\\lor\>' contained conceal cchar=∨
	syn match texMathSymbol '\\land\>' contained conceal cchar=∧
	syn match texMathSymbol '\\lnot\>' contained conceal cchar=¬
	syn match texMathSymbol '\\implies\>' contained conceal cchar=⇒
	syn match texMathSymbol '\\Rightarrow\>' contained conceal cchar=⇒

	if !exists("g:tex_nospell") || !g:tex_nospell
	 syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=text\|mbox\)\s*{'	end='}'	concealends keepend contains=@texFoldGroup,@Spell
	else
	 syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=text\|mbox\)\s*{'	end='}'	concealends keepend contains=@texFoldGroup
	endif
endif
