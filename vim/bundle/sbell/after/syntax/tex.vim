if has('conceal')
	" more reasonably sized symbols that were already defined
	syn match texMathSymbol '\\Rightarrow\>' contained conceal cchar=⇒
	syn match texMathSymbol '\\Leftarrow\>' contained conceal cchar=⇐
	syn match texMathSymbol '\\rightarrow\>' contained conceal cchar=→
	syn match texMathSymbol '\\leftarrow\>' contained conceal cchar=←
	syn match texMathSymbol '\\emptyset\>' contained conceal cchar=Ø

	" logical symbols
	syn match texMathSymbol '\\lor\>' contained conceal cchar=∨
	syn match texMathSymbol '\\land\>' contained conceal cchar=∧
	syn match texMathSymbol '\\lnot\>' contained conceal cchar=¬
	syn match texMathSymbol '\\implies\>' contained conceal cchar=⇒

	" whitespace markers
	"syn match texMathSymbol '\\quad' contained conceal cchar=␣
	"syn match texMathSymbol '\\qquad' contained conceal cchar=␣
	"syn match texMathSymbol '\\\ ' contained conceal cchar=␣
	"syn match texMathSymbol '\\,' contained conceal cchar=␣

	" \mathbb characters
	syn match texMathSymbol '\\mathbb{A}' contained conceal cchar=𝔸
	syn match texMathSymbol '\\mathbb{B}' contained conceal cchar=𝔹
	syn match texMathSymbol '\\mathbb{C}' contained conceal cchar=ℂ
	syn match texMathSymbol '\\mathbb{D}' contained conceal cchar=𝔻
	syn match texMathSymbol '\\mathbb{E}' contained conceal cchar=𝔼
	syn match texMathSymbol '\\mathbb{F}' contained conceal cchar=𝔽
	syn match texMathSymbol '\\mathbb{G}' contained conceal cchar=𝔾
	syn match texMathSymbol '\\mathbb{H}' contained conceal cchar=ℍ
	syn match texMathSymbol '\\mathbb{I}' contained conceal cchar=𝕀
	syn match texMathSymbol '\\mathbb{J}' contained conceal cchar=𝕁
	syn match texMathSymbol '\\mathbb{K}' contained conceal cchar=𝕂
	syn match texMathSymbol '\\mathbb{L}' contained conceal cchar=𝕃
	syn match texMathSymbol '\\mathbb{M}' contained conceal cchar=𝕄
	syn match texMathSymbol '\\mathbb{N}' contained conceal cchar=ℕ
	syn match texMathSymbol '\\mathbb{O}' contained conceal cchar=𝕆
	syn match texMathSymbol '\\mathbb{P}' contained conceal cchar=ℙ
	syn match texMathSymbol '\\mathbb{Q}' contained conceal cchar=ℚ
	syn match texMathSymbol '\\mathbb{R}' contained conceal cchar=ℝ
	syn match texMathSymbol '\\mathbb{S}' contained conceal cchar=𝕊
	syn match texMathSymbol '\\mathbb{T}' contained conceal cchar=𝕋
	syn match texMathSymbol '\\mathbb{U}' contained conceal cchar=𝕌
	syn match texMathSymbol '\\mathbb{V}' contained conceal cchar=𝕍
	syn match texMathSymbol '\\mathbb{W}' contained conceal cchar=𝕎
	syn match texMathSymbol '\\mathbb{X}' contained conceal cchar=𝕏
	syn match texMathSymbol '\\mathbb{Y}' contained conceal cchar=𝕐
	syn match texMathSymbol '\\mathbb{Z}' contained conceal cchar=ℤ

	" \mathcal characters
	syn match texMathSymbol '\\mathcal{A}' contained conceal cchar=𝓐
	syn match texMathSymbol '\\mathcal{B}' contained conceal cchar=𝓑
	syn match texMathSymbol '\\mathcal{C}' contained conceal cchar=𝓒
	syn match texMathSymbol '\\mathcal{D}' contained conceal cchar=𝓓
	syn match texMathSymbol '\\mathcal{E}' contained conceal cchar=𝓔
	syn match texMathSymbol '\\mathcal{F}' contained conceal cchar=𝓕
	syn match texMathSymbol '\\mathcal{G}' contained conceal cchar=𝓖
	syn match texMathSymbol '\\mathcal{H}' contained conceal cchar=𝓗
	syn match texMathSymbol '\\mathcal{I}' contained conceal cchar=𝓘
	syn match texMathSymbol '\\mathcal{J}' contained conceal cchar=𝓙
	syn match texMathSymbol '\\mathcal{K}' contained conceal cchar=𝓚
	syn match texMathSymbol '\\mathcal{L}' contained conceal cchar=𝓛
	syn match texMathSymbol '\\mathcal{M}' contained conceal cchar=𝓜
	syn match texMathSymbol '\\mathcal{N}' contained conceal cchar=𝓝
	syn match texMathSymbol '\\mathcal{O}' contained conceal cchar=𝓞
	syn match texMathSymbol '\\mathcal{P}' contained conceal cchar=𝓟
	syn match texMathSymbol '\\mathcal{Q}' contained conceal cchar=𝓠
	syn match texMathSymbol '\\mathcal{R}' contained conceal cchar=𝓡
	syn match texMathSymbol '\\mathcal{S}' contained conceal cchar=𝓢
	syn match texMathSymbol '\\mathcal{T}' contained conceal cchar=𝓣
	syn match texMathSymbol '\\mathcal{U}' contained conceal cchar=𝓤
	syn match texMathSymbol '\\mathcal{V}' contained conceal cchar=𝓥
	syn match texMathSymbol '\\mathcal{W}' contained conceal cchar=𝓦
	syn match texMathSymbol '\\mathcal{X}' contained conceal cchar=𝓧
	syn match texMathSymbol '\\mathcal{Y}' contained conceal cchar=𝓨
	syn match texMathSymbol '\\mathcal{Z}' contained conceal cchar=𝓩

	" hide \text delimiter etc inside math mode
	if !exists("g:tex_nospell") || !g:tex_nospell
	 syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=text\|mbox\)\s*{'	end='}'	concealends keepend contains=@texFoldGroup,@Spell
	else
	 syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=text\|mbox\)\s*{'	end='}'	concealends keepend contains=@texFoldGroup
	endif

	"""
	" Contributed by Wenzel Jakob
	syn match texStatement '\\item\>' contained conceal cchar=•
	syn match texDelimiter '\\{' contained conceal cchar={
	syn match texDelimiter '\\}' contained conceal cchar=}
	syn match texMathSymbol '\\setminus' contained conceal cchar=\

	" hide \text delimiter etc inside math mode
	if !exists("g:tex_nospell") || !g:tex_nospell
	syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=text\|mbox\|mathrm\)\s*{' end='}' concealends keepend contains=@texFoldGroup,@Spell
	else
	syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=text\|mbox\|mathrm\)\s*{' end='}' concealends keepend contains=@texFoldGroup
	endif

	syn region texBoldMathText matchgroup=texStatement start='\\\(mathbf\|bm\){' end='}' concealends keepend contains=@texMathZoneGroup
	syn cluster texMathZoneGroup add=texBoldMathText

	hi texBoldMathText ctermfg=white guifg=white
	"""
endif
