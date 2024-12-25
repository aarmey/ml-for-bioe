notes:
	quarto render lectures --output-dir=../notes/ --to html

slides:
	@ mkdir -p site/public
	quarto render lectures --output-dir=../site/public/lectures/ --to revealjs

.PHONY: all clean slides notes

# clean up everything
clean:
	rm -rf notes site/public

.DEFAULT_GOAL := all
