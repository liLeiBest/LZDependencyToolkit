Pod::Spec.new do |s|
    s.name             = 'LZDependencyToolkit'
    s.version          = '1.2.4.4'
    s.summary          = 'Toolkit.'
    s.description      = <<-DESC
    Toolkit 常用工具箱，包括两部分内容
    1.分类，常用系统类方法扩展。
    2.自定义结构体，封装App 及 设备的常用属性。
                        DESC
    s.homepage         = 'https://github.com/liLeiBest/LZDependencyToolkit'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'lilei' => 'lilei0502@139.com' }
    s.source           = { :git => 'https://github.com/liLeiBest/LZDependencyToolkit.git', :tag => s.version.to_s }
    s.social_media_url = 'https://github.com/liLeiBest'
    s.frameworks       = 'UIKit', 'Foundation'
    s.requires_arc     = true
    s.ios.deployment_target = '8.0'

    s.source_files        = 'LZDependencyToolkit/Classes/LZDependencyToolkit.h'
    s.public_header_files = 'LZDependencyToolkit/Classes/LZDependencyToolkit.h'

    s.subspec 'Category' do |category|
        category.source_files        = 'LZDependencyToolkit/Classes/Category/*.{h,m}'
        category.public_header_files = 'LZDependencyToolkit/Classes/Category/*.h'
        category.frameworks          = 'CoreGraphics', 'QuartzCore'
        category.dependency 'MJRefresh'
        category.dependency 'DZNEmptyDataSet'
    end

    s.subspec 'Struct' do |struct|
        struct.source_files        = 'LZDependencyToolkit/Classes/Struct/LZDependencyStruct.h'
        struct.public_header_files = 'LZDependencyToolkit/Classes/Struct/LZDependencyStruct.h'

        struct.subspec 'DeviceUnit' do |deviceUnit|
            deviceUnit.source_files        = 'LZDependencyToolkit/Classes/Struct/DeviceUnit/*.{h,m}'
            deviceUnit.public_header_files = 'LZDependencyToolkit/Classes/Struct/DeviceUnit/*.h'
            deviceUnit.frameworks          = 'CoreGraphics','CoreTelephony'
        end

        struct.subspec 'AppUnit' do |appUnit|
            appUnit.source_files        = 'LZDependencyToolkit/Classes/Struct/AppUnit/*.{h,m}'
            appUnit.public_header_files = 'LZDependencyToolkit/Classes/Struct/AppUnit/*.h'
        end
    end
end
