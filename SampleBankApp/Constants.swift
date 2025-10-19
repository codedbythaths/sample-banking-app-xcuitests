//
//  Constants.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import Foundation

struct Constants {
    // MARK: - Account Numbers
    struct AccountNumbers {
        static let rapidSave = "02-1244-0267945-001"
        static let youMoney = "02-1244-0267945-000"
        static let samplePayee = "02-1234-5678901-002"
    }
    
    // MARK: - Animation Durations
    struct Animation {
        static let menuSlide = 0.3
        static let bannerDismiss = 2.0
        static let payeeValidationDelay = 1.0
    }
    
    // MARK: - Validation
    struct Validation {
        static let pinLength = 5
        static let minPaymentAmount = 0.01
        static let maxPaymentAmount = 100000.00
    }
    
    // MARK: - Security
    struct Security {
        static let maxPinAttempts = 5
        static let pinAttemptWindow: TimeInterval = 300 // 5 minutes
        static let sessionTimeout: TimeInterval = 1800 // 30 minutes
    }
    
    // MARK: - Error Messages
    struct ErrorMessages {
        static let invalidPaymentDetails = "Invalid payment details"
        static let invalidTransferDetails = "Invalid transfer details"
        static let insufficientFunds = "Insufficient funds"
        static let sameAccountTransfer = "Cannot transfer to the same account"
        static let invalidPinLength = "PIN must be 5 digits"
        static let emptyPin = "PIN cannot be empty"
        static let nonNumericPin = "PIN must contain only numbers"
        static let noSourceAccount = "Please select a source account"
        static let noDestinationAccount = "Please select a destination account"
        static let noPayeeSelected = "Please select a payee"
        static let invalidAmount = "Please enter a valid amount"
        static let emptyPayeeName = "Payee name cannot be empty"
        static let emptyAccountNumber = "Account number cannot be empty"
        static let payeeNameTooShort = "Payee name must be at least 2 characters"
        static let accountNumberTooShort = "Account number must be at least 8 characters"
        static let payeeAlreadyExists = "Payee with this name or account number already exists"
    }
    
    // MARK: - Timeouts
    struct Timeouts {
        static let errorBannerDismiss = 3.0
        static let successBannerDismiss = 2.0
    }
    
}
