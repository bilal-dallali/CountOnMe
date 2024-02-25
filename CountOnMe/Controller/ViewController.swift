//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Connect UI elements, textView and numberButtons
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // Perform calculation with the instance calculator
    let calculator = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculator.clear()
    }
    
    // View actions when a number button is tapped
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        // Add the number to the current expression and update the textView
        textView.text = calculator.addNumber(numberText)
    }
    
    // Addition button is tapped
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        do {
            textView.text = try calculator.addOperand(.plus)
        } catch {
            presentAlert(message: error.localizedDescription)
        }
    }
    
    // Substraction button is tapped
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        do {
            textView.text = try calculator.addOperand(.minus)
        } catch {
            presentAlert(message: error.localizedDescription)
        }
    }
    
    
    // Multiplication button is tapped
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        do {
            textView.text = try calculator.addOperand(.multiply)
        } catch {
            presentAlert(message: error.localizedDescription)
        }
    }
    
    // Division button is tapped
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        do {
            textView.text = try calculator.addOperand(.divide)
        } catch {
            presentAlert(message: error.localizedDescription)
        }
    }
    
    // Equal button is tapped
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if !calculator.expressionIsCorrect {
            presentAlert(message: "Enter a correct expression !")
            return
        }
        
        if !calculator.expressionHaveEnoughElement {
            presentAlert(message: "DStart a new calculation !")
            return
        }
        
        do {
            // Try to calculate the result and add it to the next view
            let result = try calculator.calculate()
            textView.text.append(" = \(result)")
        } catch {
            // Present an elert if an error occurs during calculatiion
            presentAlert(message: error.localizedDescription)
        }
    }
    
    // Reset button is tapped
    @IBAction func tappedResetButton(_ sender: Any) {
        // Clear the calculator and reset the text view
        calculator.clear()
        textView.text = calculator.text
    }
    
    // Present an alert with the given message
    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
