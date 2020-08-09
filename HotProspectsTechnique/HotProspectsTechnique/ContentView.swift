//
//  ContentView.swift
//  HotProspectsTechnique
//
//  Created by Ataias Pereira Reis on 09/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

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

    var body: some View {
        VStack {


            TabView(selection: $selectedTab) {
                VStack {
                    Text("Tab 1 - Show Only")
                    DisplayView()
                    Text("Value: \(updater.value)")
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
