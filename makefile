# Change these only to really change the behavior of the whole setup
PANDOCHTML := pandoc -t revealjs --mathjax --slide-level 1 --highlight-style pygments -s -V theme=white -V transition=none -V revealjs-url=https://unpkg.com/reveal.js@4.1.0/

## ---- build rules ----

notes_md := $(wildcard lectures/*.md)
lec_html := $(patsubst lectures/%.md, website/lectures/%.html, $(notes_md))

$(lec_html): website/lectures/%.html: lectures/%.md
	mkdir -p website/lectures
	$(PANDOCHTML) -o $@ $<

.PHONY: all clean

all: $(lec_html)

# clean up everything
clean:
	rm -f $(lec_html)

.DEFAULT_GOAL := all
