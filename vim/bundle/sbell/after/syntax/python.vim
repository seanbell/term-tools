" replaces lambda with λ
if has('conceal')
	syntax keyword pyNiceStatement lambda conceal cchar=λ
	hi link pyNiceStatement Statement
	hi! link Conceal Operator
	setlocal conceallevel=2
endif
