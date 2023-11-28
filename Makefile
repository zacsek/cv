.PHONY: all en de clean

EN_FILES := $(wildcard en/*.tex)
DE_FILES := $(wildcard de/*.tex)

all: en de

en: $(EN_FILES)
	docker run -ti -v miktex:/var/lib/miktex -v `pwd`:/miktex/work -e MIKTEX_UID=`id -u` miktex/miktex:essential pdflatex -output-directory=output en/main.tex
	cp output/main.pdf Zoltan_Szocs_CV.en.pdf

de: $(DE_FILES)
	docker run -ti -v miktex:/var/lib/miktex -v `pwd`:/miktex/work -e MIKTEX_UID=`id -u` miktex/miktex:essential pdflatex -output-directory=output de/main.tex
	cp output/main.pdf Zoltan_Szocs_CV.de.pdf

clean:
	rm output/* Zoltan_Szocs_CV.en.pdf Zoltan_Szocs_CV.de.pdf
