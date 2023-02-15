//
//  ArticleDetailsView.swift
//  InternshipTT
//
//  Created by Vitalik Nozhenko on 04.02.2023.
//

import UIKit
import SnapKit

class ArticleDetailsView: UIView { 

    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 30, weight: .regular)
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 0
        return view
    }()

    let subtitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .regular)
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 0
        return view
    }()

    let titleImage: UIImageView = {
        let view = UIImageView()
//        view.image = UIImage(systemName: "xmark.icloud")
//        view.backgroundColor = .lightGray
        return view
    }()

    let byLineLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()

    let publishedDateLabel: UILabel = {
        let view = UILabel()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {

        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(titleImage)
        addSubview(byLineLabel)
        addSubview(publishedDateLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.15)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.1)
        }

        titleImage.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.4)
        }

        byLineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(50)
            make.width.equalToSuperview().multipliedBy(0.6)
        }

        publishedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(byLineLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(50)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.lessThanOrEqualToSuperview().offset(10)
        }
    }
        ///for configure articleListCellDetails
    func configureView(viewModel: ArticleTableViewCellViewModel) {
        
        titleLabel.text = viewModel.articleTitle
        subtitleLabel.text = viewModel.articleAbstract
        byLineLabel.text = viewModel.articleByline
        publishedDateLabel.text = viewModel.articlePublishedDate
        viewModel.getImage(completion: { data, _ in
            DispatchQueue.main.async { [unowned self] in
                self.titleImage.image = UIImage(data: data!)
            }
        })
    }
    ///for configure FavouriteArticleListCellDetails
    func configureViewFavorites(viewModel: FavoriteArticleDetailsViewModel) {
        
        titleLabel.text = viewModel.articleTitle
        subtitleLabel.text = viewModel.articleAbstract
        byLineLabel.text = viewModel.articleByline
        publishedDateLabel.text = viewModel.articlePublishedDate
        if let data = viewModel.articleImageData {
            titleImage.image = UIImage(data: data)
        }
        
    }

}

