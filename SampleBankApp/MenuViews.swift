//
//  MenuViews.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI

// MARK: - IRD Payment View
struct IRDPaymentView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                    
                    Text("Pay IRD")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Pay your taxes directly to Inland Revenue Department")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("This feature is coming soon!")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Pay IRD")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

// MARK: - International View
struct InternationalView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "globe")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                    
                    Text("International")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Send money internationally with competitive exchange rates")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("This feature is coming soon!")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("International")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

// MARK: - Mobile Top Up View
struct MobileTopUpView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "iphone")
                        .font(.system(size: 80))
                        .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                    
                    Text("Top up prepay mobile")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Top up your prepaid mobile phone directly from your account")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("This feature is coming soon!")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Mobile Top Up")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

// MARK: - Upcoming Payments View
struct UpcomingPaymentsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "calendar")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    
                    Text("Upcoming payments")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("View and manage your scheduled payments")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("This feature is coming soon!")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Upcoming Payments")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

// MARK: - Payees View
struct PayeesView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bankState: BankAppState
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "person.2")
                        .font(.system(size: 80))
                        .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                    
                    Text("Payees")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Manage your saved payees")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // Show existing payees
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your Payees:")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        ForEach(bankState.payees) { payee in
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(Color.orange.opacity(0.8))
                                        .frame(width: 40, height: 40)
                                    
                                    Text(payee.initials)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(payee.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(payee.accountNumber)
                                        .font(.caption)
                                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Payees")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

// MARK: - Cards View
struct CardsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "creditcard")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                    
                    Text("Cards")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Manage your debit and credit cards")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("This feature is coming soon!")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Cards")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

// MARK: - Documents View
struct DocumentsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "doc.text")
                        .font(.system(size: 80))
                        .foregroundColor(.orange)
                    
                    Text("Documents")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Access your bank statements and documents")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("This feature is coming soon!")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Documents")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

// MARK: - Apply Now View
struct ApplyNowView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "plus")
                        .font(.system(size: 80))
                        .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                    
                    Text("Apply now")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Apply for new banking products and services")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("This feature is coming soon!")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Apply Now")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

// MARK: - Settings View
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "gear")
                        .font(.system(size: 80))
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                    
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Manage your app preferences and security settings")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("This feature is coming soon!")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Settings")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

// MARK: - Contact View
struct ContactView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 80))
                        .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                    
                    Text("Contact")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Get in touch with our customer support team")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "phone")
                                .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                            Text("0800 275 269")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                            Text("support@samplebank.app")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(Color(red: 0.13, green: 0.48, blue: 1.0)) // Bright blue
                            Text("24/7 Support Available")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Contact")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

// MARK: - Locator View
struct LocatorView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.04, green: 0.10, blue: 0.18) // #0A192F
                    .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    Image(systemName: "location")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    
                    Text("Locator")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Find SampleBank branches and ATMs near you")
                        .font(.body)
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63)) // Medium gray
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("This feature is coming soon!")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Locator")
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
                    .accessibilityIdentifier("menu.close.button")
                }
            }
        }
    }
}

#Preview {
    VStack {
        IRDPaymentView()
    }
}