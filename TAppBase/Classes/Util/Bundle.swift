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
