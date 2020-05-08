Pod::Spec.new do |s|
    s.name     = 'PixelSDK'
    s.version  = '5.1.1'
    s.license  = 'https://www.pixelsdk.com/terms-of-use/'
    s.summary  = 'Pixel SDK is a photo and video editing framework written in Swift.'
    s.homepage = 'https://www.pixelsdk.com'
    s.author   = { 'Pixel SDK' => 'support@pixelsdk.com' }

    s.platform = :ios
    s.source   = { :git => 'https://github.com/GottaYotta/PixelSDK.git', :tag => s.version }

    s.vendored_frameworks = 'PixelSDK.framework'
    s.ios.deployment_target = '11.0'
    s.ios.dependency 'GPUImage2-Pixel', '~> 3.0.3'
    s.frameworks   = ['AVFoundation']
    s.swift_version = '5.0'
end
