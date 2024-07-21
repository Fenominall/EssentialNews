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
class ManagedSource: NSManagedObject {
    @NSManaged var id: String?
    @NSManaged var name: String
    @NSManaged var article: ManagedArticle
}
