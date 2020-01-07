//
//  PixabayItem.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import Foundation

struct PixabayItem: Decodable {
    let id: Int
    let url: URL
    
    private enum CodingKeys: String, CodingKey {
        case id
        case url = "webformatURL"
    }
}

extension PixabayItem: Identifiable { }
