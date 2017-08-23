## Problem
This is a two part problem:
1. First, write a series of instructions on how to build out an LRU Cache (pretend
the person you're writing to has no idea how to build one. Don't forget to address
the reasoning behind using particular data structures).
2. Implement an LRU Cache from scratch with no outside references. **Don't look
at the code or instructions from your homework!**

## Solution

### Part 1
Write first part here:
1.
First, we implement an LinkedList, a HashMap, and a max value upon initialization of the cache.
The LinkedList will be our cache, with the most recently used item at the end of the list.
The HashMap will contain keys pointing to Nodes in the list. These keys will be equal to each Node's key.
We must update these values in the HashMap upon deleting and appending to the cache.
If an item exists in the list, we can find it in the HashMap in O(1) time,
then we must delete it from the list and append it to the end of the list since it is now the most recently used.
Both happen in O(1) time.
2.

### Part 2
```ruby
class LRUCache
end
```
