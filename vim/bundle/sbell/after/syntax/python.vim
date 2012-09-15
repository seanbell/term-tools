" replaces lambda with λ
"   (borrowed from github.com/ehamberg/vim-cute-python -- that library
"   replaces many more operators which makes it annoying and ugly)
if has('conceal')
	syntax keyword pyNiceStatement lambda conceal cchar=λ
	hi link pyNiceStatement Statement
	hi! link Conceal Operator
	setlocal conceallevel=2
endif
