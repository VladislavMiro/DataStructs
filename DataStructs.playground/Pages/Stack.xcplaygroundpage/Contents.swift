//: [Previous](@previous)

import Foundation

/*
 Стек (от англ. stack — стопка) — структура данных, представляющая из себя упорядоченный набор элементов, в которой добавление
 новых элементов и удаление существующих производится с одного конца, называемого вершиной стека. Притом первым из стека удаляется
 элемент, который был помещен туда последним, то есть в стеке реализуется стратегия «последним вошел — первым вышел» (last-in,
 first-out — LIFO).
*/

//MARK: Реализация стека на массивах

protocol StackProtocol {
    associatedtype T: CustomStringConvertible
    
    var top: T? { get }
    var isEmpty: Bool { get }
    
    mutating func push(element: T)
    mutating func pop() -> T?
}

struct Stack<T:CustomStringConvertible>: CustomStringConvertible {
    
    private var data: [T] = []
    
    public var description: String {
        var data = self.data
        data.reverse()
        return data.description
    }
    
    public var top: T? {
        return data.last
    }
    public var isEmpty: Bool {
        return data.last == nil ? true : false
    }
}

extension Stack:  StackProtocol {

    public mutating func push(element: T) {
        data.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        return data.removeLast()
    }
}

var stack = Stack<Int>()

print("##################")
print("Is empty: ", stack.isEmpty)
print("Top element: ", stack.top ?? "Nil")

stack.push(element: 1)
stack.push(element: 4)
stack.push(element: 6)

print("##################")
print("Is empty: ", stack.isEmpty)
print("Top element: ", stack.top ?? "Nil")
print("Elements of stack: ", stack)

print("##################")
print("Is empty: ", stack.isEmpty)
print("Top element: ", stack.top ?? "Nil")
print("Elements of stack: ", stack)

stack.pop()

print("##################")
print("Is empty: ", stack.isEmpty)
print("Top element: ", stack.top ?? "Nil")
print("Elements of stack: ", stack)


//: [Next](@next)
