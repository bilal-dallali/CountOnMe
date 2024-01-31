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
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            // Si le résultat est affiché, commencez une nouvelle expression
            textView.text = ""
            calculator.clear()
        }
        // Sinon, ajoutez le chiffre à l'expression existante
        textView.text.append(numberText)
        
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            presentAlert(message: "Un opérateur est déjà mis !")
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            presentAlert(message: "Un opérateur est déjà mis !")
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" * ")
        } else {
            presentAlert(message: "Un opérateur est déjà mis !")
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" / ")
        } else {
            presentAlert(message: "Un opérateur est déjà mis !")
        }
    }
    
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            presentAlert(message: "Entrez une expression correcte !")
            return
            
        }
        
        guard expressionHaveEnoughElement else {
            presentAlert(message: "Démarrez un nouveau calcul !")
            return
            
        }
        
        do {
            let result = try calculator.calculate(elements: elements)
            textView.text.append(" = \(result)")
        } catch {
            presentAlert(message: error.localizedDescription)
        }
        
        
//        if result == "Erreur : Division par zéro" {
//            presentAlert(message: result)
//        } else {
//            textView.text.append(" = \(result)")
//        }
    }
    
    //    func isExpressionValid(_ expression: String) -> Bool {
    //        // Vérifiez que l'expression ne se termine pas par un opérateur
    //        let operators = ["+", "-", "*", "/"]
    //        if let lastCharacter = expression.last, operators.contains(String(lastCharacter)) {
    //            return false
    //        }
    //        
    //        // Ajoutez d'autres vérifications selon les besoins, par exemple pour les opérateurs consécutifs
    //        
    //        return true
    //    }
    
    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
}

