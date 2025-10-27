//
//  EmptyViewAssembled.swift
//  XBillNotepad
//
//  Created by YL Tang on 2025/10/21.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit

fileprivate var kStorageKeyEmptyView: Void?

public extension NSObject {
    
    fileprivate var _emptyView: UIView! {
        get {
            return objc_getAssociatedObject(self, &kStorageKeyEmptyView) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &kStorageKeyEmptyView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate func initEmptyView() {
//        if _emptyView == nil {
//            if let container = self as? UIView {
//                _emptyView = TUtilExt.EmptyView.generic
//                _emptyView.isHidden = true
//                container.addSubview(_emptyView)
//                container.bringSubviewToFront(_emptyView)
//                _emptyView.snp.makeConstraints { make in
//                    make.centerX.equalToSuperview()
//                    make.centerY.equalToSuperview().offset(-50.0)
//                    make.left.right.equalToSuperview()
//                }
//            } else if let container = self as? UIViewController {
//                _emptyView = TUtilExt.EmptyView.generic
//                _emptyView.isHidden = true
//                container.view.addSubview(_emptyView)
//                container.view.bringSubviewToFront(_emptyView)
//                _emptyView.snp.makeConstraints { make in
//                    make.centerX.equalToSuperview()
//                    make.centerY.equalToSuperview().offset(-50.0)
//                    make.left.right.equalToSuperview()
//                }
//            }
//        }
    }
}

extension UIViewController {
    
    var emptyView: UIView {
        initEmptyView()
        return _emptyView
    }
    
//    func emptyViewUpdate(title: String? = nil, icon: String? = nil) {
//        guard let targetView = emptyView as? TUtilExt.EmptyView else {return}
//        if let title = title {
//            targetView.titleStr = title
//        }
//        if let icon = icon {
//            targetView.iconName = icon
//        }
//    }
}

extension UIView {
    
    var emptyView: UIView {
        initEmptyView()
        return _emptyView
    }
}

extension Reactive where Base: UIViewController {
    
    var showEmptyView: Binder<Bool> {
        return Binder<Bool>(base) { (base, value) in
            base.emptyView.isHidden = !value
        }
    }
}

extension Reactive where Base: UIView {
    
    var showEmptyView: Binder<Bool> {
        return Binder<Bool>(base) { (base, value) in
            base.emptyView.isHidden = !value
        }
    }
}
