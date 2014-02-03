#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "bintree.h"

bintree *create_bintree() {
	bintree *tree = malloc(sizeof(bintree));
	tree->root = 0;
	return tree;
}

node *create_node(int key, int value) {
	node *n = malloc(sizeof(node));
	n->left = 0;
	n->right = 0;
	n->p = 0;
	n->key = key;
	n->value = value;
	return n;
}

node *insert(bintree *tree, int key, int value) {
	// Find parent
	node *x = tree->root;
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
	// Insert as root
	node *n = create_node(key, value);
	n->p = p;
	if(p == 0) {
		tree->root = n;
	}
	// Insert as left child
	else if(key <= p->key) {
		p->left = n;
	}
	// Insert as right child
	else {
		p->right = n;
	}
	// Return newly created node
	return n;
}

node *lookup(bintree *tree, int key) {
	node *x = tree->root;
	while(x != 0 && key != x->key) {
		if(key <= x->key) {
			x = x->left;
		} 
		else {
			x = x->right;
		}
	}
	return x;
}

node *minimum(node *x) {
	while(x->left != 0) {
		x = x->left;
	}
	return x;
}
void delete(bintree *tree, node *z) {
	node *y;
	if(z->left == 0) {
		transplant(tree, z, z->right);
	}
	else if(z->right == 0) {
		transplant(tree, z, z->left);
	}
	else {
		y = minimum(z->right);
		if(y->p != z) {
			transplant(tree, y, y->right);
			y->right = z->right;
			y->right->p = y;
		}
		transplant(tree, z, y);
		y->left = z->left;
		y->left->p = y;
	}
}

void transplant(bintree *tree, node *u, node *v) {
	if(u->p == 0) {
		tree->root = v;
	}
	else if(u == u->p->left) {
		u->p->left = v;
	}
	else {
		u->p->right = v;
	}
	if(v != 0) {
		v->p = u->p;
	}
}

void print_inorder(node *n) {
	if(n == 0) return;
	print_inorder(n->left);
	printf("(%d,%d)\n", n->key, n->value);
	print_inorder(n->right);
}

int main() {
	bintree *tree = create_bintree();

	// Insert four nodes
	node *n42 = insert(tree, 42, 123);
	insert(tree, 16, 42);
	node *n64 = insert(tree, 64, 999);
	insert(tree, 4, 31);
	// Print sorted on keys
	print_inorder(tree->root);

	// Delete two nodes and print again
	printf("\nDeleting (42,123) and (64,999)\n");
	delete(tree, n42);
	delete(tree, n64);
	print_inorder(tree->root);

	// Search for node with key 16
	node *n16 = lookup(tree, 16);
	printf("\nlookup(tree, 16) = (%d,%d)\n", n16->key, n16->value);
	return 0;
}
