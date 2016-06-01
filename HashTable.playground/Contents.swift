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
        let index : Int = hashKey(key)
        
        let child = Node<Key>()
        var head: Node<Key>!
        
        child.key = key
        child.value = value
        
        // Checking Buckets
        if (buckets[index] == nil) {
            buckets[index] = child
        } else {
            print("Collision found. Chaining.")
            head = buckets[index]
            
            // Append item to head
            child.next = head
            head = child
            buckets[index] = head
        }
    }
    
    func hashKey(key: Key) -> Int {
        return key.hashValue % buckets.count
    }
}
