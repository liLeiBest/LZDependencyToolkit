//
//  UILabel+LZExtension.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/26.
//

#import "UILabel+LZExtension.h"

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
