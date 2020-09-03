//
//  View+Extensions.swift
//  SnowSeeker
//
//  Created by Ataias Pereira Reis on 29/08/20.
//

import SwiftUI

extension View {
    /// This modifier allows you to easily force a NavigationView to behave as
    /// a StackNavigationView in phones and keeping the default behaviour on tablets
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
