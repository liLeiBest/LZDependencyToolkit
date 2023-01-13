//
//  UILabel+LZExtension.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/26.
//

#import "UILabel+LZExtension.h"
#import <CoreText/CoreText.h>

@implementation UILabel (LZExtension)

- (void)distributeText {
	
	CGRect textSize =
	[self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
							options:NSStringDrawingUsesLineFragmentOrigin |
									NSStringDrawingTruncatesLastVisibleLine |
	 								NSStringDrawingUsesFontLeading
						 attributes:@{NSFontAttributeName : self.font}
							context:nil];
	CGFloat margin = (self.frame.size.width - textSize.size.width) / (self.text.length - 1);
	NSNumber *number = [NSNumber numberWithFloat:margin];
	NSMutableAttributedString *attributeString =
	[[NSMutableAttributedString alloc] initWithString:self.text];
	[attributeString addAttribute:NSKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
	self.attributedText = attributeString;
}

- (NSArray *)linesOfString {
    
    NSString *text = [self text];
    UIFont *font = [self font];
    CGRect rect = [self frame];
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,MAXFLOAT));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }

    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

@end

@implementation UILabel (LZAlertActionFont)

- (void)setAppearanceFont:(UIFont *)appearanceFont {
	if(appearanceFont) {
		[self setFont:appearanceFont];
	}
}

- (UIFont *)appearanceFont {
	return self.font;
}
@end
