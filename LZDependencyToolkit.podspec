Pod::Spec.new do |s|
    s.name             = 'LZDependencyToolkit'
    s.version          = '1.1.4'
    s.summary          = 'A short description of LZDependencyToolkit.'
    s.description      = '工具箱'
    s.homepage         = 'https://github.com/liLeiBest/LZDependencyToolkit'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'lilei' => 'lilei_hapy@163.com' }
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

    # s.resource_bundles = {
    #   'LZDependencyToolkit' => ['LZDependencyToolkit/Assets/*.png']
    # }
end
