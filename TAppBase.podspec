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
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'TPKeyboardAvoiding'
  s.dependency 'RTRootNavigationController'

  s.platform = :ios, "13.0"
  s.swift_versions = ['5.0', '5.1', '5.2', '5.3', '5.4', '5.5', '5.6', '5.7', '5.8', '5.9']
  s.pod_target_xcconfig = { 'c' => '-Owholemodule' }
end

