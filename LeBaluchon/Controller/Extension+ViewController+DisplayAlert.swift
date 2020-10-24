//
//  Extension+ViewController+DisplayAlert.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 24/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

extension UIViewController {
    func displayAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
