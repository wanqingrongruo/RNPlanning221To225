//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, How to use func and closure"

// argument name - internal name
// argument label - external name

// External name 为了让函数在调用的时候，呈现更好的语义；
// Internal name 为了让函数在实现的时候，呈现更好的实现逻辑；

func mul(multiplicand m: Int, of n: Int) {
    print(m*n)
}

mul(multiplicand: 2, of: 9)

// swift 3 不在默认省略缺省 argument label
func mul02(_ m: Int, of n: Int){
    print(m*n)
}

mul02(4, of: 10)


// 默认参数
// 拥有默认值的函数参数必须从右向左依次排列，有默认值的参数不能出现在无默认值的参数的左边。
func mul03(_ m: Int, of n: Int = 100){
    print(m*n)
}

mul03(2)
mul03(2, of: 200)


// 可变长参数
func mul04(_ numbers: Int ...) {
    let arrayMul = numbers.reduce(1, *)
    print("乘积: \(arrayMul)")
    
}

mul04(2,3,4,5)

// inout argument
func mulForInout(result: inout Int, _ numbers: Int ...) {
    result = numbers.reduce(1, *)
    print("乘积: \(result)")
}

var res = 0
mulForInout(result: &res, 2,3,4,5)
res

// ***************

// 函数定义变量
func mulForType(m: Int, n: Int) -> Int {
    return m * n
}

let funcV = mulForType
funcV(2,3)

// 函数 与 Closure
// closure expression: 函数参数 返回值以及实现都写在{}
// closure expression 是 函数在上下文中更简单的写法
// closure 与 closure expression 不是一回事
// closure = 一个函数 + 捕获的变量 = 要执行的逻辑 + 其执行的上下文
func myFunc(_ m: Int) -> Int {
    return m * m
}

let myClo = { (n: Int) -> Int in
    return n * n
}
myFunc(4)
myClo(4)

// {} 可以 捕获变量
// counter01 counter02 是 closure => 它们既有要执行的逻辑（把value加1），还带有其执行的上下文（捕获的value变量）
func makeCounter() -> () -> Int {
    
    var value = 0
    
    return {
        value += 1
        return value
    }
}

let counter01 = makeCounter()
let counter02 = makeCounter()

(0...2).forEach{_ in print(counter01())} // 1 2 3
(0...5).forEach{_ in print(counter02())} // 1 2 3 4 5 6

// 利用函数里面的函数捕获变量 - local function
func makeCounter02() -> () -> Int {
    
    var value = 0
    
    func increment() -> Int{
        value += 1
        return value
    }
    
    return increment
}

let counter03 = makeCounter02()
let counter04 = makeCounter02()


// value 是局部变量,counter03()和counter04()使用不会带来冲突
(0...2).forEach{_ in print(counter03())} // 1 2 3
(0...5).forEach{_ in print(counter04())} // 1 2 3 4 5 6

// ***************
// 归并排序
extension Array where Element: Comparable {
    
    mutating func mergeSort(_ begin: Index, _ end: Index) {
        
        if (end - begin) > 1 {
            
            let mid = (begin + end) / 2
            
            mergeSort(begin, mid)
            mergeSort(mid, end)
            
            merge(begin, mid, end)
        }
    }
    
    private mutating func merge(_ begin: Index, _ mid: Index, _ end: Index) {
        
        var temp: [Element] = []
        
        var i = begin
        var j = mid
        
        while i != mid && j != end {
            if self[i] < self[j] {
                temp.append(self[i])
                i += 1
            }else{
                temp.append(self[j])
                j += 1
            }
        }
        
        temp.append(contentsOf: self[i..<mid])
        temp.append(contentsOf: self[j..<end])
        
        replaceSubrange(begin..<end, with: temp)
    }
    
    
    // local function -- 捕获变量 temp 共享存储空间
    mutating func mergeSortAboutLocalFunction(_ begin: Index, _ end: Index) {
        
        var temp: [Element] = []
        temp.reserveCapacity(count) // 申请特定大小的空间,temp最多时也就容纳原始数组的所有元素
        
        func mergeAboutLocalFunction(_ begin: Index, _ mid: Index, _ end: Index) {
            
            temp.removeAll(keepingCapacity: true) // 情况数组,并维持空间大小不变
            
            var i = begin
            var j = mid
            
            while i != mid && j != end {
                if self[i] < self[j] {
                    temp.append(self[i])
                    i += 1
                }else{
                    temp.append(self[j])
                    j += 1
                }
            }
            
            temp.append(contentsOf: self[i..<mid])
            temp.append(contentsOf: self[j..<end])
            
            replaceSubrange(begin..<end, with: temp)
        }
        
    
        if (end - begin) > 1 {
            
            let mid = (begin + end) / 2
            
            mergeSortAboutLocalFunction(begin, mid)
            mergeSortAboutLocalFunction(mid, end)
            
            mergeAboutLocalFunction(begin, mid, end)
        }

        
    }
}

var numbersss = [2,1,4,3,9,5]
numbersss.mergeSort(numbersss.startIndex, numbersss.endIndex)
numbersss.mergeSortAboutLocalFunction(numbersss.startIndex, numbersss.endIndex)

		