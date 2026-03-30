EXAMPLES = $(wildcard site/content/examples/*.qmd)

%.ipynb: %.qmd
	quarto convert $< -o $@

site/content/examples/%.html: site/content/examples/%.qmd .venv
	@ . .venv/bin/activate; cd site/content/examples && quarto render $*.qmd

convert: $(EXAMPLES:.qmd=.ipynb)
render: $(EXAMPLES:.qmd=.html)

.venv:
	@ test -d .venv || uv sync

notes: .venv
	@ . .venv/bin/activate; quarto render lectures --output-dir=../notes/ --to html --profile self

pubnotes: .venv
	@ mkdir -p site/public
	@ . .venv/bin/activate; quarto render lectures --output-dir=../site/public/notes/ --to html

slides: .venv
	@ mkdir -p site/public
	@ . .venv/bin/activate; quarto render lectures --output-dir=../site/public/lectures/ --to revealjs

.PHONY: all clean slides notes convert render

# clean up everything
clean:
	rm -rf notes site/public
	rm -rf .venv
	rm -f site/content/examples/*.ipynb site/content/examples/*.html

.DEFAULT_GOAL := all
