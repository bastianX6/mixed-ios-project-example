//
//  MainTabBarViewController.swift
//
//
//  Created by bastian.veliz.vega on 04-02-22.
//

import Foundation
import UIKit

final class MainTabBarViewController: UITabBarController {
    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
