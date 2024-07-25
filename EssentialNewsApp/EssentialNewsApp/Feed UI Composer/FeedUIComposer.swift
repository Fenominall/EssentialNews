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
    
    private typealias FeedPresentationAdapter = FeedLoaderPresentationAdapter<[Article], FeedViewAdapter>
    
    static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader, selection: @escaping (Article) -> Void) -> ListViewController {
        let presentationAdapter = FeedPresentationAdapter(loader: MainQueueDispatchDecorator(decoratee: feedLoader))
        let feedViewController = ListViewController()
        
        feedViewController.onRefresh = presentationAdapter.loadResource
        
        presentationAdapter.presenter = LoadResourcePresenter(
            resourceView: FeedViewAdapter(
                controller: feedViewController,
                imageLoader: imageLoader,
                selection: selection
            ),
            loadingView: WeakRefVirtualProxy(feedViewController),
            errorView: WeakRefVirtualProxy(feedViewController),
            mapper: { articles in
                return FeedViewModel(feed: articles)
            }
        )
        return feedViewController
    }
}

