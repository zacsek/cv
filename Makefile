.PHONY: all en de clean

EN_FILES := $(wildcard en/*.tex)
DE_FILES := $(wildcard de/*.tex)
DEV_FILES := $(wildcard devCv/*.tex)

all: en de

en: $(EN_FILES)
	docker run -ti -v `pwd`:/data zacsek:miktex_full "pdflatex -output-directory=output en/main.tex"
	cp output/main.pdf Zoltan_Szocs_CV.en.pdf

de: $(DE_FILES)
	docker run -ti -v `pwd`:/data zacsek:miktex_full "pdflatex -output-directory=output de/main.tex"
	cp output/main.pdf Zoltan_Szocs_CV.de.pdf

dev: $(DEV_FILES)
	docker run -ti -v `pwd`:/data zacsek:miktex_full "pdflatex -output-directory=output devCv/main.tex"
	cp output/main.pdf Zoltan_Szocs_CV.devCv.pdf

docker:
	docker build -t zacsek:miktex

clean:
	rm output/* Zoltan_Szocs_CV.en.pdf Zoltan_Szocs_CV.de.pdf
