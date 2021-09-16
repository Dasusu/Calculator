//
//  ViewController.swift
//  Calculator
//
//  Created by Dasu on 2021/9/8.
//

import UIKit

extension Double {
    var changNumber:String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let myNumber = formatter.string(from: NSNumber(value:(self)))
        return myNumber!
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var numberOnScreen: UILabel!

    //運算符號
    var operatingSign:String = ""
    //目前數字
    var currentNumber:Double = 0
    //上個數字
    var previousNumber:Double = 0
    //是否在運算
    var isCalculataing:Bool = false
    //是否為新的運算
    var startNew:Bool = true
    //列舉運算種類
    enum operationType {
    case add
    case subtract
    case multiply
    case divide
    case none
        }
    // 現在計算是什麼Type
    var operation:operationType = .none

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func nowAnswer() {
        switch operation {
        case .add:
            currentNumber = previousNumber + currentNumber
            okAnswerString (from: currentNumber)
        case .subtract:
            currentNumber = previousNumber - currentNumber
            okAnswerString (from: currentNumber)
        case .multiply:
            currentNumber = previousNumber * currentNumber
            okAnswerString (from: currentNumber)
        case .divide:
            currentNumber = previousNumber / currentNumber
            okAnswerString (from: currentNumber)
        case .none:
            numberOnScreen.text = ""
        }
    }
    
    func okAnswerString(from number:Double) {
        var okText:String
        if floor(number) == number{
            okText = "\(Int(number))"
        }else{
            okText = "\(number)"
        }
        if (okText.count >= 9) {
            okText = String(okText.prefix(9))
        }
        numberOnScreen.text = okText
    }

    //數字鍵觸發
    @IBAction func numbers(_ sender: UIButton) {
        //數字鍵對應tag顯示數字
        let inputnumber = sender.tag - 1
       //判斷是否為nil
        if numberOnScreen.text != nil
        {
            if startNew == true {
                numberOnScreen.text = "\(inputnumber)"
                startNew = false
            }else{
                if numberOnScreen.text == "0" {
                    numberOnScreen.text = "\(inputnumber)"
                }else {
                    numberOnScreen.text = numberOnScreen.text! + "\(inputnumber)"
                }
            }
        //儲存數值進currentNumber 如為空存0不為空存Double進去
        currentNumber = Double(numberOnScreen.text!) ?? 0
    }
}
    //按鈕除法
    @IBAction func divide(_ sender: UIButton) {
        if previousNumber != 0 {
            nowAnswer()
        }
        numberOnScreen.text = "0"
        operatingSign = "÷"
        previousNumber = currentNumber
        isCalculataing = true
        startNew = false
        operation = .divide
    }
    //按鈕乘法
    @IBAction func multiply(_ sender: UIButton) {
        if previousNumber != 0 {
            nowAnswer()
        }
        numberOnScreen.text = "0"
        operatingSign = "×"
        previousNumber = currentNumber
        isCalculataing = true
        startNew = false
        operation = .multiply
    }
    //按鈕減法
    @IBAction func subtract(_ sender: UIButton) {
        if previousNumber != 0 {
            nowAnswer()
        }
        numberOnScreen.text = "0"
        operatingSign = "-"
        previousNumber = currentNumber
        isCalculataing = true
        startNew = false
        operation = .subtract
    }
    //按鈕加法
    @IBAction func add(_ sender: UIButton) {
        if previousNumber != 0 {
            nowAnswer()
        }
        numberOnScreen.text = "0"
        operatingSign = "＋"
        previousNumber = currentNumber
        isCalculataing = true
        startNew = false
        operation = .add
    }
    //按鈕等於
    @IBAction func answer(_ sender: UIButton) {
        if isCalculataing == true {
            switch operation {
            case .add:
                currentNumber = previousNumber + currentNumber
                okAnswerString (from: currentNumber)
            case .subtract:
                currentNumber = previousNumber - currentNumber
                okAnswerString (from: currentNumber)
            case .multiply:
                currentNumber = previousNumber * currentNumber
                okAnswerString (from: currentNumber)
            case .divide:
                currentNumber = previousNumber / currentNumber
                okAnswerString (from: currentNumber)
            case .none:
                numberOnScreen.text = ""
            }
            isCalculataing = false
            startNew = true
    }
        previousNumber = 0
}
    //按鈕歸零
    @IBAction func clear(_ sender: UIButton) {
        numberOnScreen.text = "0"
        operatingSign = ""
        previousNumber = 0
        currentNumber = 0
        isCalculataing = false
        startNew = true
        operation = .none
    }
    //按鈕負號
    @IBAction func nagativeswitch(_ sender: UIButton) {
        currentNumber = Double(numberOnScreen.text!)! * -1
        okAnswerString(from: currentNumber)
        isCalculataing = true
        startNew = false
    }
    //按鈕％數
    @IBAction func percentage(_ sender: UIButton) {
        currentNumber = Double(numberOnScreen.text!)!/100
        okAnswerString(from: currentNumber)
        isCalculataing = true
        startNew = false
    }
    //按鈕小數點
    @IBAction func dot(_ sender: UIButton) {
        if (numberOnScreen.text != nil) {
        // 判斷是否為新的計算
        if (startNew == true) {
        numberOnScreen.text = "0."
        // 避免使用者忘記輸入0
        startNew = false
        // 設為false才可正常產生零點幾的數值
        } else {
        numberOnScreen.text = numberOnScreen.text! + "."
                    }
                }
    }
    
}

