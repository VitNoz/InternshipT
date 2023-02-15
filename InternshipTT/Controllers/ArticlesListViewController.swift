//
//  ArticlesListViewController.swift
//  InternshipTT
//
//  Created by Vitalik Nozhenko on 04.02.2023.
//

import UIKit
import SnapKit

class ArticlesListViewController: UIViewController {
    
    private var mainView = ArticlesListView()
    private var viewModel = ArticleListViewModel()
    private var articlesCategory: ArticleCategory?
    
    init(articlesCategory: ArticleCategory) {
        super.init(nibName: nil, bundle: nil)
        self.articlesCategory = articlesCategory
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        viewModel.delegate = self
        viewModel.getArticles(articlesCategory: articlesCategory!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let row = mainView.arcticlesTableView.indexPathForSelectedRow {
            mainView.arcticlesTableView.deselectRow(at: row, animated: true)
        }
    }
        
    private func setupView() {
        
        mainView.arcticlesTableView.dataSource = self
        mainView.arcticlesTableView.delegate = self
        mainView.arcticlesTableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.cellId)
        
        mainView.arcticlesTableView.rowHeight = view.bounds.height / 7
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ArticlesListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.cellId,
                                                            for: indexPath) as! ArticleTableViewCell
        let viewModel = viewModel.cellViewModels[indexPath.row]
        cell.configureCell(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewModel = viewModel.cellViewModels[indexPath.row]
        navigationController?.pushViewController(ArticleDetailsViewController(viewModel: viewModel), animated: true)
    }
}

/// confotm to created protocol and execute func called in viewmodel
extension ArticlesListViewController: ArticleListViewModelDelegate {
    
    func didLoadArticles() {
        mainView.downloadSpinner.stopAnimating()
        mainView.arcticlesTableView.isHidden = false
        mainView.arcticlesTableView.reloadData()
    }
}
