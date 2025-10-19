//
//  ContentView.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var bankState: BankAppState
    
    var body: some View {
        if bankState.isLoggedIn {
            HomeView()
                .accessibilityIdentifier("contentView")
        } else {
            LoginView()
                .accessibilityIdentifier("loginView")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(BankAppState())
}