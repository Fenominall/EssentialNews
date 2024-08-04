//
//  FeedViewAdapter.swift
//  EssentialNewsApp
//
//  Created by Fenominall on 7/24/24.
//

import EssentialNews
import EssentialNewsiOS
import UIKit

final class FeedViewAdapter: ResourceView {
    private weak var controller: ListViewController?
    private let imageLoader: FeedImageDataLoader
    private let selection: (Article) -> Void
    private var currentFeed: [String: CellController]
    
    private typealias ImageDataPresentationAdapter = ImageDataLoaderPresentationAdapter<Data, WeakRefVirtualProxy<FeedArticleCellController>>
    
    init(
        currentFeed: [String: CellController] = [:],
        controller: ListViewController,
        imageLoader: FeedImageDataLoader,
        selection: @escaping (Article) -> Void
    ) {
        self.currentFeed = currentFeed
        self.controller = controller
        self.imageLoader = imageLoader
        self.selection = selection
    }
    
    func display(_ viewModel: FeedViewModel) {
        guard let controller = controller else { return }
        var currentFeed = self.currentFeed
        let feed: [CellController] = viewModel.feed.map { model in
            let id = model.url.absoluteString
            
            if let existingController = currentFeed[id] {
                return existingController
            }
            
            let adapter = ImageDataPresentationAdapter(
                model: model,
                imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)
            )
            
            let view = FeedArticleCellController(
                viewModel: FeedArticlesPresenter.map(model),
                delegate: adapter,
                selection: { [selection] in
                    selection(model)
                })
            
            adapter.presenter = LoadResourcePresenter(
                resourceView: WeakRefVirtualProxy(view),
                loadingView: WeakRefVirtualProxy(view),
                errorView: WeakRefVirtualProxy(view),
                mapper: mapDataIntoImage)
            
            let controller = CellController(id: id, view)
            currentFeed[id] = controller
            return controller
        }
        self.currentFeed = currentFeed
        controller.display(feed)
    }
}
