//
//  AppBaseViewController.swift
//  Gallery
//
//  Created by tang on 5.7.21.
//

import UIKit
import TPKeyboardAvoiding
import SnapKit
import RxSwift
import RxCocoa

open class AppBaseViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
}

open class AppScrollViewController: AppBaseViewController {
    public var scrollView = TPKeyboardAvoidingScrollView()
    public var automaticallyUnfocus = true
    public var contentView: UIView = UIView()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
    
    private func uiSetup() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        scrollView.rx.willBeginDragging.subscribe(onNext: { [weak self] (_) in
            guard let self = self, self.automaticallyUnfocus else {return}
            self.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
}
