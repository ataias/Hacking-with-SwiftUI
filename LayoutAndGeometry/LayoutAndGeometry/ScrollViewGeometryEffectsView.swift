//
//  ScrollViewGeometryEffectsView.swift
//  LayoutAndGeometry
//
//  Created by Ataias Pereira Reis on 22/08/20.
//

import SwiftUI

struct ScrollViewGeometryEffectsView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                         Text("Row #\(index)")
                            .font(.title)
                            .frame(width: fullView.size.width)
                            .background(colors[index % 7])
                            .rotation3DEffect(
                                .degrees(Double(geo.frame(in: .global).minY / 5 - fullView.size.height / 2)),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct ScrollViewGeometryEffectsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewGeometryEffectsView()
    }
}
