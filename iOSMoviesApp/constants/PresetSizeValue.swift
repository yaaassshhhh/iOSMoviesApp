//
//  PresetSizeValue.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 22/07/25.
//

import Foundation

struct PresetSizeValue {
    
    static var infoCellHeight: CGFloat {
        get {
            return getInfoCellHeight()
        }
    }
    static var castCellHeight: CGFloat {
        get {
            return getCastCellHeight()
        }
    }
    static var castCollectionViewItemSize: CGSize {
        get {
            return castCollectionViewSize()
        }
    }
    static func castCollectionViewSize() -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    static func getInfoCellHeight() -> CGFloat {
        return 290
    }
    static func getCastCellHeight() -> CGFloat {
        return 250
    }
}
