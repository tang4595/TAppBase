//
//  Extensions.swift
//  TAppBase
//
//  Created by tang on 2024/7/23.
//

import Foundation

// MARK: UIColor

public extension UIColor {
    
    /// SwifterSwift: Create Color from RGB values with optional transparency.
    ///
    /// - Parameters:
    ///   - red: red component.
    ///   - green: green component.
    ///   - blue: blue component.
    ///   - transparency: optional transparency value (default is 1).
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0, red <= 255 else { return nil }
        guard green >= 0, green <= 255 else { return nil }
        guard blue >= 0, blue <= 255 else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    /// SwifterSwift: Create Color from hexadecimal value with optional transparency.
    ///
    /// - Parameters:
    ///   - hex: hex Int (example: 0xDECEB5).
    ///   - transparency: optional transparency value (default is 1).
    convenience init?(hex: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hex >> 16) & 0xFF
        let green = (hex >> 8) & 0xFF
        let blue = hex & 0xFF
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    
    /// SwifterSwift: Create Color from hexadecimal string with optional transparency (if applicable).
    ///
    /// - Parameters:
    ///   - hexString: hexadecimal string (examples: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
    ///   - transparency: optional transparency value (default is 1).
    convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        let lowercaseHexString = hexString.lowercased()
        if lowercaseHexString.hasPrefix("0x") {
            string = lowercaseHexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hexValue >> 16) & 0xFF
        let green = (hexValue >> 8) & 0xFF
        let blue = hexValue & 0xFF
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
}

// MARK: - UIView Properties

public extension UIView {
    /// SwifterSwift: Border color of view; also inspectable from Storyboard.
    @IBInspectable var layerBorderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }

    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable var layerBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var layerCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    /// SwifterSwift: Height of view.
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }

    /// SwifterSwift: Check if view is in RTL format.
    var isRightToLeft: Bool {
        return effectiveUserInterfaceLayoutDirection == .rightToLeft
    }

    /// SwifterSwift: Take screenshot of view (if applicable).
    var screenshot: UIImage? {
        let size = layer.frame.size
        guard size != .zero else { return nil }
        return UIGraphicsImageRenderer(size: layer.frame.size).image { context in
            layer.render(in: context.cgContext)
        }
    }

    /// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
    @IBInspectable var layerShadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable var layerShadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable var layerShadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable var layerShadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    /// SwifterSwift: Masks to bounds of view; also inspectable from Storyboard.
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }

    /// SwifterSwift: Size of view.
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }

    /// SwifterSwift: Get view's parent view controller
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    /// SwifterSwift: Width of view.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }

    /// SwifterSwift: x origin of view.
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }

    /// SwifterSwift: y origin of view.
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
}


// MARK: - Methods (Equatable)

public extension Array where Element: Equatable {
    /// SwifterSwift: Remove all instances of an item from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"].removeAll("l") -> ["h", "e", "o"]
    ///
    /// - Parameter item: item to remove.
    /// - Returns: self after removing all instances of item.
    @discardableResult
    mutating func removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }

    /// SwifterSwift: Remove all instances contained in items parameter from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
    ///        ["h", "e", "l", "l", "o"].removeAll(["l", "h"]) -> ["e", "o"]
    ///
    /// - Parameter items: items to remove.
    /// - Returns: self after removing all instances of all items in given array.
    @discardableResult
    mutating func removeAll(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }

    /// SwifterSwift: Remove all duplicate elements from Array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"]. removeDuplicates() -> ["h", "e", "l", "o"]
    ///
    /// - Returns: Return array with all duplicate elements removed.
    @discardableResult
    mutating func removeDuplicates() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].withoutDuplicates() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }

    /// SwifterSwift: Returns an array with all duplicate elements removed using KeyPath to compare.
    ///
    /// - Parameter path: Key path to compare, the value must be Equatable.
    /// - Returns: an array of unique elements.
    func withoutDuplicates<E: Equatable>(keyPath path: KeyPath<Element, E>) -> [Element] {
        return reduce(into: [Element]()) { result, element in
            if !result.contains(where: { $0[keyPath: path] == element[keyPath: path] }) {
                result.append(element)
            }
        }
    }

    /// SwifterSwift: Returns an array with all duplicate elements removed using KeyPath to compare.
    ///
    /// - Parameter path: Key path to compare, the value must be Hashable.
    /// - Returns: an array of unique elements.
    func withoutDuplicates<E: Hashable>(keyPath path: KeyPath<Element, E>) -> [Element] {
        var set = Set<E>()
        return filter { set.insert($0[keyPath: path]).inserted }
    }
}

// MARK: - UIStackView

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIStackView {
    private class BackgroundView: UIView {}

    /// SwifterSwift: Add background color to UIStackView
    var backgroundViewColor: UIColor? {
        get {
            if #available(iOS 14.0, *) {
                return backgroundColor
            } else {
                return subviews.first(where: { $0 is BackgroundView })?.backgroundColor
            }
        }
        set {
            if #available(iOS 14.0, *) {
                backgroundColor = newValue
            } else {
                if let existingBackgroundView = subviews.first(where: { $0 is BackgroundView }) {
                    existingBackgroundView.backgroundColor = newValue
                } else {
                    let backgroundView = BackgroundView()
                    backgroundView.backgroundColor = newValue
                    insertSubview(backgroundView, at: 0)
                    backgroundView.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        backgroundView.topAnchor.constraint(equalTo: topAnchor),
                        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
                    ])
                }
            }
        }
    }

    /// SwifterSwift: Initialize an UIStackView with an array of UIView and common parameters.
    ///
    ///     let stackView = UIStackView(arrangedSubviews: [UIView(), UIView()], axis: .vertical)
    ///
    /// - Parameters:
    ///   - arrangedSubviews: The UIViews to add to the stack.
    ///   - axis: The axis along which the arranged views are laid out.
    ///   - spacing: The distance in points between the adjacent edges of the stack view’s arranged views (default:
    /// 0.0).
    ///   - alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis (default: .fill).
    ///   - distribution: The distribution of the arranged views along the stack view’s axis (default: .fill).
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }

    /// SwifterSwift: Adds array of views to the end of the arrangedSubviews array.
    ///
    /// - Parameter views: views array.
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }

    /// SwifterSwift: Removes all views in stack’s array of arranged subviews.
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }

    /// SwifterSwift: Exchanges two views of the arranged subviews.
    /// - Parameters:
    ///   - view1: first view to swap.
    ///   - view2: second view to swap.
    ///   - animated: set true to animate swap (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - delay: animation delay in seconds (default is 1 second).
    ///   - options: animation options (default is AnimationOptions.curveLinear).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func swap(_ view1: UIView, _ view2: UIView,
              animated: Bool = false,
              duration: TimeInterval = 0.25,
              delay: TimeInterval = 0,
              options: UIView.AnimationOptions = .curveLinear,
              completion: ((Bool) -> Void)? = nil) {
        func swapViews(_ view1: UIView, _ view2: UIView) {
            guard let view1Index = arrangedSubviews.firstIndex(of: view1),
                  let view2Index = arrangedSubviews.firstIndex(of: view2) else { return }
            removeArrangedSubview(view1)
            insertArrangedSubview(view1, at: view2Index)

            removeArrangedSubview(view2)
            insertArrangedSubview(view2, at: view1Index)
        }
        if animated {
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                swapViews(view1, view2)
                self.layoutIfNeeded()
            }, completion: completion)
        } else {
            swapViews(view1, view2)
        }
    }
}

#endif

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

// MARK: - Properties

public extension Float {
    /// SwifterSwift: Int.
    var int: Int {
        return Int(self)
    }

    /// SwifterSwift: Double.
    var double: Double {
        return Double(self)
    }

    #if canImport(CoreGraphics)
    /// SwifterSwift: CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    #endif
}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator **: PowerPrecedence
/// SwifterSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base float.
///   - rhs: exponent float.
/// - Returns: exponentiation result (4.4 ** 0.5 = 2.0976176963).
public func ** (lhs: Float, rhs: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}

#if canImport(Foundation)
import Foundation

#if canImport(AVFoundation)
import AVFoundation
#endif

// MARK: - Properties

public extension URL {
    /// SwifterSwift: Dictionary of the URL's query parameters that have values.
    ///
    /// Duplicated query keys are ignored, taking only the first instance.
    var queryParameters: [String: String]? {
        guard let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems else {
            return nil
        }

        return Dictionary(queryItems.lazy.compactMap {
            guard let value = $0.value else { return nil }
            return ($0.name, value)
        }) { first, _ in first }
    }

    /// SwifterSwift: Array of the URL's query parameters.
    var allQueryParameters: [URLQueryItem]? {
        URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems
    }
}

// MARK: - Initializers

public extension URL {
    /// SwifterSwift: Initializes an `URL` object with a base URL and a relative string. If `string` was malformed,
    /// returns `nil`.
    /// - Parameters:
    ///   - string: The URL string with which to initialize the `URL` object. Must conform to RFC 2396. `string` is
    /// interpreted relative to `url`.
    ///   - url: The base URL for the `URL` object.
    init?(string: String?, relativeTo url: URL? = nil) {
        guard let string = string else { return nil }
        self.init(string: string, relativeTo: url)
    }

    /**
     SwifterSwift: Initializes a forced unwrapped `URL` from string. Can potentially crash if string is invalid.
      - Parameter unsafeString: The URL string used to initialize the `URL`object.
      */
    init(unsafeString: String) {
        self.init(string: unsafeString)!
    }
}

// MARK: - Methods

public extension URL {
    /// SwifterSwift: URL with appending query parameters.
    ///
    ///        let url = URL(string: "https://google.com")!
    ///        let param = ["q": "Swifter Swift"]
    ///        url.appendingQueryParameters(params) -> "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: parameters dictionary.
    /// - Returns: URL with appending given query parameters.
    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
            .map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url!
    }

    /// SwifterSwift: URL with appending query parameters.
    ///
    ///        let url = URL(string: "https://google.com")!
    ///        let param = [URLQueryItem(name: "q", value: "Swifter Swift")]
    ///        url.appendingQueryParameters(params) -> "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: parameters dictionary.
    /// - Returns: URL with appending given query parameters.
    func appendingQueryParameters(_ parameters: [URLQueryItem]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
        return urlComponents.url!
    }

    /// SwifterSwift: Append query parameters to URL.
    ///
    ///        var url = URL(string: "https://google.com")!
    ///        let param = ["q": "Swifter Swift"]
    ///        url.appendQueryParameters(params)
    ///        print(url) // prints "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: parameters dictionary.
    mutating func appendQueryParameters(_ parameters: [String: String]) {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
            .map { URLQueryItem(name: $0, value: $1) }
        self = urlComponents.url!
    }

    /// SwifterSwift: Append query parameters to URL.
    ///
    ///        var url = URL(string: "https://google.com")!
    ///        let param = [URLQueryItem(name: "q", value: "Swifter Swift")]
    ///        url.appendQueryParameters(params)
    ///        print(url) // prints "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: parameters dictionary.
    mutating func appendQueryParameters(_ parameters: [URLQueryItem]) {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
        self = urlComponents.url!
    }

    /// SwifterSwift: Get value of a query key.
    ///
    ///    var url = URL(string: "https://google.com?code=12345")!
    ///    queryValue(for: "code") -> "12345"
    ///
    /// - Parameter key: The key of a query value.
    func queryValue(for key: String) -> String? {
        URLComponents(url: self, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first { $0.name == key }?
            .value
    }

    /// SwifterSwift: Returns a new URL by removing all the path components.
    ///
    ///     let url = URL(string: "https://domain.com/path/other")!
    ///     print(url.deletingAllPathComponents()) // prints "https://domain.com/"
    ///
    /// - Returns: URL with all path components removed.
    func deletingAllPathComponents() -> URL {
        guard !pathComponents.isEmpty else { return self }

        var url: URL = self
        for _ in 0..<pathComponents.count - 1 {
            url.deleteLastPathComponent()
        }
        return url
    }

    /// SwifterSwift: Remove all the path components from the URL.
    ///
    ///        var url = URL(string: "https://domain.com/path/other")!
    ///        url.deleteAllPathComponents()
    ///        print(url) // prints "https://domain.com/"
    mutating func deleteAllPathComponents() {
        guard !pathComponents.isEmpty else { return }

        for _ in 0..<pathComponents.count - 1 {
            deleteLastPathComponent()
        }
    }

    /// SwifterSwift: Generates new URL that does not have scheme.
    ///
    ///        let url = URL(string: "https://domain.com")!
    ///        print(url.droppedScheme()) // prints "domain.com"
    func droppedScheme() -> URL? {
        if let scheme = scheme {
            let droppedScheme = String(absoluteString.dropFirst(scheme.count + 3))
            return URL(string: droppedScheme)
        }

        guard host != nil else { return self }

        let droppedScheme = String(absoluteString.dropFirst(2))
        return URL(string: droppedScheme)
    }
}

// MARK: - Methods

public extension URL {
    #if os(iOS) || os(tvOS)
    /// SwifterSwift: Generate a thumbnail image from given url. Returns nil if no thumbnail could be created. This
    /// function may take some time to complete. It's recommended to dispatch the call if the thumbnail is not generated
    /// from a local resource.
    ///
    ///     var url = URL(string: "https://video.golem.de/files/1/1/20637/wrkw0718-sd.mp4")!
    ///     var thumbnail = url.thumbnail()
    ///     thumbnail = url.thumbnail(fromTime: 5)
    ///
    ///     DispatchQueue.main.async {
    ///         someImageView.image = url.thumbnail()
    ///     }
    ///
    /// - Parameter time: Seconds into the video where the image should be generated.
    /// - Returns: The UIImage result of the AVAssetImageGenerator
    func thumbnail(fromTime time: Float64 = 0) -> UIImage? {
        let imageGenerator = AVAssetImageGenerator(asset: AVAsset(url: self))
        let time = CMTimeMakeWithSeconds(time, preferredTimescale: 1)
        var actualTime = CMTimeMake(value: 0, timescale: 0)

        guard let cgImage = try? imageGenerator.copyCGImage(at: time, actualTime: &actualTime) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
    #endif
}

#endif

// MARK: UIImage

public extension UIImage {
    /// SwifterSwift: Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize) {
        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer { UIGraphicsEndImageContext() }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }

        self.init(cgImage: aCgImage)
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        guard let image = UIGraphicsImageRenderer(size: size, format: format).image(actions: { context in
            color.setFill()
            context.fill(context.format.bounds)
        }).cgImage else {
            self.init()
            return
        }
        self.init(cgImage: image)
        #endif
    }

    /// SwifterSwift: Create a new image from a base 64 string.
    ///
    /// - Parameters:
    ///   - base64String: a base-64 `String`, representing the image
    ///   - scale: The scale factor to assume when interpreting the image data created from the base-64 string. Applying
    /// a scale factor of 1.0 results in an image whose size matches the pixel-based dimensions of the image. Applying a
    /// different scale factor changes the size of the image as reported by the `size` property.
    convenience init?(base64String: String, scale: CGFloat = 1.0) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        self.init(data: data, scale: scale)
    }

    /// SwifterSwift: Create a new image from a URL
    ///
    /// - Important:
    ///   Use this method to convert data:// URLs to UIImage objects.
    ///   Don't use this synchronous initializer to request network-based URLs. For network-based URLs, this method can
    /// block the current thread for tens of seconds on a slow network, resulting in a poor user experience, and in iOS,
    /// may cause your app to be terminated.
    ///   Instead, for non-file URLs, consider using this in an asynchronous way, using
    /// `dataTask(with:completionHandler:)` method of the URLSession class or a library such as `AlamofireImage`,
    /// `Kingfisher`, `SDWebImage`, or others to perform asynchronous network image loading.
    /// - Parameters:
    ///   - url: a `URL`, representing the image location
    ///   - scale: The scale factor to assume when interpreting the image data created from the URL. Applying a scale
    /// factor of 1.0 results in an image whose size matches the pixel-based dimensions of the image. Applying a
    /// different scale factor changes the size of the image as reported by the `size` property.
    convenience init?(url: URL, scale: CGFloat = 1.0) throws {
        let data = try Data(contentsOf: url)
        self.init(data: data, scale: scale)
    }
}

public extension String {
#if canImport(Foundation)
    /// SwifterSwift: Float value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Float value from given string.
    func float(locale: Locale = .current) -> Float? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self)?.floatValue
    }
#endif
    
#if canImport(Foundation)
    /// SwifterSwift: Double value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Double value from given string.
    func double(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self)?.doubleValue
    }
#endif
    
    /// SwifterSwift: Integer value from string (if applicable).
    ///
    ///        "101".int -> 101
    ///
    var int: Int? {
        return Int(self)
    }
    
    /// SwifterSwift: NSString from a string.
    var nsString: NSString {
        return NSString(string: self)
    }
}

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UINavigationController {
    /// SwifterSwift: Pop ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completion: optional completion handler (default is nil).
    func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }

    /// SwifterSwift: Push ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - viewController: viewController to push.
    ///   - completion: optional completion handler (default is nil).
    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }

    #if !os(tvOS)
    /// SwifterSwift: Pushes a view controller while hiding or showing the bottom bar.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to push.
    ///   - hidesBottomBar: If `true`, hides the bottom bar (e.g. tab bar).
    ///   - animated: Specify `true` to animate the transition.
    func pushViewController(_ viewController: UIViewController, hidesBottomBar: Bool, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBar
        pushViewController(viewController, animated: animated)
    }
    #endif

    /// SwifterSwift: Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
}

#endif

#if canImport(Foundation)
import Foundation

// MARK: - Properties

public extension Data {
    /// SwifterSwift: Return data as an array of bytes.
    var bytes: [UInt8] {
        // http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
        return [UInt8](self)
    }
}

// MARK: - Methods

public extension Data {
    /// SwifterSwift: String by encoding Data using the given encoding (if applicable).
    ///
    /// - Parameter encoding: encoding.
    /// - Returns: String by encoding Data using the given encoding (if applicable).
    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }

    /// SwifterSwift: Returns a Foundation object from given JSON data.
    ///
    /// - Parameter options: Options for reading the JSON data and creating the Foundation object.
    ///
    ///   For possible values, see `JSONSerialization.ReadingOptions`.
    /// - Throws: An `NSError` if the receiver does not represent a valid JSON object.
    /// - Returns: A Foundation object from the JSON data in the receiver, or `nil` if an error occurs.
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}

#endif

#if canImport(Dispatch)
import Dispatch

// MARK: - Properties

public extension DispatchQueue {
    /// SwifterSwift: A Boolean value indicating whether the current dispatch queue is the main queue.
    static var isMainQueue: Bool {
        enum Static {
            static var key: DispatchSpecificKey<Void> = {
                let key = DispatchSpecificKey<Void>()
                DispatchQueue.main.setSpecific(key: key, value: ())
                return key
            }()
        }
        return DispatchQueue.getSpecific(key: Static.key) != nil
    }
}

// MARK: - Methods

public extension DispatchQueue {
    /// SwifterSwift: Returns a Boolean value indicating whether the current dispatch queue is the specified queue.
    ///
    /// - Parameter queue: The queue to compare against.
    /// - Returns: `true` if the current queue is the specified queue, otherwise `false`.
    static func isCurrent(_ queue: DispatchQueue) -> Bool {
        let key = DispatchSpecificKey<Void>()

        queue.setSpecific(key: key, value: ())
        defer { queue.setSpecific(key: key, value: nil) }

        return DispatchQueue.getSpecific(key: key) != nil
    }

    /// SwifterSwift: Runs passed closure asynchronous after certain time interval.
    ///
    /// - Parameters:
    ///   - delay: The time interval after which the closure will run.
    ///   - qos: Quality of service at which the work item should be executed.
    ///   - flags: Flags that control the execution environment of the work item.
    ///   - work: The closure to run after certain time interval.
    func asyncAfter(delay: Double,
                    qos: DispatchQoS = .unspecified,
                    flags: DispatchWorkItemFlags = [],
                    execute work: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, qos: qos, flags: flags, execute: work)
    }

    func debounce(delay: Double, action: @escaping () -> Void) -> () -> Void {
        // http://stackoverflow.com/questions/27116684/how-can-i-debounce-a-method-call
        var lastFireTime = DispatchTime.now()
        let deadline = { lastFireTime + delay }
        return {
            self.asyncAfter(deadline: deadline()) {
                let now = DispatchTime.now()
                if now >= deadline() {
                    lastFireTime = now
                    action()
                }
            }
        }
    }
}

#endif
