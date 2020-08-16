//
//  ContentView.swift
//  Flashzilla
//
//  Created by Ataias Pereira Reis on 15/08/20.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @State private var scale: CGFloat = 1

    var body: some View {
        VStack {
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? Color.black : Color.green)
            .foregroundColor(Color.white)
            .clipShape(Capsule())

            Text("Hello, World!")
                .scaleEffect(scale)
                .onTapGesture {
                    withOptionalAnimation {
                        scale *= 1.5
                    }
                }
        }
    }
}

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct EventsView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

    @State private var count = 0
    @State private var time = Date()

    var body: some View {
        VStack {
            Text("Hello, world! The count is \(count)")
                .onReceive(timer) { time in
                    if count == 10 {
                        timer.upstream.connect().cancel()
                    } else {
                        self.time = time
                    }
                    count += 1
            }
            Text("Time: \(time)")
            Text("Hello background!")
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                    print("Moving to the background")
                })

            Text("Hello foreground!")
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
                    print("Moving back to foreground")
                })

            Text("Screenshot")
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification), perform: { _ in
                    print("User took a screenshot!")
                })
        }
    }
}

struct HapticEngineView: View {

    @State private var engine: CHHapticEngine?


    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("Hello, success!")
                .onTapGesture(perform: simpleSuccess)

            Text("Hello, error!")
                .onTapGesture(perform: simpleError)

            Text("Hello, warning!")
                .onTapGesture(perform: simpleWarning)

            Text("Hello, custom haptics!")
                .onAppear(perform: prepareHaptics)
                .onTapGesture(perform: complexSuccess)

            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            .contentShape(Rectangle() )
            .onTapGesture {
                print("VStack tapped!")
            }

        }
    }

    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    func simpleError() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    func simpleWarning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
            print("Engine started")
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
//        events.append(event)

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            print("Player started")
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

struct CombinedGesturesView: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in self.offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragging = true
                }
            }

        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

struct SingleGesturesView: View {
    @State private var finalAmount: CGFloat = 1.0
    @State private var currentAmount: CGFloat = 0.0

    @State private var currentAmountDegrees: Angle = .degrees(0)
    @State private var finalAmountDegrees: Angle = .degrees(0)

    var body: some View {
        VStack {
            Text("Double tap me!")
                .onTapGesture(count: 2) {
                    print("Double tapped!")
                }
            Text("Long press me!")
                .onLongPressGesture {
                    print("Long pressed!")
                }

            Text("Hello, World!")
                .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
                    print("In progress: \(inProgress)!")
                }) {
                    print("Long pressed!")
                }

            Spacer()
            Text("Scale me!")
                .font(.largeTitle)
                .scaleEffect(finalAmount + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { amount in
                            self.currentAmount = amount - 1
                        }
                        .onEnded { amount in
                            self.finalAmount += self.currentAmount
                            self.currentAmount = 0
                        }
                )

            Spacer()

            Text("Rotate me!")
                .rotationEffect(currentAmountDegrees + finalAmountDegrees)
                .gesture(
                    RotationGesture()
                        .onChanged { angle in
                            currentAmountDegrees = angle
                        }
                        .onEnded { angle in
                            finalAmountDegrees += currentAmountDegrees
                            currentAmountDegrees = .degrees(0)
                        }
                )

            Spacer()
        }


    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
            ContentView()
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .dark)
        }
    }
}
