## ---- user config ----

# directories for markdown sources: notes
NOTES := lectures

## ---- commands ----

# Change these only to really change the behavior of the whole setup

PANDOC := pandoc -t beamer --pdf-engine=xelatex --filter .support-files/overlay_filter --filter .support-files/columnfilter --slide-level 1 --highlight-style pygments --template .support-files/elsmd-slides.latex

## ---- build rules ----

notes_md := $(wildcard $(NOTES)/*.md)
notes_pdf := $(patsubst $(NOTES)/%.md,lectures/%.pdf,$(notes_md))
slides_pdf := $(patsubst $(NOTES)/%.md,lectures/slides/%.pdf,$(notes_md))

# notes_pdf is handled separately
pdfs := $(slides_pdf)

lectures/slides/.touch: 
	mkdir -p lectures/slides
	touch lectures/slides/.touch

$(notes_pdf): lectures/%.pdf: $(NOTES)/%.md
	$(PANDOC) -V beamer-notes=true -V fontsize=10pt -V scuro="" -o $@ $<
	pdfjam -q --nup 2x2 --landscape $@ -o $@

$(slides_pdf): lectures/slides/%.pdf: $(NOTES)/%.md lectures/slides/.touch
	$(PANDOC) -o $@ $< # -V scuro=true   for dark on light theme

phony_pdfs := $(if $(always_latexmk),$(pdfs) $(notes_pdf))

# phony targets to make all three PDFS for a single source
pdfsets := $(notdir $(basename $(notes_md)))

$(pdfsets): %:lectures/%.pdf lectures/slides/%.pdf

.PHONY: $(phony_pdfs) $(pdfsets) all clean deploy

all: $(pdfs) $(notes_pdf)

# clean up everything
clean:
	rm -f $(pdfs) $(notes_pdf)
	rm -rf lectures/slides

.DEFAULT_GOAL := all
