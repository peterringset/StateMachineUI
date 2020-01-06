//
//  ImageService.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import Combine
import Foundation

class ImageService: ObservableObject {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func search(text: String) -> AnyPublisher<[PixabayItem], Error>? {
        guard let hostURL = URL(string: "https://pixabay.com"),
            let apiURL = URL(string: "api/", relativeTo: hostURL),
            var components = URLComponents(url: apiURL, resolvingAgainstBaseURL: true) else {
                return nil
        }
        components.queryItems = [
            URLQueryItem(name: "key", value: "<your key here>"),
            URLQueryItem(name: "q", value: text)
        ]
        
        guard let constructedURL = components.url else {
            return nil
        }
                
        let publisher = session.dataTaskPublisher(for: constructedURL)
            .map { $0.data }
            .decode(type: Response.self, decoder: JSONDecoder())
            .map { $0.items }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        return publisher
    }
    
}

extension ImageService {
    
    struct Response: Decodable {
        let items: [PixabayItem]
        enum CodingKeys: String, CodingKey {
            case items = "hits"
        }
    }
    
}
