//
//  SampleBankAppApp.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI

@main
struct SampleBankAppApp: App {
    @StateObject private var bankState = BankAppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bankState)
        }
    }
}
