//
//  FavoritesListViewController.swift
//  InternshipTT
//
//  Created by Vitalik Nozhenko on 02.02.2023.
//

import UIKit
import SnapKit

class FavoritesListViewController: UIViewController {
    
    private var mainView = FavoritesListView()
    private var favoritesArticle: [FavoriteArticle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        favoritesArticle = CoreDataManager.shared.fecthData()

        if !favoritesArticle.isEmpty {
            mainView.emptyFavoritesLabel.isHidden = true
            mainView.favoritesArcticlesTableView.isHidden = false
        } else {
            mainView.emptyFavoritesLabel.isHidden = false
            mainView.favoritesArcticlesTableView.isHidden = true
        }
        mainView.favoritesArcticlesTableView.reloadData()
        
    }
    
    private func setupView() {
        
        mainView.favoritesArcticlesTableView.dataSource = self
        mainView.favoritesArcticlesTableView.delegate = self
        mainView.favoritesArcticlesTableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.cellId)

        mainView.favoritesArcticlesTableView.rowHeight = view.bounds.height / 7
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.cellId,
                                                            for: indexPath) as! ArticleTableViewCell
        cell.delegate = self
        let article = favoritesArticle[indexPath.row]
        let viewModel = ArticleTableViewCellViewModel(articleTitle: article.title!,
                                                      articlePublishedDate: article.publishedDate!,
                                                      articleByline: article.byline!,
                                                      articleImageUrl: nil,
                                                      articleAbstract: "",
                                                      articleImageData: article.image)
        cell.configureCellFavorites(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = favoritesArticle[indexPath.row]
        let viewModel = FavoriteArticleDetailsViewModel(article: article)
        navigationController?.pushViewController(ArticleDetailsViewController(viewModel: viewModel), animated: true)
    }
    
}


/// confotm to created protocol and execute func called in viewmodel
extension FavoritesListViewController: FavoritesArticlesCellDelegate {
    
    func didDeleteArticleFromFavorites() {

        favoritesArticle = CoreDataManager.shared.fecthData()
        mainView.favoritesArcticlesTableView.reloadData()
        if  favoritesArticle.isEmpty {
            mainView.emptyFavoritesLabel.isHidden = false
            mainView.favoritesArcticlesTableView.isHidden = true
        }
    }
}
