# Hash Table.

### Find

+ hash function turn key to array index.
+ index collision.

### Hash function

+ O(1).
+ hash code -> index

    int hash(key x):
        (x.hash_code() & 0x7fffffff) % M # M: table size.

+ cache hash code if consuming time.

### Separate Chaining

+ array + linked list
+ list average length: N/M. # N keys, M array items.
+ get(key): `array[hash(key)].get(key)`
+ put(key, value): `array[hash(key)].put(key)`

### Linear Probing

+ 2 arrays: one for saving key, one for saving value.
+ collision?: use next item not used.

    for (i=hash(key); keys[i] != null; i = (i + 1) % M):
        if (keys[i] == key):
            vals[i] = val; # change val.
            return
    keys[i] = key;
    vals[i] = val;

+ delete:
 - delete item and move all the next items.
 - (or set item a special tag?)

+ performance: N/M should be in (1/8, 1/2). Avoid case[.........  . . .]

    put(key):
        if N >= M/2:
            resize # re-hash all keys and values.
        ...

    delete(key):
        if N > 0 and N <= 1/8:
            resize

### Memory Using

SeparateChaningHashST: M SequentialSearchST(16 byte) with reference(8 byte); N node(24 byte with 3 reference[key, value, next]).
LinearProbingHashST: 4N~16N reference.

