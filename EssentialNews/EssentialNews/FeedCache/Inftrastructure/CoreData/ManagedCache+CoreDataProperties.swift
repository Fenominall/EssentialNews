//
//  ManagedCache+CoreDataProperties.swift
//  EssentialNews
//
//  Created by Fenominall on 7/21/24.
//
//

import Foundation
import CoreData


@objc(ManagedCache)
public class ManagedCache: NSManagedObject {
    @NSManaged public var timestamp: Date
    @NSManaged public var feed: NSOrderedSet
}

extension ManagedCache {
    var localFeed: [LocalArticle] {
        return feed.compactMap { ($0 as? ManagedArticle)?.local }
    }
}
