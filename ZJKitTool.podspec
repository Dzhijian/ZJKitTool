#
#  Be sure to run `pod spec lint ZJKitTool.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "ZJKitTool"
  s.version      = "2.3.2"
  s.summary      = "ZJKitTool是一个对UIK封装的框架与各种工具的集合,还有各种自定义View等等"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = "ZJKitTool是一个对UIK封装的框架,添加多种方便的工具类,倒计时、 自定义PickerView 时间日期选择器等框架集合"

  s.homepage     = "https://github.com/Dzhijian/ZJKitTool"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

   s.license          = { :type => 'MIT', :file => 'LICENSE' }
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "CoderDeng" => "dengzj@canplay.com.cn" }
  # Or just: s.author    = "CodeDeng"
  # s.authors            = { "CodeDeng" => "dengzj@canplay.com.cn" }
  # s.social_media_url   = "http://twitter.com/CodeDeng"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/Dzhijian/ZJKitTool.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #
  #所需要支持的框架
  s.frameworks   = 'UIKit' 

  s.requires_arc = true # 是否启用ARC

  # s.source_files  = "ZJKitTool", "ZJKitTool/**/*.{h,m}"
  s.source_files = 'ZJKitTool/ZJKitTool.h'
  

  
  s.public_header_files = 'ZJKitTool/ZJKitTool.h'
  
  s.dependency 'Masonry'

  s.dependency 'MBProgressHUD'
  
  s.dependency 'YYCategories'
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"
#宏
  s.subspec 'ZJGeneraMacros' do |ss|

    ss.source_files = 'ZJKitTool/ZJGeneraMacros/*.{h,m}'

  end

  # 控制器
  s.subspec 'ZJControllerKit' do |ss|

    ss.dependency 'Masonry'
    ss.dependency 'ZJKitTool/ZJGeneraMacros'
    ss.source_files = 'ZJKitTool/ZJControllerKit/*.{h,m}'
    

  end

  # ZJKit
  s.subspec 'ZJKit' do |ss|

    ss.source_files = 'ZJKitTool/ZJKit/*.{h,m}'

  end

  # UIkit + Masonry
  s.subspec 'ZJKitMasonry' do |ss|

    ss.dependency 'Masonry'
    ss.dependency 'ZJKitTool/ZJGeneraMacros'
    ss.source_files = 'ZJKitTool/ZJKitMasonry/*.{h,m}'
    
  end

  # 工具类类
  s.subspec 'ZJCategory' do |ss|
    
    ss.source_files = 'ZJKitTool/ZJCategory/ZJCategory.h'

    # UIKit
    ss.subspec 'UIKit' do |sss|
      
      sss.dependency 'MBProgressHUD'

      sss.source_files = 'ZJKitTool/ZJCategory/UIKit/*.{h,m}'
      
    end

      # NSObject
    ss.subspec 'Object' do |sss|

      sss.source_files = 'ZJKitTool/ZJCategory/Object/*.{h,m}'
    end

  end
  # ZJPickerView
  s.subspec 'ZJPickerView' do |ss|

    ss.source_files = 'ZJKitTool/ZJPickerView/*.{h,m}'
    ss.resource = "ZJKitTool/ZJPickerView/ZJPickerViewBundle.bundle"

  end
    # ZJTool
  s.subspec 'ZJTool' do |ss|

    ss.source_files = 'ZJKitTool/ZJTool/*.{h,m}'

  end
  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
