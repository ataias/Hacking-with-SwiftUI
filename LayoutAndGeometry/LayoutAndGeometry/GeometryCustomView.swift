//
//  GeometryCustomView.swift
//  LayoutAndGeometry
//
//  Created by Ataias Pereira Reis on 22/08/20.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom ")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY) ")
                    }
            }
            .background(Color.orange)
             Text("Right")
        }
    }
}

struct GeometryCustomView: View {
    var body: some View {
        OuterView()
            .background(Color.gray)
            .coordinateSpace(name: "Custom")
    }
}

struct GeometryCustomView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryCustomView()
    }
}
