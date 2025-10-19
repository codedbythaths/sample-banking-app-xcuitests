//
//  TransferView.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI

struct TransferView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bankState: BankAppState
    @State private var amount = "0.00"
    @State private var selectedFromAccount: Account?
    @State private var selectedToAccount: Account?
    @State private var showFromAccountSelection = false
    @State private var showToAccountSelection = false
    @State private var date = "Today"
    @State private var frequency = "One-off"
    @State private var showStatementDetails = false
    @State private var showConfirmTransfer = false
    @State private var showAmountError = false
    @State private var amountErrorMessage = ""
    @State private var showDatePicker = false
    @State private var showFrequencyPicker = false
    @State private var showStatementDetailsSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // From and To sections
                    HStack(spacing: 16) {
                        // From Account
                        VStack(alignment: .leading, spacing: 8) {
                            Text("From")
                                .font(.headline)
                                .foregroundColor(.white)
                                .accessibilityIdentifier("transfer.from.label")
                            
                            Button(action: { showFromAccountSelection = true }) {
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
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(red: 0.13, green: 0.48, blue: 1.0), lineWidth: 2) // Bright blue
                                    )
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
                            .accessibilityIdentifier("transfer.from.account.button")
                        }
                        
                        // To Account
                        VStack(alignment: .leading, spacing: 8) {
                            Text("To")
                                .font(.headline)
                                .foregroundColor(.white)
                                .accessibilityIdentifier("transfer.to.label")
                            
                            Button(action: { showToAccountSelection = true }) {
                                if let account = selectedToAccount {
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
                            .accessibilityIdentifier("transfer.to.account.button")
                        }
                    }
                    
                    // Amount input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Amount")
                            .font(.headline)
                            .foregroundColor(.white)
                            .accessibilityIdentifier("transfer.amount.label")
                        
                        HStack {
                            TextField("0.00", text: $amount)
                                .font(.title2)
                                .foregroundColor(.white)
                                .accentColor(.white) // Set accent color for cursor/selection
                                .accessibilityIdentifier("transfer.amount.textfield")
                            
                            if !amount.isEmpty && amount != "0.00" {
                                Button(action: { amount = "0.00" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .accessibilityIdentifier("transfer.amount.clear.button")
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
                        
                        Button(action: { showDatePicker = true }) {
                            HStack {
                                Text(date)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom, 8)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray),
                                alignment: .bottom
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .accessibilityIdentifier("transfer.date.field")
                    }
                    
                    // Frequency input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Frequency")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Button(action: { showFrequencyPicker = true }) {
                            HStack {
                                Text(frequency)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom, 8)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray),
                                alignment: .bottom
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .accessibilityIdentifier("transfer.frequency.field")
                    }
                    
                    // Statement details
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Statement details")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Button(action: { showStatementDetailsSheet = true }) {
                            HStack {
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom, 8)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray),
                                alignment: .bottom
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .accessibilityIdentifier("transfer.statement.details.field")
                    }
                    
                    Spacer()
                    
                    // Transfer button
                    Button(action: {
                        if validateAmount() {
                            showConfirmTransfer = true
                        }
                    }) {
                        Text("Transfer")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                            .cornerRadius(12)
                    }
                    .disabled(amount.isEmpty || amount == "0.00" || selectedFromAccount == nil || selectedToAccount == nil)
                    .accessibilityIdentifier("transfer.transfer.button")
                }
                .padding()
            }
            .navigationTitle("Transfer money")
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
                    .accessibilityIdentifier("transfer.cancel.button")
                }
            }
        }
        .sheet(isPresented: $showFromAccountSelection) {
            AccountSelectionSheet(selectedAccount: $selectedFromAccount, title: "From")
        }
        .sheet(isPresented: $showToAccountSelection) {
            AccountSelectionSheet(selectedAccount: $selectedToAccount, title: "To")
        }
        .sheet(isPresented: $showConfirmTransfer) {
            ConfirmTransferSheet(
                fromAccount: selectedFromAccount,
                toAccount: selectedToAccount,
                amount: amount,
                onConfirm: {
                    // Ensure we have valid accounts and amount
                    guard let fromAccount = selectedFromAccount,
                          let toAccount = selectedToAccount,
                          let amountValue = Double(amount),
                          amountValue > 0 else {
                        Logger.shared.error("Transfer validation failed: fromAccount=\(selectedFromAccount?.name ?? "nil"), toAccount=\(selectedToAccount?.name ?? "nil"), amount=\(amount)")
                        return
                    }
                    
                    bankState.currentPayment.fromAccount = fromAccount
                    bankState.currentPayment.toAccount = toAccount
                    bankState.currentPayment.amount = amount
                    
                    Logger.shared.info("Transfer initiated: \(amount) from \(fromAccount.name) to \(toAccount.name)")
                    
                    if bankState.transferMoney() {
                        dismiss()
                    }
                }
            )
        }
        .sheet(isPresented: $showDatePicker) {
            DatePickerSheet(selectedDate: $date)
        }
        .sheet(isPresented: $showFrequencyPicker) {
            FrequencyPickerSheet(selectedFrequency: $frequency)
        }
        .sheet(isPresented: $showStatementDetailsSheet) {
            StatementDetailsSheet()
        }
        .onAppear {
            if selectedFromAccount == nil {
                selectedFromAccount = bankState.accounts.first
            }
            if selectedToAccount == nil {
                selectedToAccount = bankState.accounts.last
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

// MARK: - Account Selection Sheet
struct AccountSelectionSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bankState: BankAppState
    @Binding var selectedAccount: Account?
    let title: String
    
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
                        
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding()
                    
                    // Account List
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(bankState.accounts) { account in
                                AccountSelectionRow(account: account, isSelected: selectedAccount?.id == account.id) {
                                    selectedAccount = account
                                    dismiss()
                                }
                                .accessibilityIdentifier("account.selection.row.\(account.name.lowercased().replacingOccurrences(of: " ", with: "."))")
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

// MARK: - Account Selection Row
struct AccountSelectionRow: View {
    let account: Account
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Account Icon
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
                
                // Account Details
                VStack(alignment: .leading, spacing: 4) {
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

// MARK: - Confirm Transfer Sheet
struct ConfirmTransferSheet: View {
    @Environment(\.dismiss) private var dismiss
    let fromAccount: Account?
    let toAccount: Account?
    let amount: String
    let onConfirm: () -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Handle
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.gray)
                        .frame(width: 40, height: 4)
                        .padding(.top, 8)
                    
                    // Title
                    Text("Confirm transfer")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Transfer Summary
                    VStack(spacing: 16) {
                        Text("Transfer \(CurrencyFormatter().format(Double(amount) ?? 0)) from \(fromAccount?.name ?? "") to \(toAccount?.name ?? "")")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        // Fee Warning for Rapid Save
                        if fromAccount?.name == "Rapid Save" {
                            HStack(spacing: 8) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("A $3 fee may apply for transfers from this account")
                                        .font(.caption)
                                        .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                                    
                                    Button("Learn more") {
                                        // Handle learn more action
                                    }
                                    .font(.caption)
                                    .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color(red: 0.13, green: 0.48, blue: 1.0).opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    
                    Spacer()
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        Button(action: {
                            onConfirm()
                            dismiss()
                        }) {
                            Text("Confirm")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                                .cornerRadius(12)
                        }
                        .accessibilityIdentifier("transfer.confirm.button")
                        
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(.white)
                        .font(.headline)
                        .accessibilityIdentifier("transfer.confirm.cancel.button")
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Date Picker Sheet
struct DatePickerSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedDate: String
    
    let dateOptions = ["Today", "Tomorrow", "Next Week", "Next Month"]
    
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
                        
                        Text("Select Date")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding()
                    
                    // Date Options
                    VStack(spacing: 16) {
                        ForEach(dateOptions, id: \.self) { option in
                            Button(action: {
                                selectedDate = option
                                dismiss()
                            }) {
                                HStack {
                                    Text(option)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    if selectedDate == option {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                                    }
                                }
                                .padding()
                                .background(Color(red: 0.10, green: 0.17, blue: 0.25).opacity(0.3)) // Slightly lighter dark blue
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityIdentifier("date.picker.option.\(option.lowercased().replacingOccurrences(of: " ", with: "."))")
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Frequency Picker Sheet
struct FrequencyPickerSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedFrequency: String
    
    let frequencyOptions = ["One-off", "Weekly", "Fortnightly", "Monthly", "Quarterly", "Annually"]
    
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
                        
                        Text("Select Frequency")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding()
                    
                    // Frequency Options
                    VStack(spacing: 16) {
                        ForEach(frequencyOptions, id: \.self) { option in
                            Button(action: {
                                selectedFrequency = option
                                dismiss()
                            }) {
                                HStack {
                                    Text(option)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    if selectedFrequency == option {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                                    }
                                }
                                .padding()
                                .background(Color(red: 0.10, green: 0.17, blue: 0.25).opacity(0.3)) // Slightly lighter dark blue
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityIdentifier("frequency.picker.option.\(option.lowercased().replacingOccurrences(of: " ", with: "."))")
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Statement Details Sheet
struct StatementDetailsSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var theirParticulars = ""
    @State private var theirCode = ""
    @State private var theirReference = ""
    @State private var yourParticulars = ""
    @State private var yourCode = ""
    @State private var yourReference = ""
    
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
                        
                        Text("Statement Details")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button("Done") {
                            dismiss()
                        }
                        .foregroundColor(Color(red: 0.29, green: 0.64, blue: 0.89)) // Light blue
                    }
                    .padding()
                    
                    // Statement Details Form
                    ScrollView {
                        VStack(spacing: 30) {
                            // For their statement section
                            VStack(alignment: .leading, spacing: 20) {
                                Text("For their statement")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                // Their Particulars
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Particulars")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    TextField("", text: $theirParticulars)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 8)
                                        .overlay(
                                            Rectangle()
                                                .frame(height: 1)
                                                .foregroundColor(.gray),
                                            alignment: .bottom
                                        )
                                        .accessibilityIdentifier("statement.details.their.particulars.field")
                                }
                                
                                // Their Code
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Code")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    TextField("", text: $theirCode)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 8)
                                        .overlay(
                                            Rectangle()
                                                .frame(height: 1)
                                                .foregroundColor(.gray),
                                            alignment: .bottom
                                        )
                                        .accessibilityIdentifier("statement.details.their.code.field")
                                }
                                
                                // Their Reference
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Reference")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    TextField("", text: $theirReference)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 8)
                                        .overlay(
                                            Rectangle()
                                                .frame(height: 1)
                                                .foregroundColor(.gray),
                                            alignment: .bottom
                                        )
                                        .accessibilityIdentifier("statement.details.their.reference.field")
                                }
                            }
                            
                            // For your statement section
                            VStack(alignment: .leading, spacing: 20) {
                                Text("For your statement")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                // Your Particulars
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Particulars")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    TextField("", text: $yourParticulars)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 8)
                                        .overlay(
                                            Rectangle()
                                                .frame(height: 1)
                                                .foregroundColor(.gray),
                                            alignment: .bottom
                                        )
                                        .accessibilityIdentifier("statement.details.your.particulars.field")
                                }
                                
                                // Your Code
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Code")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    TextField("", text: $yourCode)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 8)
                                        .overlay(
                                            Rectangle()
                                                .frame(height: 1)
                                                .foregroundColor(.gray),
                                            alignment: .bottom
                                        )
                                        .accessibilityIdentifier("statement.details.your.code.field")
                                }
                                
                                // Your Reference
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Reference")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    TextField("", text: $yourReference)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 8)
                                        .overlay(
                                            Rectangle()
                                                .frame(height: 1)
                                                .foregroundColor(.gray),
                                            alignment: .bottom
                                        )
                                        .accessibilityIdentifier("statement.details.your.reference.field")
                                }
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

#Preview {
    TransferView()
        .environmentObject(BankAppState())
}