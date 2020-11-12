//
//  ContentView.swift
//  betterCalculator
//
//  Created by Adriana González Martínez on 11/11/20.
//

import SwiftUI

struct CalculationState{
    var currentNumber : Double = 0
    var storedNumber: Double?
    var storedAction: CalculatorButton?
    
    mutating func appendNumber(_ number: Double){
            if number.truncatingRemainder(dividingBy: 1) == 0 && currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
                currentNumber = 10 * currentNumber + number
                print("The current number is: \(currentNumber)")
            }
            else {
                currentNumber = number
            }
        }
    }


enum CalculatorButton: String{
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case equals = "="
    case plus = "+"
    case minus = "-"
    case multiply = "×"
    case divide = "÷"
    case ac = "AC"
    case plusMinus = "+/-"
    case percent = "%"
    case dot = "."
    
    var backgroundColor: Color{
        switch self {
        case .equals, .plus, .minus, .multiply, .divide:
            return Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        case .ac, .plusMinus, .percent:
            return Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        default:
            return Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        }
    }
    func calculate(_ input1: Double, _ input2: Double) -> Double? {
        switch self {
        case .plus:
            return input1 + input2
        case .minus:
            return input1 - input2
        case .multiply:
            return input1 * input2
        case .divide:
            return input1 / input2
        default:
            return nil
        }
    }
}

struct ContentView: View {
    
    @State var state = CalculationState()
    var displayText : String {
        return String(format: "%.2f", state.currentNumber)
    }
    
    let buttonOptions: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equals]
    ]
    var body: some View {
        VStack(spacing:10){
            HStack{
                Spacer()
                Text(displayText)
                    .font(.largeTitle)
            }
            ForEach(buttonOptions, id: \.self){ row in
                HStack{
                    ForEach(row, id:\.self){ button in
                        ActionView(button: button, state: $state)}
                }
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom).padding(10)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
