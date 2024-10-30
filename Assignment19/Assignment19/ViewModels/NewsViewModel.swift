//
//  NewsViewModel.swift
//  Assignment19
//
//  Created by Beka on 30.10.24.
//

import Foundation

class NewsViewModel {
    private var newsService = NewsService()
    var articles: [NewsArticle] = []

    func fetchArticles(completion: @escaping () -> Void) {
        newsService.fetchNews(page: 1, pageSize: 10) { [weak self] articles in
            self?.articles = articles
            completion()
        }
    }

    func numberOfArticles() -> Int {
        return articles.count
    }

    func article(at index: Int) -> NewsArticle {
        return articles[index]
    }
}
