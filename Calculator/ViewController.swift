//
//  ViewController.swift
//  Calculator
//
//  Created by Dasu on 2021/9/8.
//

import UIKit

extension Double {
    var changeScient:String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 9
        let myNumber = formatter.string(from: NSNumber(value:(self)))
        return myNumber!
    }
    var changNumber:String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let myNumber = formatter.string(from: NSNumber(value:(self)))
        return myNumber!
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var numberOnScreenLabel: UILabel!
    
    var doubleforscreen:Double = 0
    
    var inputString:String = "0"
    
//    var caculator = Calculator() {
//        didSet {
//            numberOnScreenLabel.text = caculator.currentInput
//        }
//    }
    
    
    //目前數字
    
    var currentNumber:Decimal = 0
    //上個數字
    var previousNumber:Decimal = 0
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
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeButtonRound()
    }
    func makeButtonRound(){
        for button in buttons {
            let radius = button.frame.height / 2
            button.layer.cornerRadius = radius
            button.layer.masksToBounds = true
        }
    }
    
    
    func nowAnswer() {
        switch operation {
        case .add:
            currentNumber = previousNumber + currentNumber
            okAnswerString(from: currentNumber)
        case .subtract:
            currentNumber = previousNumber - currentNumber
            okAnswerString(from: currentNumber)
        case .multiply:
            currentNumber = previousNumber * currentNumber
            okAnswerString(from: currentNumber)
        case .divide:
            currentNumber = previousNumber / currentNumber
            okAnswerString(from: currentNumber)
        
        case .none:
            numberOnScreenLabel.text = ""
        }
    }
    
    func okAnswerString(from number:Decimal) {
        let formatter = NumberFormatter()
        var okText:String = ""
        okText = "\(number)"
//        okText = formatter.string(from: Double(number.description)! as NSNumber)!
        if okText.count >= 9 {
//            formatter.numberStyle = .scientific
//            formatter.maximumFractionDigits = 9
            okText = String(format: "%9g",Double(truncating: number as NSNumber) )
        }else{
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 9
            okText = formatter.string(from: Double(number.description)! as NSNumber)!
        }
        numberOnScreenLabel.text = okText
    }
    
    //數字鍵觸發
    @IBAction func numbers(_ sender: UIButton) {
//        caculator.addInput(sender.currentTitle)
        //數字鍵對應tag顯示數字
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 9
        
        let inputnumber = sender.currentTitle
        if startNew{
            inputString = inputnumber!
            currentNumber = Decimal(string: inputString)!
//            guard let inputNSNumber = Double(inputString) as NSNumber? else { return }
            numberOnScreenLabel.text = formatter.string(from: Double(currentNumber.description)! as NSNumber)!
            startNew = false
        }else{
            if currentNumber.description.count >= 9 {
                return
            }else{
            if inputString.contains(".") && inputnumber == "." { return }
            inputString.append(inputnumber!)
            currentNumber = Decimal(string: inputString)!
            if inputnumber == "." || inputString.contains(".") && inputnumber == "0" {
                numberOnScreenLabel.text! += inputnumber!
            }else{
                numberOnScreenLabel.text = formatter.string(from: currentNumber as NSNumber)!
                }
            }
        }
    }
    //按鈕除法
    @IBAction func divide(_ sender: UIButton) {
        if previousNumber != 0 {
            nowAnswer()
        }
        numberOnScreenLabel.text = "0"
        previousNumber = currentNumber
        isCalculataing = true
        startNew = true
        operation = .divide
    }
    //按鈕乘法
    @IBAction func multiply(_ sender: UIButton) {
        if previousNumber != 0 {
            nowAnswer()
        }
        numberOnScreenLabel.text = "0"
        previousNumber = currentNumber
        isCalculataing = true
        startNew = true
        operation = .multiply
    }
    //按鈕減法
    @IBAction func subtract(_ sender: UIButton) {
        if previousNumber != 0 {
            nowAnswer()
        }
        numberOnScreenLabel.text = "0"
        previousNumber = currentNumber
        isCalculataing = true
        startNew = true
        operation = .subtract
    }
    //按鈕加法
    @IBAction func add(_ sender: UIButton) {
        if previousNumber != 0 {
            nowAnswer()
        }
        numberOnScreenLabel.text = "0"
        previousNumber = currentNumber
        isCalculataing = true
        startNew = true
        operation = .add
    }
    //按鈕等於
    @IBAction func answer(_ sender: UIButton) {
        if isCalculataing == true {
            switch operation {
            case .add:
                currentNumber = previousNumber + currentNumber
                okAnswerString(from: currentNumber)
            case .subtract:
                currentNumber = previousNumber - currentNumber
                okAnswerString(from: currentNumber)
            case .multiply:
                currentNumber = previousNumber * currentNumber
                okAnswerString(from: currentNumber)
            case .divide:
                currentNumber = previousNumber / currentNumber
                okAnswerString(from: currentNumber)
            case .none:
                numberOnScreenLabel.text = ""
            
            }
            isCalculataing = false
            startNew = false
        }
        previousNumber = 0
    }
    //按鈕歸零
    @IBAction func clear(_ sender: UIButton) {
        numberOnScreenLabel.text = "0"
        previousNumber = 0
        currentNumber = 0
        isCalculataing = false
        startNew = true
        operation = .none
    }
    //按鈕負號
    @IBAction func nagativeswitch(_ sender: UIButton) {
        currentNumber = currentNumber * -1
        okAnswerString(from: currentNumber)
        isCalculataing = true
        startNew = true
    }
    //按鈕％數
    @IBAction func percentage(_ sender: UIButton) {
        currentNumber = currentNumber / 100
        okAnswerString(from: currentNumber)
        isCalculataing = true
        startNew = true
    }
}
