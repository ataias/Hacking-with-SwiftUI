//
//  CoverFlowView.swift
//  LayoutAndGeometry
//
//  Created by Ataias Pereira Reis on 22/08/20.
//

import SwiftUI

struct CoverFlowView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<50) { index in
                        VStack {
                            Spacer()
                            GeometryReader { geo in
                                Rectangle()
                                    .fill(self.colors[index % 7])
                                    .frame(height: 150)
                                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                            }
                            .frame(width: 150, height: 150)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, (fullView.size.width - 150) / 2)
            }
        }
        //        .edgesIgnoringSafeArea(.all)
    }
}

struct CoverFlowView_Previews: PreviewProvider {
    static var previews: some View {
        CoverFlowView()
    }
}
