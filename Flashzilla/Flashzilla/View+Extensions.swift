//
//  View+Extensions.swift
//  Flashzilla
//
//  Created by Ataias Pereira Reis on 16/08/20.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}
