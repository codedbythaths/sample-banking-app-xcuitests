//
//  Components.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI

// MARK: - Account Row
struct AccountRow: View {
    let account: Account
    @EnvironmentObject var bankState: BankAppState
    @State private var showAccountActivity = false
    
    var body: some View {
        Button(action: {
            showAccountActivity = true
        }) {
            HStack(spacing: 16) {
                // Account Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(red: 0.36, green: 0.75, blue: 0.87)) // Light blue background
                        .frame(width: 50, height: 50)
                        
                        if account.name == "Rapid Save" {
                            // Orange padlock icon
                            Image(systemName: "lock.fill")
                                .font(.title2)
                                .foregroundColor(Color(red: 0.78, green: 0.49, blue: 0.24)) // Rusty orange
                        } else {
                            // Banknote icon
                            Image(systemName: "banknote.fill")
                                .font(.title2)
                                .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                        }
                    }
                
                // Account Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(account.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    // Progress Bar for Rapid Save
                    if account.name == "Rapid Save" && account.progress > 0 {
                        ProgressView(value: account.progress)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 0.20, green: 0.78, blue: 0.35))) // Bright green
                            .frame(height: 4)
                    }
                }
                
                Spacer()
                
                // Balance
                Text(CurrencyFormatter().format(account.balance))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(16)
            .background(Color(red: 0.10, green: 0.17, blue: 0.25).opacity(0.3)) // Slightly lighter dark blue
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityIdentifier("account.row.\(account.name.lowercased().replacingOccurrences(of: " ", with: "."))")
        .accessibilityLabel("\(account.name) account")
        .accessibilityValue("Balance: \(CurrencyFormatter().format(account.balance))")
        .accessibilityHint("Tap to view account details and transactions")
        .sheet(isPresented: $showAccountActivity) {
            AccountActivityView(account: account)
        }
    }
}

// MARK: - Account Activity View
struct AccountActivityView: View {
    let account: Account
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bankState: BankAppState
    
    var body: some View {
            NavigationView {
                ZStack {
                    Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                        .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Account Header
                    VStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.blue.opacity(0.2))
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: account.icon)
                                .font(.system(size: 32))
                                .foregroundColor(.blue)
                        }
                        
                        Text(account.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(CurrencyFormatter().format(account.balance))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    
                    // Activity List
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(bankState.activities.filter { activity in
                                activity.fromAccount == account.name || activity.toAccount == account.name
                            }) { activity in
                                ActivityRowView(activity: activity)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Account Activity")
            #if canImport(UIKit)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(red: 0.04, green: 0.10, blue: 0.18), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 0.29, green: 0.64, blue: 0.89)) // Light blue
                    .accessibilityIdentifier("account.activity.close.button")
                }
            }
        }
    }
}

// MARK: - Activity Row View
struct ActivityRowView: View {
    let activity: Activity
    
    var body: some View {
        HStack(spacing: 16) {
            // Activity Icon
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(iconColor)
                .frame(width: 40, height: 40)
                .background(iconColor.opacity(0.1))
                .clipShape(Circle())
            
            // Activity Details
            VStack(alignment: .leading, spacing: 4) {
                Text(activity.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(activity.description)
                    .font(.body)
                    .foregroundColor(.gray)
                
                Text(activity.date, style: .relative)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Amount and Status
            VStack(alignment: .trailing, spacing: 4) {
                if let amount = activity.amount {
                    Text(CurrencyFormatter().format(amount))
                        .font(.headline)
                        .foregroundColor(amountColor)
                }
                
                Text(activity.status.rawValue.capitalized)
                    .font(.caption)
                    .foregroundColor(statusColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
        .accessibilityIdentifier("activity.row.\(activityTypeString).\(activity.id)")
        .accessibilityLabel("\(activity.title): \(activity.description)")
        .accessibilityValue(activity.amount != nil ? "Amount: \(CurrencyFormatter().format(activity.amount ?? 0))" : "")
        .accessibilityHint("Activity from \(activity.date, style: .relative)")
    }
    
    private var activityTypeString: String {
        switch activity.type {
        case .payment: return "payment"
        case .transfer: return "transfer"
        case .payeeAdded: return "payeeAdded"
        case .payeeUpdated: return "payeeUpdated"
        case .login: return "login"
        case .logout: return "logout"
        }
    }
    
    private var iconName: String {
        switch activity.type {
        case .payment: return "arrow.up.right.circle.fill"
        case .transfer: return "arrow.left.arrow.right.circle.fill"
        case .payeeAdded: return "person.badge.plus.fill"
        case .payeeUpdated: return "person.crop.circle.badge.checkmark.fill"
        case .login: return "lock.open.fill"
        case .logout: return "lock.fill"
        }
    }
    
    private var iconColor: Color {
        switch activity.type {
        case .payment: return .red
        case .transfer: return .blue
        case .payeeAdded: return .green
        case .payeeUpdated: return .orange
        case .login: return .green
        case .logout: return .gray
        }
    }
    
    private var amountColor: Color {
        switch activity.type {
        case .payment: return .red
        case .transfer: return .blue
        default: return .white
        }
    }
    
    private var statusColor: Color {
        switch activity.status {
        case .completed: return .green
        case .pending: return .orange
        case .failed: return .red
        }
    }
}

// MARK: - Success Banner
struct SuccessBanner: View {
    let message: String
    @Binding var isShowing: Bool
    let accessibilityIdentifier: String
    
    var body: some View {
        if isShowing {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                
                Text(message)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
            .transition(.move(edge: .top).combined(with: .opacity))
            .accessibilityIdentifier(accessibilityIdentifier)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isShowing = false
                    }
                }
            }
        }
    }
}