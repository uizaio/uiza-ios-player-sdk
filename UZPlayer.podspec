Pod::Spec.new do |s|
    s.name = 'UZPlayer'
    s.version = '1.1.3'
    s.summary = 'UZPlayer'
    s.homepage = 'https://uiza.io/'
    s.documentation_url = 'https://docs.uiza.io/v4'
    s.author = { 'Uiza' => 'developer@uiza.io' }
    s.license = { :type => "BSD", :file => "LICENSE" }
    s.source = { :git => "https://github.com/uizaio/uiza-ios-player-sdk.git", :tag => "v" + s.version.to_s }
    s.source_files = 'UZPlayer/**/*'
    s.resource_bundles = { 'Fonts' => ['UZPlayer/Fonts/*.ttf'],
                           'Icons' => ['UZPlayer/Themes/*.bundle'] }
    s.ios.deployment_target = '9.0'
    s.requires_arc  = true
    s.swift_version = '4.2'
    
    s.ios.dependency "NKModalViewManager"
    s.ios.dependency "FrameLayoutKit"
    s.ios.dependency "Sentry"
    
end
