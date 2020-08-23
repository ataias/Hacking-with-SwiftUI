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
                    BannerView(image: mission.image, geometry: geometry)

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


}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}

struct BannerView: View {
    let image: String
    let geometry: GeometryProxy
    @State private var initialY: CGFloat?
    @State private var height: CGFloat?

    var body: some View {
        HStack {
            Spacer()
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: height ?? getHeight())
                .padding(.top)
            Spacer()
        }
        .onChange(of: geometry.frame(in: .global).midY) { midY in
            if initialY == nil && Int(midY) != 0 {
                initialY = midY
            }
        }
        .onChange(of: geometry.frame(in: .global).midY) { midY in
            withAnimation {
                height = getHeight()
            }
        }
    }

    func getHeight() -> CGFloat {
        let y = geometry.frame(in: .global).midY
        let difference = (initialY ?? 0.0) - y
        if difference <= 0 {
            return geometry.size.width * 0.9
        } else {
            return geometry.size.width * 0.9 * 0.5
        }
    }
}
