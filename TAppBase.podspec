$version = "0.0.1"

Pod::Spec.new do |s|
  s.name         = "TAppBase" 
  s.version      = $version
  s.summary      = "TAppBase."
  s.description  = "TAppBase."
  s.homepage     = "https://www.apple.com"
  
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "tang" => "tang@apple.com" }
  s.source       = { :git => "https://github.com/tang4595/", :tag => $version }
  s.source_files = "TAppBase/Classes/**/*"
  s.resource_bundles = {
    'TAppBaseResource' => ['TAppBase/Assets/*.{xcassets,json,plist}']
  }

  s.dependency 'SnapKit'
  s.dependency 'SwifterSwift'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'TPKeyboardAvoiding'
  s.dependency 'RTRootNavigationController'

  s.platform = :ios, "12.0"
  s.pod_target_xcconfig = { 'c' => '-Owholemodule' }
end

