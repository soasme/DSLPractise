#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef char* string;

typedef struct {
    string* keys;
    int* values;
    int size;
} LinearProbing;

LinearProbing* linear_probing_init(int size);
void linear_probing_resize(LinearProbing* table, int size);
int linear_probing_hash(LinearProbing* table, string key);
void linear_probing_set(LinearProbing* table, string key, int value);
int linear_probing_get(LinearProbing* table, string key);
void linear_probing_delete(LinearProbing* table, string key);
void linear_probing_print(LinearProbing* table);
void linear_probing_free(LinearProbing* table);

int
main(int argv, char** args){
    int hello;
    int size = 10;

    LinearProbing* table = linear_probing_init(size);

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
    linear_probing_free(table);
    return 0;
}

LinearProbing*
linear_probing_init(int size){
    LinearProbing* table = (LinearProbing*) malloc (sizeof(LinearProbing));
    table->size = size;
    table->keys = (string*) malloc(sizeof(char) * 20 * size);
    table->values = (int*) malloc(sizeof(string) * size);
    return table;
}

void
linear_probing_free(LinearProbing* table) {
    free(table->keys);
    free(table->values);
    free(table);
}

void
linear_probing_resize(LinearProbing* table, int size){
}

int
linear_probing_hash(LinearProbing* table, string key){
    // ref: https://gist.github.com/soasme/6109366
    unsigned int hash = 0;
    unsigned int x    = 0;
    unsigned int i    = 0;
    for(i = 0; i < table->size; key++, i++) {
        hash = (hash << 4) + (*key);
        if((x = hash & 0xF0000000L) != 0)
        {
        hash ^= (x >> 24);
        }
        hash &= ~x;
    }
    return hash;
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
    int i;
    printf("[table begin]\n");
    for (i = 0; i < table->size; i++) {
        if (table->keys[i] && table->values[i]) {
            printf("[table] %s: %d\n", table->keys[i], table->values[i]);
        }
    }
    printf("[table end]\n");
}
