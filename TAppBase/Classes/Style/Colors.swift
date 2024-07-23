//
//  Colors.swift
//  Gallery
//
//  Created by tang on 5.7.21.
//

import UIKit

public struct AppColors {
    
    /// Window.
    static let windowBg = UIColor.white
    /// Toast.
    static let toastBg = UIColor.black.withAlphaComponent(0.8)
    /// 导航栏.
    static let navigationBar = UIColor.white
    /// 导航栏按钮.
    static let barMenu = UIColor.gray
    /// 页面背景.
    static let viewBg = UIColor.white
    /// Tabar背景.
    static let tabarTint = UIColor.white
    /// 按钮背景-可交互.
    static let btnBgEnabled = UIColor.systemBlue
    /// 按钮背景-不可交互.
    static let btnBgDisabled = UIColor.systemBlue.withAlphaComponent(0.5)
    /// 按钮标题-可交互.
    static let btnTitleEnabled = UIColor.white
    /// 按钮标题-不可交互.
    static let btnTitleDisabled = UIColor.black
    /// 按钮标题-取消.
    static let btnTitleCancel = UIColor.red
    /// 标题文本.
    static let textTitle = UIColor.c1
    /// 二级标题文本.
    static let textSubtitle = UIColor.gray
    /// 常规文本.
    static let textGeneric = UIColor.black
    /// 分割线.
    static let separator = UIColor.gray.withAlphaComponent(0.3)
    /// 错误.
    static let error = UIColor.red
}

public enum AppColorType: String {
    case C1 = "C1"
    case C2 = "C2"
    case C3 = "C3"
    case C4 = "C4"
    case C5 = "C5"
    case C6 = "C6"
    case C7 = "C7"
    case C8 = "C8"
    case C9 = "C9"
    case C10 = "C10"
    case C11 = "C11"
    case C12 = "C12"
    case C13 = "C13"
    case C14 = "C14"
    case C15 = "C15"
    case G1 = "G1"
    case G2 = "G2"
    case G3 = "G3"
    case G4 = "G4"
}

public extension UIColor {
    
    static func color(_ type: AppColorType) -> UIColor {
        return AppSkin.shared.color(key:type.rawValue)
    }
    
    static func colors(_ type: AppColorType) -> [UIColor] {
        return AppSkin.shared.colors(key:type.rawValue)
    }
    
    static var c1: UIColor { color(.C1)}
    static var c2: UIColor { color(.C2)}
    static var c3: UIColor { color(.C3)}
    static var c4: UIColor { color(.C4)}
    static var c5: UIColor { color(.C5)}
    static var c6: UIColor { color(.C6)}
    static var c7: UIColor { color(.C7)}
    static var c8: UIColor { color(.C8)}
    static var c9: UIColor { color(.C9)}
    static var c10: UIColor { color(.C10)}
    static var c11: UIColor { color(.C11)}
    static var c12: UIColor { color(.C12)}
    static var c13: UIColor { color(.C13)}
    static var c14: UIColor { color(.C14)}
    static var c15: UIColor { color(.C15)}
    static var g1: [UIColor] { colors(.G1)}
    static var g2: [UIColor] { colors(.G2)}
    static var g3: [UIColor] { colors(.G3)}
    static var g4: [UIColor] { colors(.G4)}
    static var up: UIColor { UIColor(hexString: "#40B970")! }
    static var down: UIColor { UIColor(hexString: "#D03131")! }
}
