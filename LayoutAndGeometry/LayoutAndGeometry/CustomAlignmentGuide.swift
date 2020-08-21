//
//  CustomAlignmentGuide.swift
//  LayoutAndGeometry
//
//  Created by Ataias Pereira Reis on 21/08/20.
//

import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuide: View {
    // in this tutorial, we are trying to align two pieces of text in different VStacks
    // for that, we need a custom alignment guide, which requires an Extension!
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                // ALIGN THIS
                Text("600x Placeholder")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center]}
                Image("600")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                // WITH THIS
                Text("Placeholder Place")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center]}
                    .font(.largeTitle)
            }
        }
    }
}

struct CustomAlignmentGuide_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentGuide()
    }
}
