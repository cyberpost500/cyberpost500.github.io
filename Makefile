
# All conversion is done in place because this Makefile generates a web site to
# be hosted on github.io.
#
SHELL=/bin/bash

PDF_OPTS:=-V geometry:margin=0.5in       # default is too large, make margins 0.5inches
PDF_OPTS+=-V mainfont="DejaVu Sans"      # using a sans font because this is digital
PDF_OPTS+=-V sansfont="DejaVu Sans"      # turns out, DejaVu is fairly complete, unicode-wise
PDF_OPTS+=-V monofont="DejaVu Sans Mono"
PDF_OPTS+=--latex-engine=xelatex         # to get unicode support in the output, use xelatex
PDF_OPTS+=--highlight-style=tango        # this gives a light background and syntax highlighting
PDF_OPTS+=--toc                          # include table of contents
PDF_OPTS+=-N                             # number the sections, doesn't look
                                         # as pretty, but it's easier to
                                         # refer to a section when it has a
                                         # number.

HTML_OPTS:=--highlight-style=tango
HTML_OPTS+=-s                            #stand-alone
HTML_OPTS+=--css /modules/styles.css
#HTML_OPTS+=--toc

# Anyone adding more content, just copy and paste and update the paths below.
EVERYTHING:=index.html

all: $(EVERYTHING)

%.pdf: %.mkd
	pandoc $(PDF_OPTS) $< -o $@

%.pdf: %.md
	pandoc $(PDF_OPTS) $< -o $@

%.html: %.mkd
	pandoc $(HTML_OPTS) $< -o $@

%.html: %.md
	pandoc $(HTML_OPTS) $< -o $@

index.html: README.md
	@pandoc $(HTML_OPTS) README.md -o index.html
