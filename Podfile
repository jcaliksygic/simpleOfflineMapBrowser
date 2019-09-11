#source "ssh://git@git.sygic.com:7999/navi/cocoapods.git"
source "https://github.com/CocoaPods/Specs.git"

platform :ios, '12.0'
use_frameworks!

def shared_pods
    pod 'SygicMapsKit'
end

target 'SimpleOfflineMapBrowser' do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
            config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
            config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
        end
    end
end
