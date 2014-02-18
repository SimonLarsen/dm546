project(formals)

cmake_minimum_required(VERSION 2.8)

add_executable(formals
	formals.c
	lex.yy.c
	main.c
	y.tab.c
)

target_link_libraries(formals fl)

add_custom_command(
	OUTPUT y.tab.c y.tab.h
	COMMAND bison -y -d grammar.y
	DEPENDS grammar.y
)

add_custom_command(
	OUTPUT lex.yy.c
	COMMAND flex lexer.l
	DEPENDS lexer.l y.tab.h
)
