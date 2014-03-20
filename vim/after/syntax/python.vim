" replaces lambda with λ
"   (borrowed from github.com/ehamberg/vim-cute-python -- that library
"   replaces many more operators which makes it annoying and ugly)
if has('conceal')
	syn keyword pyNiceStatement lambda conceal cchar=λ

	" This is actually kinda annoying, so I'm turning it off for now:
	"
	"syn match pyNiceKeyword "\<\%(math\.\)\?pi\>" conceal cchar=π
	"syn match pyNiceVariable '\a\@<!Delta\%(\a\)\@!' conceal cchar=Δ containedin=pythonFunction
	"syn match pyNiceVariable '\a\@<!Lambda\%(\a\)\@!' conceal cchar=Λ containedin=pythonFunction
	"syn match pyNiceVariable '\a\@<!alpha\%(\a\)\@!' conceal cchar=α containedin=pythonFunction
	"syn match pyNiceVariable '\a\@<!delta\%(\a\)\@!' conceal cchar=δ containedin=pythonFunction
	"syn match pyNiceVariable '\a\@<!epsilon\%(\a\)\@!' conceal cchar=ε containedin=pythonFunction
	"syn match pyNiceVariable '\a\@<!eta\%(\a\)\@!' conceal cchar=η containedin=pythonFunction
	"syn match pyNiceVariable '\a\@<!mu\%(\a\)\@!' conceal cchar=μ containedin=pythonFunction
	"syn match pyNiceVariable '\a\@<!nabla\%(\a\)\@!' conceal cchar=∇ containedin=pythonFunction
	"syn match pyNiceVariable '\a\@<!sigma\%(\a\)\@!' conceal cchar=σ containedin=pythonFunction
	"syn match pyNiceVariable '\a\@<!theta\%(\a\)\@!' conceal cchar=θ containedin=pythonFunction

	hi link pyNiceStatement Statement
	"hi link pyNiceKeyword Keyword
	"hi link pyNiceVariable Variable
	hi! link Conceal Operator
	setlocal conceallevel=2
endif

" Trailing comma warning
syn match PythonTrailingCommaWarning    " [=] .*\(,\)\s*\(#.*\)*$" display
hi! link PythonTrailingCommaWarning Error
