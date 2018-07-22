# Put your project's name right here
# This will generate an executive file named $(PROJ)
PROJ = main

# Compiler
CXX = g++

# Path for object library
OPATH = lib/build

# Path for library source file
SPATH = lib/src

# Path for library header files 
IPATH = lib/inc

# General flags for g++ compiler
CXXFLAGS = -O2 -Wall -DNDEBUG -std=c++11 -I$(IPATH)

# Flags for generate object library
LIB_FLAGS = -c 

# Flags for debugging
DEBUG_FLAGS = -g -Wall -I$(IPATH) -std=c++11 

# Flag for output executive file
OUTPUT_FLAGS = -o

# Get all source files in /lib/src and its subdirectories 
SOURCE_LIBS = $(wildcard $(SPATH)/**/*.cpp $(SPATH)/*.cpp)

# Get all header files in lib/inc and its subdirectories
HEADER_LIBS = $(wildcard $(IPATH)/**/*.h $(IPATH)/*.h)

# Get all object files by substituting .cpp by .o
# More info: Google "patsubst in Makefile"
OBJ_LIBS = $(patsubst $(SPATH)/%.cpp, $(OPATH)/%.o, $(SOURCE_LIBS))


# All necessary files and directories for project
WORKING_FILES = LICENSE README.md
WORKING_DIRS = bin lib $(OPATH) $(SPATH) $(IPATH) src

all: $(OBJ_LIBS) $(PROJ)

class: $(OBJ_LIBS)

# Compile object libraries 
$(OBJ_LIBS): $(SOURCE_LIBS) $(HEADER_LIBS)
	@echo Building object libraries...
	@$(CXX) $(CXXFLAGS) $(LIB_FLAGS) $(SOURCE_LIBS)

	@# Move *.o to lib/build because g++ can not generate multiple .o file
	@# into a specified directory
	@mv *.o -v $(OPATH)

	@echo Finished.

# Compile executive file from src/main.cpp named $(PROJ)
$(PROJ): $(SOURCE_LIBS) $(HEADER_LIBS) src/main.cpp
	@echo Building executive files...
	@$(CXX) $(CXXFLAGS) src/main.cpp $(OBJ_LIBS) $(OUTPUT_FLAGS) $@
	@echo Finished.

# Make necessary directories and file
.PHONY: configure
configure:
	@echo Creating working files and directories...
	@mkdir -p $(WORKING_DIRS)
	@touch $(WORKING_FILES)
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
debug: 
	@echo Create debuging file...
	@# Generate a.out
	@$(CXX) $(DEBUG_FLAGS) src/main.cpp $(OBJ_LIBS) 
	
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
