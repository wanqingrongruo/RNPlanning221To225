//: Playground - noun: a place where people can play

import UIKit

var str = "为代码的执行做个决定"

var i = 0

// while
while i < 10 {
    print("while loop")
    i += 1
}

// do while
repeat {
    print("repeat while loop \(i) ")
    i -= 1
} while i > 0

// continue => 停止当前循环语句,立即进入下次循环

for num in 1...10{
    if num % 2 != 0 {
        continue
    }
    
    print("2 de 倍数: \(num)")
}

// break => 终止整个循环

for num in 1...10{
    if num > 3 {
        break
    }
    
    print("小于等于3: \(num)")
}

// 匹配值 -- 样式匹配

// 1. case 匹配的值 = 要检查的对象
let pt = (x: 0, y: 0)
if case (0, 0) = pt {
    print("this is origin")
}
switch pt {
case (0,0):
    print("this is origin")
case (_, 0):
    print("on x axis")
case (0, _):
    print("on y axis")
case (-1...1, -1...1):
    print("inside 1x1 square")
default:
    break
}
let arr = [1,1,2,3,4,2]
for case 2 in arr {
    print("found 2")
}
// 2. value binding: binging value with variable => 除了在case中使用各种形式的具体值之外，我们还可以把匹配到的内容直接绑定到变量上，这样我们就可以在相应的处理代码中直接使用它们
switch pt {
case (let x, 0):
    print("(\(x),0) is on x axis")
case (0, let y):
    print("(0, \(y)) is on y axis")
default:
    break
}
enum Direction {
    case north
    case south
    case east
    case west(abbr: String)
}

let west = Direction.west(abbr: "W")
if case .west = west {
    print("west")
}

if case .west(let direction) = west {
    print(direction)
}

// 自动提取 optional 的值
let skills: [String?] = ["Swift", nil, "PHP", "JavaScript", nil]
for case let skill? in skills {
    print(skill)
}

// 自动绑定类型转换的结果

let someValues: [Any] = [1, 2.0, "one"]
for value in someValues {
    switch value {
    case let v as Int:
        print("Integer \(v)")
    case let v as Double:
        print("Double \(v)")
    case let v as String:
        print("String \(v)")
    default:
        print("Invalid value")
    }
}

for value in someValues {
    switch value {
    case is Int:
        print("Integer")
    case is Double:
        print("Double")
    case is String:
        print("String")
    default:
        break
    }
}

// 使用 where 约束条件

for i in 1...10 where i % 2 == 0 {
    print(i)
}

enum Power {
    case fullyCharged
    case normal(percentage: Double)
    case outOfPower
}

let battery = Power.normal(percentage: 0.1)
switch battery {
case .normal(let per) where per <= 0.1:
    print("almost out of power")
case .normal(let per) where per >= 0.8:
    print("Almost fully power")
case .fullyCharged, .outOfPower: // 使用逗号串联条件
     print("Normal battery status")
default:
    print("Normal battery status")
}

if case .normal(let percentage) = battery, case 0...0.1 = percentage {
   print("Almost fully power")
}

// 使用tuple简化多个条件的比较

let userName = "roni"
let password = "123456"

// 抛弃
if userName == "roni" && password == "123456" {
    print("correct")
}
// turple
if case ("roni", "123456") = (userName, password){
     print("correct...")
}

