Pod::Spec.new do |s|
  s.name = 'TDCore'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Develop faster with convenience functions from The Distance.'
  # s.homepage = 'https://github.com/'
  # s.social_media_url = 'http://twitter.com/...'
  s.authors = { 'Josh Campion' => 'josh@thedistance.co.uk' }
  s.source = { :git => 'git@bitbucket.org:josh_TD/thedistancecore.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TDCore/Classes/**/*.swift', 'TDCore/Extensions/**/*.swift'
  s.requires_arc = true
end