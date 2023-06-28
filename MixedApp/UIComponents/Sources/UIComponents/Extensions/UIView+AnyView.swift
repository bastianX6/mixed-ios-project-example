//
//  UIView+AnyView.swift
//
//
//  Created by bastian.veliz.vega on 24-04-21.
//

import SwiftUI

public extension View {
    /// Wraps this view with a type eraser.
    /// - Returns: An `AnyView` wrapping this view.
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}
