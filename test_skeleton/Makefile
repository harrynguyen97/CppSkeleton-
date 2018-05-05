CC = g++

OBJFLAGS = -c

INC = -I../lib/inc -Iinc

CPP_FLAGS = -O2 -Wall $(INC)

OBJ_SPEED_UP_TEST = speed_up_test.o

SRC_SPEED_UP_TEST = src/speed-up-test/speed_up_test.cpp

TEST_SRC_FILE = $(wildcard src/*.cpp)

OBJ_FILE = $(wildcard ../lib/build/*.o)

all: test-run

configure: test_skeleton speed
speed: $(SRC_SPEED_UP_TEST)
	@echo Speeding up testing...
	@$(CC) $(OBJFLAGS) $(INC) $(SRC_SPEED_UP_TEST)
	@mv $(OBJ_SPEED_UP_TEST) build
	@echo Finished.

test-run: $(TEST_SRC_FILE)
	@echo Building executive test file 
	$(CC) $(CPP_FLAGS) $(TEST_SRC_FILE) $(OBJ_FILE) build/$(OBJ_SPEED_UP_TEST) -o $@

	@echo Finished.

test_skeleton: 
	@echo Creating working files and directories...
	@mkdir -p build inc src src/speed-up-test 
	@echo Finished.

.PHONY: clean
clean:
	@echo Cleaning executive test files...
	@$(RM) -rf test-run
	@echo Finished.