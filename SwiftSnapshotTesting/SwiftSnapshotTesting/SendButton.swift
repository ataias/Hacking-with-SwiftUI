//
//  SendButton.swift
//  SwiftSnapshotTesting
//
//  Created by Ataias Pereira Reis on 08/08/20.
//

import SwiftUI

struct SendButton: View {
    let onAction: () -> Void = {}

    var body: some View {
        Button(
            action: onAction,
            label: {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("common.button.send")
                }
        })
    }
}

struct SendButton_Preview: PreviewProvider {
    static var previews: some View {
        SendButton()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
