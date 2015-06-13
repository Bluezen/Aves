Pod::Spec.new do |s|

  s.name         = "Aves"
  s.version      = "0.0.1"
  s.summary      = "Quick and dirty little cute alert bar"
  s.description  = <<-DESC
                   Alert bar inspired by awesome similar library "Dodo" but in objc and far less polished (and customizable, yet).
                   DESC
  s.homepage     = "https://github.com/Bluezen/Aves"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Adrien Long" => "adrien.nuilab@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Bluezen/Aves.git", :tag => "v0.0.1-alpha"}
  s.source_files = "Yapluka/Aves", "Yapluka/Aves/**/*.{h,m}"
  s.requires_arc = true

end
