//
//  AppBaseNavigationController.swift
//  Gallery
//
//  Created by tang on 5.7.21.
//

import RTRootNavigationController

public class AppBaseNavigationController: RTRootNavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            let backImage = UIImage(named: "navigationBackBlack")?.withAlignmentRectInsets(
                UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            ).withRenderingMode(.alwaysOriginal)
            let button = UIButton(type: .custom)
            button.setImage(backImage, for: .normal)
            button.setImage(backImage, for: .highlighted)
            button.sizeToFit()
            button.contentHorizontalAlignment = .left
            button.addTarget(self, action: #selector(popSelf), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 40.0, height: 40.0)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func popSelf() {
        self.popViewController(animated: true)
    }
}
