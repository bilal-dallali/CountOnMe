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
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.text = ""
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if calculator.expressionHaveResult {
            // Si le résultat est affiché, commencez une nouvelle expression
            textView.text = ""
            calculator.clear()
        }
        // Sinon, ajoutez le chiffre à l'expression existante
        textView.text.append(numberText)
        
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" + ")
        } else {
            presentAlert(message: "Un opérateur est déjà mis !")
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" - ")
        } else {
            presentAlert(message: "Un opérateur est déjà mis !")
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" * ")
        } else {
            presentAlert(message: "Un opérateur est déjà mis !")
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" / ")
        } else {
            presentAlert(message: "Un opérateur est déjà mis !")
        }
    }
    
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if !calculator.expressionIsCorrect {
            presentAlert(message: "Entrez une expression correcte !")
            return
        }
        
        if calculator.expressionHaveEnoughElement {
            presentAlert(message: "Démarrez un nouveau calcul !")
            return
            
        }
        
        do {
            let result = try calculator.calculate(elements: elements)
            textView.text.append(" = \(result)")
        } catch {
            presentAlert(message: error.localizedDescription)
        }
        
    }
    
    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
