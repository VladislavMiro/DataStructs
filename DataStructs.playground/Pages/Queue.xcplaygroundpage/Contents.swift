//: [Previous](@previous)

import Foundation

/*
 Очередь (англ. queue)  — это структура данных, добавление и удаление элементов в которой происходит путём операций push и pop
 соответственно. Притом первым из очереди удаляется элемент, который был помещен туда первым, то есть в очереди реализуется
 принцип «первым вошел — первым вышел» (англ. first-in, first-out — FIFO).
*/

//MARK: Реализация очереди на массивах

protocol QueueProtocol {
    
    associatedtype T
    
    var isEmpty: Bool { get }
    var peek: T? { get }
    var count: Int { get }
    
    mutating func enqueue(element: T)
    mutating func dequeue() -> T?
    
}


struct Queue<T>: CustomStringConvertible {
    
    private var elements: [T]
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var count: Int {
        return elements.count
    }
    
    public var peek: T? {
        get {
            return elements.first
        }
    }
    
    public var description: String {
        String(describing: elements)
    }
    
    init() {
        elements = []
    }
    
}

extension Queue: QueueProtocol {
    
    public mutating func enqueue(element: T) {
        elements.append(element)
    }
    
    @discardableResult //Отсутствует предупреждение IDE о неиспользуемом возвращающимся значении
    public mutating func dequeue() -> T? {
        return  isEmpty ? nil : elements.removeFirst()
    }
    
}

var queue = Queue<Int>()

queue.enqueue(element: 1)
queue.enqueue(element: 5)
queue.enqueue(element: 6)

print("Count of elemenst in queue: ", queue.count)
print("Elements of queue: ", queue)
print("Peek of queue: ", queue.peek ?? "Empty queue")

while !queue.isEmpty {
    let element = queue.dequeue()
    print("Dequeue elemnt: ", element ?? "")
}

print("Is empty: ", queue.isEmpty)


//: [Next](@next)
