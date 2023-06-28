//
//  UIColor+Custom.swift
//
//
//  Created by bastian.veliz.vega on 23-04-21.
//

import Foundation
import SwiftUI
import UIKit

public extension Color {
    /**
     Background color
     */
    static let backgroundColor: Color = {
        Color(UIColor.systemBackground)
    }()

    /**
     Foreground color
     */
    static let foregroundColor: Color = {
        Color(UIColor.systemBackground)
    }()

    /**
     Indigo color
     */
    static let indigo: Color = {
        Color(UIColor.systemIndigo)
    }()

    /**
     Indigo color
     */
    static let teal: Color = {
        Color(UIColor.systemTeal)
    }()

    /**
     System gray color
     */
    static let systemGray: Color = {
        Color(UIColor.systemGray)
    }()

    /**
     System gray 2 color
     */
    static let systemGray2: Color = {
        Color(UIColor.systemGray2)
    }()

    /**
     System gray 3 color
     */
    static let systemGray3: Color = {
        Color(UIColor.systemGray3)
    }()

    /**
     System gray 4 color
     */
    static let systemGray4: Color = {
        Color(UIColor.systemGray4)
    }()

    /**
     System gray 5 color
     */
    static let systemGray5: Color = {
        Color(UIColor.systemGray5)
    }()

    /**
     System gray 6 color for each OS
     */
    static let systemGray6: Color = {
        Color(UIColor.systemGray6)
    }()
}
