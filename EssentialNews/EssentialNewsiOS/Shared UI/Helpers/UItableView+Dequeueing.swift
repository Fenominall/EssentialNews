//
//  UItableView+Dequeueing.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 7/22/24.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
