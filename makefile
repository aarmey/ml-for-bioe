## ---- build rules ----
qmd_files := $(wildcard lectures/*.qmd)
notes := $(patsubst lectures/%.qmd, lectures/notes/%.html, $(qmd_files))
slides := $(patsubst lectures/%.qmd, lectures/slides/%.html, $(qmd_files))

notes:
	quarto render lectures --output-dir=../notes/ --to html

slides:
	quarto render lectures --output-dir=../website/lectures/ --to revealjs

.PHONY: all clean slides test-htmlproofer

# clean up everything
clean:
	rm -rf notes website/lectures

.DEFAULT_GOAL := all


# HTMLProofer
HTML_PROOFER ?= bundle exec htmlproofer
HTML_PROOFER_ARGS += --no-check-internal-hash
HTML_PROOFER_ARGS += --ignore_status_codes "412, 503, 403, 406"
