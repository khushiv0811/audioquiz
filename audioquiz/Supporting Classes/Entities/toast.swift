//
//  toast.swift
//  aasoa
//
//  Created by KHUSHBOO on 27/02/19.
//  Copyright © 2019 KHUSHBOO. All rights reserved.
//

import Foundation
import Toast_Swift

// MARK: - UIView extension for manage toast view
extension UIView {
    // MARK: UIView extension for manage toast view method
    
    /// Hel to show toast
    /// - Parameter message: message of toast
    func showToast(message : String)
    {
        self.makeToast(message, duration: 3.0, position: .center)
    }
}
