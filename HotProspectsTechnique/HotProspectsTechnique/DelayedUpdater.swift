//
//  DelayedUpdates.swift
//  HotProspectsTechnique
//
//  Created by Ataias Pereira Reis on 09/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation
import SwiftUI

class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}
