#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint datagrandflutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'datagrandflutter'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin for Datagrand.'
  s.description      = <<-DESC
A new Flutter plugin for Datagrand.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.static_framework = true
  s.dependency 'Flutter'

  s.vendored_frameworks = 'Library/PixelSDK.framework'

  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
