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
  s.version      = "2.0.0"
  s.summary      = "ZJKitTool是一个对UIK封装的框架"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = "ZJKitTool是一个对UIK封装的框架,添加多种方便的工具类"

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
  # s.platform     = :ios, "8.0"

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
  s.requires_arc = true # 是否启用ARC

  # s.source_files  = "ZJKitTool", "**/*.{h,m}"
  s.source_files = 'ZJKitTool/ZJHelperKit.h'
  
  s.public_header_files = 'ZJKitTool/ZJHelperKit.h'
  

  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  s.subspec 'ZJGenneralMacros' do |ss|

    ss.source_files = 'ZJKitTool/ZJGenneralMacros'

  end

  # 控制器
  s.subspec 'ZJControllerKit' do |ss|

    ss.source_files = 'ZJKitTool/ZJControllerKit'

  end

  # UIkit
  s.subspec 'ZJKit' do |ss|

    ss.source_files = 'ZJKitTool/ZJKit'

  end

  # UIkit + Masonry
  s.subspec 'ZJKitMasonry' do |ss|

    ss.source_files = 'ZJKitTool/ZJKitMasonry'

    ss.dependency 'Masonry', '~> 1.0.2'

  end

  #类目
  s.subspec 'ZJCategory' do |ss|
    
    ss.source_files = 'ZJKitTool/ZJCategory/ZJCategory.h'

    #编码
    ss.subspec 'Unicode' do |sss|
      sss.source_files = 'ZJKitTool/ZJCategory/UIKit'
    end

      #编码
    ss.subspec 'Unicode' do |sss|
      sss.source_files = 'ZJKitTool/ZJCategory/Object'
    end

  end

    # UIkit + Masonry
  s.subspec 'ZJTool' do |ss|

    ss.source_files = 'ZJKitTool/ZJTool'

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
