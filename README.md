# C++ Makefile

This repository contains a simple Makefile and provides an auto-configuration script for C+ projects.

## Installation

Download auto-configuration script:
```
cd /tmp
curl -O https://raw.githubusercontent.com/ngharry/cpp-project/master/cppconf.sh
```

Place the downloaded script to `$HOME/bin/` or `/bin`:
```
cp cppconf.sh /bin/
```

## Usage

- `make configure`: creates necessary directories and files for a C++ project.

- `make objects`: builds .o files from .cpp files except for main.cpp, which can be used for testing classes. 

- `make`: builds .o files and links them to an executable file.

- `make DEBUG=true`: enable debugging flags and create a debugable file in bin/

- `make DEBUG=false`: default, disable debugging flags.

- `make BIN=<executable_name>`: specifies executable file name. 

## Bugs Reporting
- Unit testing does not work properly. It requires C++11, even though I added `CXXFLAGS += -std=c++11.

## TODO

- [ ] Unit testing.

- [ ] Build dynamic and static libraries.