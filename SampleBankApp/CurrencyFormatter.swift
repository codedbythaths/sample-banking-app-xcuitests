//
//  CurrencyFormatter.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import Foundation

class CurrencyFormatter {
    private let formatter: NumberFormatter
    
    init() {
        formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "NZD"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
    }
    
    func format(_ amount: Double) -> String {
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
    
    func parse(_ string: String) -> Double {
        // Handle empty string
        guard !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return 0.0
        }
        
        // Remove currency symbols and spaces
        let cleaned = string.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
        
        // Handle empty string after cleaning
        guard !cleaned.isEmpty else {
            return 0.0
        }
        
        let amount = Double(cleaned) ?? 0.0
        
        // Validate amount is within reasonable bounds
        guard amount >= 0 && amount <= Constants.Validation.maxPaymentAmount else {
            return 0.0
        }
        
        return amount
    }
    
    func formatInput(_ input: String) -> String {
        // Allow empty input
        if input.isEmpty {
            return ""
        }
        
        // Remove any non-numeric characters except decimal point
        let cleaned = input.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
        
        // Handle multiple decimal points
        let components = cleaned.components(separatedBy: ".")
        let finalText: String
        
        if components.count > 2 {
            finalText = components[0] + "." + components[1...].joined()
        } else {
            finalText = cleaned
        }
        
        // Limit to 2 decimal places
        return limitDecimalPlaces(finalText, maxPlaces: 2)
    }
    
    private func limitDecimalPlaces(_ text: String, maxPlaces: Int) -> String {
        guard let dotIndex = text.firstIndex(of: ".") else {
            return text
        }
        
        let beforeDot = String(text[..<dotIndex])
        let afterDot = String(text[text.index(after: dotIndex)...])
        let limitedAfterDot = String(afterDot.prefix(maxPlaces))
        
        return beforeDot + "." + limitedAfterDot
    }
}
