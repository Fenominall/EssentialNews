//
//  SceneDelegate.swift
//  EssentialNewsApp
//
//  Created by Fenominall on 7/22/24.
//

import UIKit
import EssentialNews

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var store: FeedStore & FeedImageDataStore = {
        do {
            return try CoreDataFeedStore(
                storeURL: CoreDataFeedStore.storeURL)
        } catch {
            print("Error instantiating CoreData store: \(error.localizedDescription)")
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            return NullStore()
        }
    }()
    
    private lazy var remoteURL = URL(string: "https://newsapi.org/v2/everything?q=apple&from=2024-07-23&to=2024-07-23&sortBy=popularity&apiKey=0642572b6eb446f08649cd463d45df10")!
    
    private lazy var remoteFeedLoader: RemoteFeedLoader = {
        RemoteFeedLoader(url: remoteURL, client: httpClient)
    }()
    
    private lazy var remoteImageLoader: RemoteFeedImageDataLoader = {
        RemoteFeedImageDataLoader(client: httpClient)
    }()
    
    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store, currentDate: Date.init)
    }()
    
    private lazy var localFeedImageDataLoader: LocalFeedImageDataLoader = {
        LocalFeedImageDataLoader(store: store)
    }()
    
    private lazy var navigationController = UINavigationController(
        rootViewController: FeedUIComposer
            .feedComposedWith(
                feedLoader: FeedLoaderWithFallbackComposite(
                    primary: FeedLoaderCacheDecorator(
                        decoratee: remoteFeedLoader,
                        cache: localFeedLoader),
                    fallback: localFeedLoader),
                imageLoader: FeedImageDataLoaderWithFallbackComposite(
                    primary: localFeedImageDataLoader,
                    fallback: FeedImageDataLoaderCacheDecorator(
                        decoratee: remoteImageLoader,
                        cache: localFeedImageDataLoader)),
                selection: showArticleDetail
            )
    )
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        localFeedLoader.validateCache { _ in  }
    }
    
    // MARK: - Helpers
    private func showArticleDetail(for article: Article) {
        let articleDetails = ArticleDetailsUIComposer
            .articleDetailsComposedWith(
                feedLoader: remoteFeedLoader,
                imageLoader: remoteImageLoader,
                selection: article
            )
        navigationController.pushViewController(articleDetails, animated: true)
    }
}
