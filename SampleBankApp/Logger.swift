//
//  Logger.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 18/10/2025.
//

import Foundation
import os.log

enum LogLevel: String, CaseIterable {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
    case security = "SECURITY"
}

class Logger {
    static let shared = Logger()
    
    private let osLog = OSLog(subsystem: "com.samplebank.app", category: "BankApp")
    
    private init() {}
    
    func log(_ level: LogLevel, _ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        let logMessage = "[\(level.rawValue)] \(fileName):\(line) \(function) - \(message)"
        
        switch level {
        case .debug:
            os_log("%{public}@", log: osLog, type: .debug, logMessage)
        case .info:
            os_log("%{public}@", log: osLog, type: .info, logMessage)
        case .warning:
            os_log("%{public}@", log: osLog, type: .default, logMessage)
        case .error:
            os_log("%{public}@", log: osLog, type: .error, logMessage)
        case .security:
            os_log("%{public}@", log: osLog, type: .fault, logMessage)
        }
        
        // In production, also send to remote logging service
        #if DEBUG
        print(logMessage)
        #endif
    }
    
    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.debug, message, file: file, function: function, line: line)
    }
    
    func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.info, message, file: file, function: function, line: line)
    }
    
    func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.warning, message, file: file, function: function, line: line)
    }
    
    func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.error, message, file: file, function: function, line: line)
    }
    
    func security(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.security, message, file: file, function: function, line: line)
    }
}
