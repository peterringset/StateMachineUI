//
//  ContentView.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        return NavigationView {
            VStack(spacing: 0) {
                SearchBar(
                    text: $viewModel.searchText,
                    isEditing: $viewModel.isSearching,
                    showsCancelButton: viewModel.showSearchCancelButton,
                    searchingChanged: viewModel.searchStatusChanged
                )
                
                self.content
                
                Spacer()
            }.navigationBarTitle(Text("Search images"))
                .edgesIgnoringSafeArea([.bottom])
        }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .start: return AnyView(StartView())
        case .searching: return AnyView(SearchingView(action: { self.viewModel.search($0) }))
        case .loading: return AnyView(LoadingView())
        case .searchResults: return AnyView(SearchResultsView(viewModel: viewModel.createSearchResultsViewModel()))
        case .error: return AnyView(ErrorView())
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(stateMachine: StateMachine(state: .start), imageService: ImageService(session: .shared)))
    }
}
