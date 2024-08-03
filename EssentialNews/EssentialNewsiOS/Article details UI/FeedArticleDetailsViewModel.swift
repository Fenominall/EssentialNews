//
//  ArticleDetailsViewModel.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 8/3/24.
//

import EssentialNews

public struct FeedArticleDetailsViewModel {
    private let viewModel: ArticleDetailViewModel
    
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
