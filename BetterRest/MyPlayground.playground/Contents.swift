import UIKit

func componentsToDate(components: DateComponents) -> Date {
    // We can define only portions of a date like

    var components = components
    components.hour = 8
    components.minute = 0

    let date = Calendar.current.date(from: components) ?? Date()

    // The above looks weird to me at the moment. Xcode shows "date" is Jan 1st, but today is April 19th for me.
    return date

}

componentsToDate(components: DateComponents())

func dateToComponents(date: Date) -> DateComponents {
    // We can get the components from a date (if we want just hour and minute for instance

    let components = Calendar.current.dateComponents([.hour, .minute], from: date)

    return components
}

let components = dateToComponents(date: Date())
let hour = components.hour ?? 0
let minute = components.minute ?? 0

let formatter = DateFormatter()
formatter.timeStyle = .medium
let dateString = formatter.string(from: Date())
