//
//  Mission.swift
//  Moonshot
//
//  Created by Ataias Pereira Reis on 20/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }

    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        }
        return "N/A"
    }

    var formattedCrewMembers: String {
        return self.crew.map({$0.name}).joined(separator: ", ")
    }

    func formattedSubtitle(_ missionOverview: MissionOverview) -> String {
        switch missionOverview {
        case .LaunchDate:
            return formattedLaunchDate
        default:
            return formattedCrewMembers
        }
    }

    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}
