//
//  MissionView.swift
//  Moonshot
//
//  Created by Ataias Pereira Reis on 20/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]

    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        self.astronauts = mission.crew.map { member in
            guard let astronaut = astronauts.first(where: { $0.id == member.name }) else {
                fatalError("Missing \(member)")
            }

            return CrewMember(
                role: member.role,
                astronaut: astronaut
            )
        }

    }

    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }


    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    Text(self.mission.description)
                        .padding()


                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName))
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
