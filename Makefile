clean:
	rm -r thesis/_markdown_fi-lualatex
	mv thesis/fi-lualatex.tex .
	rm thesis/fi-lualatex.*
	mv fi-lualatex.tex thesis/fi-lualatex.tex
