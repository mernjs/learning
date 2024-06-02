//// Decision Making
//let num = 10
//
//print("\nIf Statement")
//// If Statement
//if num > 0 {
//    print("Number is positive")
//}
//print("\nIf...Else Statement")
//// If...Else Statement
//if num > 0 {
//    print("Number is positive")
//} else {
//    print("Number is non-positive")
//}
//print("\nIf...Else If...Else Statement")
//// If...Else If...Else Statement
//if num > 0 {
//    print("Number is positive")
//} else if num < 0 {
//    print("Number is negative")
//} else {
//    print("Number is zero")
//}
//
//print("\nNested If Statements")
//// Nested If Statements
//let a = 10
//let b = 20
//
//if a > 0 {
//    if b > 0 {
//        print("Both a and b are positive")
//    }
//}
//
//print("\nSwitch Statement")
//// Switch Statement
//let grade = "A"
//
//switch grade {
//case "A":
//    print("Excellent!")
//case "B":
//    print("Good job!")
//case "C":
//    print("Satisfactory")
//default:
//    print("You need to improve")
//}
//
//print("\nFor In Loop")
//// Loops
//// For In Loop
//for i in 1...5 {
//    print(i)
//}
//
//print("\nWhile Loop")
//// While Loop
//var x = 5
//while x > 0 {
//    print(x)
//    x -= 1
//}
//
//print("\nRepeat While Loop")
//// Repeat...While Loop
//var y = 5
//repeat {
//    print(y)
//    y -= 1
//} while y > 0
//
//print("\nContinue Statement")
//// Continue Statement
//for i in 1...10 {
//    if i % 2 == 0 {
//        continue
//    }
//    print(i)
//}
//
//print("\nBreak Statement")
//// Break Statement
//for i in 1...10 {
//    if i == 5 {
//        break
//    }
//    print(i)
//}
//
//print("\nFall Throught Statement")
//// Fall Through Statement
//let numSwitch = 2
//switch numSwitch {
//case 1:
//    fallthrough
//case 2:
//    print("Number is either 1 or 2")
//default:
//    print("Number is not 1 or 2")
//}
//
//print("\n")
//
//
//// If-Else statement with multiple conditions
//let temperature = 25
//
//if temperature < 0 {
//    print("It's freezing cold!")
//} else if temperature >= 0 && temperature < 10 {
//    print("It's cold")
//} else if temperature >= 10 && temperature < 20 {
//    print("It's cool")
//} else if temperature >= 20 && temperature < 30 {
//    print("It's warm")
//} else {
//    print("It's hot!")
//}
//
//print("\n")
//// Switch statement with ranges
//let marks = 85
//
//switch marks {
//case 0..<40:
//    print("Fail")
//case 40..<60:
//    print("Pass")
//case 60..<75:
//    print("Merit")
//case 75..<100:
//    print("Distinction")
//default:
//    print("Invalid marks")
//}
//
//print("\n")
//// For loop with stride
//for i in stride(from: 0, to: 10, by: 2) {
//    print(i)
//}
//
//print("\n")
//// While loop with break statement
//var count = 0
//while true {
//    print("Count:", count)
//    count += 1
//    if count == 5 {
//        break
//    }
//}
//
//print("\n")
//// Repeat-While loop with continue statement
//var number = 0
//repeat {
//    number += 1
//    if number % 2 == 0 {
//        continue
//    }
//    print(number)
//} while number < 10
