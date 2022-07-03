//
//  MockData.swift
//  MultiSectionCompositionalLayout
//
//  Created by Emmanuel Okwara on 21.05.22.
//

import Foundation

struct ListItem {
    let image: String
}

enum ListSection {
    case popular([ListItem])
    
    var items: [ListItem] {
        switch self {
        case.popular(let items):
            return items
        }
    }
    var count: Int {
        return items.count
    }
}

struct MockData {
    static let shared = MockData()
    
    private let popular: ListSection = {
        .popular([.init(image: "popular-1"),
                  .init(image: "popular-2"),
                  .init(image: "popular-3"),
                  .init(image: "popular-4"),
                  .init(image: "popular-5")])
    }()
    var pageData: [ListSection] {
        [popular]
    }
}
