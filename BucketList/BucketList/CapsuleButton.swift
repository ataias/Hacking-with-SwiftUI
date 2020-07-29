//
//  CapsuleButton.swift
//  BucketList
//
//  Created by Ataias Pereira Reis on 29/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct CapsuleButton: View {
    let text: String
    let perform: () -> ()

    var body: some View {
        Button(text) {
            self.perform()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleButton(text: "Example", perform: {})
    }
}
