//
//  ZJChooseModel.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/23.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJChooseModel.h"

@implementation ZJChooseModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self == [super init]) {
        self.name = dict[@"name"];
        self.res_id = dict[@"res_id"];
        self.child_list = dict[@"child_list"];
    }
    return self;
}

+(instancetype)chooseWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}


@end
