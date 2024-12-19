# Change these only to really change the behavior of the whole setup
PANDOCCOMMON := --standalone --mathml --highlight-style pygments
PANDOCHTML := pandoc --pdf-engine=typst --highlight-style pygments --template .support-files/slides.typ
PANDOCNOTES := pandoc --pdf-engine=typst --highlight-style pygments --lua-filter=.support-files/speakernotes.lua --metadata-file=.support-files/notes.yml

## ---- build rules ----
notes_md := $(wildcard lectures/*.md)
notes_pdf := $(patsubst lectures/%.md, lectures/%.pdf,$(notes_md))
lec_html := $(patsubst lectures/%.md, website/lectures/%.pdf, $(notes_md))

website/lectures/lectures/figs:
	mkdir -p website/lectures
	mkdir -p website/lectures/lectures
	cp -R lectures/figs website/lectures/lectures/

$(lec_html): website/lectures/%.pdf: lectures/%.md website/lectures/lectures/figs
	$(PANDOCHTML) -o $@ $<

$(notes_pdf): lectures/%.pdf: lectures/%.md
	$(PANDOCNOTES) -o $@ $<
# -V fontsize=10pt

pdf_notes: $(notes_pdf)
all: $(lec_html) $(notes_pdf)

# clean up everything
clean:
	rm -rf website/lectures $(notes_pdf)

.DEFAULT_GOAL := all
