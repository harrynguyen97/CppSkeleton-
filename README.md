# CppSkeleton- #
Makefile which can be used in both C and C++ projects

* **Feature:**
	* Compile both C and C++ project, specify by $LANG. 
	* Make seperate class in C++.
	* Generate binary file with any name, specify by $NAME.

* **Usage:**
	* `make configure`: create neccessary files and dirs for the project.
	* `make LANG=c`: compile C project.
	* `make LANG=cpp`: compile C++ project.
	* `make name_of_class`: compile class to object files.
	* `make debug`: enter debugging mode.
	* `make clean`: clean unnecessary files.

	* `make LANG=c NAME=project_name`: specify language and name of project.
