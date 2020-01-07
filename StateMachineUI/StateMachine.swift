//
//  StateMachine.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import Combine
import Foundation

class StateMachine {
    
    enum State {
        case start
        case searching
        case loading
        case searchResults
    }
    
    enum Event {
        case startSearch
        case cancel
        case search
        case success
    }
    
    private(set) var state: State {
        didSet { stateSubject.send(self.state) }
    }
    private let stateSubject: PassthroughSubject<State, Never>
    let statePublisher: AnyPublisher<State, Never>
    
    init(state: State) {
        self.state = state
        self.stateSubject = PassthroughSubject<State, Never>()
        self.statePublisher = self.stateSubject.eraseToAnyPublisher()
    }
    
}

// MARK: - State changes

extension StateMachine {
    
    @discardableResult func tryEvent(_ event: Event) -> Bool {
        guard let state = nextState(for: event) else {
            return false
        }
        
        self.state = state
        return true
    }
    
    private func nextState(for event: Event) -> State? {
        switch state {
        case .start:
            switch event {
            case .startSearch: return .searching
            case .cancel, .search, .success: return nil
            }
        case .searching:
            switch event {
            case .search: return .loading
            case .startSearch: return nil
            case .cancel: return .start
            case .success: return nil
            }
        case .loading:
            switch event {
            case .search, .cancel, .startSearch: return nil
            case .success: return .searchResults
            }
        case .searchResults:
            break
        }
        
        return nil
    }
    
}
