import Foundation

/*
 Двоичное дерево — иерархическая структура данных, в которой каждый узел имеет не более двух
 потомков. Как правило, первый называется родительским узлом, а дети называются левым и
 правым наследниками. Двоичное дерево является упорядоченным ориентированным деревом.
 */

//MARK: Реализация двоичного дерева поиска

/*
 Бинарное дерево поиска (англ. binary search tree, BST) — структура данных для работы с
 упорядоченными множествами.
 Бинарное дерево поиска обладает следующим свойством: если x — узел бинарного дерева с ключом k,
 то все узлы в левом поддереве должны иметь ключи, меньшие k, а в правом поддереве большие k.
 */

struct BinnaryTree<T: Comparable> {
    //MARK: Узел дерева
    private class Node<T: Comparable> {
        public var value: T
        public var leftChild: Node?
        public var rightChild: Node?
        
        init(value: T, leftChild: Node?, rightChild: Node?) {
            self.value = value
            self.leftChild = leftChild
            self.rightChild = rightChild
        }
    }
    
    //MARK: Корневой узел
    private var head: Node<T>?
    
    init() {
        self.head = nil
    }
    
    //MARK: Поиск максимального хначения в дереве
    public var max: T? {
        guard let node = head else { return nil }
        let maxVal = maxValue(root: node)
        return maxVal
    }
    
    private func maxValue(root: Node<T>) -> T {
        return root.rightChild == nil ? root.value : maxValue(root: root.rightChild!)
    }
    
    //MARK: Поиск минимльного значения в дереве
    public var min: T? {
        guard let node = head else { return nil }
        let minVal = minValue(root: node)
        return minVal
    }
    
    private func minValue(root: Node<T>) -> T {
        return root.leftChild == nil ? root.value : minValue(root: root.leftChild!)
    }
    
    //MARK: Добавление элемента
    public mutating func append(_ element: T) {
        //Если корневой узел пустой, то создать его
        if head == nil {
            head = Node(value: element, leftChild: nil, rightChild: nil)
        } else {
            //Иначе добавить новый узел
            let node = Node(value: element, leftChild: nil, rightChild: nil)
            appendElement(currentNode: head, newNode: node)
        }
    }
    //Рекурсивный метод
    private func appendElement(currentNode: Node<T>?, newNode: Node<T>) {
        guard let currentNode = currentNode else { return }
        
        if currentNode.value > newNode.value {
            if currentNode.leftChild == nil {
                currentNode.leftChild = newNode
            } else {
                appendElement(currentNode: currentNode.leftChild, newNode: newNode)
            }
        } else if currentNode.value < newNode.value {
            if currentNode.rightChild == nil {
                currentNode.rightChild = newNode
            } else {
                appendElement(currentNode: currentNode.rightChild, newNode: newNode)
            }
        }
    }
    
    //MARK: Вывод списка элементов дерева в массив
    public func traverseInOrder() -> [T] {
        var array = [T]()
        traverseInOrder(root: head, array: &array)
        return array
    }
    
    public func traversePreOrder() -> [T] {
        var array = [T]()
        traversePreOrder(root: head, array: &array)
        return array
    }
    
    public func traversePostOrder() -> [T] {
        var array = [T]()
        traversePostOrder(root: head, array: &array)
        return array
    }
    
    
    //MARK: Обход по дереву
    private func traverseInOrder(root: Node<T>?, array: inout [T]) {
        guard let node = root else { return }
        traverseInOrder(root: node.leftChild, array: &array)
        array.append(node.value)
        traverseInOrder(root: node.rightChild, array: &array)
    }
    
    private func traversePreOrder(root: Node<T>?, array: inout [T]) {
        guard let node = root else { return }
        array.append(node.value)
        traversePreOrder(root: node.leftChild, array: &array)
        traversePreOrder(root: node.rightChild, array: &array)
    }
    
    private func traversePostOrder(root: Node<T>?, array: inout [T]) {
        guard let node = root else { return }
        traversePostOrder(root: node.leftChild, array: &array)
        traversePostOrder(root: node.rightChild, array: &array)
        array.append(node.value)
    }
    
    //MARK: Поиск элемента
    public func search(element: T) -> T? {
        guard let node = searchElement(root: head, element: element) else { return nil }
        return node.value
    }
    
    private func searchElement(root: Node<T>?, element: T) -> Node<T>? {
        guard let node = root else { return nil }
        
        if node.value == element {
            return node
        }else if node.value > element {
            return searchElement(root: node.leftChild, element: element)
        } else {
            return searchElement(root: node.rightChild, element: element)
        }
    }
    
    public func remove(element: T) {
        let _ = deleteElement(root: head, element: element)
    }
    
    private func deleteElement(root: Node<T>?, element: T) -> Node<T>? {
        guard let node = root else { return nil }
        
        if element < node.value {
            node.leftChild = deleteElement(root: node.leftChild, element: element)
        } else if element > node.value {
            node.rightChild = deleteElement(root: node.rightChild, element: element)
        } else {
            guard let _ = node.leftChild else { return node.rightChild }
            guard let rChild = node.rightChild else { return node.leftChild }
            
            node.value = minValue(root: rChild)
            node.rightChild = deleteElement(root: node.rightChild, element: node.value)
        }
        
        return node
    }
    
}

var tree = BinnaryTree<Int>()

tree.append(45)
tree.append(10)
tree.append(7)
tree.append(12)
tree.append(90)
tree.append(50)
tree.append(2)

print("minValue", tree.min ?? "Nil")

let elem = tree.search(element: 7)
print("find: ", elem ?? "Not found")

tree.remove(element: 7)
print("Traverse in oreder: ", tree.traverseInOrder())

