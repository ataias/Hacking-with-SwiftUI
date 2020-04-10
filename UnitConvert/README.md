#  UnitConvert

This project is a unit converter based on the specs on [Project Challenge 1](https://www.hackingwithswift.com/100/swiftui/19) of "[100 Days Hacking with SwiftUI](https://www.hackingwithswift.com/100/swiftui)".

## Requirements
The requirements were to build a unit converter for:
- Temperature: celsius, fahrenheit and kelvin
- Length: m, km, cm, ft, yd and miles
- Duration: seconds, minutes, hours and days
- Volume: ml, l, cups, pints and gallons

## Extra
Some non-requirements that I followed are:
- Use UnitDuration and Measurement classes
- Sanitize decimal

## Lessons Learned
- Updating state based on other state is not obvious: I tried didSet and willSet, but there were bugs and the value was not updating, and I even checked the debugger. Eventually I found out about [bindings](https://stackoverflow.com/a/57702713/2304697) and the issue was fixed.
- Pickers are picky: even when I fixed the states mentioned above, which decided the number of elements in two pickers, they would not get updated. At the moment I don't know why, but I suspect it is some kind of optimization SwiftUI does. To fix it: [id(:identifier:)](https://stackoverflow.com/a/58359139/2304697) was used. Each picker of a different length now has a unique id, and they update accordingly.
- Extensions are awesome: UnitDuration does not include a "days" unit. However, I could add one just fine and set up a conversion coefficient easily. I experimented a little with Xcode playground to understand how to use it, as I am so new to SwiftUI I still have troubles knowing how to google for terms. The official docs have the classes and lists everything, but it is hard to find examples in the ones I saw so far.
