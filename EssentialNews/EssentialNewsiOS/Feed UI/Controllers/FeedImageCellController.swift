//
//  FeedImageCellController.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 7/22/24.
//

import UIKit
import EssentialNews

public protocol FeedArticlesCellControllerDelegate {
    func didRequestImage()
    func didCancelImageRequest()
}

public final class FeedArticleCellController: NSObject {
    
    public typealias ResourceViewModel = UIImage
    
    private let viewModel: FeedArticleViewModel
    private let delegate: FeedArticlesCellControllerDelegate
    private let selection: () -> Void
    private var cell: FeedArticleViewCell?
    
    public init(
        viewModel: FeedArticleViewModel,
        delegate: FeedArticlesCellControllerDelegate,
        selection: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.delegate = delegate
        self.selection = selection
    }
}

extension FeedArticleCellController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedArticleViewCell.self)) as? FeedArticleViewCell
        
        cell?.descriptionLabel.text = viewModel.title
        cell?.onRetry = { [weak self] in
            self?.delegate.didRequestImage()
        }
        delegate.didRequestImage()
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection()
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelLoad()
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        delegate.didRequestImage()
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        cancelLoad()
    }
    
    private  func cancelLoad() {
        releaseCellForReuse()
        delegate.didCancelImageRequest()
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
}

extension FeedArticleCellController: ResourceView, ResourceErrorView, ResourceLoadingView {
    
    public func display(_ viewModel: UIImage) {
        cell?.articleImageView.setImageAnimated(viewModel)
    }
    
    public func display(_ viewModel: EssentialNews.ResourceLoadingViewModel) {
        cell?.articlesImageContainer.isShimmering = viewModel.isLoading
    }
    
    public func display(_ viewModel: EssentialNews.ResourceErrorViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.cell?.retryButton.isHidden = viewModel.message == nil
        }
    }
}
