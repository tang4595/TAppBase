//
//  Bundle.swift
//  TAppBase
//
//  Created by tang on 10.10.22.
//

import Foundation

public extension Bundle {
    
    static func frameworkBundle(moduleName: String) -> Bundle? {
        if var bundleURL = Bundle.main.url(forResource: "Frameworks", withExtension: nil) {
            if #available(iOS 16.0, *) {
                bundleURL = bundleURL.appending(component: moduleName)
            } else {
                bundleURL = bundleURL.appendingPathComponent(moduleName)
            }
            bundleURL = bundleURL.appendingPathExtension("framework")
            return Bundle(url: bundleURL)
        }
        return nil
    }
    
    static func fetchImage(imageName: String, moduleName: String, bundleName: String) -> UIImage? {
        if let bundle = frameworkBundle(moduleName: moduleName),
           let tempBundleURL = bundle.url(forResource: bundleName, withExtension: "bundle"),
           let tempBundle = Bundle(url: tempBundleURL) {
            return UIImage(named: imageName, in: tempBundle, compatibleWith: nil)
        }
        return nil
    }
    
    static func fetchFilePath(fileName: String, moduleName: String, bundleName: String) -> String? {
        if let bundle = frameworkBundle(moduleName: moduleName),
           let tempBundleURL = bundle.url(forResource: bundleName, withExtension: "bundle"),
           let tempBundle = Bundle(url: tempBundleURL),
           let file = tempBundle.path(forResource: fileName, ofType: nil) {
           return file
        }
        return nil
    }
    
    static func fetchFileURL(fileName: String, moduleName: String, bundleName: String) -> URL? {
        return URL(string: fetchFilePath(fileName: fileName, moduleName: moduleName, bundleName: bundleName))
    }
}

public extension String {
    
    /// 工程内图片
    public var image: UIImage? {
        return UIImage(named: self)
    }
    
    /// 获取Bundle中的图片
    public func image(in bundle: Bundle?) -> UIImage? {
        return UIImage(named: self, in: bundle, with: nil)
    }
    
    /// 多语言读取
    /// - Parameter bundle: 包
    /// - Returns: 多语言
    public func language(in bundle: Bundle?) -> String {
        if let bundle {
            if !bundle.isLoaded { bundle.load() }
            let language = "zh-Hans"
            if let path = bundle.path(forResource: language, ofType: "lproj"), let languageBundle = Bundle(path: path) {
                return NSLocalizedString(self, tableName: nil, bundle: languageBundle, value: "", comment: "")
            }
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }
        return self
    }
    
    /// 多语言带参读取
    /// - Parameter bundle: 包名
    /// - Parameter args: 参数
    /// - Returns: 多语言
    public func language(in bundle: Bundle?, args: CVarArg...) -> String {
        return String(format: language(in: bundle), args)
    }
    
    public func language(in bundle: Bundle?, args: String, args1: String) -> String {
        return String(format: language(in: bundle), args, args1)
    }
    
    public func language(in bundle: Bundle?, args: String) -> String {
        return String(format: language(in: bundle), args)
    }
}
