//
//  AlignmentView.swift
//  LayoutAndGeometry
//
//  Created by Ataias Pereira Reis on 21/08/20.
//

import SwiftUI

struct AlignmentView: View {
    var body: some View {
        VStack {
            Text("Live long and prosper")
                .frame(width: 300, height: 200, alignment: .topLeading)
                .offset(x: 10.0, y: 10.0)

            // just setting alignment "bottom" in HStack does not work!
            // Each text view has a different font size and a different baseline
            // To fix the alignment, you do "lastTextBaseline"
            HStack(alignment: .lastTextBaseline) {
                Text("Live")
                    .font(.caption)
                Text("long")
                Text("and")
                    .font(.title)
                Text("prosper")
                    .font(.largeTitle)
            }

            // we can have custom alignments for views inside a VStack
            VStack(alignment: .leading) {
                // this is effectively translating the "leading" edge of the view to be its "trailing" edge
                // this augments the size of the view of the leading edge of this one needs to match the next view
                Text("Hello, world!")
                    .alignmentGuide(.leading) { d in
                        d[.trailing] //
                    }
                Text("This is a longer line of text")
                ForEach(0..<5) { position in
                    Text("Number \(position)")
                        .alignmentGuide(.leading) { _ in
                            CGFloat(position) * -10
                        }
                }
            }
            .background(Color.red)
            .frame(width: 300, height: 200)
            .background(Color.blue)
        }
    }
}

struct AlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentView()
    }
}
