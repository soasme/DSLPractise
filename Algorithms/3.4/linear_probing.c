#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef char* string;

typedef struct {
    string* keys;
    int* values;
} LinearProbing;

void linear_probing_init(LinearProbing* table, int size);
void linear_probing_resize(LinearProbing* table, int size);
int linear_probing_hash(LinearProbing* table, string key);
void linear_probing_set(LinearProbing* table, string key, int value);
int linear_probing_get(LinearProbing* table, string key);
void linear_probing_delete(LinearProbing* table, string key);
void linear_probing_print(LinearProbing* table);

int
main(int argv, char** args){
    LinearProbing* table;
    int hello;
    int size = 10;

    linear_probing_init(table, size);

    hello = linear_probing_get(table, "hello");
    printf("first get: %d\n", hello);

    linear_probing_set(table, "hello", 1);

    hello = linear_probing_get(table, "hello");
    printf("get after set: %d\n", hello);

    linear_probing_delete(table, "hello");

    hello = linear_probing_get(table, "hello");
    printf("get after delete: %d\n", hello);

    // collision
    int i;
    for (i = 0; i < 11; i++) {
        string key = (string) malloc (30);
        sprintf(key, "/key/%d", i);

        linear_probing_set(table, key, i);
        int value = linear_probing_get(table, key);
        printf("get %s: %d\n", key, value);
        free(key);
    }

    linear_probing_print(table);
    return 0;
}

void
linear_probing_init(LinearProbing* table, int size){
}

void
linear_probing_resize(LinearProbing* table, int size){
}

int
linear_probing_hash(LinearProbing* table, string key){

}

void
linear_probing_set(LinearProbing* table, string key, int value){

}

int
linear_probing_get(LinearProbing* table, string key){
    return 0;
}

void
linear_probing_delete(LinearProbing* table, string key){

}

void
linear_probing_print(LinearProbing* table) {

}
