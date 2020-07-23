//
//  ContentView.swift
//  Instafilter
//
//  Created by Ataias Pereira Reis on 23/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    // TODO display the image
                }
                .onTapGesture {
                    // TODO select an image
                }

                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity, in: 0.0...1.0)
                }.padding(.vertical)

                HStack {
                    Button("Change Filter") {
                        // TODO Change filter
                    }

                    Spacer()

                    Button("Save") {
                        // TODO Save the picture
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
