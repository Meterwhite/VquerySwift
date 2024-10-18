Pod::Spec.new do |s|
  s.name         = "Vquery"
  s.version      = "1.0.0"
  s.summary      = 'Vquery provides a query service for views under UIKit in Swift..'
  s.homepage     = 'https://github.com/Meterwhite/Vquery'
  s.license      = 'MIT'
  s.author       = { "Meterwhite" => "quxingyi@outlook.com" }
  s.platform     = :ios, '13.0'
  s.ios.deployment_target = '13.0'
  s.requires_arc = true
  s.source       = { :git => "https://github.com/Meterwhite/Vquery.git", :tag => s.version}
  s.source_files  = 'Vquery/**/*.{swift}'
end