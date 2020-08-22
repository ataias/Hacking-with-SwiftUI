//
//  GeometryTestView.swift
//  LayoutAndGeometry
//
//  Created by Ataias Pereira Reis on 22/08/20.
//

import SwiftUI


struct GeometryTestView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("Hello, World!")
                    .frame(width: geo.size.width * 0.9, height: 40)
                    .background(Color.red)
            }
            .background(Color.green)
            Text("More Text")
                .background(Color.blue)
        }

    }
}

struct GeometryTestView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryTestView()
    }
}
