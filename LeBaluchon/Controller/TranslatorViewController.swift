//
//  TranslatorViewController.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 21/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {
    //MARK: - Properties
    var translatorService: TranslatorService!
    private var placeholderLabel: UILabel!
    
    //MARK: - Outlets
    @IBOutlet weak var traductionButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var frenchTextView: UITextView!
    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(shown: false)
        // creating a placeholder for the frenchtextview
        placeholderLabel = UILabel()
        placeholderLabel.text = "Entrez votre texte ici."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (frenchTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        frenchTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (frenchTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !frenchTextView.text.isEmpty
        // Add a "continue" button to the textviex keyboard
        self.frenchTextView.addContinueButton(title: "Terminé", target: self, selector: #selector(tapContinue(sender:)))
    }
    
    //MARK: - Actions
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        frenchTextView.resignFirstResponder()
    }
    
    @IBAction func traductionButtonTapped(_ sender: UIButton) {
        do {
            try makeTheTranslation()
            stackViewAnimation()
        } catch let error as TranslatorError {
            displayAlert(title: error.errorDescription, message: error.failureReason)
        } catch {
            displayAlert(title: "Oups!", message: "erreur inconnue")
        }
    }
    
    //MARK: - Methods
    @objc private func tapContinue(sender: Any) {
        self.view.endEditing(true)
    }
    
    private func makeTheTranslation() throws {
        guard let text = frenchTextView.text else { return }
        if text.isEmpty {
            throw TranslatorError.incorrectSentence
        }
        toggleActivityIndicator(shown: true)
        translatorService.getTranslation(text: text, completionHandler: { [weak self] result in
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
    
    private func stackViewAnimation() {
        stackView.transform = .identity
        stackView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: [], animations: {
            self.stackView.transform = .identity }, completion: nil)
    }
}
    //MARK: - Extension
extension TranslatorViewController: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
