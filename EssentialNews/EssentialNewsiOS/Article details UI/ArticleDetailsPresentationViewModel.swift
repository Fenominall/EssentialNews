//
//  ArticleDetailsViewModel.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 8/3/24.
//

import EssentialNews

public class ArticleDetailsPresentationViewModel {
    private let viewModel: ArticleDetailsViewModel
    var isLoading: ((Bool) -> Void)?
    
    public init(viewModel: ArticleDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var author: String {
        viewModel.author ?? ""
    }
    
    var sourceName: String {
        "From: \(viewModel.source.name)"
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


extension ArticleDetailsPresentationViewModel: ResourceLoadingView {
    public func display(_ viewModel: ResourceLoadingViewModel) {
        isLoading?(viewModel.isLoading)
    }
}

extension ArticleDetailsPresentationViewModel: ResourceErrorView {
    public func display(_ viewModel: ResourceErrorViewModel) {
        
    }
}

