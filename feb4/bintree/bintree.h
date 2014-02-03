#ifndef __BINTREE_H
#define __BINTREE_H

typedef struct {
	node *left;
	node *right;
	node *p;
	int key;
} node;

typedef struct {
	node *root;
} bintree;

bintree *create_bintree();
node *create_node(int key);

void insert(bintree *tree, int key);
void delete(

#endif
