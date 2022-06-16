//
//  SearchBar.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 12/06/22.
//

import UIKit

class SearchBar {
    
    var data: [Restaurants] = []
    var filteredData: [Restaurants] = []
    
    public func search(setData: NSSet, searchText: String) -> [Restaurants] {
        let data = setData.allObjects as! [Restaurants]
        self.data = data
        filteredData = []
        
        print(searchText)
        if searchText == "" {
            filteredData = data
        } else {
            for d in data {
                if d.name!.lowercased().contains(searchText.lowercased()) {
                    print(d.name!)
                    filteredData.append(d)
                }
            }
        }
        
        print(filteredData)
        return filteredData
    }

}
