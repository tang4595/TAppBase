//
//  AppError.swift
//  Gallery
//
//  Created by tang on 14.7.21.
//

import Foundation

public typealias JSONValue = [String:Any]

public protocol ApiErrorConvertable {
    func convert() -> AppError.NetError
}

public enum AppError: Error {
    case ui(UIError)
    case dispatch(DispatchError)
    case net(NetError)
}

public extension AppError {
    
    enum UIError {
        case disabled
        case invisible
        case outOfBounds
        case custom(error: String?)
    }
    
    enum DispatchError {
        case noPermission
        case waiting
        case killed
    }
    
    enum NetError {
        case success(JSONValue)
        case failure(message: String?, code: Int = -1, data: Any?)
        case needsAuthentication(AppAuthenticationType, data: Any?)
        case timeout
        case unknown(data: Any?)
        
        public init(_ specificError: ApiErrorConvertable) {
            self = specificError.convert()
        }
    }
}

public enum AppAuthenticationType: Int {
    case sms = 0
    case email
    case otp
}

extension AppError.NetError: Error {
    
    public var data: Any? {
        switch self {
        case .failure(_, _, let data), .needsAuthentication(_, let data):
            return data
        default:
            return nil
        }
    }

    public var errorCode: Int {
        switch self {
        case .failure(_, let code, _):
            return code
        default:
            return 0
        }
    }

    public var message: String? {
        switch self {
        case .failure(let msg, _, _):
            return msg
        case .needsAuthentication(let authType, _):
            return "\(authType)"
        default:
            return self.localizedDescription
        }
    }
}

public extension AppError {
    
    static var `default`: Error {
        return AppError.ui(AppError.UIError.custom(error: "Failed"))
    }
}

// MARK: - Each Project
public struct ApiParseError: ApiErrorConvertable {
    
    public let reason: String = "API parse error."
    public let code: Int = -2
    public let data: Any?
    
    public init(data: Any?) {
        self.data = data
    }
    
    public func convert() -> AppError.NetError {
        return AppError.NetError.failure(message: reason, code: code, data: data)
    }
}

public struct ApiDecryptError: ApiErrorConvertable {
    
    public let reason: String = "API decrypt error."
    public let code: Int = -3
    public let data: Any?
    
    public init(data: Any?) {
        self.data = data
    }
    
    public func convert() -> AppError.NetError {
        return AppError.NetError.failure(message: reason, code: code, data: data)
    }
}
