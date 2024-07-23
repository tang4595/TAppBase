//
//  AppStyle.swift
//  Gallery
//
//  Created by tang on 5.7.21.
//

import UIKit

public enum AppStyle {
    case title
    case subTitle
    case barMenu
    case confirmButton
    case cancelButton
    case generic
    case error
}

public extension AppStyle {
    
    var color: UIColor {
        switch self {
        case .title:
            return AppColors.textTitle
        case .subTitle:
            return AppColors.textSubtitle
        case .barMenu:
            return AppColors.barMenu
        case .confirmButton:
            return AppColors.btnTitleEnabled
        case .cancelButton:
            return AppColors.btnTitleCancel
        case .generic:
            return AppColors.textGeneric
        case .error:
            return AppColors.error
        }
    }
    
    var font: UIFont {
        switch self {
        case .title:
            return UIFont.systemFont(ofSize: 18.0, weight: .medium)
        case .subTitle:
            return UIFont.systemFont(ofSize: 16.0, weight: .regular)
        case .barMenu:
            return UIFont.systemFont(ofSize: 16.0, weight: .regular)
        case .confirmButton:
            return UIFont.systemFont(ofSize: 16.0, weight: .regular)
        case .cancelButton:
            return UIFont.systemFont(ofSize: 16.0, weight: .regular)
        case .generic:
            return UIFont.systemFont(ofSize: 16.0, weight: .regular)
        case .error:
            return UIFont.systemFont(ofSize: 16.0, weight: .regular)
        }
    }
    
    static var statusBarStyle: UIStatusBarStyle = .default/** TODO: aop实现切换状态栏颜色 */
}

public func configAppStyle() {
    /// Tabar
    UITabBar.appearance().backgroundImage = UIImage(color: .white, size: CGSize(width: 1.0, height: 1.0))
    UITabBar.appearance().shadowImage = UIImage(color: .clear, size: CGSize(width: 0.5, height: 0.5))
    UITabBar.appearance().tintColor = .c7
    
    /// NaviBar
    let bar = UINavigationBar.appearance()
    if #available(iOS 15.0, *) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowImage = UIImage(color: .clear, size: CGSize(width: 1.0, height: 1.0))
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.c1,
                                          NSAttributedString.Key.font:UIFont.bd(17.0)]
        bar.backgroundColor = .white
        bar.standardAppearance = appearance
        bar.scrollEdgeAppearance = appearance
        UITabBar.appearance().backgroundColor = .white
    } else {
        bar.setBackgroundImage(UIImage(color: .c2, size: CGSize(width: 1.0, height: 1.0)), for: .default)
        bar.shadowImage = UIImage()
    }
    
    let backImage = UIImage(named: "navigationBackBlack")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)).withRenderingMode(.alwaysOriginal)
    UINavigationBar.appearance().backIndicatorImage = backImage
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.c1,
                                                        NSAttributedString.Key.font:UIFont.bd(17.0)]
    
    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.c1,
                                                         NSAttributedString.Key.font:UIFont.smbd(16)], for: .normal)
    
    /// Other
    UITextField.appearance().tintColor = UIColor.blue
}
