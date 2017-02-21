//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, How to use func and closure"

// argument name - internal name
// argument label - external name

// External name 为了让函数在调用的时候，呈现更好的语义；
// Internal name 为了让函数在实现的时候，呈现更好的实现逻辑；

func mul(multiplicand m: Int, of n: Int){
    print(m*n)
}

mul(multiplicand: 2, of: 9)

// swift 3 不在默认省略缺省 argument label
func mul02(_ m: Int, of n: Int){
    print(m*n)
}

mul02(4, of: 10)


// 默认参数
func mul03(_ m: Int, of n: Int = 100){
    print(m*n)
}

mul03(2)
mul03(2, of: 200)
