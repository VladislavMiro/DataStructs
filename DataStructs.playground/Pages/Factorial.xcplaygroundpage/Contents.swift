//: [Previous](@previous)

import Foundation

func factorial(n: Int) -> Int {
    return n == 0 ? 1 : n * factorial(n: n-1)
}

let val1 = factorial(n: 5)
let val2 = factorial(n: 3)

print(val1)
print(val2)


//: [Next](@next)
