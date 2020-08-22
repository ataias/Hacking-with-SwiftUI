//
//  PositioningView.swift
//  LayoutAndGeometry
//
//  Created by Ataias Pereira Reis on 22/08/20.
//

import SwiftUI

struct PositioningView: View {
    var body: some View {
        VStack {
            // Absolute positioning will take all the available space so that the modifier can place its child correctly in the space
//            Text("Absolute Hello, World!")
//                .background(Color.red)
//                .position(x: 100.0, y: 100.0)
//                .background(Color.blue)
            // Offset does not change the geometry!
            Text("Relative Hello, World!")
                .background(Color.red)
                .offset(x: 100.0, y: 100.0)
                .background(Color.blue)

        }
    }
}

struct PositioningView_Previews: PreviewProvider {
    static var previews: some View {
        PositioningView()
    }
}
