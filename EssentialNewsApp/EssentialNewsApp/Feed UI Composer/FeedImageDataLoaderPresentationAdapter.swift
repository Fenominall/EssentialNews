//
//  FeedImageDataLoaderPresentationAdapter.swift
//  EssentialNewsApp
//
//  Created by Fenominall on 7/24/24.
//

import EssentialNews
import EssentialNewsiOS

final class FeedImageDataLoaderPresentationAdapter<Resource, View: ResourceView>: FeedArticlesCellControllerDelegate where View.ResourceViewModel == Resource {
    private let model: Article
    private let imageLoader: FeedImageDataLoader
    private var task: FeedImageDataLoaderTask?
    
    var presenter: LoadResourcePresenter<Data, View>?
    
    init(model: Article, imageLoader: FeedImageDataLoader) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    func didRequestImage() {
        presenter?.didStartLoading()
        
        guard let imageURL = model.urlToImage else { return }
        task = imageLoader.loadImageData(from: imageURL) { [weak self] result in
            switch result {
            case let .success(data):
                self?.presenter?.didFinishLoading(with: data)
                
            case let .failure(error):
                self?.presenter?.didFinishLoading(with: error)
            }
        }
    }
    
    func didCancelImageRequest() {
        task?.cancel()
    }
}
