Pod::Spec.new do |s|
    s.name             = 'LZDependencyToolkit'
    s.version          = '1.2.7.6'
    s.summary          = 'Toolkit.'
    s.description      = <<-DESC
    Toolkit 常用工具箱，包括两部分内容
    1.分类，常用系统类方法扩展。
    2.自定义结构体，封装App 及 设备的常用属性。
	3.宏定义。
                        DESC
    s.homepage         = 'https://github.com/liLeiBest/LZDependencyToolkit'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'lilei' => 'lilei0502@139.com' }
    s.source           = { :git => 'https://github.com/liLeiBest/LZDependencyToolkit.git', :tag => s.version.to_s }
    s.social_media_url = 'https://github.com/liLeiBest'
    s.frameworks       = 'UIKit', 'Foundation', 'CoreGraphics'
    s.requires_arc     = true
    s.ios.deployment_target = '8.0'

    s.source_files        = 'LZDependencyToolkit/Classes/LZDependencyToolkit.h'
    s.public_header_files = 'LZDependencyToolkit/Classes/LZDependencyToolkit.h'

    s.subspec 'Category' do |category|
        category.source_files				= 'LZDependencyToolkit/Classes/Category/*.{h,m}'
        category.public_header_files 		= 'LZDependencyToolkit/Classes/Category/*.h'
        category.frameworks          		= 'CoreGraphics', 'QuartzCore'
        category.dependency 'MJRefresh'
    end

    s.subspec 'Struct' do |struct|
        struct.source_files					= 'LZDependencyToolkit/Classes/Struct/LZDependencyStruct.h'
        struct.public_header_files			= 'LZDependencyToolkit/Classes/Struct/LZDependencyStruct.h'

        struct.subspec 'DeviceUnit' do |deviceUnit|
            deviceUnit.source_files        	= 'LZDependencyToolkit/Classes/Struct/DeviceUnit/*.{h,m}'
            deviceUnit.public_header_files 	= 'LZDependencyToolkit/Classes/Struct/DeviceUnit/*.h'
            deviceUnit.frameworks      		= 'CoreGraphics', 'CoreTelephony'
        end

        struct.subspec 'AppUnit' do |appUnit|
            appUnit.source_files			= 'LZDependencyToolkit/Classes/Struct/AppUnit/*.{h,m}'
            appUnit.public_header_files		= 'LZDependencyToolkit/Classes/Struct/AppUnit/*.h'
        end
		
		struct.subspec 'QuickUnit' do |quickUnit|
			quickUnit.source_files			= 'LZDependencyToolkit/Classes/Struct/QuickUnit/*.{h,m}'
			quickUnit.public_header_files	= 'LZDependencyToolkit/Classes/Struct/QuickUnit/*.h'
			quickUnit.frameworks			= 'CoreGraphics'
		end
		
		struct.subspec 'CryptoUnit' do |cryptoUnit|
			cryptoUnit.source_files        	= 'LZDependencyToolkit/Classes/Struct/CryptoUnit/*.{h,m}'
			cryptoUnit.public_header_files 	= 'LZDependencyToolkit/Classes/Struct/CryptoUnit/*.h'
		end
    end
	
	s.subspec 'Define' do |define|
		define.source_files        = 'LZDependencyToolkit/Classes/Define/*.{h,m}'
		define.public_header_files = 'LZDependencyToolkit/Classes/Define/*.h'
	end
	
	s.subspec 'Object' do |object|
		object.source_files        = 'LZDependencyToolkit/Classes/Object/*.{h,m}'
		object.public_header_files = 'LZDependencyToolkit/Classes/Object/*.h'
	end
end
