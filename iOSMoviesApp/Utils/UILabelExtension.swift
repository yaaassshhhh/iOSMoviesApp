//
//  UIViewExtension.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 18/07/25.
//
import Foundation
import UIKit

extension UILabel {
    func setLinesByTail() {
        self.numberOfLines = 0
        self.lineBreakMode = .byTruncatingTail
    }
    func setLinesByWord() {
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }
}
