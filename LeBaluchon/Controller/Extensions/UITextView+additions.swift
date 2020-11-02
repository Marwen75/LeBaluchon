//
//  UiTextView+additions.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 28/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

extension UITextView {
    
    func addContinueButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}

