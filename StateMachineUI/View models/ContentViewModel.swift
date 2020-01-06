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
    private var stateCancellable: AnyCancellable?
    
    @Published var searchText: String = ""
    @Published var state: StateMachine.State
    
    var showSearchCancelButton: Bool {
        return stateMachine.state == .searching
    }
    
    init(stateMachine: StateMachine) {
        self.stateMachine = stateMachine
        self.state = stateMachine.state
        
        self.stateCancellable = stateMachine.statePublisher.sink { state in
            self.state = state
        }
    }
    
    func searchStatusChanged(_ value: SearchBar.Status) {
    }
    
}
