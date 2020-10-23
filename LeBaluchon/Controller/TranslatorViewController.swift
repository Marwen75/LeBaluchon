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
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        frenchTextView.resignFirstResponder()
    }
    @IBAction func traductionButtonTapped(_ sender: UIButton) {
        do {
            try makeTheTranslation()
        } catch let error as AppError {
            displayAlert(title: error.errorDescription, message: error.failureReason)
        } catch {
            displayAlert(title: "Oups!", message: "erreur inconnue")
        }
    }
    
    private func makeTheTranslation() throws {
        guard let text = frenchTextView.text else { return }
        if text.isEmpty {
            throw AppError.incorrectAmount
        }
        toggleActivityIndicator(shown: true)
        TranslatorService.shared.getTranslation(text: text, completionHandler: { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.toggleActivityIndicator(shown: false)
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let translation):
                guard let translation = translation.data.translations.first?.translatedText else {return}
                strongSelf.displayTranslation(translationText: translation)
            }
        })
    }
    
    
    private func displayTranslation(translationText: String) {
        englishTextView.text = translationText
    }
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        traductionButton.isHidden = shown
    }
    
}

extension TranslatorViewController: UITextViewDelegate {
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}

extension TranslatorViewController {
    func displayAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
