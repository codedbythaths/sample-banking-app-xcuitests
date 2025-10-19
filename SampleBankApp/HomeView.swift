//
//  HomeView.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var bankState: BankAppState
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Professional banking background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.04, green: 0.10, blue: 0.18),
                        Color(red: 0.08, green: 0.15, blue: 0.25)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header Section
                    VStack(spacing: 0) {
                        // Top Navigation Bar
                        HStack(alignment: .center) {
                            // Menu Button
                            Button(action: { bankState.showMenu.toggle() }) {
                                Image(systemName: "line.horizontal.3")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(Circle())
                            }
                            .accessibilityIdentifier("home.menu.button")
                            .accessibilityLabel("Menu")
                            .accessibilityHint("Tap to open the main menu")
                            
                            Spacer()
                            
                            // App Title
                            Text("SampleBank")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            // Right Actions
                            HStack(spacing: 12) {
                                Button(action: {}) {
                                    Image(systemName: "bell")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)
                                        .frame(width: 44, height: 44)
                                        .background(Color.white.opacity(0.1))
                                        .clipShape(Circle())
                                }
                                .accessibilityIdentifier("home.notifications.button")
                                .accessibilityLabel("Notifications")
                                .accessibilityHint("Tap to view notifications")
                                
                                Button(action: {}) {
                                    Image(systemName: "ellipsis")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)
                                        .frame(width: 44, height: 44)
                                        .background(Color.white.opacity(0.1))
                                        .clipShape(Circle())
                                }
                                .accessibilityIdentifier("home.more.button")
                                .accessibilityLabel("More options")
                                .accessibilityHint("Tap to view more options")
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                        
                        // Tab Navigation
                        HStack(spacing: 0) {
                            TabButton(title: "Accounts", isSelected: bankState.selectedTab == 0) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    bankState.selectedTab = 0
                                }
                            }
                            .accessibilityIdentifier("home.accounts.tab")
                            .accessibilityLabel("Accounts tab")
                            .accessibilityValue(bankState.selectedTab == 0 ? "Selected" : "Not selected")
                            .accessibilityHint("Tap to view your accounts")
                            
                            TabButton(title: "Activity", isSelected: bankState.selectedTab == 1) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    bankState.selectedTab = 1
                                }
                            }
                            .accessibilityIdentifier("home.activity.tab")
                            .accessibilityLabel("Activity tab")
                            .accessibilityValue(bankState.selectedTab == 1 ? "Selected" : "Not selected")
                            .accessibilityHint("Tap to view your transaction history")
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                    
                    // Main Content Area
                    VStack(spacing: 0) {
                        if bankState.selectedTab == 0 {
                            AccountsTabView()
                        } else {
                            ActivityTabView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                // Success Banner
                VStack {
                    SuccessBanner(message: "Payment is success", isShowing: $bankState.showSuccessBanner, accessibilityIdentifier: "payment.confirmation.success")
                    SuccessBanner(message: "Transfer is success", isShowing: $bankState.showTransferSuccessBanner, accessibilityIdentifier: "transfer.confirmation.success")
                    Spacer()
                }
            }
        }
        .overlay(
            // Hamburger Menu
            Group {
                if bankState.showMenu {
                    MenuOverlay()
                        .transition(.move(edge: .leading))
                }
            }
        )
        .animation(.easeInOut(duration: 0.3), value: bankState.showMenu)
        .sheet(isPresented: $bankState.showPaymentView) {
            PaymentView()
        }
        .sheet(isPresented: $bankState.showTransferView) {
            TransferView()
        }
        .sheet(isPresented: $bankState.showEditPayeeSheet) {
            if let selectedPayee = bankState.selectedPayeeForEdit {
                EditPayeeSheet(payee: selectedPayee)
            }
        }
        .sheet(isPresented: $bankState.showIRDPaymentView) {
            IRDPaymentView()
        }
        .sheet(isPresented: $bankState.showInternationalView) {
            InternationalView()
        }
        .sheet(isPresented: $bankState.showMobileTopUpView) {
            MobileTopUpView()
        }
        .sheet(isPresented: $bankState.showUpcomingPaymentsView) {
            UpcomingPaymentsView()
        }
        .sheet(isPresented: $bankState.showPayeesView) {
            PayeesView()
        }
        .sheet(isPresented: $bankState.showCardsView) {
            CardsView()
        }
        .sheet(isPresented: $bankState.showDocumentsView) {
            DocumentsView()
        }
        .sheet(isPresented: $bankState.showApplyNowView) {
            ApplyNowView()
        }
        .sheet(isPresented: $bankState.showSettingsView) {
            SettingsView()
        }
        .sheet(isPresented: $bankState.showContactView) {
            ContactView()
        }
        .sheet(isPresented: $bankState.showLocatorView) {
            LocatorView()
        }
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(isSelected ? .white : Color.white.opacity(0.6))
                
                // Underline indicator
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(isSelected ? Color.white : .clear)
                    .cornerRadius(1)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ? Color.white.opacity(0.1) : Color.clear)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
        )
    }
}

struct AccountsTabView: View {
    @EnvironmentObject var bankState: BankAppState
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Account List
                ForEach(bankState.accounts) { account in
                    AccountRow(account: account)
                }
                
                // Add Account
                Button(action: {}) {
                    HStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.04, green: 0.10, blue: 0.18)) // Dark blue background
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Text("Add Account")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(16)
                    .background(Color(red: 0.10, green: 0.17, blue: 0.25).opacity(0.3)) // Slightly lighter dark blue
                    .cornerRadius(16)
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityIdentifier("home.add.account.button")
                .accessibilityLabel("Add Account")
                .accessibilityHint("Tap to add a new bank account")
                
                // Quick Payees Section
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Quick payees")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                            .accessibilityIdentifier("home.quick.payees.title")
                            .accessibilityLabel("Quick payees section")
                            .accessibilityAddTraits(.isStaticText)
                        
                        Button(action: {}) {
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        }
                        .accessibilityIdentifier("home.quick.payees.expand.button")
                        .accessibilityLabel("Expand quick payees")
                        .accessibilityHint("Tap to expand or collapse quick payees section")
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 20) {
                        // Payment Button
                        VStack(spacing: 8) {
                            Button(action: { bankState.showPaymentView = true }) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.04, green: 0.10, blue: 0.18)) // Dark blue background
                                        .frame(width: 60, height: 60)
                                    
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityIdentifier("home.quick.payment.button")
                            .accessibilityLabel("Make a payment")
                            .accessibilityHint("Tap to make a payment to a payee")
                            
                            Text("Payment")
                                .font(.caption)
                                .foregroundColor(.white)
                                .accessibilityIdentifier("home.quick.payment.label")
                                .accessibilityLabel("Payment label")
                                .accessibilityAddTraits(.isStaticText)
                        }
                        
                        // John Smith Button
                        VStack(spacing: 8) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.94, green: 0.82, blue: 0.75)) // Light peach/orange
                                    .frame(width: 60, height: 60)
                                
                                Text(bankState.payees.first?.initials ?? "TA")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.75, green: 0.38, blue: 0.25)) // Reddish-brown
                            }
                            .onTapGesture {
                                if let payee = bankState.payees.first {
                                    bankState.selectedPayeeForEdit = payee
                                    bankState.showEditPayeeSheet = true
                                }
                            }
                            .accessibilityIdentifier("home.quick.payee.button")
                            .accessibilityLabel("Edit payee \(bankState.payees.first?.name ?? "Payee")")
                            .accessibilityHint("Tap to edit payee details")
                            
                            Text(bankState.payees.first?.name ?? "Payee")
                                .font(.caption)
                                .foregroundColor(.white)
                                .accessibilityIdentifier("home.quick.payee.label")
                                .accessibilityLabel("Payee name label")
                                .accessibilityAddTraits(.isStaticText)
                        }
                    }
                }
                .padding(.top, 32)
            }
            .padding(.horizontal)
        }
    }
}

struct ActivityTabView: View {
    @EnvironmentObject var bankState: BankAppState
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Activity")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                if bankState.activities.isEmpty {
                    // Empty state
                    VStack(spacing: 20) {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No activity yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text("Your recent transactions and activities will appear here")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .padding(.top, 60)
                } else {
                    // Activity list
                    LazyVStack(spacing: 12) {
                        ForEach(bankState.activities) { activity in
                            ActivityRowView(activity: activity)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }
}

struct MenuOverlay: View {
    @EnvironmentObject var bankState: BankAppState
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // Menu Content
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    HStack {
                        Text("06:20")
                            .font(.headline)
                            .foregroundColor(.white)
                            .accessibilityIdentifier("menu.time.text")
                        
                        Image(systemName: "moon.fill")
                            .foregroundColor(.white)
                            .accessibilityIdentifier("menu.moon.icon")
                        
                        Spacer()
                        
                        Button("Logout") {
                            bankState.logout()
                        }
                        .foregroundColor(.white)
                        .font(.headline)
                        .accessibilityIdentifier("menu.logout.button")
                    }
                    .padding()
                    .background(Color(red: 0.04, green: 0.10, blue: 0.18)) // Solid dark blue-black
                    
                    // Menu Items
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(Array(bankState.menuItems.enumerated()), id: \.offset) { index, item in
                                MenuItemRow(title: item.0, icon: item.1) {
                                    handleMenuSelection(item.0)
                                }
                                .accessibilityIdentifier("menu.item.\(index)")
                            }
                        }
                    }
                    .background(Color(red: 0.04, green: 0.10, blue: 0.18)) // Solid dark blue-black
                }
                .frame(width: geometry.size.width * 0.7)
                .background(Color(red: 0.04, green: 0.10, blue: 0.18)) // Solid dark blue-black
                
                // Tap to close area
                Color.black.opacity(0.5)
                    .onTapGesture {
                        bankState.showMenu = false
                    }
                    .accessibilityIdentifier("menu.close.area")
            }
            .background(Color.black.opacity(0.7))
        }
    }
    
    private func handleMenuSelection(_ item: String) {
        switch item {
        case "Home":
            break
        case "Make a payment":
            bankState.showPaymentView = true
        case "Transfer money":
            bankState.showTransferView = true
        case "Pay IRD":
            bankState.showIRDPaymentView = true
        case "International":
            bankState.showInternationalView = true
        case "Top up prepay mobile":
            bankState.showMobileTopUpView = true
        case "Upcoming payments":
            bankState.showUpcomingPaymentsView = true
        case "Payees":
            bankState.showPayeesView = true
        case "Cards":
            bankState.showCardsView = true
        case "Documents":
            bankState.showDocumentsView = true
        case "Apply now":
            bankState.showApplyNowView = true
        case "Settings":
            bankState.showSettingsView = true
        case "Contact":
            bankState.showContactView = true
        case "Locator":
            bankState.showLocatorView = true
        case "Logout":
            bankState.logout()
        default:
            break
        }
        bankState.showMenu = false
    }
}

struct MenuItemRow: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 24)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    HomeView()
        .environmentObject(BankAppState())
}