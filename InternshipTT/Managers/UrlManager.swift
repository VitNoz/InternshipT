//
//  UrlManager.swift
//  InternshipTT
//
//  Created by Vitalik Nozhenko on 14.02.2023.
//

import Foundation

struct UrlManager {
    
    static let shared = UrlManager()
    
    private let baseUrl = "https://api.nytimes.com/svc"
    private let section = "all-sections"
    private let timePeriod = "30"
    
    func buildUrl(articlesCategory: ArticleCategory) -> String {
                
        let apiMostPopular = "/mostpopular/v2/\(articlesCategory.rawValue.lowercased())/\(section)/\(timePeriod).json"
        let url = baseUrl + apiMostPopular + "?api-key=\(ApiKey.apiKey)"
        return url
    }
    
    func getImageUrl(article: Article) -> String? {
        
        guard let imageUrl = article.media?.first?.mediametadata?.first?.url else { return nil }
        return imageUrl
    }
}
