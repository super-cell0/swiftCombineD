//
//  BaseViewController.swift
//  ps
//
//  Created by chen on 2024/11/14.
//

import UIKit
import Combine
import SwifterSwift
import SnapKit

class BaseViewController: UIViewController, NavigationBarSettings {
    
    var subscriptions = Set<AnyCancellable>()
    
    var navigationBarTintColor: UIColor? {
        .white
    }
    
    var navigationTintColor: UIColor? {
        .black
    }
    
    var hidesSeparator: Bool {
        true
    }
    
    var isInteractivePopGestureRecognizerEnabled: Bool {
        true
    }
    
    deinit {
        print("\(String(describing: self)) 🥳🥳🥳🥳")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindView()
        
        if let nav = self.navigationController as? BaseNavigationController {
            nav.setNavigationBarColors(self)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        transitionCoordinator?.animateAlongsideTransition(in: navigationController?.navigationBar, animation: { [weak self] (context) in
            guard let `self` = self else { return }
            
            guard let nav = self.navigationController as? BaseNavigationController else { return }
            
            nav.setNavigationBarColors(self)
        }, completion: { [weak self] (context) in
            guard let `self` = self else { return }
            
            guard let nav = self.navigationController as? BaseNavigationController else { return }
            
            nav.setNavigationBarColors(self)
        })
    }
    

    func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    func bindView() {
        
    }
    
    
}

