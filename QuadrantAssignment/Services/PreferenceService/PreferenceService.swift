//
//  PreferenceService.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation

open class PreferenceService {
    let container: UserDefaults
        
    init(container: UserDefaults) {
        self.container = container
    }

    @PreferenceWrapper(key: "favorite_category", defaultValue: "")
    var favoriteCategory: String
}
