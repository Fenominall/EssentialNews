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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = .label
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
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var publishedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorAndDateStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            authorLabel, publishedDateLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.contentMode = .left
        stack.distribution = .equalCentering
        return stack
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .label
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefreshControl()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(articleImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(publishedDateLabel)
        contentView.addSubview(authorAndDateStackView)
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
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            
            // AuthorAndDateUILabel constraints
            authorAndDateStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            authorAndDateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            authorAndDateStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
                        
            // ArticleImage constraints
            articleImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            articleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            articleImage.heightAnchor.constraint(equalToConstant: articleImage.image != nil ? 300 : 0),
            
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
    
    public func bind(_ viewModel: FeedArticleDetailsViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        publishedDateLabel.text = viewModel.publishedDate
        contentLabel.text = viewModel.content
    }
}