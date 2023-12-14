//
//  Styles.swift
//  Gallery
//
//  Created by tang on 5.7.21.
//

import UIKit

public struct AppGlobalStyle {
    
    public static let navigationBarTint = AppColors.navigationBar
    public static let titleColor = AppColors.textTitle
    public static let titleFont = UIFont.smbd(18)
    public static let barItemTint = AppColors.barMenu
    public static let barItemFont = UIFont.rg(16)
    public static let tabarTint = AppColors.tabarTint
}

public struct LayoutStyle {
    
    public static let sideMargin: CGFloat = 24.0
    public static let sideCellMargin: CGFloat = 10.0
    public static let separatorWidth: CGFloat = 1.0
    public static let inputViewHeight: CGFloat = 52.0
    public static let buttonHeight: CGFloat = 42.0
    
    public struct TableView {
        static let heightForHeaderInSection: CGFloat = 30.0
        static let separatorColor = AppColors.separator
    }
    
    public struct CollectionView {
        static let heightForHeaderInSection: CGFloat = 40
    }
}
