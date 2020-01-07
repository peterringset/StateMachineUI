//
//  ContentViewModel.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import Combine
import Foundation

class ContentViewModel: ObservableObject {
    
    private let stateMachine: StateMachine
    private let imageService: ImageService
    
    private var stateCancellable: AnyCancellable?
    private var searchCancelleble: AnyCancellable?
    
    @Published var searchText: String = ""
    @Published var state: StateMachine.State {
        didSet { enterState(state) }
    }
    private var searchItems: [PixabayItem] = []
    
    var showSearchCancelButton: Bool {
        return stateMachine.state == .searching
    }
    
    init(stateMachine: StateMachine, imageService: ImageService) {
        self.stateMachine = stateMachine
        self.imageService = imageService
        
        self.state = stateMachine.state
        
        self.stateCancellable = stateMachine.statePublisher.sink { state in
            self.state = state
        }
    }
    
    func searchStatusChanged(_ value: SearchBar.Status) {
        let event: StateMachine.Event = {
            switch value {
            case .searching: return .startSearch
            case .searched: return .search
            case .notSearching: return .cancel
            }
        }()
        stateMachine.tryEvent(event)
    }
    
    func createSearchResultsViewModel() -> SearchResultsViewModel {
        return SearchResultsViewModel(items: searchItems)
    }
    
}

// MARK: - Search

extension ContentViewModel {
    
    func search() {
        searchCancelleble = imageService.search(text: searchText)?.sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error): print("error \(error.localizedDescription)") // TODO
            }
        }, receiveValue: { items in
            self.searchItems = items
            self.stateMachine.tryEvent(.success)
        })
    }
    
}

// MARK: - State changes

extension ContentViewModel {

    func enterState(_ state: StateMachine.State) {
        if case .loading = state {
            search()
        }
    }
    
}
