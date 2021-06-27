# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def sharedpods
  use_frameworks!
  
  # ignore all warnings from all pods
  inhibit_all_warnings!
  
  # Pods for CookBook
  pod 'SwiftLint'
  pod 'RealmSwift', '5.4.0'
end

target 'CookBook' do
  sharedpods
end

target 'CookBookTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'CookBookUITests' do
  inherit! :search_paths
  # Pods for testing
end
