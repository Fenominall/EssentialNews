//
//  FeedLoaderPresentationAdapter.swift
//  EssentialNewsApp
//
//  Created by Fenominall on 7/24/24.
//

import EssentialNews
import EssentialNewsiOS

final class FeedLoaderPresentationAdapter<Resource, View: ResourceView> {
    private let loader: FeedLoader
    var presenter: LoadResourcePresenter<[Article], View>?
    private var isLoading = false
    
    init(loader: FeedLoader) {
        self.loader = loader
    }
    
    func loadResource() {
        guard !isLoading else { return }
        
        presenter?.didStartLoading()
        isLoading = true
        
        loader.load { [weak self] result in
            switch result {
            case let .success(feed):
                self?.presenter?.didFinishLoading(with: feed)
                
            case let .failure(error):
                self?.presenter?.didFinishLoading(with: error)
            }
            self?.isLoading = false
        }
    }
}
