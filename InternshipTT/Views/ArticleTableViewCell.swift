//
//  ArticleTableViewCell.swift
//  InternshipTT
//
//  Created by Vitalik Nozhenko on 03.02.2023.
//

import UIKit
import SnapKit
import AlamofireImage
import Alamofire

class ArticleTableViewCell: UITableViewCell {
    
    static let cellId = "ArticleTableViewCell"
    var cellViewModel: ArticleTableViewCellViewModel?
    weak var delegate: FavoritesArticlesCellDelegate?
    
    let titleImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 17, weight: .semibold)
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    let favoriteButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "star"), for: .normal)
        view.isSelected = false
        view.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return view
    }()
    
    let byLineLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    let publishedDateLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .secondarySystemBackground
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        
        contentView.addSubview(titleImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(byLineLabel)
        contentView.addSubview(publishedDateLabel)
        contentView.addSubview(favoriteButton)
        
        titleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(titleImage.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(titleImage.snp.trailing).offset(10)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-5)
        }

        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(publishedDateLabel.snp.height)
            make.width.equalTo(favoriteButton.snp.height)
        }
        
        byLineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.trailing.equalTo(titleLabel.snp.centerX).offset(30)
            make.leading.equalTo(titleImage.snp.trailing).offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        
        publishedDateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-2)
            make.trailing.equalToSuperview().offset(-2)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleImage.af_cancelImageRequest()
        titleImage.image = nil
    }
    
        ///for configure articleListCell
    func configureCell(viewModel: ArticleTableViewCellViewModel) {
        
        cellViewModel = viewModel
        titleLabel.text = viewModel.articleTitle
        byLineLabel.text = viewModel.articleByline
        publishedDateLabel.text = viewModel.articlePublishedDate
        if let url = URL(string: viewModel.articleImageUrl ?? "") {
            titleImage.af_setImage(withURL: url, placeholderImage: UIImage(systemName: "star"))
        }
    }
    
    ///for configure FavouriteArticleListCell
    func configureCellFavorites(viewModel: ArticleTableViewCellViewModel) {
        
        titleLabel.text = viewModel.articleTitle
        byLineLabel.text = viewModel.articleByline
        publishedDateLabel.text = viewModel.articlePublishedDate
        if let data = viewModel.articleImageData {
            titleImage.image = UIImage(data: data)
        }
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal) //
    }
    
    @objc func favoriteButtonTapped() {
        
        if favoriteButton.imageView?.image != UIImage(systemName: "star.fill") {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            CoreDataManager.shared.saveData(title: cellViewModel!.articleTitle, abstract: cellViewModel!.articleAbstract, publishedDate: cellViewModel!.articlePublishedDate, byline: cellViewModel!.articleByline, image: titleImage.image?.jpegData(compressionQuality: 1))
            favoriteButton.isSelected = true
        } else {
            favoriteButton.isSelected = false
            CoreDataManager.shared.deleteData(objectName: titleLabel.text!)
            delegate?.didDeleteArticleFromFavorites()
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
