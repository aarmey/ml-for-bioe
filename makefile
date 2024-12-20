## ---- build rules ----
qmd_files := $(wildcard lectures/*.qmd)
notes := $(patsubst lectures/%.qmd, lectures/notes/%.html, $(qmd_files))
slides := $(patsubst lectures/%.qmd, lectures/slides/%.html, $(qmd_files))

notes:
	@ mkdir -p lectures/notes
	quarto render lectures --output-dir=./notes/ --to typst

slides:
	@ mkdir -p website/lectures
	quarto render lectures --output-dir=../website/lectures/ --to revealjs

.PHONY: all clean slides

# clean up everything
clean:
	rm -rf lectures/notes website/lectures

.DEFAULT_GOAL := all
