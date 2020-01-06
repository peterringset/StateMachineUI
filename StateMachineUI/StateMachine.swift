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
    }
    
    enum Event {
        case startSearch
        case cancel
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
            if case .startSearch = event {
                return .searching
            }
        case .searching:
            if case .cancel = event {
                return .start
            }
        }
        
        return nil
    }
    
}
