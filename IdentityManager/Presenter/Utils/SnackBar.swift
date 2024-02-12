//
//  SnackBar.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 13/02/24.
//

import UIKit

class SnackbarView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let padding: CGFloat = 16
    private let animationDuration: TimeInterval = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = UIColor.errorBackground.withAlphaComponent(0.8)
        layer.cornerRadius = 8
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
    }
    
    func showMessage(_ message: String, duration: TimeInterval = 3) {
        label.text = message
        
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.addSubview(self)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraint(equalTo: keyWindow.safeAreaLayoutGuide.topAnchor, constant: -self.frame.size.height).isActive = true
            self.leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor, constant: padding).isActive = true
            self.trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor, constant: -padding).isActive = true
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseInOut], animations: {
                self.topAnchor.constraint(equalTo: keyWindow.safeAreaLayoutGuide.topAnchor, constant: self.padding).isActive = true
                keyWindow.layoutIfNeeded()
            }, completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                    self.hide()
                })
            })
        }
    }
    
    private func hide() {
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseInOut], animations: {
                self.topAnchor.constraint(equalTo: keyWindow.safeAreaLayoutGuide.topAnchor, constant: -self.frame.size.height).isActive = true
                keyWindow.layoutIfNeeded()
            }, completion: { _ in
                self.removeFromSuperview()
            })
        }
    }
}
