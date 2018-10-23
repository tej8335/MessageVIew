//
//  UIView+Extensions.swift
//  PBToastView
//
//  Created by Tej on 23/10/18.
//  Copyright © 2018 Peerbits. All rights reserved.
//
import UIKit
import Foundation

extension UIView {
    func showMessage(_ message : String , direction : Direction)
    {
        let msgView = PBMessageView()
        msgView.showMessage(messageType: .Error, message, view: self, direction: direction)
    }
}
