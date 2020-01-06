//
//  SearchBar.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    enum Status {
        case notSearching, searching, searched
    }
    
    @Binding var text: String
    let showsCancelButton: Bool
    let searchingChanged: (Status) -> Void
    
    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        
        let searchingChanged: (Status) -> Void
        
        init(text: Binding<String>, searchingChanged: @escaping (Status) -> Void) {
            _text = text
            self.searchingChanged = searchingChanged
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchingChanged(.searching)
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchingChanged(.notSearching)
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchingChanged(.searched)
            searchBar.resignFirstResponder()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, searchingChanged: searchingChanged)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        searchBar.backgroundImage = UIImage()
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
        uiView.showsCancelButton = showsCancelButton
    }
    
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), showsCancelButton: false, searchingChanged: { _ in })
            .previewLayout(.sizeThatFits)
    }
}
