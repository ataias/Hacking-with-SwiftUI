//
//  AstronautView.swift
//  Moonshot
//
//  Created by Ataias Pereira Reis on 20/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]

    init(astronaut: Astronaut) {
        self.astronaut = astronaut

        let missions: [Mission] = Bundle.main.decode("missions.json")

        self.missions = missions.filter { mission in
            mission.crew.contains(where: { $0.name == astronaut.id })
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text("Missions")
                        .font(.largeTitle)

                    ForEach(self.missions) { mission in
                        Text("\(mission.displayName)")
                    }

                    Text("Bio")
                        .font(.largeTitle)

                    Text(self.astronaut.description)
                        .padding()
                        // SwiftUI was confusing priorities and letting text clip
                        // here we prioritize it so that text shows in full
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)

    }


}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
