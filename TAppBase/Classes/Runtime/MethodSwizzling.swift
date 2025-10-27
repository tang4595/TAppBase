//
//  MethodSwizzling.swift
//  XBillNotepad
//
//  Created by YL Tang on 2025/10/21.
//

import UIKit
import Dispatch

/* Bridging with `+load` method of Category `UIApplication+LoaderProxy` that implement with ObjC. */
public class RuntimeLoader: UIApplication {
    
    @objc public static func swiftyLoad() {
        DispatchQueue.once {
            var classCount: UInt32 = 0
            guard
                let image = class_getImageName(object_getClass(Self.self)),
                let classes = objc_copyClassNamesForImage(image, &classCount)
            else { return }
            for i in 0..<Int(classCount) {
                guard let clsFullName = String(cString: classes[i], encoding: .utf8) else { continue }
                (NSClassFromString(clsFullName) as? ClassLoadable.Type)?.classLoad()
            }
            classes.deallocate()
        }
    }
    
    @objc public static func swiftyInitialize() {
        
    }
}

public protocol ClassLoadable {
    
    static func classLoad()
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector)
}

public extension ClassLoadable {
    
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {return}
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}

// MARK: Utils

internal extension DispatchQueue {
    
    fileprivate static var _onceTokens = [String]()
    
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        guard !_onceTokens.contains(token) else {return}
        _onceTokens.append(token)
        block()
    }
    
    class func once(file: String = #file, function: String = #function, line: Int = #line, block: () -> Void) {
        once(token: "\(file)\(function)\(line)", block: block)
    }
}
