# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Sixt Assignment' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'AlamofireObjectMapper', '~> 4.1.0'
  pod 'Kingfisher', '~> 3.13.1'
  # Pods for Sixt Assignment

  target 'Sixt AssignmentTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Sixt AssignmentUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['ENABLE_BITCODE'] = 'YES'
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end

end
