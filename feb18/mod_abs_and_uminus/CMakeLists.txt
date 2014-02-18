project(exp)
cmake_minimum_required(VERSION 2.8)

set(CMAKE_C_FLAGS "-std=c99 -Wall -Wextra -pedantic -m32")

add_executable(exp
	lex.yy.c
	main.c
	memory.c
	pretty.c
	tree.c
	y.tab.c
)

target_link_libraries(exp fl)

add_custom_command(
	OUTPUT y.tab.c y.tab.h
	COMMAND bison -y -d exp.y
	DEPENDS exp.y
)

add_custom_command(
	OUTPUT lex.yy.c
	COMMAND flex exp.l
	DEPENDS exp.l y.tab.h
)
