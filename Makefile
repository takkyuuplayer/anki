setup:
	carton install
test:
	carton exec -- prove -Ilib -r t/
generate:
	find ./data -type f | xargs cat | carton exec -- perl -Ilib ./bin/create-anki-tsv.pl > anki-result.tsv
