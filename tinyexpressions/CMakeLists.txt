# CMake project example for tiny expressions.
# Note that cmake will overwrite the Makefile file in the current directory.

project(exp)
cmake_minimum_required(VERSION 2.8)

# Set compile flags
set(CMAKE_C_FLAGS "-std=c99 -Wall -Wextra -pedantic -m32")

# Enumerate all source files
set(SOURCES
	lex.yy.c
	main.c
	memory.c
	pretty.c
	tree.c
	y.tab.c
)

# All source files should be compiled and linked
# as executable "exp"
add_executable(exp ${SOURCES})

# exp should be linked with fl
target_link_libraries(exp fl)

# Produce y.tab.c and y.tab.h using Bison
add_custom_command(
	OUTPUT y.tab.c y.tab.h
	COMMAND bison -y -d exp.y
	DEPENDS exp.y
)

# Produce lex.yy.c using Flex
add_custom_command(
	OUTPUT lex.yy.c
	COMMAND flex exp.l
	DEPENDS exp.l y.tab.h
)
