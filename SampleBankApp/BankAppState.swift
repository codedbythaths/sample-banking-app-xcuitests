//
//  BankAppState.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI
import Foundation
import Combine

// MARK: - Data Models
struct Account: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var balance: Double
    let progress: Double // 0.0 to 1.0 for progress bar
    let icon: String
    let accountNumber: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Payee: Identifiable, Equatable, Hashable {
    let id = UUID()
    var name: String
    var accountNumber: String
    var initials: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Payee, rhs: Payee) -> Bool {
        return lhs.id == rhs.id
    }
}

struct StatementDetails {
    var theirParticulars: String = ""
    var theirCode: String = ""
    var theirReference: String = ""
    var yourParticulars: String = ""
    var yourCode: String = ""
    var yourReference: String = ""
}

struct Payment {
    var fromAccount: Account?
    var toPayee: Payee?
    var toAccount: Account? // For transfers between own accounts
    var amount: String = "0.00"
    var date: Date = Date()
    var frequency: String = "One-off"
    var statementDetails: StatementDetails = StatementDetails()
}

struct Activity: Identifiable {
    let id = UUID()
    let type: ActivityType
    let title: String
    let description: String
    let amount: Double?
    let date: Date
    let status: ActivityStatus
    let fromAccount: String?
    let toAccount: String?
    
    enum ActivityType {
        case payment
        case transfer
        case payeeAdded
        case payeeUpdated
        case login
        case logout
    }
    
    enum ActivityStatus: String {
        case completed = "completed"
        case pending = "pending"
        case failed = "failed"
    }
}

// MARK: - BankAppState
class BankAppState: ObservableObject {
    @Published var isLoggedIn = false // Start as logged out - require PIN authentication
    @Published var currentPayment = Payment()
    @Published var showNewPayeeSheet = false
    @Published var showSuccessBanner = false
    @Published var showTransferSuccessBanner = false
    @Published var showMenu = false
    @Published var errorMessage: String?
    @Published var showErrorBanner = false
    @Published var showIRDPaymentView = false
    @Published var showInternationalView = false
    @Published var showMobileTopUpView = false
    @Published var showUpcomingPaymentsView = false
    @Published var showPayeesView = false
    @Published var showCardsView = false
    @Published var showDocumentsView = false
    @Published var showApplyNowView = false
    @Published var showSettingsView = false
    @Published var showContactView = false
    @Published var showLocatorView = false
    @Published var selectedTab = 0
    @Published var showPaymentView = false
    @Published var showTransferView = false
    @Published var showEditPayeeSheet = false
    @Published var selectedPayeeForEdit: Payee?
    
    // Mock data - accounts with initial money for testing
    @Published var accounts = [
        Account(name: "Rapid Save", balance: 5000.00, progress: 0.3, icon: "lock.fill", accountNumber: Constants.AccountNumbers.rapidSave),
        Account(name: "YouMoney", balance: 7500.00, progress: 0.0, icon: "banknote.fill", accountNumber: Constants.AccountNumbers.youMoney)
    ]
    
    @Published var payees = [
        Payee(name: "John Smith", accountNumber: Constants.AccountNumbers.samplePayee, initials: "JS")
    ]
    
    // Activity history
    @Published var activities: [Activity] = [
        Activity(type: .login, title: "Login", description: "Successful login", amount: nil, date: Date().addingTimeInterval(-3600 * 24 * 2), status: .completed, fromAccount: nil, toAccount: nil),
        Activity(type: .payment, title: "Payment to John Doe", description: "Electricity Bill", amount: -120.50, date: Date().addingTimeInterval(-3600 * 24), status: .completed, fromAccount: "YouMoney", toAccount: "John Doe"),
        Activity(type: .transfer, title: "Transfer to Rapid Save", description: "Savings", amount: -200.00, date: Date().addingTimeInterval(-3600 * 12), status: .completed, fromAccount: "YouMoney", toAccount: "Rapid Save"),
        Activity(type: .payeeAdded, title: "New Payee Added", description: "Sample Payee", amount: nil, date: Date().addingTimeInterval(-3600 * 6), status: .completed, fromAccount: nil, toAccount: nil)
    ]
    
    // Security tracking
    private var pinAttempts: [Date] = []
    
    var quickPayees: [Payee] {
        return payees
    }
    
    let menuItems = [
        ("Home", "house.fill"),
        ("Transfer money", "arrow.triangle.2.circlepath"),
        ("Make a payment", "dollarsign.circle"),
        ("Pay IRD", "person.circle"),
        ("International", "globe"),
        ("Top up prepay mobile", "iphone"),
        ("Upcoming payments", "calendar"),
        ("Payees", "person.2"),
        ("Cards", "creditcard"),
        ("Documents", "doc.text"),
        ("Apply now", "plus"),
        ("Settings", "gear"),
        ("Contact", "bubble.left"),
        ("Locator", "location"),
        ("Logout", "rectangle.portrait.and.arrow.right")
    ]
    
    init() {
        // Set default account for payments and transfers
        currentPayment.fromAccount = accounts.first
    }
    
    func login(pin: String) -> Bool {
        // Check rate limiting first
        guard !isRateLimited() else {
            Logger.shared.security("Login blocked due to rate limiting - \(pinAttempts.count) attempts in last 5 minutes")
            return false
        }
        
        // Record this attempt
        pinAttempts.append(Date())
        
        // In production, this should validate against secure storage
        // For demo purposes, accept any 5-digit PIN but log the attempt
        guard !pin.isEmpty else {
            Logger.shared.warning("Empty PIN attempt")
            return false
        }
        
        guard pin.count == Constants.Validation.pinLength else {
            Logger.shared.security("Invalid PIN length attempted: \(pin.count) digits")
            return false
        }
        
        guard pin.allSatisfy({ $0.isNumber }) else {
            Logger.shared.security("Non-numeric PIN characters attempted")
            return false
        }
        
        // NOTE: In production, implement proper PIN validation with secure storage (Keychain)
        // NOTE: Add biometric authentication (Touch ID/Face ID) for enhanced security
        // NOTE: Log security events for monitoring and fraud detection
        
        // Clear failed attempts on successful login
        pinAttempts.removeAll()
        
        isLoggedIn = true
        // Set default account for payment
        currentPayment.fromAccount = accounts.first
        
        // Track login activity
        trackLogin()
        
        Logger.shared.info("User logged in successfully (demo mode)")
        return true
    }
    
    private func isRateLimited() -> Bool {
        let now = Date()
        // Remove attempts older than the window
        pinAttempts = pinAttempts.filter { now.timeIntervalSince($0) < Constants.Security.pinAttemptWindow }
        
        // Check if we've exceeded the limit
        return pinAttempts.count >= Constants.Security.maxPinAttempts
    }
    
    func logout() {
        // Track logout activity before clearing data
        trackLogout()
        
        // Actually log out the user
        isLoggedIn = false
        showMenu = false

        // Clear sensitive data
        currentPayment = Payment()
        showSuccessBanner = false
        showTransferSuccessBanner = false
        showErrorBanner = false
        errorMessage = nil

        Logger.shared.info("User logged out successfully")
    }
    
    func updatePayee(_ payee: Payee) {
        if let index = payees.firstIndex(where: { $0.id == payee.id }) {
            payees[index] = payee
            trackPayeeUpdated(payee)
            Logger.shared.info("Updated payee: \(payee.name)")
        }
    }
    
    func makePayment() -> Bool {
        guard let fromAccount = currentPayment.fromAccount else {
            errorMessage = Constants.ErrorMessages.noSourceAccount
            showErrorBanner = true
            Logger.shared.error("Payment failed: No source account selected")
            return false
        }
        
        guard let toPayee = currentPayment.toPayee else {
            errorMessage = Constants.ErrorMessages.noPayeeSelected
            showErrorBanner = true
            Logger.shared.error("Payment failed: No payee selected")
            return false
        }
        
        guard !currentPayment.amount.isEmpty,
              let amount = Double(currentPayment.amount),
              amount > 0 else {
            errorMessage = Constants.ErrorMessages.invalidAmount
            showErrorBanner = true
            Logger.shared.error("Payment failed: Invalid amount")
            return false
        }
        
        // Check if account has sufficient funds
        guard fromAccount.balance >= amount else {
            errorMessage = Constants.ErrorMessages.insufficientFunds
            showErrorBanner = true
            Logger.shared.error("Insufficient funds for payment")
            return false
        }
        
        // Update account balance
        if let accountIndex = accounts.firstIndex(where: { $0.id == fromAccount.id }) {
            let currentAccount = accounts[accountIndex]
            let updatedAccount = Account(
                name: currentAccount.name,
                balance: currentAccount.balance - amount,
                progress: currentAccount.progress,
                icon: currentAccount.icon,
                accountNumber: currentAccount.accountNumber
            )
            
            // Update the published property to trigger UI refresh
            accounts[accountIndex] = updatedAccount
        }
        
        // Track payment activity
        trackPayment(fromAccount: fromAccount.name, toPayee: toPayee.name, amount: amount)
        
        // Show success banner
        showSuccessBanner = true
        
        // Clear payment form
        currentPayment = Payment()
        currentPayment.fromAccount = accounts.first
        
        // Force UI refresh by triggering a small delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            // This ensures the UI updates with the new balances
            self?.objectWillChange.send()
        }
        
        Logger.shared.info("Payment successful: $\(amount) from \(fromAccount.name) to \(toPayee.name)")
        return true
    }
    
    func transferMoney() -> Bool {
        guard let fromAccount = currentPayment.fromAccount else {
            errorMessage = Constants.ErrorMessages.noSourceAccount
            showErrorBanner = true
            Logger.shared.error("Transfer failed: No source account selected")
            return false
        }
        
        guard let toAccount = currentPayment.toAccount else {
            errorMessage = Constants.ErrorMessages.noDestinationAccount
            showErrorBanner = true
            Logger.shared.error("Transfer failed: No destination account selected")
            return false
        }
        
        guard !currentPayment.amount.isEmpty,
              let amount = Double(currentPayment.amount),
              amount > 0 else {
            errorMessage = Constants.ErrorMessages.invalidAmount
            showErrorBanner = true
            Logger.shared.error("Transfer failed: Invalid amount")
            return false
        }
        
        // Check if transferring to same account
        guard fromAccount.id != toAccount.id else {
            errorMessage = Constants.ErrorMessages.sameAccountTransfer
            showErrorBanner = true
            Logger.shared.error("Attempted transfer to same account")
            return false
        }
        
        // Check if account has sufficient funds
        guard fromAccount.balance >= amount else {
            errorMessage = Constants.ErrorMessages.insufficientFunds
            showErrorBanner = true
            Logger.shared.error("Insufficient funds for transfer")
            return false
        }
        
        // Update account balances
        if let fromIndex = accounts.firstIndex(where: { $0.id == fromAccount.id }),
           let toIndex = accounts.firstIndex(where: { $0.id == toAccount.id }) {
            let fromBalanceBefore = accounts[fromIndex].balance
            let toBalanceBefore = accounts[toIndex].balance
            
            let fromAccount = accounts[fromIndex]
            let toAccount = accounts[toIndex]
            
            // Create updated account objects
            let updatedFromAccount = Account(
                name: fromAccount.name,
                balance: fromAccount.balance - amount,
                progress: fromAccount.progress,
                icon: fromAccount.icon,
                accountNumber: fromAccount.accountNumber
            )
            let updatedToAccount = Account(
                name: toAccount.name,
                balance: toAccount.balance + amount,
                progress: toAccount.progress,
                icon: toAccount.icon,
                accountNumber: toAccount.accountNumber
            )
            
            // Update the published property to trigger UI refresh
            accounts[fromIndex] = updatedFromAccount
            accounts[toIndex] = updatedToAccount
            
            Logger.shared.info("Transfer balance update: \(fromAccount.name) \(fromBalanceBefore) -> \(updatedFromAccount.balance), \(toAccount.name) \(toBalanceBefore) -> \(updatedToAccount.balance)")
        }
        
        // Track transfer activity
        trackTransfer(fromAccount: fromAccount.name, toAccount: toAccount.name, amount: amount)
        
        // Show success banner
        showTransferSuccessBanner = true
        
        // Clear transfer form
        currentPayment = Payment()
        currentPayment.fromAccount = accounts.first
        
        // Force UI refresh by triggering a small delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            // This ensures the UI updates with the new balances
            self?.objectWillChange.send()
        }
        
        Logger.shared.info("Transfer successful: $\(amount) from \(fromAccount.name) to \(toAccount.name)")
        return true
    }
    
    func validateNewPayee(name: String, accountNumber: String) -> (isValid: Bool, errorMessage: String?) {
        // Basic validation
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAccountNumber = accountNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else {
            return (false, Constants.ErrorMessages.emptyPayeeName)
        }
        
        guard !trimmedAccountNumber.isEmpty else {
            return (false, Constants.ErrorMessages.emptyAccountNumber)
        }
        
        guard trimmedName.count >= 2 else {
            return (false, Constants.ErrorMessages.payeeNameTooShort)
        }
        
        guard trimmedAccountNumber.count >= 8 else {
            return (false, Constants.ErrorMessages.accountNumberTooShort)
        }
        
        // Check if payee already exists
        let existingPayee = payees.first { 
            $0.name.lowercased() == trimmedName.lowercased() || $0.accountNumber == trimmedAccountNumber 
        }
        
        if let existing = existingPayee {
            return (false, "Payee with name '\(existing.name)' or account number already exists")
        }
        
        return (true, nil)
    }
    
    func addNewPayee(name: String, accountNumber: String) -> Payee {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAccountNumber = accountNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let initials = String(trimmedName.prefix(2)).uppercased()
        let newPayee = Payee(name: trimmedName, accountNumber: trimmedAccountNumber, initials: initials)
        payees.append(newPayee)
        
        // Track payee addition activity
        trackPayeeAdded(newPayee)
        
        Logger.shared.info("Added new payee: \(trimmedName) with account: \(trimmedAccountNumber)")
        return newPayee
    }
    
    // MARK: - Activity Tracking
    private func trackLogin() {
        let activity = Activity(
            type: .login,
            title: "Login",
            description: "User logged in successfully",
            amount: nil,
            date: Date(),
            status: .completed,
            fromAccount: nil,
            toAccount: nil
        )
        activities.insert(activity, at: 0)
    }
    
    private func trackLogout() {
        let activity = Activity(
            type: .logout,
            title: "Logout",
            description: "User logged out",
            amount: nil,
            date: Date(),
            status: .completed,
            fromAccount: nil,
            toAccount: nil
        )
        activities.insert(activity, at: 0)
    }
    
    private func trackPayment(fromAccount: String, toPayee: String, amount: Double) {
        let activity = Activity(
            type: .payment,
            title: "Payment",
            description: "Payment to \(toPayee)",
            amount: amount,
            date: Date(),
            status: .completed,
            fromAccount: fromAccount,
            toAccount: toPayee
        )
        activities.insert(activity, at: 0)
    }
    
    private func trackTransfer(fromAccount: String, toAccount: String, amount: Double) {
        let activity = Activity(
            type: .transfer,
            title: "Transfer",
            description: "Transfer to \(toAccount)",
            amount: amount,
            date: Date(),
            status: .completed,
            fromAccount: fromAccount,
            toAccount: toAccount
        )
        activities.insert(activity, at: 0)
    }
    
    private func trackPayeeAdded(_ payee: Payee) {
        let activity = Activity(
            type: .payeeAdded,
            title: "Payee Added",
            description: "Added \(payee.name) as payee",
            amount: nil,
            date: Date(),
            status: .completed,
            fromAccount: nil,
            toAccount: nil
        )
        activities.insert(activity, at: 0)
    }
    
    private func trackPayeeUpdated(_ payee: Payee) {
        let activity = Activity(
            type: .payeeUpdated,
            title: "Payee Updated",
            description: "Updated \(payee.name) details",
            amount: nil,
            date: Date(),
            status: .completed,
            fromAccount: nil,
            toAccount: nil
        )
        activities.insert(activity, at: 0)
    }
}
