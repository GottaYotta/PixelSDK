Pod::Spec.new do |s|
    s.name     = 'PixelSDK'
    s.version  = '3.0.1'
    s.license  = 'License'
    s.summary  = 'Summary'
    s.homepage = 'https://github.com/joshbernfeld/PixelSDK'
    s.author   = { 'Pixel SDK' => 'support@pixelsdk.com' }
    s.source   = { :git => 'https://github.com/joshbernfeld/PixelSDK.git', :tag => s.version }

    s.source_files = '*'
    s.swift_version = '5.0'
end
