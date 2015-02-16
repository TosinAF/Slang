source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

def import_pods
    pod 'pop'
    pod 'Cartography'
    pod 'AHKBendableView', :git => 'https://github.com/TosinAF/AHKBendableView'
end

target :"Slang" do
    import_pods
    pod 'Reveal-iOS-SDK', :configurations => ['Debug']
end

target :"SlangTests" do
    import_pods
    pod 'Quick'
    pod 'Nimble'
end