.PHONY: all altacv devcv dev en de altacv-en altacv-de devcv-en devcv-de clean

IMAGE := zacsek/miktex
DOCKER_RUN := docker run --rm -v $(CURDIR):/home/miktex/work -w /home/miktex/work --user 1000:1000 $(IMAGE) -enable-installer -interaction=nonstopmode
OUTPUT_DIR := output

COMMON_FILES := $(wildcard common/*.sty)
CONTENT_EN   := $(wildcard content/en/*.tex content/en/experience/*.tex)
CONTENT_DE   := $(wildcard content/de/*.tex content/de/experience/*.tex)
ALTA_LAYOUT  := $(wildcard layouts/altacv/*) altacv.cls
DEV_LAYOUT   := $(wildcard layouts/developercv/*) developercv.cls

all: altacv devcv

altacv: altacv-en altacv-de

devcv: devcv-en devcv-de

dev: devcv

en: altacv-en devcv-en

de: altacv-de devcv-de

altacv-en: $(COMMON_FILES) $(CONTENT_EN) $(ALTA_LAYOUT)
	mkdir -p $(OUTPUT_DIR)
	$(DOCKER_RUN) -output-directory=$(OUTPUT_DIR) -jobname=altacv_en layouts/altacv/main_en.tex
	cp $(OUTPUT_DIR)/altacv_en.pdf Zoltan_Szocs_CV.altacv.en.pdf
	cp $(OUTPUT_DIR)/altacv_en.pdf Zoltan_Szocs_CV.en.pdf

altacv-de: $(COMMON_FILES) $(CONTENT_DE) $(ALTA_LAYOUT)
	mkdir -p $(OUTPUT_DIR)
	$(DOCKER_RUN) -output-directory=$(OUTPUT_DIR) -jobname=altacv_de layouts/altacv/main_de.tex
	cp $(OUTPUT_DIR)/altacv_de.pdf Zoltan_Szocs_CV.altacv.de.pdf
	cp $(OUTPUT_DIR)/altacv_de.pdf Zoltan_Szocs_CV.de.pdf

devcv-en: $(COMMON_FILES) $(CONTENT_EN) $(DEV_LAYOUT)
	mkdir -p $(OUTPUT_DIR)
	$(DOCKER_RUN) -output-directory=$(OUTPUT_DIR) -jobname=developercv_en layouts/developercv/main_en.tex
	cp $(OUTPUT_DIR)/developercv_en.pdf Zoltan_Szocs_CV.developercv.en.pdf
	cp $(OUTPUT_DIR)/developercv_en.pdf Zoltan_Szocs_CV.devCv.pdf

devcv-de: $(COMMON_FILES) $(CONTENT_DE) $(DEV_LAYOUT)
	mkdir -p $(OUTPUT_DIR)
	$(DOCKER_RUN) -output-directory=$(OUTPUT_DIR) -jobname=developercv_de layouts/developercv/main_de.tex
	cp $(OUTPUT_DIR)/developercv_de.pdf Zoltan_Szocs_CV.developercv.de.pdf

clean:
	rm -rf $(OUTPUT_DIR)/* Zoltan_Szocs_CV.*.pdf
