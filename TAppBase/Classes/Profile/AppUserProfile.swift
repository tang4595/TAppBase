//
//  AppUserProfile.swift
//  TAppBase
//
//  Created by tang on 8.10.22.
//

import Foundation
import RxCocoa

public class AppUserProfile {
    
    public static let shared = AppUserProfile()
    private init() {}
    
    public let isLogined = BehaviorRelay<Bool>(value: false)
    public let authToken = BehaviorRelay<String?>(value: nil)
}
