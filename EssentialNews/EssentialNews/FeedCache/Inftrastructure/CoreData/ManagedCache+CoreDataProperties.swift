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

}

extension ManagedCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCache> {
        return NSFetchRequest<ManagedCache>(entityName: "ManagedCache")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var feed: NSOrderedSet?

}

extension ManagedCache : Identifiable {

}
