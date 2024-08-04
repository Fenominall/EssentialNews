//
//  Data+mapDataIntoUIImage.swift
//  EssentialNewsApp
//
//  Created by Fenominall on 8/4/24.
//

import UIKit
import Foundation

func mapDataIntoImage(_ data: Data) throws -> UIImage {
    guard let image = UIImage(data: data) else {
        throw InvalidImageDataError()
    }
    return image
}

class InvalidImageDataError: Error {}
