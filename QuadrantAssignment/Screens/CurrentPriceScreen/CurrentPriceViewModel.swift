//
//  CurrentPriceViewModel.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 16/09/22.
//

import Combine

class CurrentPriceViewModel: ObservableObject {
    let service: ServicesProvider
    
    init(service: ServicesProvider) {
        self.service = service
    }
}
