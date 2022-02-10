# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

post_install do |installer|
    installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
                config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
          end
    end
end

target 'exchangeApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

 pod 'RealmSwift', '~> 10.22'
  # Pods for exchangeApp

  target 'exchangeAppTests' do
    inherit! :search_paths
    # Pods for testing
 pod 'RealmSwift', '~> 10.22'
  end

  target 'exchangeAppUITests' do
    # Pods for testing
    pod 'RealmSwift', '~> 10.22'
  end

end
