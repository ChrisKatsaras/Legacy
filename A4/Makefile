all: fortran
	ada
	python

fortran:
	gfortran polish.f95
ada:
	gcc -c polish.adb
	gnatbind polish
	gnatmake polish
python:
	python polish.py
clean:
	rm a.out
	rm *.o
	rm polish
