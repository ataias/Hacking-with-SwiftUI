//
//  CardView.swift
//  Flashzilla
//
//  Created by Ataias Pereira Reis on 16/08/20.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    let card: Card
    var removal: (() -> Void)? = nil

    @State private var isShowingAnswer = false

    @State private var offset = CGSize.zero

    @State private var feedback = UINotificationFeedbackGenerator()

    var answeredRight: Bool {
        offset.width > 0
    }


    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(answeredRight ? Color.green : Color.red)
                )
                .shadow(radius: 10)

            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)

                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)

        }
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            // Think about the UX; a power user might get annoyed at so many notifications
                            // Paul Hudson said if it were his app, he would keep the error and let the success case go, as success is likely more common; this way the error case becomes more "special"
                            feedback.notificationOccurred(.success)
                        } else {
                            feedback.notificationOccurred(.error)
                        }

                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
    }

}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()

    }
}
