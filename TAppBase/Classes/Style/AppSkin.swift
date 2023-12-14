//
//  AppSkin.swift
//  TAppBase
//
//  Created by tang on 10.10.22.
//

import Foundation
import UIKit
import SwifterSwift

public class AppSkin {
    
    public static let shared = AppSkin()
    private init() {}
    
    private var colorPlist = [String: String]()
    /// 单值颜色
    private var colors = [String: UIColor]()
    /// 数组颜色
    private var listableColors = [String: [UIColor]]()
    /// 夜间模式
    private var isDark = false
    private var darkBundle: Bundle? {
        let frameworkBundle = Bundle.frameworkBundle(moduleName: "TAppBase")
        guard let resourceBundlePath = frameworkBundle?.url(forResource: "TAppBaseDarkResource", withExtension: "bundle") else { return nil }
        let resourceBundle = Bundle(url: resourceBundlePath)
        return resourceBundle
    }
    private var normalBundle: Bundle? {
        let frameworkBundle = Bundle.frameworkBundle(moduleName: "TAppBase")
        guard let resourceBundlePath = frameworkBundle?.url(forResource: "TAppBaseResource", withExtension: "bundle") else { return nil }
        let resourceBundle = Bundle(url: resourceBundlePath)
        return resourceBundle
    }
}

public extension AppSkin {
    
    func color(key: String) -> UIColor {
        if let color = self.colors[key] {
            return color
        }
        
        if self.colorPlist.count == 0 {
            let bundle = isDark ? darkBundle : normalBundle
            let path = bundle?.path(forResource: "AppColors", ofType: "plist")
            self.colorPlist = NSDictionary(contentsOfFile: path ?? "") as? [String: String] ?? [:]
        }
        
        let value = self.colorPlist[key] ?? "#060606"
        let color = UIColor.init(hexString: value.colorComps.0, transparency: value.colorComps.1) ?? UIColor.white
        self.colors[key] = color
        return color
   }
    
    func colors(key: String) -> [UIColor] {
        if let colors = self.listableColors[key] {
            return colors
        }
        
        if self.colorPlist.count == 0 {
            let bundle = isDark ? darkBundle : normalBundle
            let path = bundle?.path(forResource: "AppColors", ofType: "plist")
            self.colorPlist = NSDictionary(contentsOfFile: path ?? "") as? [String: String] ?? [:]
        }
        
        let value = self.colorPlist[key] ?? "#060606-#060606"
        let values = value.split(separator: "-")
        let colors = values.map { sub in
            let comps = String(sub).colorComps
            return UIColor.init(hexString: comps.0, transparency: comps.1) ?? UIColor.black
        }
        self.listableColors[key] = colors
        return colors
   }
}

private extension String {
    
    /// Hex, Alpha
    var colorComps: (String, CGFloat) {
        let comps = self.split(separator: "_")
        guard let hex = comps.first else {
            return ("#060606", 1.0)
        }
        let alpha: String = comps.count > 1 ? String(comps.last ?? "1.0") : "1.0"
        return (String(hex), Float(alpha)?.cgFloat ?? 1.0)
    }
}
