Pod::Spec.new do |s|

  s.name         = "ISXBMC"
  s.version      = "0.0.1"
  s.summary      = "XBMC JSON-RPC API"
  s.homepage     = "https://github.com/jbmorley/ISXBMC"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Jason Barrie Morley" => "jason.morley@inseven.co.uk" }
  s.source       = { :git => "https://github.com/jbmorley/ISXBMC.git", :commit => "4dfdc08112c2167b7366414cb3c173e24eb472f8" }

  s.source_files = 'Classes/*.{h,m}'

  s.requires_arc = true

  s.platform = :ios, "6.0", :osx, "10.8"

end
