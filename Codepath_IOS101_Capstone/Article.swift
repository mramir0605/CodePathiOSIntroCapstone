//
//  Article.swift
//  Codepath_IOS101_Capstone
//
//  Created by mary ramirez on 11/15/25.
//

import Foundation

struct NewsFeed: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Equatable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable, Equatable {
    let id: String?
    let name: String
}

extension Article {
    static var readKey: String {
        return "Favorites"
    }
    
    static var watchlistKey: String {
        return "Watchlist"
    }
    
    static func save(_ articles: [Article], forKey key: String) {
        let defaults = UserDefaults.standard
        let encodeData = try! JSONEncoder().encode(articles)
        defaults.set(encodeData, forKey: key)
    }
    
    static func getArticles(forKey key: String) -> [Article] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: key) {
            let decodedArticles = try! JSONDecoder().decode([Article].self, from: data)
            return decodedArticles
        } else {
            return []
        }
    }
    
    func addToFavorites() {
        var favoritesArticles = Article.getArticles(forKey: Article.readKey)
        favoritesArticles.append(self)
        Article.save(favoritesArticles, forKey: Article.readKey)
        print(favoritesArticles)
    }
    
    func removeFromFavorites() {
        var favoritesArticles = Article.getArticles(forKey: Article.readKey)
        favoritesArticles.removeAll { article in
                return self == article
        }
        Article.save(favoritesArticles, forKey: Article.readKey)
        print(favoritesArticles)
    }
    
    func addToWatchlist() {
        var watchlistArticles = Article.getArticles(forKey: Article.watchlistKey)
        watchlistArticles.append(self)
        Article.save(watchlistArticles, forKey: Article.watchlistKey)
        print(watchlistArticles)
    }
    
    func removeFromWatchlist() {
        var watchlistArticles = Article.getArticles(forKey: Article.watchlistKey)
        watchlistArticles.removeAll { article in
            return self == article
        }
        Article.save(watchlistArticles, forKey: Article.watchlistKey)
        print(watchlistArticles)
    }
}
