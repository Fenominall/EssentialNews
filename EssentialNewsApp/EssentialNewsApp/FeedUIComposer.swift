//
//  FeedUIComposer.swift
//  EssentialNewsApp
//
//  Created by Fenominall on 7/22/24.
//

import Foundation
import EssentialNews
import EssentialNewsiOS

final class FeedUIComposer {
    private init() {}
    
    static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> ListViewController {
        let feedViewController = ListViewController()
        
        return feedViewController
    }
}


final class FeedViewAdapter: ResourceView {
    private weak var controller: ListViewController?
    private let imageLoader: FeedImageDataLoader
    
    init(
        controller: ListViewController? = nil,
        imageLoader: FeedImageDataLoader
    ) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        
    }
}
