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
    
    static var reviewCellHeight: CGFloat {
        get {
            return getReviewCellHeight()
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
    
    static var reviewCollectionViewItemSize: CGSize {
        get {
            return reviewCollectionViewSize()
        }
    }
    
    static func reviewCollectionViewSize() -> CGSize {
        return CGSize(width: 250, height: 220)
    }
    
    static func castCollectionViewSize() -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    
    
    static func getInfoCellHeight() -> CGFloat {
        return 320
    }
    
    static func getCastCellHeight() -> CGFloat {
        return 250
    }
    
    static func getReviewCellHeight() -> CGFloat {
        return 292
    }
}
