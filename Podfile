# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ps' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ps
  pod 'SwifterSwift'
  pod 'MJRefresh'
  pod 'Moya/Combine', '~> 15.0'
  pod 'CombineCocoa'
  pod 'CleanJSON'
  pod 'JXSegmentedView'
  pod 'FSPagerView'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'SnapKit', '~> 5.6.0'
  pod 'lottie-ios'
  pod 'PanModal'
  pod 'TZImagePickerController'
  pod 'DZNEmptyDataSet'
  pod 'LeanCloud'
  pod 'CryptoSwift', '~> 1.6.0'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
  installer.generated_projects.each do |project|
      project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
           end
      end
    end
end
