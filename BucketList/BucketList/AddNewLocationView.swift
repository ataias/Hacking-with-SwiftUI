//
//  AddNewLocationView.swift
//  BucketList
//
//  Created by Ataias Pereira Reis on 29/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct PlusButton: View {
    let perform: () -> ()

    var body: some View {
        Button(action: {
            self.perform()
        }) {
            Image(systemName: "plus")
                .padding()
                .background(Color.black.opacity(0.75))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                .padding(.trailing)
        }
    }
}

struct AddNewLocationView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton(perform: {})
    }
}
