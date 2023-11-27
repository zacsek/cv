
all:
	docker run -ti -v miktex:/var/lib/miktex -v `pwd`:/miktex/work -e MIKTEX_UID=`id -u` miktex/miktex:essential pdflatex -output-directory=output main.tex
	cp output/main.pdf Zoltan_Szocs_CV.en.pdf

# all: en de hu
#
# en:
# 	docker run -ti -v miktex:/var/lib/miktex -v `pwd`:/miktex/work -e MIKTEX_UID=`id -u` miktex/miktex:essential pdflatex -output-directory=output en/cv_en.tex
#
# de:
# 	docker run -ti -v miktex:/var/lib/miktex -v `pwd`:/miktex/work -e MIKTEX_UID=`id -u` miktex/miktex:essential pdflatex -output-directory=output de/cv_de.tex
#
# hu:
# 	docker run -ti -v miktex:/var/lib/miktex -v `pwd`:/miktex/work -e MIKTEX_UID=`id -u` miktex/miktex:essential pdflatex -output-directory=output hu/cv_hu.tex

clean:
	rm output/*

