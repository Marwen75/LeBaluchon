//
//  ExchangeRateViewController.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 21/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var euroTextField: UITextField!
    @IBOutlet weak var convertActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var resultTextField: UITextField!
    @IBOutlet weak var actualRateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertActivityIndicator.isHidden = true 
    }
    
    @IBAction func dismissKeybord(_ sender: UITapGestureRecognizer) {
        euroTextField.resignFirstResponder()
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        do {
            try displayTheConvertAmount()
        } catch let error as AppError {
            displayAlert(title: error.errorDescription, message: error.failureReason)
        } catch {
            displayAlert(title: "Oups !", message: "Erreur inconnue")
        }
    }
    
    private func displayTheConvertAmount() throws {
        guard let text = euroTextField.text else { return }
        if text.isEmpty || text.first == "." {
            throw AppError.incorrectAmount
        }
        guard let amount = Double(text) else { return }
        toggleActivityIndicator(shown: true)
        ExchangeRateService.shared.getChangeRate { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.toggleActivityIndicator(shown: false)
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let rate):
                strongSelf.displayResult(result: rate.calculate(amount: amount))
                strongSelf.displayRate(rate: rate.rates.first!.value)
            }
        }
    }
    
    private func displayResult(result: Double) {
        let result = String(format: "%.2f", result)
        resultTextField.text = result
    }
    
    private func displayRate(rate: Double) {
        let rate = String(format: "%.2f", rate)
        actualRateLabel.text = "Le taux actuel est de \(rate)"
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        convertActivityIndicator.isHidden = !shown
        convertButton.isHidden = shown
    }
}

extension ExchangeRateViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
