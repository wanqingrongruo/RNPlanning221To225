//: Playground - noun: a place where people can play

import UIKit
import Foundation

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

// ***************************************************

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

// ***************************************************
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
            
            temp.removeAll(keepingCapacity: true) // 保留数组空间
            
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


// ***************************************************

// OC 中水土不服的运行时特性
final class Episode: NSObject {
    var title: String
    var type: String
    var length: Int
    
    override var description: String {
        return title + "\t" + type + "\t" + String(length)
    }
    
    init(title: String, type: String, length: Int) {
        self.title = title
        self.type = type
        self.length = length
    }
}

let episodes = [
    Episode(title: "title 1", type: "Free", length: 520),
    Episode(title: "title 4", type: "Paid", length: 500),
    Episode(title: "title 2", type: "Free", length: 330),
    Episode(title: "title 5", type: "Paid", length: 260),
    Episode(title: "title 3", type: "Free", length: 240),
    Episode(title: "title 6", type: "Paid", length: 390),
]

// key: 表示要排序的属性
// ascending: 表示是否按升序排列
// selector: 表示要进行比较的方法
let typeDescriptor = NSSortDescriptor(key: #keyPath(Episode.type), ascending: true, selector: #selector(NSString.localizedCompare(_:)))

let lengthDescriptor = NSSortDescriptor(key: #keyPath(Episode.length), ascending: true)

// 先按 type 升序, 再按 length 升序
let descriptors = [typeDescriptor, lengthDescriptor]

let sortedEpisodes = (episodes as NSArray).sortedArray(using: descriptors)
sortedEpisodes.forEach{print($0 as! Episode)}


// ***************************************************

// 通过类型系统模拟 OC 的运行时表达

//// 抽象要比较的属性 以及 比较规则

typealias SortDescriptor<T> = (T, T) -> Bool

// Key: 处理的对象
// Value: 要排序的类型
// 我们使用@escaping修饰了用于获取Value以及排序的函数参数，这是因为在我们返回的函数里，使用了key以及isAscending，这两个函数都逃离了makeDescriptor作用域，而Swift 3里，作为参数的函数类型默认是不能逃离的，因此我们需要明确告知编译器这种情况
func makeDescription<Key, Value>(key: @escaping(Key) -> Value, _ isAscending: @escaping (Value, Value) -> Bool) -> SortDescriptor<Key>{
    return { isAscending(key($0), key($1))}
    
}

// 为optional类型“提升”比较函数
func shift<T: Comparable>(
    _ compare: @escaping (T, T) -> Bool) -> (T?, T?) -> Bool {
    return { l, r in
        switch (l, r) {
        case (nil, nil):
            return false
        case (nil, _):
            return false
        case (_, nil):
            return true
        case let (l?, r?):
            return compare(l, r)
        default:
            fatalError()
        }
    }
}

let typeDes: SortDescriptor<Episode> = makeDescription(key: {$0.type}) { $0.localizedCompare($1) == .orderedAscending}
let lengthDes: SortDescriptor<Episode> = makeDescription(key: {$0.length}, shift(<))

episodes.sorted(by: typeDes).forEach{ print($0)}

// 合并多个排序条件

func combine<T>(rules: [SortDescriptor<T>]) -> SortDescriptor<T> {
    
    return { l,r in
        for rule in rules {
            if rule(l, r) {
                return true
            }
            if rule(r, l){
                return false
            }
        }
        
        return false
    }
}

let mixDes = combine(rules: [typeDes, lengthDes])
episodes.sorted(by: mixDes).forEach { print($0) }


// 定义操作符
// LogicalDisjunctionPrecedence 优先级
// 如果我们不指定优先级，Swift会为它设置默认的DefaultPrecedence。
infix operator +++: LogicalDisjunctionPrecedence

func +++<T>(l: @escaping SortDescriptor<T>, r: @escaping SortDescriptor<T>) -> SortDescriptor<T> {
    return {
        if l($0, $1) {
            return true
        }
        
        if l($1, $0) {
            return false
        }
        
        // $0 and $1 is the same, try the second descriptor
        if r($0, $1) {
            return true
        }
        
        return false
    }
}

episodes.sorted(by: typeDes +++ lengthDes).forEach { print($0) }


// ***************************************************

// 为什么 delegate 模式不适用于 struct

// ***************************************************

// 传递引用参数
// 可以把UnsafeMutablePointer<Int>理解为C语言中的Int *


func incrementByReference(_ pointer: UnsafeMutablePointer<Int>) {
    pointer.pointee += 1 // 地址加一
}

var i = 0
incrementByReference(&i)

// 不要让接受指针参数的函数返回另外一个函数!!!!

struct color {
    var r: Int
    var g: Int
    var b: Int
    
    // rgb 转 16进制
    var hex:Int {
        // << 向左移位移位(字节为单位)
        return r << 16 + g << 8 + b
    }
}


let c = color(r: 255, g: 255, b: 255)
String(c.hex, radix: 16) //　转成字符串 -- 10进制转16进制

// ***************************************************

// 把参数自动转化为 closure
// @autoclosure 修饰参数

func logicAdd(_ l :Bool, _ r: @autoclosure () -> Bool) -> Bool {
    
    guard l else {
        return false
    }
    
    // 第一个条件成立才会继续判断第二个条件 => short circuit <= && ||
    return r()
}

let nums: [Int] = []

logicAdd(!nums.isEmpty, nums[0] > 0)

// capture list 
// [weak counter]
