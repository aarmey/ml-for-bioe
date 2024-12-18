# Change these only to really change the behavior of the whole setup
PANDOCCOMMON := --standalone --embed-resources --mathjax --highlight-style pygments
PANDOCHTML := pandoc -t revealjs $(PANDOCCOMMON) --slide-level 1 --include-in-header=.support-files/style.html -V theme=white -V transition=none -V revealjs-url=https://unpkg.com/reveal.js@5.1.0/
PANDOCNOTESHTML := pandoc -t html --lua-filter=.support-files/speakernotes.lua --metadata-file=.support-files/notes.yml $(PANDOCCOMMON)

## ---- build rules ----
notes_md := $(wildcard lectures/*.md)
notes_html := $(patsubst lectures/%.md, lectures/%.html,$(notes_md))
lec_html := $(patsubst lectures/%.md, website/lectures/%.html, $(notes_md))

$(lec_html): website/lectures/%.html: lectures/%.md
	mkdir -p website/lectures
	$(PANDOCHTML) -o $@ $<

$(notes_html): lectures/%.html: lectures/%.md
	$(PANDOCNOTESHTML) -o $@ $<
# -V fontsize=10pt

html_notes: $(notes_html)
all: $(lec_html) $(notes_html)

# clean up everything
clean:
	rm -f $(lec_html) $(notes_html)

.DEFAULT_GOAL := all
