//
//  StartView.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            HStack {
                Text("Search for images").font(.headline)
                Image(systemName: "magnifyingglass").font(.headline)
            }
            Text("Type in the search field above, and hit the search button to find images").font(.body)
        }.padding()
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().previewLayout(.sizeThatFits)
    }
}
