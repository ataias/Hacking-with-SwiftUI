//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Ataias Pereira Reis on 29/08/20.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort

    @State private var selectedFacility: String?

    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()

                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { SkiDetailsView(resort: resort) }
                            VStack { ResortDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)

                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    HStack {
                        ForEach(resort.facilities, id: \.self) { facility in
                            Facility.icon(for: facility)
                                .font(.title)
                                .onTapGesture {
                                    selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .alert(item: $selectedFacility) { facility in
            Facility.alert(for: facility)
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

// FIXME this is not desired; it is easy to mess up. You should use something else as identifiable in the alert instead of making all strings identifiable.
extension String: Identifiable {
    public var id: String { self }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
            .environment(\.horizontalSizeClass, .compact)
    }
}
