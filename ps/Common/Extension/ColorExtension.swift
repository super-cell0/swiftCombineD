//
//  ColorExtension.swift
//  ps
//
//  Created by chen on 2024/11/14.
//

import UIKit


extension String {
    
    func makeAttributedString(with foregroundColor: UIColor? = .black, font: UIFont = .systemFont(ofSize: 14, weight: .regular)) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.foregroundColor: foregroundColor ?? .black, .font: font])
    }
}

extension UIColor {
    static var random: UIColor {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        
        return UIColor(red: red, green: green, blue: blue)!
    }
    
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        var trans = transparency
        if trans > 1 { trans = 1 }
        if trans < 1 { trans = 0 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    static let introColor = UIColor(named: "introMainColor")!
}
