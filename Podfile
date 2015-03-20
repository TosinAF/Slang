source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

def import_pods
    pod 'pop'
    pod 'Cartography'
    pod 'AHKBendableView', :git => 'https://github.com/fastred/AHKBendableView.git'
end

target :"Slang" do
    import_pods
    pod 'Reveal-iOS-SDK', :configurations => ['Debug']
end

target :"SlangTests" do
    import_pods
    pod 'Quick'
    pod 'Nimble', '0.3.0'
end