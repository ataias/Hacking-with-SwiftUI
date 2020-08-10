import UIKit
import Foundation
import Combine

class A {
    @Published var password: String = ""
    @Published var passwordAgain: String = ""

}


let a = A()

a.password = "1234"

let printerSubscription = a.$password.sink {
    print("The published value is '\($0)'")
}


a.password = "password"

a.passwordAgain = "password"

let validatedPassword = a.$password.combineLatest(a.$passwordAgain) { password, passwordAgain -> String? in
        guard password == passwordAgain, password.count > 8 else { return nil}
        return password
    }
    .map { $0 == "password1" ? nil : $0 }
    .compactMap { $0 }
    .eraseToAnyPublisher()

a.password = "password1"

a.passwordAgain = "password1"

let validatedSubscription = validatedPassword.sink {
    print("The validated value is '\($0)'")
}

a.password = "password123"
a.passwordAgain = "password123"
