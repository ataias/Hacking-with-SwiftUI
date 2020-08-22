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

    @State private var initialYPosition: CGFloat? = nil


    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { imageGeometry in
                        HStack {
                            Spacer()
                            Image(self.mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: calculateImageWidth(imageGeometry))
                                .padding(.top)
                                .onAppear {
                                    initialYPosition = imageGeometry.frame(in: .global).midY
                                }
                            Spacer()
                        }
                    }

                    Text(self.mission.formattedLaunchDate)
                    Text(self.mission.description)
                        .padding()


                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                            .padding([.horizontal])
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName))
    }

    func calculateImageWidth(_ imgProxy: GeometryProxy) -> CGFloat {
        let y = imgProxy.frame(in: .global).midY
        let difference = (initialYPosition ?? 0.0) - y
        if difference <= 0 {
            return imgProxy.size.height * 0.9
        } else {
            return imgProxy.size.height * 0.9 * 0.7
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
