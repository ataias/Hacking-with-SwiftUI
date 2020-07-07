//
//  TaylorSwiftView.swift
//  CupcakeCorner
//
//  Created by Ataias Pereira Reis on 07/07/20.
//

//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ataias Pereira Reis on 07/07/20.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable, Identifiable {
    var trackId: Int
    var trackName: String
    var collectionName: String

    var id: Int {
        return trackId
    }
}

struct TaylorSwiftView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }

        }
        .onAppear(perform: loadData)
    }

    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        results = decoded.results
                    }
                }
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct TaylorSwiftView_Previews: PreviewProvider {
    static var previews: some View {
        TaylorSwiftView()
    }
}
