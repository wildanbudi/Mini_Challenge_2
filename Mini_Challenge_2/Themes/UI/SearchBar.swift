//
//  SearchBar.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 12/06/22.
//

import UIKit

class SearchBar {
    
    var data: [String] = []
    var filteredData: [String] = []
    
    public func search(data: [String], searchText: String) -> [String] {
        self.data = data
        filteredData = []
        
        if searchText == "" {
            filteredData = data
        } else {
            for d in data {
                if d.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(d)
                }
            }
        }
        
        return filteredData
    }

}
