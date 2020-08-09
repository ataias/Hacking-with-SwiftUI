#  Lessons Learned
- Tip: It’s common to want to use NavigationView and TabView at the same time, but you should be careful: TabView should be the parent view, with the tabs inside it having a NavigationView as necessary, rather than the other way around.
- If a closure is used later in the program flow and its creator was already destroyed, the closure becomes invalid. This poses a problem to asynchronous programming. To fix it, we use "@escaping" closures to ensure swift keeps the memory for the closure alive.
- Local and push notifications are different. Local notifications were scheduled locally by the device. Push come from a server (remote notifications)
