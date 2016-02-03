Pod::Spec.new do |s|
  s.name = 'TheDistanceCore'
  s.version = '0.2.1'
  s.license = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.summary = 'Develop faster with convenience functions from The Distance.'
  s.homepage = 'https://bitbucket.org/thedistance/thedistancecore'
  # s.social_media_url = 'http://twitter.com/...'
  s.authors = { 'Josh Campion' => 'josh@thedistance.co.uk' }
  s.source = { :git => 'git@bitbucket.org:thedistance/thedistancecore.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TDCore/Classes/**/*.swift', 'TDCore/Extensions/**/*.swift', 'TDCore/Protocols/**/*.swift'
  s.requires_arc = true
end