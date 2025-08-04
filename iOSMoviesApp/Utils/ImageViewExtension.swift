//
//  ImageViewExtension.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 14/07/25.
//
import UIKit

extension UIImageView {
    func setRounded() {
//            self.contentMode = .scaleAspectFit
            self.layer.cornerRadius = self.frame.width / 2
            self.layer.masksToBounds = true
       }
}
