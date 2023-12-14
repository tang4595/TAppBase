//
//  Fonts.swift
//  TAppBase
//
//  Created by tang on 10.10.22.
//

import UIKit

public extension UIFont {
    
    // MARK: 常规
    static func rg(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func smbd(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static func md(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func bd(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    // MARK: 数字/金额
    static func d_rg(_ size: CGFloat) -> UIFont {
        return .rg(size)
    }
    
    static func d_smbd(_ size: CGFloat) -> UIFont {
        return .smbd(size)
    }
    
    static func d_md(_ size: CGFloat) -> UIFont {
        return .md(size)
    }
    
    static func d_bd(_ size: CGFloat) -> UIFont {
        return .bd(size)
    }
}
