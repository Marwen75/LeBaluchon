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
    @IBOutlet weak var euroLabel: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!
    @IBOutlet weak var euroTextField: UITextField!
    @IBOutlet weak var dollarTextField: UITextField!
    @IBOutlet weak var convertActivityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertActivityIndicator.isHidden = true
    }
    
    @IBAction func dismissKeybord(_ sender: UITapGestureRecognizer) {
        euroTextField.resignFirstResponder()
        dollarTextField.resignFirstResponder()
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        convertActivityIndicator.isHidden = false
        convertButton.isHidden = true
        
    }
    
    
    
    
    
    
}

extension ExchangeRateViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
