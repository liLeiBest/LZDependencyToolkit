//
//  UIImage+LZEntend.h
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (LZEntend)

/**
 获取网络图片的Size, 先通过文件头来获取图片大小
 如果失败 会下载完整的图片Data 来计算大小 所以最好别放在主线程
 如果你有使用SDWebImage就会先看下 SDWebImage有缓存过改图片没有
 支持文件头大小的格式 png、gif、jpg   http://www.cocoachina.com/bbs/read.php?tid=165823
 */
/**
 *  获取网络图片的Size,先通过文件头来获取图片大小,支持文件头大小的格式:jpg\gif\png)。
 *
 *  @param imageURL 图片的网络地址
 *
 *  @return size
 */
+ (CGSize)downloadImageSizeWithURL:(id)imageURL;

/**
 *  取出视频第一毫秒的图片
 *
 *  @param videoURL 视频地址
 *  @param time     毫秒
 */
+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL
                            atTime:(NSTimeInterval)time;

/**
 *  保存图片到相册
 */
- (void)saveToAlbum;

@end
