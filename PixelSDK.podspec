Pod::Spec.new do |s|
    s.name     = 'PixelSDK'
    s.version  = '3.0.0'
    s.license  = 'License'
    s.summary  = 'Summary'
    s.homepage = 'https://github.com/joshbernfeld/Pixel'
    s.author   = { 'Josh Bernfeld' => 'onepixeldev@gmail.com' }
    s.source   = { :git => 'https://github.com/joshbernfeld/Pixel.git', :tag => s.version }

    s.source_files = '*'
    s.swift_version = '5.0'
end
