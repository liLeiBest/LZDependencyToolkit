Pod::Spec.new do |s|
    s.name             = 'LZDependencyToolkit'
    s.version          = '0.1.0'
    s.summary          = 'A short description of LZDependencyToolkit.'
    s.description      = '工具箱'
    s.homepage         = 'https://github.com/liLeiBest/LZDependencyToolkit'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'lilei' => 'lilei_hapy@163.com' }
    s.source           = { :git => 'https://github.com/liLeiBest/LZDependencyToolkit.git', :tag => s.version.to_s }
    s.social_media_url = 'https://github.com/liLeiBest'
    s.frameworks       = 'Foundation','UIKit'
    s.requires_arc     = true
    s.ios.deployment_target = '8.0'

    s.source_files        = 'LZDependencyToolkit/Classes/LZDependencyToolkit.h'
    s.public_header_files = 'LZDependencyToolkit/Classes/LZDependencyToolkit.h'

    s.subspec 'Unit' do |unit|

        unit.source_files        = 'LZDependencyToolkit/Classes/Unit/LZDependencyUnit.h'
        unit.public_header_files = 'LZDependencyToolkit/Classes/Unit/LZDependencyUnit.h'

        unit.subspec 'DeviceUnit' do |deviceUnit|
            deviceUnit.vendored_frameworks = 'LZDependencyToolkit/Classes/Unit/DeviceUnit/LZDeviceUnit.framework'
            deviceUnit.frameworks           = 'CoreGraphics','CoreTelephony'
        end

        unit.subspec 'AppUnit' do |appUnit|
            appUnit.vendored_frameworks = 'LZDependencyToolkit/Classes/Unit/AppUnit/LZAppUnit.framework'
        end
    end

    # s.resource_bundles = {
    #   'LZDependencyToolkit' => ['LZDependencyToolkit/Assets/*.png']
    # }
end
