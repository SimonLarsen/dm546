#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "bintree.h"

bintree *create_bintree() {
	bintree *tree = malloc(sizeof(bintree));
	tree->root = 0;
	return tree;
}

node *create_node(int key) {
	node *n = malloc(sizeof(node));
	n->left = 0;
	n->right = 0;
	n->p = 0;
	n->key = key;
	return n;
}

node *insert(bintree *tree, int key) {
	// Insert as root if tree is empty
	if(tree->root == 0) {
		tree->root = create_node(key);
		return;
	}

	// Find parent
	node *x = root;
	node *p = 0;
	while(x != 0) {
		p = x;
		if(key <= x->key) {
			x = x->left;
		}
		else {
			x = x->right;
		}
	}

	// Insert as left child
	if(key <= p->key) {
		p->left = create_node(key);
		p->left->p = p;
	}
	// Insert as right child
	else {
		p->right = create_node(key);
		p->right->p = p;
	}
}
