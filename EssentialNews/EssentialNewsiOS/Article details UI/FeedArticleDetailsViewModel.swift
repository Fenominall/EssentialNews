//
//  ArticleDetailsViewModel.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 8/3/24.
//

import EssentialNews

public class FeedArticleDetailsViewModel {
    private let viewModel: ArticleDetailViewModel
    var isLoading: ((Bool) -> Void)?
    
    public init(viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var author: String {
        viewModel.author ?? ""
    }
    
    var title: String {
        viewModel.title
    }
    
    var description: String {
        viewModel.description ?? ""
    }
        
    var publishedDate: String {
        convertDate(with: viewModel.publishedAt)
    }
    
    var content: String {
        viewModel.content ?? ""
    }
}


extension FeedArticleDetailsViewModel: ResourceLoadingView {
    public func display(_ viewModel: ResourceLoadingViewModel) {
        isLoading?(viewModel.isLoading)
    }
}

extension FeedArticleDetailsViewModel: ResourceErrorView {
    public func display(_ viewModel: ResourceErrorViewModel) {
        
    }
}

