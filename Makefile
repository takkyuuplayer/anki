RESULT=$(shell date '+%s')
setup:
	carton install
	mkdir -p result
test:
	carton exec -- prove -Ilib -r t/
generate:
	find ./data -type f | xargs cat | carton exec -- perl -Ilib ./bin/create-anki-tsv-by-alc.pl > result/${RESULT}.tsv

perl:
	cd docker && $(MAKE) perl
