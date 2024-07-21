//
//  ManagedArticle+CoreDataProperties.swift
//  EssentialNews
//
//  Created by Fenominall on 7/21/24.
//
//

import Foundation
import CoreData


@objc(ManagedArticle)
class ManagedArticle: NSManagedObject {
    @NSManaged var author: String?
    @NSManaged var title: String
    @NSManaged var desscription: String?
    @NSManaged var url: URL
    @NSManaged var urlToImage: URL?
    @NSManaged var publishedAt: Date
    @NSManaged var content: String?
    @NSManaged var data: Data?
    @NSManaged var source: ManagedSource
    @NSManaged var cache: ManagedCache
}

extension ManagedArticle {
    var local: LocalArticle {
        return LocalArticle(
            source: LocalSource(
                id: source.id,
                name: source.name
            ),
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content
        )
    }
}
