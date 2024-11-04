Pod::Spec.new do |s|
  s.name         = "Vquery"
  s.version      = "4.0.6"
  s.summary      = 'Vquery provides a query service for views under UIKit and AppKit in Swift.'
  s.homepage     = 'https://github.com/Meterwhite/VquerySwift'
  s.license      = 'MIT'
  s.author       = { "Meterwhite" => "quxingyi@outlook.com" }
  s.platform     = :ios, '12.0'
  s.ios.deployment_target = '12.0'
  s.platform     = :osx, '10.14'
  s.osx.deployment_target = '10.14'
  s.requires_arc = true
  s.swift_version = '5.0'
  s.source       = { :git => "https://github.com/Meterwhite/VquerySwift.git", :tag => s.version }
  s.source_files  = 'Sources/Vquery/*.{swift}'
end
