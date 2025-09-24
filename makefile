PHONENUM = 1234567890
OUTPUT = resume.pdf
EXTRAOPTS =

TEMP_DIR := $(shell mktemp -d)

all:
	export TEXMFVAR=$(TEMP_DIR) \
	&& echo "\newcommand{\PHONENUM}{$(PHONENUM)}" \
	| pandoc \
		--pdf-engine=xelatex \
		--metadata-file="metadata.yaml" \
		--include-in-header=header.tex \
		--include-in-header=/dev/stdin \
		--include-before-body=before.tex \
		$(EXTRAOPTS) \
		--output ./build/$(OUTPUT) \
		resume.md \
	&& rm -fr $(TEMP_DIR)

clean:
	rm -fr build/* \
	&& rm -fr $(TEMP_DIR)
