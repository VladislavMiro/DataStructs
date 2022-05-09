import Cocoa

/*
 Связный список (англ. List) — структура данных, состоящая из элементов, содержащих помимо собственных данных ссылки на следующий
 и/или предыдущий элемент списка. С помощью списков можно реализовать такие структуры данных как стек и очередь.
 Простейшая реализация списка. В узлах хранятся данные и указатель на следующий элемент в списке.
*/

//Реализация двунаправленного связного спписка

struct LinkedList<T: CustomStringConvertible>: CustomStringConvertible {
    
    private class Node<T: CustomStringConvertible> {
        
        public var value: T
        public var next: Node<T>?
        public var previous: Node<T>?
        
        init(value: T, next: Node<T>? = nil, previous: Node<T>? = nil) {
            self.value = value
            self.next = next
            self.previous = previous
        }
        
        deinit {
            print("Node has deleted")
        }
        
    }
    
    private var head: Node<T>?
    private var tail: Node<T>?
    
    private var firstNode: Node<T>? {
        return head
    }
    
    private var lastNode: Node<T>? {
        guard var node = head else { return nil }
        
        while let next = node.next {
            node = next
        }
        
        return node
    }
    
    public var first: T? {
        guard let value = firstNode?.value else { return nil }
        return value
    }
    
    public var last: T? {
        guard let value = lastNode?.value else { return nil }
        return value
    }
    
    public var count: Int {
        guard var node = head else { return 0 }
        
        var counter = 1
        
        while let next = node.next {
            node = next
            counter += 1
        }
        
        return counter
    }
    
    public var description: String {
        guard var node = head else { return "Empty LinkedList" }
        
        var string: String = "\(node.value)"
        
        while let next = node.next {
            node = next
            string += ", \(next.value)"
        }
        
        return string
    }
    
    //MARK: Добавление элемента
    public mutating func append(_ value: T) {
        let newNode = Node<T>(value: value)
        
        if let lastNode = lastNode {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            //head пустой
            head = newNode
        }
        
        tail = lastNode
    }
    
    public mutating func append(_ collection: [T]) {
        for item in collection {
            append(item)
        }
    }
    
    public mutating func append(_ collection: LinkedList<T>) {
        for index in 0..<collection.count {
            append(collection[index])
        }
    }
    
    public mutating func insert(at index: Int, value: T) {
        assert(index >= 0 && index < count, "Error index out of range")
        
        let newNode = Node<T>(value: value)
        
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else {
            guard let currentNode = getNode(atIndex: index) else { return }
            
            let previousNode = currentNode.previous
            let nextNode = previousNode?.next
            
            newNode.previous = previousNode
            newNode.next = previousNode?.next
            
            previousNode?.next = newNode
            nextNode?.previous = newNode
        }
        
        tail = lastNode

    }
    
    public mutating func insert(at index: Int, collection: [T]) {
        assert(index >= 0 && index < count, "Error index out of range")
        
        var index = index
        
        for item in collection {
            insert(at: index, value: item)
            index += 1
        }

    }
    
    public mutating func insert(at index: Int, collection: LinkedList<T>) {
        assert(index >= 0 && index < count, "Error index out of range")
        
        var index = index
        
        for indexOfElement in 0..<collection.count {
            insert(at: index, value: collection[indexOfElement])
            index += 1
        }
        
    }
    //MARK: Получение/Изменение элемента по индексу
    subscript(index: Int) -> T {
        get {
            assert(index >= 0 && index < count, "Error index out of range")
            let node = getNode(atIndex: index)
            assert(node != nil, "Error! There is no element at index")
            return node!.value
        }
        
        set {
            assert(index >= 0 && index < count, "Error index out of range")
            let node = getNode(atIndex: index)
            assert(node != nil, "Error! There is no element at index")
            node!.value = newValue
        }
    }
    
    private func getNode(atIndex index: Int) -> Node<T>? {
        if index == 0 {
            return head
        } else {
            var node = head?.next
            for _ in 1 ..< index {
                node = node?.next
                if node == nil { break }
            }
            return node
        }
    }
    
    //MARK: Удаление элемента
    private mutating func deleteNode(node: Node<T>) {
        let previousNode = node.previous
        let nextNode = node.next
        
        if let previousNode = previousNode {
            previousNode.next = nextNode
        } else {
            //head
            head = nextNode
        }
        
        nextNode?.previous = previousNode
        node.next = nil
        node.previous = nil
        
        tail = lastNode
    }
    
    public mutating func remove(at index: Int) {
        assert(index >= 0 && index < count, "Error index out of range")
        guard let nodeToRemove = getNode(atIndex: index) else { return }
        deleteNode(node: nodeToRemove)
    }
    
    public mutating func removeFirst() {
        guard let nodeToRemove = firstNode else { return }
        deleteNode(node: nodeToRemove)
    }
    
    public mutating func removeLast() {
        guard let nodeToRemove = lastNode else { return }
        deleteNode(node: nodeToRemove)
    }
    
    public mutating func removeAll() {
        guard let node = head else { return }
        while let node = node.next {
            deleteNode(node: node)
        }
        deleteNode(node: node)
    }
    
    public mutating func reversed() {
        var currentNode = head
        
        while currentNode != nil {
            let tmp = currentNode?.next
            currentNode?.next = currentNode?.previous
            currentNode?.previous = tmp
            currentNode = tmp
        }
        
        currentNode = head
        head = tail
        tail = lastNode
    }
    
}

var linkedList = LinkedList<Int>()

linkedList.append(1)
linkedList.append(2)
linkedList.append(3)

linkedList.count
linkedList[2]
linkedList[2] = 44
linkedList[2]
print("Elements of list: ", linkedList)
linkedList.insert(at: 0, value: 12)
print(linkedList)

var list = LinkedList<Int>()
list.append(linkedList)
print("Elements of list: ", list)
list.append([1,1,1,1,1,1])
print("Elements of list: ", list)
list.insert(at: 4, collection: [2,2])
print("Elements of list: ", list)
list.reversed()
print("Elements of list: ", list)
list.reversed()
print("Elements of list: ", list)
list.removeLast()
list.reversed()
print("Elements of list: ", list)

