# Put your project's name right here
# This will generate an executive file named $(PROJ)
PROJ = main

# Because C is a subset of C++, I use C++ Makefile for C projects.
# Select language 
LANG = c
# Uncomment this to choose C++
# LANG = cpp

# Compiler
CXX = g++

# Path for object library
OPATH = lib/build

# Path for library source file
SPATH = lib/src

# Path for library header files 
IPATH = lib/inc

# General flags for g++ compiler
CXXFLAGS = -O2 -Wall -DNDEBUG -I$(IPATH)

ifeq ($(LANG),c)
	CXXFLAGS +=
else 
	# If C++ is chosen, add -std=c++11 to CXXFLAGS
	ifeq ($(LANG),cpp)
		CXXFLAGS += -std=c++11
	endif
endif

# Get all source files in /lib/src and its subdirectories 
SOURCE_LIBS = $(wildcard $(SPATH)/**/*.$(LANG) $(SPATH)/*.$(LANG))

# Get all header files in lib/inc and its subdirectories
HEADER_LIBS = $(wildcard $(IPATH)/**/*.h $(IPATH)/*.h)

# Get all object files by substituting .cpp by .o
# More info: Google "patsubst in Makefile"
OBJ_LIBS = $(patsubst $(SPATH)/%.$(LANG), $(OPATH)/%.o, $(SOURCE_LIBS))

# All necessary files and directories for project
FILES = LICENSE README.md
DIRS = bin lib $(OPATH) $(SPATH) $(IPATH) src

all: $(OBJ_LIBS) $(PROJ)

# Compile object files
class: $(OBJ_LIBS)

# Compile object libraries 
$(OBJ_LIBS): CXXFLAGS += -c # flag for compiling object libraries
$(OBJ_LIBS): $(SOURCE_LIBS) $(HEADER_LIBS) 
	@echo Building object libraries...
	@$(CXX) $(CXXFLAGS) $(SOURCE_LIBS)

	@# Move *.o to lib/build because g++ can not generate multiple .o file
	@# into a specified directory
	@mv *.o -v $(OPATH)

	@echo Finished.

# Compile executive file from src/main.cpp named $(PROJ)
$(PROJ): $(SOURCE_LIBS) $(HEADER_LIBS) src/main.$(LANG)
	@echo Building executive file...
	@$(CXX) $(CXXFLAGS) src/main.$(LANG) $(OBJ_LIBS) -o $@
	@echo Finished.

# Make necessary directories and file
.PHONY: configure
configure:
	@echo Creating neccessary files and directories...
	@mkdir -p $(DIRS)
	@touch $(FILES)
	@echo Finished.

	@# [TODO] It seems like speeding Catch Unite Testing does not work properly, 
	@# it requires C++11, even though I turn flag -std=c++11 on.

	@# Uncomment these lines for configuring unit testing

	@# Download Makefile for Unit Testing from Github
	@#$(RM) test/Makefile
	@#echo Download necessary files...
	@#wget -P test/ $(MAKEFILE_TEST_LINK)
	@# Make the Makefile in test for unit testing
	@# make -C <dir> <option> is for changing the directory for multiple make
	@#make -C test configure 
	
	@#echo Finished

# For debugging purpose.
.PHONY: debug
debug: CXXFLAGS += -g # flag for debuging
debug: 
	@echo Create debuging file...
	@# Generate a.out
	@$(CXX) $(CXXFLAGS) src/main.$(LANG) $(OBJ_LIBS) 
	
	@# Move a.out to bin/ because g++ does not provide any way to
	@# generate a.out file into a specified directory
	@mv a.out bin/
	@echo Finished.

	@echo Entering debugging mode.
	@# Debug
	@gdb bin/a.out 

.PHONY: clean
clean: 
	@echo Cleaning following files: [$(OBJ_LIBS) $(PROJ)]...
	@$(RM) $(OBJ_LIBS) $(PROJ)
	@echo Finished.
