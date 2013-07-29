# -*- coding: utf-8 -*-

class NotFound(Exception): pass

class SeparateChanningHashTable(object):

    def __init__(self, size=20):
        self.size = size
        self.array = []
        for i in range(size):
            self.array.append([])

    def hash(self, key):
        return hash(key) % self.size

    def search_node(self, key):
        index = self.hash(key)
        return self.array[index]

    def set(self, key, value):
        node = self.search_node(key)
        for item in node:
            if item[0] == key:
                item[1] = value
                return

        node.append((key, value))

    def get(self, key):
        node = self.search_node(key)

        for item in node:
            if item[0] == key:
                return item[1]

        raise NotFound, key

    def delete(self, key):
        node = self.search_node(key)
        for item in node:
            if item[0] == key:
                node.remove(item)

HashTable = SeparateChanningHashTable

table = HashTable()
table.set('hello', 'world')
print table.get('hello')
table.delete('hello')
table.get('hello')

'''world
Traceback (most recent call last):
  File "seperate_channing.py", line 51, in <module>
    table.get('hello')
  File "seperate_channing.py", line 35, in get
    raise NotFound, key
__main__.NotFound: hello
'''
