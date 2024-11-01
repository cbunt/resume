PHONENUM = 1234567890
OUTPUT = resume.pdf
EXTRAOPTS =

all:
	echo "\newcommand{\PHONENUM}{$(PHONENUM)}" \
	| pandoc \
		--pdf-engine=lualatex \
		--lua-filter=WrapItemFilter.lua \
		--metadata fontsize="12pt" \
		--include-in-header=/dev/stdin \
		--include-in-header=header.tex \
		--include-before-body=before.tex \
		$(EXTRAOPTS) \
		--output ./build/$(OUTPUT) \
		resume.md
		

clean:
	rm -fr build/*

install:
	mkdir -p fonts && \
	cd fonts && \
	curl --location --remote-name --remote-header-name --clobber \
	https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFontMono-Regular.ttf && \
	curl --location "https://gwfh.mranftl.com/api/fonts/asap?download=zip&subsets=latin&variants=500,900,500italic,600,600italic,900italic&formats=ttf" \
	| unzip - && \
	for i in $$( find . -name "asap-*.ttf"  ) ; do \
		mv -f $$i $$(echo $$i | sed 's/-v[0-9]\+-latin//') ; \
	done
