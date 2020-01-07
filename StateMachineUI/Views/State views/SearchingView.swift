//
//  SearchingView.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import SwiftUI

struct SearchingView: View {
    
    let action: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent searches").font(.system(.headline))
            
            VStack(alignment: .leading) {
                Divider()
                textButton("Dogs")
                Divider()
                textButton("Ponies")
                Divider()
                textButton("Unicorns")
                Divider()
                textButton("Cats")
                Divider()
            }
        }.padding()
    }
    
    private func textButton(_ text: String) -> Button<Text> {
        return Button(action: { self.action(text) }, label: { Text(text) })
    }
}

struct SearchingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingView(action: { _ in }).previewLayout(.sizeThatFits)
    }
}
