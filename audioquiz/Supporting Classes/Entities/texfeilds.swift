//
//  textfeildmaxlimit.swift
//  Zivello-Kiosk
//
//  Created by KHUSHBOO on 31/05/19.
//  Copyright © 2019 KHUSHBOO. All rights reserved.
//

import Foundation
import UIKit

private var kAssociationKeyMaxLength: Int = 0
private var rPadding: Int = 0
extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}

class RTextField: UITextField {
    
    ///
    var padding: UIEdgeInsets?
    ///
    @IBInspectable var cornerRadius: CGFloat = 4.0
    ///
    @IBInspectable var leftRightPadding: CGFloat = 11 {
        didSet {
            setPadding()
        }
    }
    ///
    @IBInspectable var isHaveBoarder: Bool = true {
        didSet {
            guard isHaveBoarder else { return }
            setBorder()
            setCornerRadius(value: cornerRadius)
        }
    }
    
    func setPadding() {
        padding = UIEdgeInsets(top: 0, left: leftRightPadding, bottom: 0, right: leftRightPadding)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        guard let paddingText = padding else { return CGRect() }
        return bounds.inset(by: paddingText)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        guard let paddingText = padding else { return CGRect() }
        return bounds.inset(by: paddingText)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        guard let paddingText = padding else { return CGRect() }
        return bounds.inset(by: paddingText)
    }
    
    ///
    func setBorder() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.7882352941, green: 0.7882352941, blue: 0.7882352941, alpha: 1).cgColor
    }
    ///
    func setCornerRadius(value: CGFloat) {
        self.layer.cornerRadius = value
    }

    
}
