Pod::Spec.new do |s|
    s.name             = 'HXDependent_toolkit'
    s.version          = '2.1.0.1'
    s.summary          = 'HXApp 依赖'
    s.description      = '工具箱'
    s.homepage         = 'http://www.hxkid.com'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'lilei' => 'lilei@hxkid.com' }
    s.source           = { :git => 'git@ibbgitlab.hxkid.com:wbb/ios_hbb_iphone_dependent_toolkit.git', :tag => s.version.to_s }
    s.frameworks       = 'UIKit', 'Foundation'
    s.ios.deployment_target = '7.0'

    s.source_files = 'HXDependent_toolkit/Classes/HXDependent_toolkit.h'
    s.public_header_files = 'HXDependent_toolkit/Classes/HXDependent_toolkit.h'

    # 分类
    s.subspec 'Category' do |category|
        category.source_files           = 'HXDependent_toolkit/Classes/Category/**/*.{h,m}'
        category.public_header_files    = 'HXDependent_toolkit/Classes/Category/**/*.h'
        #category.resource               = 'HXDependent_toolkit/Classes/Category/HXCategory.bundle'
        category.frameworks             = 'CoreGraphics', 'QuartzCore'
        category.dependency 'MJRefresh'
        category.dependency 'DZNEmptyDataSet'
    end

    # 函数
    s.subspec 'Tool' do |tool|
        tool.source_files           = 'HXDependent_toolkit/Classes/Tool/**/*'
        tool.public_header_files    = 'HXDependent_toolkit/Classes/Tool/*.h'
        tool.dependency 'HXDependent_toolkit/Macro'
    end

    # 宏定义
    s.subspec 'Macro' do |macro|
        macro.source_files          = 'HXDependent_toolkit/Classes/Macro/**/*'
        macro.public_header_files   = 'HXDependent_toolkit/Classes/Macro/*.h'
    end
end
