DOCS_SOURCE_DIR = docs
DOCS_HTML_DIR = dist/docs/html
DOCS_LATEX_DIR = dist/docs/latex
SLIDES_SOURCE_DIR = slides
SLIDES_HTML_DIR = dist/slides/html
DOCS_SOURCE = $(wildcard $(DOCS_SOURCE_DIR)/*.rst)
DOCS_HTML = $(patsubst $(DOCS_SOURCE_DIR)/%,$(DOCS_HTML_DIR)/%,$(patsubst %.rst,%.html,$(DOCS_SOURCE)))
DOCS_LATEX = $(patsubst $(DOCS_SOURCE_DIR)/%,$(DOCS_LATEX_DIR)/%,$(patsubst %.rst,%.tex,$(DOCS_SOURCE)))
SLIDES_SOURCE = $(wildcard $(SLIDES_SOURCE_DIR)/*.rst)
SLIDES_HTML = $(patsubst $(SLIDES_SOURCE_DIR)/%,$(SLIDES_HTML_DIR)/%,$(patsubst %.rst,%.html,$(SLIDES_SOURCE)))

.DEFAULT_GOAL: dist

.PHONY: dist
dist: docs-html docs-latex slides-html

.PHONY: docs-html
docs-html: $(DOCS_HTML)

.PHONY: docs-latex
docs-latex: $(DOCS_LATEX)

.PHONY: slides-html
slides-html: $(SLIDES_HTML)

$(DOCS_HTML_DIR)/%.html: docs/%.rst
	@mkdir -p $(DOCS_HTML_DIR)
	$(info rst2html5 $< $@)
	@rst2html5 $< $@

$(DOCS_LATEX_DIR)/%.tex: docs/%.rst
	@mkdir -p $(DOCS_LATEX_DIR)
	$(info rst2latex $< $@)
	@rst2latex $< $@

$(SLIDES_HTML_DIR)/%.html: slides/%.rst
	@mkdir -p $(SLIDES_HTML_DIR)
	$(info rst2html5slides $< $@)
	@rst2html5slides $< $@

.PHONY: clean
clean:
	rm -f $(DOCS_HTML_DIR)/*.html
	rm -f $(DOCS_LATEX_DIR)/*.tex
	rm -f $(SLIDES_HTML_DIR)/*.html
