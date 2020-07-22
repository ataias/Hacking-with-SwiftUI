//
//  CustomBindingView.swift
//  Instafilter
//
//  Created by Ataias Pereira Reis on 20/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct CustomBindingView: View {
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )

        return (
            VStack {
                Text("Hello, World!")
                    .blur(radius: blurAmount)

                Slider(value: blur, in: 0...20)
            }
            .padding()
        )
    }
}

struct CustomBindingView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBindingView()
    }
}
