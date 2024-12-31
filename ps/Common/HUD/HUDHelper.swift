//
//  HUDHelper.swift
//  ps
//
//  Created by chen on 2024/11/17.
//

import Foundation
import MBProgressHUD


struct HUDHelper {
    static func showIndicator() {
        guard let view = keyWindow else { return }
        MBProgressHUD.hide(for: view, animated: true)
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    static func hideIndicator() {
        guard let view = keyWindow else { return }
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    static func showMessage(message: String) {
        guard let view = keyWindow else { return }
        MBProgressHUD.hide(for: view, animated: true)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = message
        hud.label.font = .systemFont(ofSize: 14, weight: .medium)
        hud.label.numberOfLines = 0
        hud.isUserInteractionEnabled = false
        hud.hide(animated: true, afterDelay: 2.5)
    }
    
    static func showError(error: Error) {
        Self.showMessage(message: error.localizedDescription)
    }
}
