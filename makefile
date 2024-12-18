# Change these only to really change the behavior of the whole setup
PANDOCCOMMON := --standalone --mathml --highlight-style pygments
PANDOCHTML := pandoc -t revealjs $(PANDOCCOMMON) --slide-level 1 --include-in-header=.support-files/style.html -V theme=white -V transition=none -V revealjs-url=https://unpkg.com/reveal.js@5.1.0/
PANDOCNOTESHTML := pandoc -t html $(PANDOCCOMMON) --embed-resources --lua-filter=.support-files/speakernotes.lua --metadata-file=.support-files/notes.yml

## ---- build rules ----
notes_md := $(wildcard lectures/*.md)
notes_html := $(patsubst lectures/%.md, lectures/%.html,$(notes_md))
lec_html := $(patsubst lectures/%.md, website/lectures/%.html, $(notes_md))

website/lectures/lectures/figs:
	mkdir -p website/lectures
	mkdir -p website/lectures/lectures
	cp -R lectures/figs website/lectures/lectures/

$(lec_html): website/lectures/%.html: lectures/%.md website/lectures/lectures/figs
	$(PANDOCHTML) -o $@ $<

$(notes_html): lectures/%.html: lectures/%.md
	$(PANDOCNOTESHTML) -o $@ $<
# -V fontsize=10pt

html_notes: $(notes_html)
all: $(lec_html) $(notes_html)

# clean up everything
clean:
	rm -rf website/lectures $(notes_html)

.DEFAULT_GOAL := all
