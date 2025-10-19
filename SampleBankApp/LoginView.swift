//
//  LoginView.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var bankState: BankAppState
    @State private var pin = ""
    @State private var showWelcomeAnimation = false
    
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
                        // Top utility buttons - right side only
                        HStack {
                            Spacer()
                            
                            HStack(spacing: 16) {
                                Button(action: {}) {
                                    Image(systemName: "location")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .accessibilityIdentifier("login.location.button")
                                .accessibilityLabel("Find SampleBank locations")
                                .accessibilityHint("Tap to find nearby SampleBank branches and ATMs")
                                
                                Button(action: {}) {
                                    Image(systemName: "phone")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .accessibilityIdentifier("login.contact.button")
                                .accessibilityLabel("Contact SampleBank")
                                .accessibilityHint("Tap to contact SampleBank customer service")
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        
                        // App branding section
                        VStack(spacing: 16) {
                            // Logo and welcome
                            VStack(spacing: 8) {
                                Text("SampleBank")
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .scaleEffect(showWelcomeAnimation ? 1.0 : 0.95)
                                    .animation(.spring(response: 0.6, dampingFraction: 0.8), value: showWelcomeAnimation)
                                
                                Text("Welcome back")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                                    .opacity(showWelcomeAnimation ? 1.0 : 0.0)
                                    .animation(.easeInOut(duration: 0.8).delay(0.3), value: showWelcomeAnimation)
                            }
                            .padding(.top, 40)
                            
                            // PIN Entry Section
                            VStack(spacing: 24) {
                                VStack(spacing: 16) {
                                    // PIN dots
                                    HStack(spacing: 16) {
                                        ForEach(0..<Constants.Validation.pinLength, id: \.self) { index in
                                            Circle()
                                                .fill(index < pin.count ? Color.white : Color.white.opacity(0.3))
                                                .frame(width: 12, height: 12)
                                                .scaleEffect(index < pin.count ? 1.2 : 1.0)
                                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: pin.count)
                                        }
                                    }
                                    
                                    Text("Enter your PIN")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.white.opacity(0.9))
                                }
                                
                                // Keypad
                                VStack(spacing: 24) {
                                    // Rows 1-3: Numbers 1-9
                                    ForEach(0..<3) { row in
                                        HStack(spacing: 0) {
                                            ForEach(1...3, id: \.self) { col in
                                                let number = row * 3 + col
                                                KeypadButton(number: "\(number)") {
                                                    addDigit("\(number)")
                                                }
                                                .frame(maxWidth: .infinity)
                                            }
                                        }
                                    }
                                    
                                    // Bottom row: Forgot, 0, Empty
                                    HStack(spacing: 0) {
                                        Button("Forgot PIN?") {
                                            // Handle forgot PIN
                                        }
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white.opacity(0.7))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 60)
                                        
                                        KeypadButton(number: "0") {
                                            addDigit("0")
                                        }
                                        .frame(maxWidth: .infinity)
                                        
                                        // Empty space for symmetry
                                        Spacer()
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                .padding(.horizontal, 40)
                            }
                            
                            Spacer()
                            
                            // Bottom spacing
                            Spacer()
                                .frame(height: 40)
                        }
                    }
                }
            }
        }
        .onAppear {
            showWelcomeAnimation = true
        }
        .onChange(of: pin) { _, newValue in
            if newValue.count == Constants.Validation.pinLength {
                let success = bankState.login(pin: newValue)
                if !success {
                    pin = ""
                }
            }
        }
    }
    
    private func addDigit(_ digit: String) {
        if pin.count < Constants.Validation.pinLength {
            pin += digit
        }
    }
}

struct KeypadButton: View {
    let number: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(number)
                .font(.system(size: 28, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
        }
        .accessibilityIdentifier("login.keypad.button.\(number)")
        .accessibilityLabel("Number \(number)")
        .accessibilityHint("Tap to enter digit \(number)")
    }
}

#Preview {
    LoginView()
        .environmentObject(BankAppState())
}