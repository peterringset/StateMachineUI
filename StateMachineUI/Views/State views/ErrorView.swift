//
//  ErrorView.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 07/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Ouch")
                Image(systemName: "exclamationmark.triangle.fill").foregroundColor(Color.orange)
            }.font(.headline)
            Text("We're sorry, something went wrong. Please try again.").font(.body)
        }.padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView().previewLayout(.sizeThatFits)
    }
}
