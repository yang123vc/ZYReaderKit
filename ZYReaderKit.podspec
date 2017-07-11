#
# Be sure to run `pod lib lint ZYReaderKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZYReaderKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ZYReaderKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/luzhiyongGit/ZYReaderKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luzhiyongGit' => 'luzy@2345.com' }
  s.source           = { :git => 'https://github.com/luzhiyongGit/ZYReaderKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZYReaderKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZYReaderKit' => ['ZYReaderKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
#  s.frameworks = 'UIKit', 'libz', 'libxml2'
  s.libraries = 'xml2'
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  s.dependency 'SSZipArchive'
# s.dependency 'XMLDictionary'
#  s.dependency 'Ono'
  s.dependency 'TouchXML'
end
