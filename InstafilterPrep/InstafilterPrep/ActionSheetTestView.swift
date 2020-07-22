//
//  ActionSheetTestView.swift
//  Instafilter
//
//  Created by Ataias Pereira Reis on 20/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ActionSheetTestView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white

    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Change Background"), message: Text("Select a new color"), buttons: [
                .default(Text("Red")) { self.backgroundColor = .red },
                .default(Text("Green")) { self.backgroundColor = .green},
                .default(Text("Blue")) { self.backgroundColor = .blue },
                .default(Text("White")) { self.backgroundColor = .white },
                .cancel(),
            ])
        }
    }
}

struct ActionSheetTestView_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetTestView()
    }
}
