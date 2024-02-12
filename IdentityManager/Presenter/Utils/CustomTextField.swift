//
//  CustomTextField.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 13/02/24.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK: - Properties
    var customBackgroundColor: UIColor = .backgroundSoftBlue {
        didSet {
            backgroundColor = customBackgroundColor
            setupTextField()
        }
    }
    
    var customTextColor: UIColor = .black {
        didSet {
            textColor = customTextColor
            setupTextField()
        }
    }
    
    var customBorderColor: UIColor = .clear {
        didSet {
            layer.borderColor = customBorderColor.cgColor
            setupTextField()
        }
    }
    
    var placeHolder: String {
        get {
            return placeholder ?? .emptyString
        }
        set {
            placeholder = newValue
            setupTextField()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    // MARK: - Setup
    private func setupTextField() {
        // Set default properties
        clearButtonMode = .always
        backgroundColor = customBackgroundColor
        textColor = customTextColor
        layer.borderWidth = 1.0
        layer.borderColor = customBorderColor.cgColor
        layer.cornerRadius = 10.0
        clipsToBounds = true
        attributedPlaceholder = NSAttributedString(string: self.placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryText])
    }
    
}
