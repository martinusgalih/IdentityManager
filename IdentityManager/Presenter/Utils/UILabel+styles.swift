//
//  UILabel+styles.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 13/02/24.
//

import UIKit

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
    
    func underlineText(textToUnderline: String) {
        guard let labelText = self.text else { return }
        
        if let range = labelText.range(of: textToUnderline) {
            let nsRange = NSRange(range, in: labelText)
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
            
            self.attributedText = attributedString
        }
    }
}
