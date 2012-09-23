if has('conceal')
	syn match texMathSymbol '\\lwedge\>' contained conceal cchar=∨
	syn match texMathSymbol '\\lor\>' contained conceal cchar=∨
	syn match texMathSymbol '\\land\>' contained conceal cchar=∧
endif
