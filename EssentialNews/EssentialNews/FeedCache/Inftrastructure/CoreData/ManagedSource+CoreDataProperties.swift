//
//  ManagedSource+CoreDataProperties.swift
//  EssentialNews
//
//  Created by Fenominall on 7/21/24.
//
//

import Foundation
import CoreData


@objc(ManagedSource)
public class ManagedSource: NSManagedObject {

}

extension ManagedSource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedSource> {
        return NSFetchRequest<ManagedSource>(entityName: "ManagedSource")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var article: ManagedArticle?

}

extension ManagedSource: Identifiable {

}
