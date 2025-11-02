//
//  Countdown.swift
//  TAppBase
//
//  Created by YL Tang on 2025/11/1.
//

import Foundation

/// 全局倒计时能力协议
public protocol TimeableProtocol: AnyObject {
    /// 定时间隔
    func duration() -> TimeInterval?
    
    /// 对象唯一标识
    func identifier(_ file: String) -> String
    
    /// 倒计时回调
    func onCountdown()
    
    /// 生命周期
    func onPause()
    func onResume()
    func onDestroy()
}

public extension TimeableProtocol {
    
    func duration() -> TimeInterval? {
        return nil
    }
    
    func identifier(_ file: String = #file) -> String {
        return "\(file)-\(Self.self)"
    }

    func onCountdown() {}
    func onPause() {}
    func onResume() {}
    func onDestroy() {}
}

// MARK: Util

public class GlobalCountdownUtil: NSObject {
    
    public static let shared = GlobalCountdownUtil()
    
    private lazy var timer = Timer(timeInterval: Constants.defaultInterval,
                                   target: self,
                                   selector: #selector(countdown),
                                   userInfo: nil,
                                   repeats: true)
    
    private var targets: [TimeableWeakReference<TimeableProtocol>] = []
    private let queue = DispatchQueue(label: "app.base.countdown.global")
    private let lock = NSRecursiveLock()
    private var last: TimeInterval = 0
    
    private override init() {
        super.init()
        timer.tolerance = 0.3
    }
}

// MARK: Define

fileprivate enum Constants {
    static let defaultInterval: TimeInterval = 1.0
}

fileprivate class TimeableWeakReference<T> {
    weak private var value: AnyObject?
    
    fileprivate var pointer: T? { value as? T }
    
    init<T: AnyObject>(_ value: T) {
        self.value = value
    }
}

// MARK: Action

private extension GlobalCountdownUtil {
    
    @objc func countdown() {
        #if DEBUG
        debugPrint("Global timer is running: \(Date())")
        #endif
        
        queue.async { [weak self] in
            guard let self else { return }
            self.lock.lock()
            defer { self.lock.unlock() }
            
            self.targets.forEach {
                if let customInterval = $0.pointer?.duration() {
                    let current = Date().timeIntervalSince1970
                    if current - self.last >= customInterval {
                        self.last = current
                        $0.pointer?.onCountdown()
                    }
                } else {
                    $0.pointer?.onCountdown()
                }
            }
        }
    }
}

// MARK: Public

public extension GlobalCountdownUtil {
    
    /// 启动全局倒计时工具
    func enable() {
        RunLoop.main.add(timer, forMode: .common)
    }
    
    /// 注册目标类
    /// - Parameter target: `TimeableProtocol`
    func register<T: TimeableProtocol>(_ target: T) {
        queue.async { [weak self, target] in
            guard let self else { return }
            self.lock.lock()
            defer { self.lock.unlock() }
            guard !self.targets.contains(where: { $0.pointer?.identifier() == target.identifier() }) else {
                debugPrint("Duplicate identifier for the target: \(target)")
                return
            }
            self.targets.append(.init(target))
        }
    }
    
    /// 取消目标类监听
    /// - Parameter target: `TimeableProtocol`
    func cancel(_ target: TimeableProtocol) {
        let identifier = target.identifier()
        queue.async { [weak self, identifier] in
            guard let self else { return }
            self.lock.lock()
            defer { self.lock.unlock() }
            self.targets.removeAll(where: { $0.pointer?.identifier() == identifier })
        }
    }
}
