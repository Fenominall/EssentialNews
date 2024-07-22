//
//  UITableView+HeaderSizing.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 7/22/24.
//

import UIKit

extension UITableView {
    func sizeTableHeaderFit() {
        guard let header = tableHeaderView else { return }
        
        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        let needsFrameUpdate = header.frame.height != size.height
        if needsFrameUpdate {
            header.frame.size.height = size.height
            tableHeaderView = header
        }
    }
}
