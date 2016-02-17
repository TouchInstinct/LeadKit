
Pod::Spec.new do |s|
  s.name            = "LeadKit"
  s.version         = "0.0.1"
  s.summary         = "iOS framework with a bunch of tools for rapid development"
  s.homepage        = "https://github.com/TouchInstinct/LeadKit"
  s.license         = "Apache License, Version 2.0"
  s.author          = "Touch Instinct"
  s.platform        = :ios, "8.0"
  s.source          = { :git => "https://github.com/TouchInstinct/LeadKit.git", :tag => "podspec" }
  s.source_files    = "LeadKit/LeadKit/**/*.swift"

  s.dependency "CocoaLumberjack", "2.2.0"
end
