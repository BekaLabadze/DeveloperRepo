//
//  NewsService.swift
//  Assignment19
//
//  Created by Beka on 30.10.24.
//

import Foundation

class NewsService {
    func fetchNews(page: Int, pageSize: Int, completion: @escaping ([NewsArticle]) -> Void) {
        let apiKey = "967b09ab27394e269ee6f25ef2579253"
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=\(apiKey)&country=us&page=\(page)&pageSize=\(pageSize)"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let articlesResponse = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(articlesResponse.articles)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
}
