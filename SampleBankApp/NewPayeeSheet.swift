//
//  NewPayeeSheet.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI

struct NewPayeeSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bankState: BankAppState
    @State private var name: String = ""
    @State private var accountNumber: String = ""
    @State private var showValidationError = false
    @State private var validationMessage: String = ""
    
    var body: some View {
            NavigationView {
                ZStack {
                    Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                        .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Icon and connection
                    HStack(spacing: 20) {
                        // Bank icon
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.13, green: 0.48, blue: 1.0).opacity(0.2)) // Bright blue with opacity
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "building.2")
                                .font(.title2)
                                .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                        }
                        
                        // Dashed line
                        Rectangle()
                            .fill(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                            .frame(height: 2)
                            .opacity(0.3)
                        
                        // Person icon
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.13, green: 0.48, blue: 1.0).opacity(0.2)) // Bright blue with opacity
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "person")
                                .font(.title2)
                                .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                        }
                    }
                    
                    Text("Someone new")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Information text
                    Text("We check the account owner name and account number match before you pay this account.")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button("Learn more") {
                        // Handle learn more
                    }
                    .foregroundColor(Color(red: 0.29, green: 0.64, blue: 0.89)) // Light blue
                    
                    // Input Fields
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Account owner name")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextField("Their full name or business name", text: $name)
                                .font(.body)
                                .foregroundColor(.white)
                                .padding(.bottom, 8)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)), // Bright blue
                                    alignment: .bottom
                                )
                                .accessibilityIdentifier("new.payee.name.field")
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Account number")
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
                                .accessibilityIdentifier("new.payee.account.number.field")
                        }
                    }
                    
                    Spacer()
                    
                    // Check account details button
                    Button(action: {
                        addNewPayee()
                    }) {
                        Text("Check account details")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                            .cornerRadius(12)
                    }
                    .disabled(name.isEmpty || accountNumber.isEmpty)
                    .accessibilityIdentifier("new.payee.check.button")
                    
                    // Done button
                    Button("Done") {
                        dismiss()
                    }
                    .accessibilityIdentifier("new.payee.done.button")
                    .foregroundColor(Color(red: 0.29, green: 0.64, blue: 0.89)) // Light blue
                }
                .padding()
            }
            .navigationTitle("Someone new")
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
        .alert(isPresented: $showValidationError) {
            Alert(title: Text("Validation Error"), message: Text(validationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func addNewPayee() {
        // Use improved validation from BankAppState
        let validation = bankState.validateNewPayee(name: name, accountNumber: accountNumber)
        
        if !validation.isValid {
            validationMessage = validation.errorMessage ?? "Invalid payee information"
            showValidationError = true
            return
        }
        
        
        // Add new payee
        _ = bankState.addNewPayee(name: name, accountNumber: accountNumber)
        dismiss()
    }
}

#Preview {
    NewPayeeSheet()
        .environmentObject(BankAppState())
}