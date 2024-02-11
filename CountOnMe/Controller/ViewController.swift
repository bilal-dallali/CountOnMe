//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    let calculator = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculator.clear()
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        textView.text = calculator.appendElement(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        do {
            textView.text = try calculator.addOperand(.plus)
        } catch {
            presentAlert(message: error.localizedDescription)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        do {
            textView.text = try calculator.addOperand(.minus)
        } catch {
            presentAlert(message: error.localizedDescription)
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        do {
            textView.text = try calculator.addOperand(.multiply)
        } catch {
            presentAlert(message: error.localizedDescription)
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        do {
            textView.text = try calculator.addOperand(.divide)
        } catch {
            presentAlert(message: error.localizedDescription)
        }
    }
    
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if !calculator.expressionIsCorrect {
            presentAlert(message: "Entrez une expression correcte !")
            return
        }
        
        if !calculator.expressionHaveEnoughElement {
            presentAlert(message: "Démarrez un nouveau calcul !")
            return
        }
        
        do {
            let result = try calculator.calculate()
            textView.text.append(" = \(result)")
        } catch {
            presentAlert(message: error.localizedDescription)
        }
    }
    
    @IBAction func tappedResetButton(_ sender: Any) {
        calculator.clear()
        textView.text = calculator.text
    }
    
    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
