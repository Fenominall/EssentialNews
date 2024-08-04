//
//  FeedImageDataLoaderPresentationAdapter.swift
//  EssentialNewsApp
//
//  Created by Fenominall on 7/24/24.
//

import EssentialNews
import EssentialNewsiOS

final class ImageDataLoaderPresentationAdapter<Resource, View: ResourceView>: FeedArticlesCellControllerDelegate {
    private let model: Article
    private let imageLoader: FeedImageDataLoader
    private var task: FeedImageDataLoaderTask?
    private var isLoading = false
    
    var presenter: LoadResourcePresenter<Data, View>?
    
    init(
        model: Article,
        imageLoader: FeedImageDataLoader
    ) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    func didRequestImage() {
        guard !isLoading else { return }

        presenter?.didStartLoading()
        isLoading = true
        
        guard let imageURL = model.urlToImage else {
            isLoading = false
            return
        }
        
        task = imageLoader.loadImageData(from: imageURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.presenter?.didFinishLoading(with: data)
            case let .failure(error):
                self.presenter?.didFinishLoading(with: error)
            }
            self.isLoading = false
        }
    }
    
    func didCancelImageRequest() {
        task?.cancel()
    }
}
