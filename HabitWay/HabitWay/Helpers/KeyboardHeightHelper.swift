//
//  KeyboardHeightHelper.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 13.12.2023.
//

import UIKit

final class KeyboardHeightHelper: ObservableObject {
    
    
    private var _center: NotificationCenter
       @Published var keyboardHeight: CGFloat = 0

       init(center: NotificationCenter = .default) {
           _center = center
           _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
           _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       }

       deinit {
           _center.removeObserver(self)
       }

       @objc func keyBoardWillShow(notification: Notification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               keyboardHeight = keyboardSize.height
           }
       }

       @objc func keyBoardWillHide(notification: Notification) {
           keyboardHeight = 0
       }
}
