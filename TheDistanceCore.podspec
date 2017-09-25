Pod::Spec.new do |s|

  s.name         = "TheDistanceCore"
  s.version      = "1.3.5"
  s.summary      = "Develop faster with convenience functions from The Distance."
  s.homepage     = "https://github.com/thedistance"
  s.license      = "MIT"
  s.author       = { "The Distance" => "dev@thedistance.co.uk" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/thedistance/TheDistanceCore.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "8.0"

  s.requires_arc = true
  
  s.module_name = "TheDistanceCore"  
  s.default_subspec = 'App'
  
  s.subspec 'Extension' do |ext|
    ext.source_files = 'TDCore/Classes/**/*.swift', 'TDCore/Extensions/**/*.swift', 'TDCore/Protocols/**/*.swift', 'TDCore-Extension/*.swift'
  end  
  
  s.subspec 'App' do |app|
    app.source_files = 'TDCore/Classes/**/*.swift', 'TDCore/Extensions/**/*.swift', 'TDCore/Protocols/**/*.swift', 'TheDistanceCore-App/*.swift'
  end  

end
