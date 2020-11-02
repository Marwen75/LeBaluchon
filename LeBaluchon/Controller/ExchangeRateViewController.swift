//
//  ExchangeRateViewController.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 21/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    // MARK: - Properties
    private let exchangeRateService = ExchangeRateService()
    // MARK: - Outlets
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var euroTextField: UITextField!
    @IBOutlet weak var convertActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var resultTextField: UITextField!
    @IBOutlet weak var actualRateLabel: UILabel!
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(shown: false)
    }
    // MARK: - Actions
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        euroTextField.resignFirstResponder()
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        do {
            try displayTheConvertAmount()
            actualRateAnimation()
        } catch let error as ExchangeRateError {
            displayAlert(title: error.errorDescription, message: error.failureReason)
        } catch {
            displayAlert(title: "Oups !", message: "Erreur inconnue")
        }
    }
    // MARK: - Methods
    private func displayTheConvertAmount() throws {
        guard let text = euroTextField.text else { return }
        if text.isEmpty || text.first == "." {
            throw ExchangeRateError.incorrectAmount
        }
        guard let amount = Double(text) else { return }
        toggleActivityIndicator(shown: true)
        exchangeRateService.getChangeRate { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.toggleActivityIndicator(shown: false)
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let rate):
                strongSelf.displayResult(result: rate.calculate(amount: amount))
                guard let finalRate = rate.rates.first?.value else {return}
                strongSelf.displayRate(rate: finalRate)
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
    // the animation for the actual rate label
    private func actualRateAnimation() {
        actualRateLabel.transform = .identity
        actualRateLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: [], animations: {
            self.actualRateLabel.transform = .identity
        }, completion: nil)
    }
}
    //MARK: - Extension
extension ExchangeRateViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
