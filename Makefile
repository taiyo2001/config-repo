format/fix:
	shfmt -i 2 -ci -sr -w .

format/check:
	shfmt -i 2 -ci -sr -d .
