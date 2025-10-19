//
//  EditPayeeSheet.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI

struct EditPayeeSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bankState: BankAppState
    @State var payee: Payee
    @State private var name: String
    @State private var accountNumber: String
    
    init(payee: Payee) {
        _payee = State(initialValue: payee)
        _name = State(initialValue: payee.name)
        _accountNumber = State(initialValue: payee.accountNumber)
    }
    
    var body: some View {
            NavigationView {
                ZStack {
                    Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                        .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Payee Icon
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.94, green: 0.82, blue: 0.75)) // Light peach/orange
                            .frame(width: 80, height: 80)
                        
                        Text(payee.initials)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color(red: 0.75, green: 0.38, blue: 0.25)) // Reddish-brown
                    }
                    
                    Text("Edit Payee")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Input Fields
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Payee Name")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextField("Enter payee name", text: $name)
                                .font(.body)
                                .foregroundColor(.white)
                                .padding(.bottom, 8)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)), // Bright blue
                                    alignment: .bottom
                                )
                                .accessibilityIdentifier("edit.payee.name.field")
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Account Number")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextField("Enter account number", text: $accountNumber)
                                .font(.body)
                                .foregroundColor(.white)
                                .padding(.bottom, 8)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)), // Bright blue
                                    alignment: .bottom
                                )
                                .accessibilityIdentifier("edit.payee.account.number.field")
                        }
                    }
                    
                    Spacer()
                    
                    // Save button
                    Button(action: {
                        var updatedPayee = payee
                        updatedPayee.name = name
                        updatedPayee.accountNumber = accountNumber
                        updatedPayee.initials = String(name.prefix(2)).uppercased()
                        bankState.updatePayee(updatedPayee)
                        dismiss()
                    }) {
                        Text("Save Changes")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                            .cornerRadius(12)
                    }
                    .disabled(name.isEmpty || accountNumber.isEmpty)
                    .accessibilityIdentifier("edit.payee.save.button")
                }
                .padding()
            }
            .navigationTitle("Edit Payee")
            #if canImport(UIKit)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(red: 0.04, green: 0.10, blue: 0.18), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 0.29, green: 0.64, blue: 0.89)) // Light blue
                }
            }
        }
    }
}

#Preview {
    EditPayeeSheet(payee: Payee(name: "Sample Payee", accountNumber: "02-1234-5678901-002", initials: "SP"))
        .environmentObject(BankAppState())
}