//
//  NavigationController.swift
//  ps
//
//  Created by chen on 2024/11/14.
//

import UIKit

protocol NavigationBarSettings: UIViewController {
    var navigationTintColor: UIColor? { get }
    var navigationBarTintColor: UIColor? { get }
    var hidesSeparator: Bool { get }
    var isInteractivePopGestureRecognizerEnabled: Bool { get }
}

extension NavigationBarSettings {
    var navigationTintColor: UIColor? { return nil }
}

class BaseNavigationController: UINavigationController {
        
    private let _view_background: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let _shadowLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    override var childForStatusBarStyle: UIViewController? {
        visibleViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        visibleViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
        
        if let colors = rootViewController as? NavigationBarSettings {
            setNavigationBarColors(colors)
        }
    }
    
    
    func setNavigationBarColors(_ colors: NavigationBarSettings) {
        
        if let tintColor = colors.navigationTintColor {
            navigationBar.titleTextAttributes = [
                .foregroundColor : tintColor,
                .font: UIFont.systemFont(ofSize: 17, weight: .medium)
            ]
            navigationBar.tintColor = tintColor
        }
        _view_background.backgroundColor = colors.navigationBarTintColor
        _shadowLine.isHidden = colors.hidesSeparator
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            viewController.hidesBottomBarWhenPushed = false
        }
        
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem()
        super.pushViewController(viewController, animated: animated)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        let vcs = viewControllers
        vcs.forEach {
            $0.hidesBottomBarWhenPushed = true
            $0.navigationItem.backBarButtonItem = UIBarButtonItem()
        }
        vcs.first?.hidesBottomBarWhenPushed = false
        super.setViewControllers(vcs, animated: animated)
    }
    
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count == 1 {
            return false
        } else {
            return (topViewController as? NavigationBarSettings)?.isInteractivePopGestureRecognizerEnabled ?? false
        }
    }
}


extension UINavigationController {
    
    var rootViewController: UIViewController? {
        return viewControllers.first
    }
}
