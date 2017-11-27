Pod::Spec.new do |s|

s.name                   = "WKTitleScorll"
s.version                = '1.0.3'
s.summary                = 'A multi interface self map for iOS'
s.homepage               = 'https://github.com/wyxlh/WKTitleScorll'
s.license                = { :type => 'MIT', :file => 'LICENSE' }
s.author                 = { "wyxlh" => "Yuki" }
s.source                 = { :git => "https://github.com/wyxlh/WKTitleScorll.git", :tag => "1.0.3" }
s.ios.deployment_target  = "8.0"

#s.source_files  = 'WKTitleScorll/Demo/Demo/WKTitleScroll/**/*'
s.requires_arc = true

s.subspec 'WKTitleScorll' do |wktitlescorll|
wktitlescorll.source_files = 'WKTitleScorll/Demo/Demo/WKTitleScroll/**/*'
end

end

