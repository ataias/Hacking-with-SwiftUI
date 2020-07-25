//
//  FilterSlider.swift
//  Instafilter
//
//  Created by Ataias Pereira Reis on 25/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct FilterSlider: View {
    let title: String
    let range: ClosedRange<Double>
    @Binding var value: Double
    let afterUpdate: () -> ()

    var body: some View {
        let internalValue = Binding<Double>(
            get: {
                self.value
            },
            set: {
                self.value = $0
                self.afterUpdate()
            }
        )

        return (
            HStack {
                Text(title)
                Slider(value: internalValue, in: range)
            }
        )
    }
}

struct FilterSlider_Previews: PreviewProvider {
    static var previews: some View {
        FilterSlider(title: "Intensity", range: 0.0...5.0, value: .constant(2.5), afterUpdate: {})
    }
}
