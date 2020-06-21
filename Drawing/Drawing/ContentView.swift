//
//  ContentView.swift
//  Drawing
//
//  Created by Ataias Pereira Reis on 21/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Flower: Shape {
    /// How much we move this petal away from the center
    var petalOffset: Double = -20

    /// How wide to make each petal
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        var path = Path()

        for number in stride(from: 0, to: 2 * CGFloat.pi, by: CGFloat.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            // move the petal to the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))

            let rotatedPetal = originalPetal.applying(position)

            path.addPath(rotatedPetal)

        }
        return path
    }
}

struct Arc: InsettableShape {

    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let rotationAdjustement = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustement
        let modifiedEnd = endAngle - rotationAdjustement

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }


}

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0

    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
            Text("Offset")

            Slider(value: $petalOffset, in: -40...40)
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct BasicArcsView: View {
    var body: some View {
        VStack {
//            Path { path in
//                path.move(to: CGPoint(x: 200, y: 100))
//                path.addLine(to: CGPoint(x: 100, y: 300))
//                path.addLine(to: CGPoint(x: 300, y: 300))
//                path.addLine(to: CGPoint(x: 200, y: 100))
//            }
//            .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))

            Triangle()
                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200)
            Spacer()
            Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                .stroke(Color.blue, lineWidth: 10)
                .padding()
//                .frame(width: 200, height: 200)

            Spacer()
//            Circle()
//                .strokeBorder(Color.blue, lineWidth: 40)
////                .frame(width: 200, height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
