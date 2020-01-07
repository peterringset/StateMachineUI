//
//  SearchResultsViewModel.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import Combine
import Foundation

class SearchResultsViewModel: ObservableObject {
    
    let items: [PixabayItem]
    
    init(items: [PixabayItem]) {
        self.items = items
    }
    
}
