//
//  LoadingView.swift
//
//
//  Created by bastian.veliz.vega on 23-04-21.
//

import SwiftUI

/// Loading view
public struct LoadingView: View {
    /// Default initializer
    public init() {}

    /// View's body
    public var body: some View {
        VStack {
            ProgressView()
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .background(Color.backgroundColor.opacity(0.5))
    }
}

struct LoadingView_Previews: PreviewProvider {
    enum FakeError: Error {
        case fake
    }

    static var previews: some View {
        LoadingView()
    }
}
