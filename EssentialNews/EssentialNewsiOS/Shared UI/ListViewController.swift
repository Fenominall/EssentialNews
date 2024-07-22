//
//  FeedViewController.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 7/22/24.
//

import Foundation
import UIKit

public final class ListViewController: UITableViewController, UITableViewDataSourcePrefetching {
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, CellController> = {
        .init(tableView: tableView) { (tableView, indexPath, controller) in
            return controller.dataSource.tableView(tableView, cellForRowAt: indexPath)
        }
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        dataSource.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
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
}

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
    
    // MARK: - Helpers
    private func cellController(at indexPath: IndexPath) -> CellController? {
        dataSource.itemIdentifier(for: indexPath)
    }
}
