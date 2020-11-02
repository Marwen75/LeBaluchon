//
//  RoundButton.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 24/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit
// Custom class to have round buttons in our storyboard
@IBDesignable
class RoundButton: UIButton {

       @IBInspectable var cornerRadius: CGFloat = 0{
           didSet{
           self.layer.cornerRadius = cornerRadius
           }
       }

       @IBInspectable var borderWidth: CGFloat = 0{
           didSet{
               self.layer.borderWidth = borderWidth
           }
       }

       @IBInspectable var borderColor: UIColor = UIColor.clear{
           didSet{
               self.layer.borderColor = borderColor.cgColor
           }
       }
}
