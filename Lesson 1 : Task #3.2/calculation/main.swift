//
//  main.swift
//  calculation
//
//  Created by Andrey on 23.10.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation



// Стек из цифр в выражении
struct doubleStack {
    var items = [Double]()
    mutating func push(item: Double) {
        items.append(item)
    }
    mutating func pop() -> Double {
        return items.removeLast()
    }
    mutating func count() -> Int {
        return items.count
    }
    mutating func peek() -> Double {
        return items.last!
    }
}

// Стек из операторов
struct charStack {
    var items = [Character]()
    mutating func push(item: Character) {
        items.append(item)
    }
    mutating func pop() -> Character {
        return items.removeLast()
    }
    mutating func count() -> Int {
        return items.count
    }
    mutating func peek() -> Character {
        return items.last!
    }
}





var expr = readLine()!

func calc(expr: String) -> Double {
    var values = doubleStack()
    var chars = charStack()
    var actions = ["+","-","/","*"]
    var fullNumbers = ""
    
   
    for elementsInExp in Array(expr.characters) {
        // Выделяем цифры и запихиваем в пустую строку
        
        if elementsInExp >= "0" && elementsInExp <= "9" {
            fullNumbers += String(elementsInExp)
            continue
        }
        //Ложим число в стек
        if !fullNumbers.isEmpty {
            values.push(item: Double(fullNumbers)!)
            fullNumbers = ""
        }
        //Вычисляем скобочку по айпи и ложим в операции
        if elementsInExp == "(" {
            chars.push(item: elementsInExp)
        }
        //Вычисляем какая функция приоритетнее и выполняем
        if actions.contains(String(elementsInExp)) {
            if chars.count() > 0 && priority(operator1: elementsInExp, operator2: chars.peek()) {
                values.push(item: calculate2(a: values.pop(), b: values.pop(),operation: chars.pop()))
            }
            chars.push(item: elementsInExp)
            
            
        }
        //Выполняем операции до скобки
        if elementsInExp == ")" {
            while chars.peek() != "(" {
                values.push(item: calculate2(a: values.pop(), b: values.pop(),operation: chars.pop()))
            }
            chars.pop()
        }
        
        
    }
    //Проверка строки фуллнамбер
    if !fullNumbers.isEmpty {
        values.push(item: Double(fullNumbers)!)
    }
    while values.count() > 1 {
        values.push(item: calculate2(a: values.pop(), b: values.pop(),operation: chars.pop()))
    }
    
    
    return values.pop()
}

//Вычисляем приоритет
func priority(operator1 : Character, operator2: Character) -> Bool {
    
    if ((operator1 == "*" || operator1 == "/") && (operator2 == "+" || operator2 == "-")) || (operator2 == "(" || operator2 == ")") {
        return false
    }
    
    return true
}
//Арифметика
func calculate2(a: Double, b: Double,operation: Character) -> Double {
    switch(operation) {
    case "+":
        return a+b
    case "-":
        return b-a
    case "*":
        return a*b
    case "/":
        return b/a
    default:
        return 0
    }
}


print("\(calc(expr: expr))")
