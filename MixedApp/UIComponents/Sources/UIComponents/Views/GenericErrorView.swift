//
//  GenericErrorView.swift
//
//
//  Created by bastian.veliz.vega on 23-04-21.
//

import SwiftUI

/// Error view
public struct GenericErrorView: View {
    let error: Error?
    let title: String

    /// Default initializer
    /// - Parameters:
    ///   - title: view title
    ///   - error: error object
    public init(title: String, error: Error?) {
        self.title = title
        self.error = error
    }

    /// View's body
    public var body: some View {
        VStack {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100,
                       height: 100,
                       alignment: .leading)
                .foregroundColor(.red)
            Text(self.title)
                .bold()
            Text(self.error?.localizedDescription ?? "")
        }
    }
}

struct GenericErrorView_Previews: PreviewProvider {
    enum FakeError: Error {
        case fake
    }

    static var previews: some View {
        GenericErrorView(title: "View title", error: FakeError.fake)
    }
}
