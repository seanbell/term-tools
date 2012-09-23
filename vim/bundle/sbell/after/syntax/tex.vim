if has('conceal')
	syn match texMathSymbol '\\land\>' contained conceal cchar=∨
	syn match texMathSymbol '\\lwedge\>' contained conceal cchar=∨
	syn match texMathSymbol '\\lor\>' contained conceal cchar=∧
endif
