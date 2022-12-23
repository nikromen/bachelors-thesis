clean:
	rm -rf thesis/_markdown_fi-lualatex
	mv thesis/fi-lualatex.tex .
	rm -f thesis/fi-lualatex.*
	mv fi-lualatex.tex thesis/fi-lualatex.tex
	rm -f bc-thesis.zip

upload:
	zip -r bc-thesis.zip thesis/

rebase:
	mv ~/Downloads/bc-thesis.zip ./bc-thesis.zip
	mv thesis/ thesis_copy/
	unzip bc-thesis.zip -d thesis
	rm -r thesis_copy
	rm bc-thesis.zip

auto-rebase: rebase
	./auto_push.sh
