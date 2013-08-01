# -*- coding: utf-8 -*-

class NullItem(object):
    def __repr__(self):
        return 'Null'
nullitem = NullItem()

class LinearProbingHashTable(object):

    def get(self, key):
        start = self.hash(key)
        index = start
        while True:
            if not self.keys[index]:
                return
            if self.keys[index] and self.keys[index] == key:
                return self.values[index]
            index = (index + 1) % self.size
            if index == start:
                raise Exception

    def set(self, key, value):
        if self.existing_keys * 2 >= self.size:
            self.resize(self.size * 2)

        start = self.hash(key)
        index = start
        while True:
            if not self.keys[index]:
                self.keys[index] = key
                self.values[index] = value
                self.existing_keys += 1
                return
            if self.keys[index] and self.keys[index] == nullitem:
                self.keys[index] = key
                self.values[index] = value
                self.existing_keys += 1
                return
            if self.keys[index] and self.keys[index] == key:
                self.values[index] = value
                self.existing_keys += 1
                return
            index = (index + 1) % self.size
            if index == start:
                raise Exception

    def delete(self, key):
        if self.existing_keys * 8 <= self.size:
            self.resize(self.size / 2)

        start = self.hash(key)
        index = start
        while True:
            if not self.keys[index]:
                return
            if self.keys[index] and self.keys[index] == key:
                self.keys[index] = nullitem
                self.existing_keys -= 1
                return
            index = (index + 1) % self.size
            if index == start:
                return


    def resize(self, size):
        new_keys, new_values = self.init(size)
        for i, item in enumerate(zip(self.keys, self.values)):
            k, v = item
            if not k:
                continue
            start = self.hash(k, size)
            index = start
            while True:
                if not new_keys[index]:
                    new_keys[index] = k
                    new_values[index] = v
                    break
                if new_keys[index] and new_keys[index] == k:
                    new_values[index] = v
                    break
                index = (index + 1) % size
                if index == start:
                    raise Exception
        self.keys = new_keys
        self.values = new_values
        self.size = size

    def hash(self, key, size=None):
        if not size:
            size = self.size
        return hash(key) % size

    def init(self, size):
        keys = []
        values = []
        for i in range(size):
            keys.append(None)
            values.append(None)

        return keys, values

    def __init__(self, size):
        self.size = size
        self.existing_keys = 0
        self.keys, self.values = self.init(size)


table = LinearProbingHashTable(5)
table.set('hello', 1)
print table.keys, table.values, table.existing_keys
print table.get('hello')
table.set('hello', 2)
print table.get('hello')
print table.keys, table.values, table.existing_keys
for i in range(4):
    key = "hello/%s" % i
    table.set(key, i)
    print table.get(key)
    print table.keys, table.values, table.existing_keys

for i in range(4):
    key = "hello/%s" % i
    table.delete(key)
    print table.get(key)
    print table.keys, table.values, table.existing_keys, table.size
