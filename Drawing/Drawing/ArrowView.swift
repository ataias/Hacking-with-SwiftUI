//
//  ArrowView.swift
//  Drawing
//
//  Created by Ataias Pereira Reis on 28/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {

    var thickness: CGFloat
    var height: CGFloat
//    var insetAmount: CGFloat
//
    var animatableData: CGFloat {
        get { thickness }
        set { self.thickness = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addRect(CGRect(x: rect.midX, y: rect.midY, width: thickness, height: height))
        path.addPath(Triangle().path(in: CGRect(x: rect.midX - thickness / 2, y: rect.midY - thickness*2, width: thickness*2, height: thickness*2)))


        return path
    }
}

struct ArrowView: View {
    @State private var thickness = CGFloat(5.0)
    @State private var height = CGFloat(100.0)
    var body: some View {
        VStack {
            Spacer()
            Arrow(thickness: thickness, height: height)
                .frame(width: 500, height: 500)
            Spacer()
            Text("Thickness: \(Int(thickness))")
            Slider(value: $thickness, in: 2...30)
            Button(action: {
                withAnimation {
                    self.thickness = 15
                }

            }) {
                Text("Set thickness = 15")
            }
            Text("Height: \(Int(height))")
            Slider(value: $height, in: 50...300)
        }

    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
