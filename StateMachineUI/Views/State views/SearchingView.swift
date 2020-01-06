//
//  SearchingView.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import SwiftUI

struct SearchingView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent searches").font(.system(.headline))
            
            VStack(alignment: .leading) {
                Divider()
                Button(action: { }) { () -> Text in Text("Dogs") }
                Divider()
                Button(action: { }) { () -> Text in Text("Ponies") }
                Divider()
                Button(action: { }) { () -> Text in Text("Unicorns") }
                Divider()
                Button(action: { }) { () -> Text in Text("Cats") }
                Divider()
            }
        }.padding()
    }
}

struct SearchingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingView().previewLayout(.sizeThatFits)
    }
}
