//
//  SearchResultsView.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import SwiftUI

struct SearchResultsView: View {
    
    let viewModel: SearchResultsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(self.dataCollection(items: self.viewModel.items, size: geometry.size)) { rowModel in
                    HStack(spacing: 0) {
                        ForEach(rowModel.items) { item in
                            Image(systemName: "pencil.circle.fill").frame(size: self.size(for: geometry), alignment: .center)
                        }
                    }.listRowInsets(EdgeInsets())
                }
            }.onAppear {
                UITableView.appearance().separatorStyle = .none
            }
        }
    }
    
    private func size(for geometry: GeometryProxy) -> CGSize {
        let size = geometry.size.width / CGFloat(columnCount(for: geometry.size))
        return CGSize(width: size, height: size)
    }
    
    private func columnCount(for size: CGSize) -> Int {
        return Int(ceil(size.width / 138))
    }
    
    private func dataCollection(items: [PixabayItem], size: CGSize) -> [RowModel] {
        let strideSize = columnCount(for: size)
        let rowModels = stride(from: items.startIndex, to: items.endIndex, by: strideSize).compactMap { index -> RowModel? in
            let range = index ..< min(index + strideSize, items.endIndex)
            let subItems = items[range]
            return try? RowModel(items: Array(subItems))
        }
        
        return rowModels
    }
    
}

extension View {

    func frame(size: CGSize, alignment: Alignment) -> some View {
        return self.frame(width: size.width, height: size.height, alignment: alignment)
    }

}

private struct RowModel: Identifiable {
    let id: Int
    let items: [PixabayItem]
    
    init(items: [PixabayItem]) throws {
        guard let first = items.first else {
            throw NSError(domain: "SM", code: 0, userInfo: [
                NSLocalizedDescriptionKey: "Cannot initalize with empty array"
            ])
        }
        self.id = first.id
        self.items = items
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(viewModel: SearchResultsViewModel(items: [
            PixabayItem(id: 1, url: URL(string: "http://eggsdesign.com")!),
            PixabayItem(id: 2, url: URL(string: "http://eggsdesign.com")!),
            PixabayItem(id: 3, url: URL(string: "http://eggsdesign.com")!),
            PixabayItem(id: 4, url: URL(string: "http://eggsdesign.com")!)
        ])).previewLayout(.fixed(width: 414, height: 300))
    }
}
