//
//  ArticleListViewModelDelegate.swift
//  InternshipTT
//
//  Created by Vitalik Nozhenko on 06.02.2023.
//

import Foundation

/// protocol for delegate(first func) and send data(second) from viewmodel to vc
protocol ArticleListViewModelDelegate: AnyObject {
    func didLoadArticles()
}


