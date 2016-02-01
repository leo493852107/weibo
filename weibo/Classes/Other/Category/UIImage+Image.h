//
//  UIImage+Image.h
//  weibo
//
//  Created by leo on 16/1/31.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

// instancetype默认会识别当前是哪个类或者对象调用,就会转换成对应的类的对象
// UIImage *

/**
 *  加载最原始的图片，没有渲染
 *
 *  @param imageName <#imageName description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

/**
 *  拉伸图片
 *
 *  @param imageName <#imageName description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end
