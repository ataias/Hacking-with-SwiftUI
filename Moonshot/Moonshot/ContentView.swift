//
//  ContentView.swift
//  Moonshot
//
//  Created by Ataias Pereira Reis on 16/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var missionOverview: MissionOverview = .LaunchDate

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(mission.formattedSubtitle(self.missionOverview))
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(action: {
                self.missionOverview.next()

            }) {
                Text("Toggle")
            })
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum MissionOverview {
    case LaunchDate
    case CrewMembers

    mutating func next() {
        switch self {
        case .LaunchDate:
            self = .CrewMembers
        case .CrewMembers:
            self = .LaunchDate
        }
    }
}
