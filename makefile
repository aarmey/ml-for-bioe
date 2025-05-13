EXAMPLES = $(wildcard site/content/examples/*.qmd)

%.ipynb: %.qmd
	quarto convert $< -o $@

site/content/examples/%.html: site/content/examples/%.qmd site/content/examples/.venv
	@ . site/content/examples/.venv/bin/activate; cd site/content/examples && quarto render $*.qmd

convert: $(EXAMPLES:.qmd=.ipynb)
render: $(EXAMPLES:.qmd=.html)

site/content/examples/.venv:
	@ cd site/content/examples && test -d .venv || uv sync

notes:
	quarto render lectures --output-dir=../notes/ --to html --profile self

pubnotes:
	@ mkdir -p site/public
	quarto render lectures --output-dir=../site/public/notes/ --to html

slides:
	@ mkdir -p site/public
	quarto render lectures --output-dir=../site/public/lectures/ --to revealjs

.PHONY: all clean slides notes convert render

# clean up everything
clean:
	rm -rf notes site/public
	rm -rf site/content/examples/.venv
	rm -f site/content/examples/*.ipynb site/content/examples/*.html

.DEFAULT_GOAL := all
