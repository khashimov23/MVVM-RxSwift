//
//  UIView+Ext.swift
//  MVVM-RxSwift
//
//  Created by Shavkat Khoshimov on 15/10/22.
//

import UIKit

extension UIView {
    @discardableResult
    func addBorders(edges: UIRectEdge, color: UIColor, inset: CGFloat = 0.0, thickness: CGFloat = 0.3) -> [UIView] {
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }

        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }

        return borders
    }
// Usage:
//       view.addBorder(edges: [.all]) // All with default arguments
//       view.addBorder(edges: [.top], color: .green) // Just Top, green, default thickness
//       view.addBorder(edges: [.left, .right, .bottom], color: .red, thickness: 3) // All except Top, red, thickness 3
}

extension UIView {
        
    /// Top constraint
    func top(_ equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ constant: CGFloat = 0){
        self.topAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    /// Bottom constraint
    func bottom(_ equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ constant: CGFloat = 0){
        self.bottomAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    /// Left constraint
    func left(_ equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ constant: CGFloat = 0){
        self.leftAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    /// Right constraint
    func right(_ equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ constant: CGFloat = 0){
        self.rightAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    
    /// CenterY constraint
    func centerY(_ equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ constant: CGFloat = 0){
        self.centerYAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    
    /// CenterX constraint
    func centerX(_ equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ constant: CGFloat = 0){
        self.centerXAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    
    /// height constraint
    func height(_ constant: CGFloat = 0){
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    
    /// width constraint
    func width(_ constant: CGFloat = 0){
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    
    /// Width constraint for layout with other items width
    func widthForLayout(_ equalTo: NSLayoutAnchor<NSLayoutDimension>, _ constant: CGFloat = 0) {
        self.widthAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    
    /// pin to edges to parentView
    func pinToEdges(parentView: UIView, _ constant: CGFloat = 0) {
        self.top(parentView.topAnchor, constant)
        self.bottom(parentView.bottomAnchor, -constant)
        self.left(parentView.leftAnchor, constant)
        self.right(parentView.rightAnchor, -constant)
    }
}


extension UIView {
    // handle adding Subviews to parentView, and make false subviews TAMIC
    func addSubviews(parent: UIView, subviews: [UIView]) {
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
            parent.addSubview(subview)
        }
    }
}
