#  Lessons Learned
- If you have an observable object with a property like an array, SwiftUI automatically detects changes you make to the array, adding or removing items. If you change a property of an item of the array, like a boolean field, it does not trigger SwiftUI. You need to manually handle it with `objectWillChange.send()`
