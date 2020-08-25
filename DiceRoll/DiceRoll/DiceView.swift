//
//  DiceView.swift
//  DiceRoll
//
//  Created by Ataias Pereira Reis on 25/08/20.
//

import SwiftUI

struct DiceView: View {
    let number: Int
    let baseDimension: CGFloat = 70

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                .fill(Color.white)
                .background(RoundedRectangle(cornerRadius: 10.0, style: .continuous).frame(width: baseDimension + 10.0, height: baseDimension + 10.0, alignment: .center))
                .frame(width: baseDimension, height: baseDimension, alignment: .center)

            Text("\(number)")
                .font(.largeTitle)
                .fontWeight(.bold)

        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(number: 5)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
