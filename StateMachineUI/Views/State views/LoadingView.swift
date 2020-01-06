//
//  LoadingView.swift
//  StateMachineUI
//
//  Created by Peter Ringset on 06/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        HStack {
            Text("Loading...").font(.body)
            ActivityIndicator(isAnimating: .constant(true), style: .medium)
        }.padding()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView().previewLayout(.sizeThatFits)
    }
}
