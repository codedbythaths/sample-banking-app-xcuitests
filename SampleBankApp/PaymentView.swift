//
//  PaymentView.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bankState: BankAppState
    @State private var amount = "0.00"
    @State private var selectedPayee: Payee?
    @State private var showNewPayeeSheet = false
    @State private var showAccountSelection = false
    @State private var showPayeeSelection = false
    @State private var selectedFromAccount: Account?
    @State private var date = "Today"
    @State private var frequency = "One-off"
    @State private var showStatementDetails = false
    @State private var showAmountError = false
    @State private var amountErrorMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // From and To sections
                    HStack(spacing: 12) {
                        // From Account
                        VStack(alignment: .leading, spacing: 8) {
                            Text("From")
                                .font(.headline)
                                .foregroundColor(.white)
                                .accessibilityIdentifier("payment.from.label")
                                .accessibilityLabel("From account")
                                .accessibilityAddTraits(.isStaticText)
                            
                            Button(action: { showAccountSelection = true }) {
                                if let account = selectedFromAccount {
                                    VStack(spacing: 8) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color(red: 0.36, green: 0.75, blue: 0.87)) // Light blue background
                                                .frame(width: 50, height: 50)
                                            
                                            if account.name == "Rapid Save" {
                                                Image(systemName: "lock.fill")
                                                    .font(.title2)
                                                    .foregroundColor(Color(red: 0.78, green: 0.49, blue: 0.24)) // Rusty orange
                                            } else {
                                                Image(systemName: "banknote.fill")
                                                    .font(.title2)
                                                    .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                                            }
                                        }
                                        
                                        Text(account.name)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        
                                        Text("\(CurrencyFormatter().format(account.balance)) Avl.")
                                            .font(.body)
                                            .foregroundColor(.white)
                                        
                                        Text(account.accountNumber)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                        
                                        if account.name == "Rapid Save" {
                                            HStack {
                                                Image(systemName: "exclamationmark.triangle.fill")
                                                    .foregroundColor(.orange)
                                                Text("Fees may apply")
                                                    .foregroundColor(.orange)
                                            }
                                            .font(.caption)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 0.10, green: 0.17, blue: 0.25).opacity(0.3)) // Slightly lighter dark blue
                                    .cornerRadius(12)
                                } else {
                                    HStack {
                                        Text("+ Select")
                                            .foregroundColor(Color(red: 0.29, green: 0.64, blue: 0.89)) // Light blue
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 0.10, green: 0.17, blue: 0.25).opacity(0.3)) // Slightly lighter dark blue
                                    .cornerRadius(12)
                                }
                            }
                            .accessibilityIdentifier("payment.from.account.button")
                            .accessibilityLabel(selectedFromAccount != nil ? "From: \(selectedFromAccount?.name ?? "")" : "Select from account")
                            .accessibilityHint("Tap to select the account to pay from")
                        }
                        
                        // To Payee
                        VStack(alignment: .leading, spacing: 8) {
                            Text("To")
                                .font(.headline)
                                .foregroundColor(.white)
                                .accessibilityIdentifier("payment.to.label")
                                .accessibilityLabel("To payee")
                                .accessibilityAddTraits(.isStaticText)
                            
                            Button(action: { showPayeeSelection = true }) {
                                if let payee = selectedPayee {
                                    VStack(spacing: 8) {
                                        ZStack {
                                            Circle()
                                                .fill(Color(red: 0.94, green: 0.82, blue: 0.75)) // Light peach/orange
                                                .frame(width: 50, height: 50)
                                            
                                            Text(payee.initials)
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(red: 0.75, green: 0.38, blue: 0.25)) // Reddish-brown
                                        }
                                        
                                        Text(payee.name)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        
                                        Text(payee.accountNumber)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 0.10, green: 0.17, blue: 0.25).opacity(0.3)) // Slightly lighter dark blue
                                    .cornerRadius(12)
                                } else {
                                    HStack {
                                        Text("+ Select")
                                            .foregroundColor(Color(red: 0.29, green: 0.64, blue: 0.89)) // Light blue
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 0.10, green: 0.17, blue: 0.25).opacity(0.3)) // Slightly lighter dark blue
                                    .cornerRadius(12)
                                }
                            }
                            .accessibilityIdentifier("payment.to.payee.button")
                            .accessibilityLabel(selectedPayee != nil ? "To: \(selectedPayee?.name ?? "")" : "Select payee")
                            .accessibilityHint("Tap to select the payee to send money to")
                        }
                    }
                    
                    // Amount input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Amount")
                            .font(.headline)
                            .foregroundColor(.white)
                            .accessibilityIdentifier("payment.amount.label")
                            .accessibilityLabel("Payment amount")
                            .accessibilityAddTraits(.isStaticText)
                        
                        HStack {
                            TextField("0.00", text: $amount)
                                .font(.title2)
                                .foregroundColor(.white)
                                .accentColor(.white) // Set accent color for cursor/selection
                                .accessibilityIdentifier("payment.amount.textfield")
                                .accessibilityLabel("Amount input field")
                                .accessibilityHint("Enter the amount to pay")
                                .accessibilityValue(amount)
                            
                            if !amount.isEmpty && amount != "0.00" {
                                Button(action: { amount = "0.00" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .accessibilityIdentifier("payment.amount.clear.button")
                                .accessibilityLabel("Clear amount")
                                .accessibilityHint("Tap to clear the amount field")
                            }
                        }
                        .padding(.bottom, 8)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )
                    }
                    
                    // Date input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack {
                            Text(date)
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .accessibilityIdentifier("payment.date.field")
                        .accessibilityLabel("Payment date")
                        .accessibilityValue("Selected: \(date)")
                        .accessibilityHint("Tap to change payment date")
                        .padding(.bottom, 8)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )
                    }
                    
                    // Frequency input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Frequency")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack {
                            Text(frequency)
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .accessibilityIdentifier("payment.frequency.field")
                        .accessibilityLabel("Payment frequency")
                        .accessibilityValue("Selected: \(frequency)")
                        .accessibilityHint("Tap to change payment frequency")
                        .padding(.bottom, 8)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )
                    }
                    
                    // Statement details
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Statement details")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack {
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .accessibilityIdentifier("payment.statement.details.field")
                        .accessibilityLabel("Statement details")
                        .accessibilityHint("Tap to add statement details for the payment")
                        .padding(.bottom, 8)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )
                    }
                    
                    Spacer()
                    
                    // Pay button
                    Button(action: {
                        if validateAmount() {
                            if let payee = selectedPayee, let fromAccount = selectedFromAccount {
                                bankState.currentPayment.fromAccount = fromAccount
                                bankState.currentPayment.toPayee = payee
                                bankState.currentPayment.amount = amount
                                
                                if bankState.makePayment() {
                                    dismiss()
                                }
                            }
                        }
                    }) {
                        Text("Pay")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                            .cornerRadius(12)
                    }
                    .disabled(amount.isEmpty || amount == "0.00" || selectedPayee == nil || selectedFromAccount == nil)
                    .accessibilityIdentifier("payment.pay.button")
                    .accessibilityLabel("Pay")
                    .accessibilityHint("Tap to process the payment")
                }
                .padding()
            }
            .navigationTitle("Make a payment")
            #if canImport(UIKit)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(red: 0.04, green: 0.10, blue: 0.18), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar) // Added for white title
            #endif
            .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(Color(red: 0.29, green: 0.64, blue: 0.89)) // Light blue
                        .accessibilityIdentifier("payment.cancel.button")
                        .accessibilityLabel("Cancel payment")
                        .accessibilityHint("Tap to cancel and close the payment form")
                    }
            }
        }
        .sheet(isPresented: $showAccountSelection) {
            AccountSelectionSheet(selectedAccount: $selectedFromAccount, title: "From")
        }
        .sheet(isPresented: $showPayeeSelection) {
            PayeeSelectionSheet(selectedPayee: $selectedPayee)
        }
        .sheet(isPresented: $showNewPayeeSheet) {
            NewPayeeSheet()
        }
        .onAppear {
            if selectedPayee == nil {
                selectedPayee = bankState.payees.first
            }
            if selectedFromAccount == nil {
                selectedFromAccount = bankState.accounts.first
            }
        }
        .alert("Invalid Amount", isPresented: $showAmountError) {
            Button("OK") { }
        } message: {
            Text(amountErrorMessage)
        }
    }
    
    private func validateAmount() -> Bool {
        guard let amountValue = Double(amount), amountValue > 0 else {
            amountErrorMessage = "Please enter a valid amount greater than $0.00"
            showAmountError = true
            return false
        }
        
        guard let fromAccount = selectedFromAccount, amountValue <= fromAccount.balance else {
            amountErrorMessage = "Insufficient funds. Available balance: \(CurrencyFormatter().format(selectedFromAccount?.balance ?? 0))"
            showAmountError = true
            return false
        }
        
        return true
    }
}


// MARK: - Payee Selection Sheet
struct PayeeSelectionSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bankState: BankAppState
    @Binding var selectedPayee: Payee?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
                
                VStack {
                    // Handle
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.gray)
                        .frame(width: 40, height: 4)
                        .padding(.top, 8)
                    
                    // Header
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(Color(red: 0.29, green: 0.64, blue: 0.89)) // Light blue
                        
                        Spacer()
                        
                        Text("Select Payee")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: { bankState.showNewPayeeSheet = true }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(Color(red: 0.29, green: 0.64, blue: 0.89)) // Light blue
                        }
                        .accessibilityIdentifier("payee.selection.add.new.button")
                    }
                    .padding()
                    
                    // Payee List
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(bankState.payees) { payee in
                                PayeeSelectionRow(payee: payee, isSelected: selectedPayee?.id == payee.id) {
                                    selectedPayee = payee
                                    dismiss()
                                }
                                .accessibilityIdentifier("payee.selection.row.\(payee.name.lowercased().replacingOccurrences(of: " ", with: "."))")
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Payee Selection Row
struct PayeeSelectionRow: View {
    let payee: Payee
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Payee Icon
                ZStack {
                    Circle()
                        .fill(Color(red: 0.94, green: 0.82, blue: 0.75)) // Light peach/orange
                        .frame(width: 50, height: 50)
                    
                    Text(payee.initials)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.75, green: 0.38, blue: 0.25)) // Reddish-brown
                }
                
                // Payee Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(payee.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(payee.accountNumber)
                        .font(.caption)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding()
            .background(isSelected ? Color(red: 0.13, green: 0.48, blue: 1.0).opacity(0.1) : Color(red: 0.10, green: 0.17, blue: 0.25).opacity(0.3)) // Bright blue or slightly lighter dark blue
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color(red: 0.13, green: 0.48, blue: 1.0) : Color.clear, lineWidth: 2) // Bright blue or clear
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    PaymentView()
        .environmentObject(BankAppState())
}