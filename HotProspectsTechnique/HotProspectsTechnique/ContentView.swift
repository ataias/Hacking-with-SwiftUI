//
//  ContentView.swift
//  HotProspectsTechnique
//
//  Created by Ataias Pereira Reis on 09/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import UserNotifications
import SamplePackage

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    let user = User()
    @State private var selectedTab = 0
    @State private var urlResult = ""

    @ObservedObject var updater = DelayedUpdater()

    @State private var backgroundColor = Color.red

    let possibleNumbers = Array(1...60)

    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }

    var body: some View {
        VStack {


            TabView(selection: $selectedTab) {
                VStack {
                    Text("Tab 1 - Show Only")
                    DisplayView()
                    Text("Value: \(updater.value)")

                    // Using an external package
                    Text(results)
                }
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("One")
                }
                .tag(0)

                VStack {
                    Text("Tab 2 - Edit View")
                    EditView()
                }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
                .tag(1)

                VStack {
                    Image("example")
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: .infinity)
                        .background(Color.black)
                        .edgesIgnoringSafeArea(.all)
                }
                .tabItem {
                    Image(systemName: "doc")
                    Text("Three")
                }
                .tag(2)

                VStack {
                    Text("Hello, World!")
                        .padding()
                        .background(backgroundColor)

                    Text("Change Color")
                        .padding()
                        .contextMenu {
                            Button(action: {
                                self.backgroundColor = .red
                            }) {
                                Text("Red")
                                Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.red)
                            }

                            Button(action: {
                                self.backgroundColor = .green
                            }) {
                                Text("Green")
                            }

                            Button(action: {
                                self.backgroundColor = .blue
                            }) {
                                Text("Blue")
                            }
                    }

                    VStack {
                        Button("Request Permission") {
                            // first
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("All set!")
                                } else if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
                        }

                        Button("Schedule Notification") {
                            // second
                            let content = UNMutableNotificationContent()
                            content.title = "Feed the cat"
                            content.subtitle = "It looks hungry"
                            content.sound = UNNotificationSound.default

                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                            UNUserNotificationCenter.current().add(request)


                        }
                    }
                }
                .tabItem {
                    Image(systemName: "doc.fill")
                    Text("Four")
                }
                .tag(3)

            }
        }
        .environmentObject(user)
        .onAppear {
            self.fetchData(from: "https://www.apple.com") { result in
                switch result {
                case .success(let str):
                    print(str)
                    self.urlResult = str
                case .failure(let error):
                    switch error {
                    case .badUrl:
                        self.urlResult = "Invalid URL"
                    case .requestFailed:
                        self.urlResult = "Network error"
                    case .unknown:
                        self.urlResult = "Impossible!"
                    }
                }
            }
        }
    }


    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let dataString = String(decoding: data, as: UTF8.self)
                    completion(.success(dataString))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
