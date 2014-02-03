#ifndef __BINTREE_H
#define __BINTREE_H

typedef struct node_t {
	struct node_t *left;
	struct node_t *right;
	struct node_t *p;
	int key;
	int value;
} node;

typedef struct {
	node *root;
} bintree;

bintree *create_bintree();
node *create_node(int key, int value);

node *insert(bintree *tree, int key, int value);
node *lookup(bintree *tree, int key);
node *minimum(node *x);
void delete(bintree *tree, node *z);
void transplant(bintree *tree, node *u, node *t);

void print_inorder(node *n);

#endif
