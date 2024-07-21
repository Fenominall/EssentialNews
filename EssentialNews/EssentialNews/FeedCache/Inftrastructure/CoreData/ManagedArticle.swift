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
    
    static func first(with url: URL, in context: NSManagedObjectContext) throws -> ManagedArticle? {
        let request = NSFetchRequest<ManagedArticle>(entityName: entity().name!)
        request.predicate = NSPredicate(
            format: "%K = %@",
            argumentArray: [#keyPath(ManagedArticle.url), url]
        )
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    static func articles(from localFeed: [LocalArticle], in context: NSManagedObjectContext) -> NSOrderedSet {
        let articles = NSOrderedSet(array: localFeed.map { local in
            let source = ManagedSource(context: context)
            source.id = local.source.id
            source.name = local.source.name
            
            let managed = ManagedArticle(context: context)
            managed.source = source
            managed.author = local.author
            managed.title = local.title
            managed.desscription = local.description
            managed.url = local.url
            managed.urlToImage = local.urlToImage
            managed.publishedAt = local.publishedAt
            managed.content = local.content
            
            guard let urlToImage = local.urlToImage else {
                managed.data = nil
                return managed
            }
            managed.data = context.userInfo[urlToImage] as? Data
            
            return managed
        })
        
        context.userInfo.removeAllObjects()
        return articles
    }
    
    // Called for each CoreData entity before it`s deletion
    public override func prepareForDeletion() {
        super.prepareForDeletion()
        // storing the data for url
        guard let unwrappedUrlToImage = urlToImage else {
            return
        }
        managedObjectContext?.userInfo[unwrappedUrlToImage] = data
    }
}
