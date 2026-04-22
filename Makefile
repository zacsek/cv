.PHONY: all en de dev clean

IMAGE := zacsek/miktex
DOCKER_RUN := docker run --rm -v $(CURDIR):/home/miktex/work -w /home/miktex/work --user 1000:1000 $(IMAGE)
OUTPUT_DIR := output

EN_FILES := $(wildcard en/*.tex)
DE_FILES := $(wildcard de/*.tex)
DEV_FILES := $(wildcard devCv/*.tex)

all: en de dev

en: $(EN_FILES)
	mkdir -p $(OUTPUT_DIR)
	$(DOCKER_RUN) -interaction=nonstopmode -output-directory=$(OUTPUT_DIR) en/main.tex
	cp $(OUTPUT_DIR)/main.pdf Zoltan_Szocs_CV.en.pdf

de: $(DE_FILES)
	mkdir -p $(OUTPUT_DIR)
	$(DOCKER_RUN) -interaction=nonstopmode -output-directory=$(OUTPUT_DIR) de/main.tex
	cp $(OUTPUT_DIR)/main.pdf Zoltan_Szocs_CV.de.pdf

dev: $(DEV_FILES)
	mkdir -p $(OUTPUT_DIR)
	$(DOCKER_RUN) -interaction=nonstopmode -output-directory=$(OUTPUT_DIR) devCv/main.tex
	cp $(OUTPUT_DIR)/main.pdf Zoltan_Szocs_CV.devCv.pdf

clean:
	rm -rf $(OUTPUT_DIR)/* Zoltan_Szocs_CV.*.pdf
