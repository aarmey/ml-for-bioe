# Change these only to really change the behavior of the whole setup

PANDOC := pandoc -t beamer --pdf-engine=lualatex --filter .support-files/overlay_filter --filter .support-files/columnfilter --slide-level 1 --highlight-style pygments --template .support-files/elsmd-slides.latex

## ---- build rules ----

notes_md := $(wildcard lectures/*.md)
notes_pdf := $(patsubst lectures/%.md, lectures/%.pdf,$(notes_md))
pdfs := $(patsubst lectures/%.md, website/public/%.pdf,$(notes_md))

$(notes_pdf): lectures/%.pdf: lectures/%.md
	$(PANDOC) -V beamer-notes=true -V fontsize=10pt -V scuro="" -o $@ $<
	pdfjam -q --nup 2x2 --landscape $@ -o $@

$(pdfs): website/public/%.pdf: lectures/%.md
	$(PANDOC) -o $@ $< # -V scuro=true   for dark on light theme

phony_pdfs := $(if $(always_latexmk),$(pdfs) $(notes_pdf))

# phony targets to make all three PDFS for a single source
pdfsets := $(notdir $(basename $(notes_md)))

$(pdfsets): %:lectures/%.pdf website/public/%.pdf

.PHONY: $(phony_pdfs) $(pdfsets) all clean

all: $(pdfs) $(notes_pdf)

# clean up everything
clean:
	rm -f $(pdfs) $(notes_pdf)

.DEFAULT_GOAL := all
