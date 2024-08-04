//
//  Extension+DispatchQueue.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 8/3/24.
//

import Foundation

extension DispatchQueue {
    static func mainAsync(execute work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}

