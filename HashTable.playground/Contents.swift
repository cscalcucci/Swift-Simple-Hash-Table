//: Playground - noun: a place where people can play

import UIKit

class Node<Key: Hashable> {
    var key: Key? = nil
    var value: AnyObject? = nil
    var next: Node?
}

class HashTable<Key: Hashable> {
    
    subscript(key: Key) -> AnyObject? {
        get {
            return getValue(forKey: key)
        }
        set {
            if let value = newValue {
                addValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    private var buckets: [Node<Key>?]
    
    init(size: Int) {
        self.buckets = [Node<Key>?](count: size, repeatedValue: nil)
    }
    
    func getValue(forKey key: Key) -> AnyObject? {
        return buckets[hashKey(key)]?.value
    }
    
    func removeValue(forKey key: Key) {
        if let _ : Node<Key> = buckets[hashKey(key)] {
            buckets[hashKey(key)] = nil
        }
    }
    
    func updateValue(forKey key: Key, value: AnyObject) {
        if let node : Node<Key> = buckets[hashKey(key)] {
            node.value = value
        }
    }
    
    func addValue(value: AnyObject, forKey key: Key) {
        let hashindex : Int = hashKey(key)
        
        let child = Node<Key>()
        var head: Node<Key>!
        
        child.key = key
        
        //check for an existing bucket 
        if (buckets[hashindex] == nil) {
            buckets[hashindex] = child
        } else {
            print("Found collision. Begin chaining.")
            head = buckets[hashindex]
            
            //append new item to the head of the list
            child.next = head
            head = child
            
            //update the chained list
            buckets[hashindex] = head
        }
    }
    
    func hashKey(key: Key) -> Int {
        return key.hashValue % buckets.count
    }
}