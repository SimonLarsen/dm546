#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "hashtable.h"

int hash(hash_table *table, int key) {
	return (HASH_FACTOR * key) % table->size;
}

hash_table *create_hash_table(int size) {
	// Allocate hash_table structure
	hash_table *table = malloc(sizeof(hash_table));

	// Set hash_table size
	table->size = size;
	// Allocate array of values
	table->values = malloc(sizeof(int)*size);
	// Set all values to zero
	memset(table->values, 0, sizeof(int)*size);

	return table;
}

void delete_hash_table(hash_table *table) {
	// Free inner members first!
	free(table->values);
	// Then structure itself
	free(table);
}

void insert(hash_table *table, int key, int value) {
	int bucket = hash(table, key);
	table->values[bucket] = value;
}

void delete(hash_table *table, int key) {
	int bucket = hash(table, key);
	table->values[bucket] = 0;
}

int lookup(hash_table *table, int key) {
	int bucket = hash(table, key);
	return table->values[bucket];
}

int main(int argc, char** argv) {
	hash_table *table = create_hash_table(123);

	printf("Insert (123, 42)\n");
	insert(table, 123, 42);
	printf("Lookup: %d = %d\n", 123, lookup(table, 123));

	printf("Delete key 123\n");
	delete(table, 123);
	printf("Lookup: %d = %d\n", 123, lookup(table, 123));

	delete_hash_table(table);
	return 0;
}
