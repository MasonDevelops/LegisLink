# Uncomment the next line to define a global platform for your project
  platform :ios, '16.4'

target 'LegisLink' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LegisLink
  pod 'Auth0', '~> 2.3'
  pod 'JWTDecode', '~> 3.0'
  pod 'SimpleKeychain', '~> 1.0'
  pod "Fuse"
  pod 'Yams'
  
  project 'LegisLink', 'DevBuildSettings' => :debug

  
  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
              end
          end
      end
  end
  
  
end








