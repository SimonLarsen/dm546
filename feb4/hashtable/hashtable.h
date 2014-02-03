#ifndef __HASHTABLE_H
#define __HASHTABLE_H

#define HASH_FACTOR 47

typedef struct {
	int *values;
	int size;
} hash_table;

int hash(hash_table *table, int key);

hash_table *create_hash_table(int size);
void delete_hash_table(hash_table *table);

void insert(hash_table *table, int key, int value);
void delete(hash_table *table, int key);
int lookup(hash_table *table, int key);

#endif
