#  Lessons Learned

- Gestures in SwiftUI are quite powerful. You can have single taps, but also configure the number of taps for a closure to run. Similarly for long presses and you can have closures that run when the user started pressing and when the pressing time has completed. You can also combine gestures.
- Haptics are also quite powerful; CoreHaptics is quite customizable
- If you want to change the frame of a tap gesture, `contentShape` allows you to do that, like:
`
Circle()
    .fill(Color.red)
    .frame(width: 300, height: 300)
    .contentShape(Rectangle())
    .onTapGesture {
        print("Circle tapped!")
    }
`

- ContentShape is also very useful for `VStack`, as it allows you to make the whole tappable, even if there is spacing in the middle, which is by default not tappable
- To disable tapping in a view that has it configured, you can use the modifier `allowsHitTesting`
