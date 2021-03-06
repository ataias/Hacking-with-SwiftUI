//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Ataias Pereira Reis on 10/08/20.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    let filter: FilterType
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortMenu = false
    @Binding var sortKey: ProspectSortKey

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }

    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects.sorted(by: sortKey)) { prospect in
                    HStack {
                        if filter == .none {
                            if prospect.isContacted {
                                Image(systemName: "hand.thumbsup")
                            } else {
                                Image(systemName: "hand.point.right")
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                        Button("Sort By") {
                            isShowingSortMenu.toggle()
                        }
                    }

                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(trailing: Button(action: {
                self.isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
            }
            .actionSheet(isPresented: $isShowingSortMenu) {
                let buttons: [Alert.Button] = (ProspectSortKey.allCases.map { sortType in .default(Text(sortType.rawValue), action: { self.sortKey = sortType }) }) + [.cancel()]
                return (
                    ActionSheet(title: Text("Select a sorting key"), buttons: buttons)
                )
            }
        }
    }

    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            let prospect = Prospect()
            prospect.name = details[0]
            prospect.emailAddress = details[1]
            prospects.add(prospect)
        case .failure:
            print("Scanning failed")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default

            #if DEBUG
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            #else
                var dateComponents = DateComponents()
                dateComponents.hour = 9
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            #endif

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)

        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }

        }
    }

    enum FilterType {
        case none, contacted, uncontacted
    }

}

enum ProspectSortKey: String, CaseIterable {
    case name, email
}

extension Array where Element: Prospect {
    func sorted(by sortKey: ProspectSortKey) -> [Element] {
        switch sortKey {
        case .name:
            return self.sorted(by: { (p1, p2) in p1.name < p2.name} )
        case .email:
            return self.sorted(by: { (p1, p2) in p1.emailAddress < p2.emailAddress} )
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none, sortKey: .constant(ProspectSortKey.name))
    }
}
