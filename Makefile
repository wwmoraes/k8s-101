IMAGES_SOURCE_DIR = src/images
IMAGES_DIST_DIR = dist/images
DOCS_SOURCE_DIR = src/docs
DOCS_HTML_DIR = dist/docs
DOCS_LATEX_DIR = dist/docs
SLIDES_SOURCE_DIR = src/slides
SLIDES_HTML_DIR = dist/slides
IMAGES = $(patsubst $(IMAGES_SOURCE_DIR)/%,$(IMAGES_DIST_DIR)/%,$(wildcard $(IMAGES_SOURCE_DIR)/*))
DOCS_SOURCE = $(wildcard $(DOCS_SOURCE_DIR)/*.rst)
DOCS_HTML = $(patsubst $(DOCS_SOURCE_DIR)/%,$(DOCS_HTML_DIR)/%,$(patsubst %.rst,%.html,$(DOCS_SOURCE)))
DOCS_LATEX = $(patsubst $(DOCS_SOURCE_DIR)/%,$(DOCS_LATEX_DIR)/%,$(patsubst %.rst,%.tex,$(DOCS_SOURCE)))
SLIDES_SOURCE = $(wildcard $(SLIDES_SOURCE_DIR)/*.rst)
SLIDES_HTML = $(patsubst $(SLIDES_SOURCE_DIR)/%,$(SLIDES_HTML_DIR)/%,$(patsubst %.rst,%.html,$(SLIDES_SOURCE)))

.DEFAULT_GOAL: dist

.PHONY: dist
dist: docs-html docs-latex slides-html

.PHONY: docs-html
docs-html: $(DOCS_HTML) images

.PHONY: docs-latex
docs-latex: $(DOCS_LATEX) images

.PHONY: slides-html
slides-html: $(SLIDES_HTML) images

.PHONY: images
images: $(IMAGES)

$(DOCS_HTML_DIR)/%.html: $(DOCS_SOURCE_DIR)/%.rst
	@mkdir -p $(DOCS_HTML_DIR)
	$(info rst2html5 $< $@)
	@rst2html5 $< $@

$(DOCS_LATEX_DIR)/%.tex: $(DOCS_SOURCE_DIR)/%.rst
	@mkdir -p $(DOCS_LATEX_DIR)
	$(info rst2latex $< $@)
	@rst2latex $< $@

$(SLIDES_HTML_DIR)/%.html: $(SLIDES_SOURCE_DIR)/%.rst
	@mkdir -p $(SLIDES_HTML_DIR)
	$(info hovercraft $< $@)
	@hovercraft $< $@

$(IMAGES_DIST_DIR)/%: $(IMAGES_SOURCE_DIR)/%
	@mkdir -p $(IMAGES_DIST_DIR)
	$(info cp $< $@)
	@cp $< $@

.PHONY: clean
clean:
	rm -rf $(DOCS_HTML_DIR)
	rm -rf $(DOCS_LATEX_DIR)
	rm -rf $(SLIDES_HTML_DIR)
	rm -rf $(IMAGES_DIST_DIR)
