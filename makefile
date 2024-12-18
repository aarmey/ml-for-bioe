# Change these only to really change the behavior of the whole setup

PANDOC := pandoc -t beamer --pdf-engine=lualatex --slide-level 1 --highlight-style pygments --template .support-files/elsmd-slides.latex
PANDOCHTML := pandoc -t revealjs --standalone --embed-resources --mathjax --slide-level 1 --highlight-style pygments -s --include-in-header=.support-files/style.html -V theme=white -V transition=none -V revealjs-url=https://unpkg.com/reveal.js@5.1.0/

## ---- build rules ----

notes_md := $(wildcard lectures/*.md)
notes_pdf := $(patsubst lectures/%.md, lectures/%.pdf,$(notes_md))
pdfs := $(patsubst lectures/%.md, website/public/%.pdf,$(notes_md))
lec_html := $(patsubst lectures/%.md, website/lectures/%.html, $(notes_md))

$(notes_pdf): lectures/%.pdf: lectures/%.md
	$(PANDOC) -V beamer-notes=true -V fontsize=10pt -o $@ $<

$(pdfs): website/public/%.pdf: lectures/%.md
	$(PANDOC) -o $@ $<

$(lec_html): website/lectures/%.html: lectures/%.md
	mkdir -p website/lectures
	$(PANDOCHTML) -o $@ $<

phony_pdfs := $(if $(always_latexmk),$(pdfs) $(notes_pdf))

# phony targets to make all three PDFS for a single source
pdfsets := $(notdir $(basename $(notes_md)))

$(pdfsets): %:lectures/%.pdf website/public/%.pdf

.PHONY: $(phony_pdfs) $(pdfsets) all clean html_lectures

all: $(pdfs) $(notes_pdf) $(lec_html) $(lec_html)
html_lectures: $(lec_html)

# clean up everything
clean:
	rm -f $(pdfs) $(notes_pdf) $(lec_html)

.DEFAULT_GOAL := all
