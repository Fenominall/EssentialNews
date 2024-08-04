//
//  FeedViewController.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 7/22/24.
//

import Foundation
import UIKit
import EssentialNews

public final class ListViewController: UITableViewController, UITableViewDataSourcePrefetching {
    // MARK: Properties
    public var onRefresh: (() -> Void)?
    private var onViewDidAppear: ((ListViewController) -> Void)?
    private(set) public var errorView = ErrorView()
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, CellController> = {
        .init(tableView: tableView) { (tableView, indexPath, controller) in
            return controller.dataSource.tableView(tableView, cellForRowAt: indexPath)
        }
    }()
    
    // MARK: Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        createRefreshControl()
        configureErrorView()
        setDarkModeSupportForTheBackButton()
        refresh()
        
        onViewDidAppear = { vc in
            vc.onViewDidAppear = nil
            vc.refresh()
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.sizeTableHeaderFit()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        onViewDidAppear?(self)
    }
    
    // MARK: Helper Methods
    private func setDarkModeSupportForTheBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = title
        backButton.tintColor = .label
        navigationItem.backBarButtonItem = backButton
    }
    
    private func configureTableView() {
        tableView.register(FeedArticleViewCell.self, forCellReuseIdentifier: String(describing: FeedArticleViewCell.self))
        dataSource.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
        tableView.tableHeaderView = errorView.makeContainer()
    }
    
    private func configureErrorView() {
        errorView.isUserInteractionEnabled = true
        
        errorView.onHide = { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.sizeTableHeaderFit()
            self?.tableView.endUpdates()
        }
    }
    
    public func display(_ sections: [CellController]...) {
        // a new empty snapshot created
        var snapshot = NSDiffableDataSourceSnapshot<Int, CellController>()
        // new controllers appended
        sections.enumerated().forEach { section, cellControllers in
            snapshot.appendSections([section])
            snapshot.appendItems(cellControllers, toSection: section)
        }
        // data source will check what change using the hashable implementation and only updates what is necessary
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
    
    func createRefreshControl() {
        view.backgroundColor = .systemBackground
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        onRefresh?()
    }
}

// MARK: - Data Source and Delegation methods for the ListViewController
extension ListViewController {
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let delegate = cellController(at: indexPath)?.delegate
        delegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let ds = cellController(at: indexPath)?.dataSourcePrefetching
            ds?.tableView(tableView, prefetchRowsAt: [indexPath])
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let dsPrefetching = cellController(at: indexPath)?.dataSourcePrefetching
            dsPrefetching?.tableView?(tableView, cancelPrefetchingForRowsAt: [indexPath])
        }
    }
    
    // MARK: Helpers
    private func cellController(at indexPath: IndexPath) -> CellController? {
        dataSource.itemIdentifier(for: indexPath)
    }
}

extension ListViewController: ResourceLoadingView, ResourceErrorView {
    public func display(_ viewModel: EssentialNews.ResourceLoadingViewModel) {
        refreshControl?.update(isRefreshing: viewModel.isLoading)
    }
    
    public func display(_ viewModel: EssentialNews.ResourceErrorViewModel) {
        errorView.message = viewModel.message
    }
}
