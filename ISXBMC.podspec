Pod::Spec.new do |s|

  s.name         = "ISXBMC"
  s.version      = "0.0.1"
  s.summary      = "XBMC JSON-RPC API"
  s.homepage     = "https://github.com/jbmorley/ISXBMC"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Jason Barrie Morley" => "jason.morley@inseven.co.uk" }
  s.source       = { :git => "https://github.com/jbmorley/ISXBMC.git", :commit => "2c02145878c67623d47143814f411409b1220d39" }

  s.source_files = 'Classes/*.{h,m}'

  s.requires_arc = true

  s.platform = :ios, "6.0", :osx, "10.8"

end
