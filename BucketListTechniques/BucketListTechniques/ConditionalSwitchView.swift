//
//  ConditionalSwitchView.swift
//  BucketListTechniques
//
//  Created by Ataias Pereira Reis on 26/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct ConditionalSwitchView: View {
    let state: LoadingState

    var body: some View {
        Group {
            if state == .loading {
                LoadingView()
            } else if state == .success {
                SuccessView()
            } else if state == .failed {
                FailedView()
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ConditionalSwitchView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionalSwitchView(state: .failed)
    }
}
