//
//  ImageCache.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 09/07/25.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}
