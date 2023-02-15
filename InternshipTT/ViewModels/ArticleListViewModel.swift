//
//  ArticleListViewModel.swift
//  InternshipTT
//
//  Created by Vitalik Nozhenko on 04.02.2023.
//

import UIKit

class ArticleListViewModel {
    
    weak var delegate: ArticleListViewModelDelegate?
    
    ///Array of articles and creating viewmodel for each cell
    var articles: [Article] = [] {
        didSet {
            for article in articles {
                let cellViewModel = ArticleTableViewCellViewModel(articleTitle: article.title!,
                                                                  articlePublishedDate: article.published_date!,
                                                                  articleByline: article.byline!,
                                                                  articleImageUrl: UrlManager.shared.getImageUrl(article: article),
                                                                  articleAbstract: article.abstract!,
                                                                  articleImageData: nil)
                cellViewModels.append(cellViewModel)
            }
        }
    }

    var cellViewModels: [ArticleTableViewCellViewModel] = []
        
        ///get article with request based on article category url
    func getArticles(articlesCategory: ArticleCategory) {

        NetworkManager.shared.getData(urlString: UrlManager.shared.buildUrl(articlesCategory: articlesCategory),
                                      completion: { [weak self] response, error in
            if let response = response {
                self?.articles = response.results!
                DispatchQueue.main.async {
                    self?.delegate?.didLoadArticles()
                }
            }
            if let error = error {
                print("Failed to fetch posts:", error)
                return
            }
        })
    }
}
