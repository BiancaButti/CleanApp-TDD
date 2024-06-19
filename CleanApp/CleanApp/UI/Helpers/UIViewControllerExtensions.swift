//
//  UIViewControllerExtensions.swift
//  UI
//
//  Created by Bianca on 22/11/23.
//

import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
}
