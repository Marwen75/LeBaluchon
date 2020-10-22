//
//  TranslatorViewController.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 21/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {
    
    @IBOutlet weak var traductionButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var frenchTextView: UITextView!
    @IBOutlet weak var englishTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true 
    }
    
    @IBAction func traductionButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        frenchTextView.resignFirstResponder()
    }
    
    
    
    
}

extension TranslatorViewController: UITextViewDelegate {
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
