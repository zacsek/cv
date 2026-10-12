.PHONY: all altacv devcv dev awesomecv en de altacv-en altacv-de devcv-en devcv-de awesomecv-en awesomecv-de clean

IMAGE := zacsek/miktex
DOCKER_RUN := docker run --rm -v $(CURDIR):/home/miktex/work -w /home/miktex/work --user 1000:1000 $(IMAGE) -enable-installer -interaction=nonstopmode
DOCKER_XELATEX := docker run --rm -v $(CURDIR):/home/miktex/work -w /home/miktex/work --user 1000:1000 --entrypoint xelatex $(IMAGE) -enable-installer -interaction=nonstopmode
OUTPUT_DIR := output

COMMON_FILES   := $(wildcard common/*.sty)
CONTENT_EN     := $(wildcard content/en/*.tex content/en/experience/*.tex)
CONTENT_DE     := $(wildcard content/de/*.tex content/de/experience/*.tex)
ALTA_LAYOUT    := $(wildcard layouts/altacv/*) altacv.cls
DEV_LAYOUT     := $(wildcard layouts/developercv/*) developercv.cls
AWESOME_LAYOUT := $(wildcard layouts/awesomecv/*) awesome-cv.cls

all: altacv devcv awesomecv

altacv: altacv-en altacv-de

devcv: devcv-en devcv-de

awesomecv: awesomecv-en awesomecv-de

dev: devcv

en: altacv-en devcv-en awesomecv-en

de: altacv-de devcv-de awesomecv-de

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

awesomecv-en: $(COMMON_FILES) $(CONTENT_EN) $(AWESOME_LAYOUT)
	mkdir -p $(OUTPUT_DIR)
	$(DOCKER_XELATEX) -output-directory=$(OUTPUT_DIR) -jobname=awesomecv_en layouts/awesomecv/main_en.tex
	cp $(OUTPUT_DIR)/awesomecv_en.pdf Zoltan_Szocs_CV.awesomecv.en.pdf

awesomecv-de: $(COMMON_FILES) $(CONTENT_DE) $(AWESOME_LAYOUT)
	mkdir -p $(OUTPUT_DIR)
	$(DOCKER_XELATEX) -output-directory=$(OUTPUT_DIR) -jobname=awesomecv_de layouts/awesomecv/main_de.tex
	cp $(OUTPUT_DIR)/awesomecv_de.pdf Zoltan_Szocs_CV.awesomecv.de.pdf

clean:
	rm -rf $(OUTPUT_DIR)/* Zoltan_Szocs_CV.*.pdf
