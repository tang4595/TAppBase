//
//  DisposeBagAssembled.swift
//  XBillNotepad
//
//  Created by YL Tang on 2025/10/21.
//

import Foundation
import RxSwift
import Dispatch

public class DisposeBagAssembled {
    var disposeBag = DisposeBag()
}

fileprivate var kStorageKeyDisposeBag: Void?

public extension NSObject {
    
    var disposeBag: DisposeBag! {
        get {
            return objc_getAssociatedObject(self, &kStorageKeyDisposeBag) as? DisposeBag
        }
        set {
            objc_setAssociatedObject(self, &kStorageKeyDisposeBag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIViewController: ClassLoadable {
    
    public static func classLoad() {
        DispatchQueue.once {
            swizzlingForClass(UIViewController.self, originalSelector: #selector(viewDidLoad), swizzledSelector: #selector(swizzled_viewDidLoad))
        }
    }
    
    @objc func swizzled_viewDidLoad() {
        if disposeBag == nil {
            disposeBag = DisposeBag()
        }
        swizzled_viewDidLoad()
    }
}

extension UIView: ClassLoadable {
    
    public static func classLoad() {
        DispatchQueue.once {
            swizzlingForClass(UIView.self, originalSelector: #selector(willMove(toSuperview:)), swizzledSelector: #selector(swizzled_willMove(toSuperview:)))
        }
    }
    
    @objc func swizzled_willMove(toSuperview newSuperview: UIView?) {
        if type(of: self).description().hasPrefix(Bundle.main.executableName), disposeBag == nil {
            disposeBag = DisposeBag()
        }
        swizzled_willMove(toSuperview: newSuperview)
    }
}

fileprivate let lock = NSRecursiveLock()

public extension NSObject {
    
    /** 类似于UIView对象init方法需要访问disposeBag的任何场景，此时还未执行willMove(toSuperview:)需要手动赋值 */
    func ___initDisposeBagManually() {
        if !DispatchQueue.isMainQueue {
            lock.lock()
        }
        if disposeBag == nil {
            disposeBag = DisposeBag()
        }
        if !DispatchQueue.isMainQueue {
            lock.unlock()
        }
    }
}

// MARK: Utils

internal extension Bundle {
    
    var executableName: String {
        return infoDictionary?["CFBundleExecutable"] as? String ?? ""
    }
}
