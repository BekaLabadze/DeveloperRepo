//
//  NewsArticle.swift
//  Assignment19
//
//  Created by Beka on 30.10.24.
//

import Foundation

struct ArticlesResponse: Codable {
    let articles: [NewsArticle]
}

struct NewsArticle: Codable {
    let title: String
    let author: String?
    let publishedAt: String
    let urlToImage: String?
    let description: String?
}
