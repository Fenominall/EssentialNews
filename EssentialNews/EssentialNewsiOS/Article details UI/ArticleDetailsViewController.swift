//
//  ArticleDetailsViewController.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 8/3/24.
//

import Foundation
import UIKit

public final class ArticleDetailsViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var articleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleUILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = .systemBackground
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorAndDateUILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .systemBackground
        label.numberOfLines = 0
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemBackground
        label.numberOfLines = 0
        return label
    }()
    
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemBackground
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefreshControl()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(articleImage)
        contentView.addSubview(titleUILabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorAndDateUILabel)
        contentView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // TitleUILabel constraints
            titleUILabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            titleUILabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            titleUILabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleUILabel.bottomAnchor, constant: 25),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            
            // AuthorAndDateUILabel constraints
            authorAndDateUILabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            authorAndDateUILabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            authorAndDateUILabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            
            // ArticleImage constraints
            articleImage.topAnchor.constraint(equalTo: authorAndDateUILabel.bottomAnchor, constant: 20),
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            articleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            articleImage.heightAnchor.constraint(equalToConstant: 300),
            
            // BodyUILabel constraints
            contentLabel.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 40),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupRefreshControl() {
        scrollView.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh() {
        // TODO
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    func bind(_ viewModel: FeedArticleDetailsViewModel) {
        titleUILabel.text = viewModel.title
        descriptionLabel.text = viewModel.title
        authorAndDateUILabel.text = "\(viewModel.author) \(viewModel.publishedDate)"
        contentLabel.text = viewModel.content
    }
}
