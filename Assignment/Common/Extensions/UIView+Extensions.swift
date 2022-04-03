//
//  UIView+Extensions.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

extension UIView {
    /// Call to prevent autoresizing mask's translation into constraints.
    func usingAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIView {
    /// Constraint the leading anchor to the superview's leading anchor.
    /// - Parameter constant: the constant of the constraint.
    func anchorToLeading(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
    }

    /// Constraint the trailing anchor to the superview's trailing anchor.
    /// - Parameter constant: the constant of the constraint.
    func anchorToTrailing(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant).isActive = true
    }

    /// Constraint the bottom anchor to the superview's bottom anchor.
    /// - Parameter constant: the constant of the constraint.
    func anchorToBottom(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant).isActive = true
    }

    /// Constraint the top anchor to the superview's top anchor.
    /// - Parameter constant: the constant of the constraint.
    func anchorToTop(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
    }

    /// Constraint the center y anchor to the superview's center y anchor.
    /// - Parameter constant: the constant of the constraint.
    func anchorToCenterY(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant).isActive = true
    }

    /// Constraint the center x anchor to the superview's center x anchor.
    /// - Parameter constant: the constant of the constraint.
    func anchorToCenterX(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant).isActive = true
    }

    /// Set the height constraint of the view.
    /// - Parameter constant: the constant of the constraint.
    func setHeight(_ constant: CGFloat) {
        usingAutoLayout()
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    /// Set the height constraint of the view.
    /// - Parameter constant: the constant of the constraint.
    func setWidth(_ constant: CGFloat) {
        usingAutoLayout()
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    /// Set the size constraint of the view.
    /// - Parameter size: the size of the constraint.
    func setSize(_ size: CGSize) {
        setHeight(size.height)
        setHeight(size.width)
    }
}

extension UIView {
    /// Constraint the center x and y anchor to the superview's center x and y anchor.
    func anchorToCenter() {
        anchorToCenterX()
        anchorToCenterY()
    }

    /// Constraint the view's anchors to the superview's anchors.
    /// - Parameter top: the constant of the top constraint. If nil, it will be ignored. By default nil.
    /// - Parameter bottom: the constant of the constraint. If nil, it will be ignored. By default nil.
    /// - Parameter leading: the constant of the constraint. If nil, it will be ignored. By default nil.
    /// - Parameter trailing: the constant of the constraint. If nil, it will be ignored. By default nil.
    func anchorToSuperview(top: CGFloat? = nil,
                           bottom: CGFloat? = nil,
                           leading: CGFloat? = nil,
                           trailing: CGFloat? = nil) {
        if let top = top {
            anchorToTop(constant: top)
        }
        if let bottom = bottom {
            anchorToBottom(constant: bottom)
        }
        if let leading = leading {
            anchorToLeading(constant: leading)
        }
        if let trailing = trailing {
            anchorToTrailing(constant: trailing)
        }
    }
}
