//
//  CenterCircle.swift
//  BucketList
//
//  Created by Ataias Pereira Reis on 29/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct BigBlueCircle: View {
    var body: some View {
        Circle()
        .fill(Color.blue)
        .opacity(0.3)
        .frame(width: 32, height: 32)
    }
}

struct CenterCircle_Previews: PreviewProvider {
    static var previews: some View {
        BigBlueCircle()
    }
}
