//
//  ArticleDetailUIComposer.swift
//  EssentialNewsApp
//
//  Created by Fenominall on 8/3/24.
//

import EssentialNews
import EssentialNewsiOS
import UIKit

public final class ArticleDetailsUIComposer {
    private init() {}
    
    private typealias ImageDataPresentationAdapter = ImageDataLoaderPresentationAdapter<Data, WeakRefVirtualProxy<ArticleDetailsViewController>>
    
    static func articleDetailsComposedWith(
        feedLoader: FeedLoader,
        imageLoader: FeedImageDataLoader,
        selection: Article
    ) -> ArticleDetailsViewController {
        let imageAdapter = ImageDataPresentationAdapter(model: selection, imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader))
        let viewModel = ArticleDetailsPresentationViewModel(viewModel: ArticleDetailsPresenter.map(selection))
        let articleDetailVC = ArticleDetailsViewController(delegate: imageAdapter, viewModel: viewModel)
                
        imageAdapter.presenter = LoadResourcePresenter(
            resourceView: WeakRefVirtualProxy(articleDetailVC),
            loadingView: WeakRefVirtualProxy(viewModel),
            errorView: WeakRefVirtualProxy(viewModel),
            mapper: mapDataIntoImage
        )
        return articleDetailVC
    }
}
