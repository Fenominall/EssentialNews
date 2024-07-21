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
public class ManagedArticle: NSManagedObject {
    @NSManaged public var author: String?
    @NSManaged public var title: String
    @NSManaged public var desscription: String?
    @NSManaged public var url: URL
    @NSManaged public var urlToImage: URL?
    @NSManaged public var publishedAt: Date
    @NSManaged public var content: String?
    @NSManaged public var source: ManagedSource
    @NSManaged public var cache: ManagedCache
}

extension ManagedArticle : Identifiable {
    
}
