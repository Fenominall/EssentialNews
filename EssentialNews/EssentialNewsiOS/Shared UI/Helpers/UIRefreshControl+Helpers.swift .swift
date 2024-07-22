//
//  UIRefreshControl+Helpers.swift .swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 7/22/24.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        return isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
