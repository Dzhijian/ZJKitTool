//
//  ZJChooseModel.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/23.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJChooseModel : NSObject

// 名字
@property(nonatomic ,copy) NSString *name;
// id
@property(nonatomic ,copy) NSString *res_id;
// 子数据
@property(nonatomic ,strong) NSArray *child_list;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)chooseWithDict:(NSDictionary *)dict;

@end
