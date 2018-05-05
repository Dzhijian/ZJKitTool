//
//  ZJCommit.h
//  ZJCommitListDemo
//
//  Created by 邓志坚 on 2017/12/10.
//  Copyright © 2017年 邓志坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJCommit : NSObject

@property(nonatomic, copy) NSString     *comments_id;
@property(nonatomic, copy) NSString     *supper_parent_id;
@property(nonatomic, copy) NSString     *parent_id;
@property(nonatomic, copy) NSString     *uid;
@property(nonatomic, copy) NSString     *ttype;
@property(nonatomic, copy) NSString     *avatar;
@property(nonatomic, copy) NSString     *rating;
@property(nonatomic, copy) NSString     *nickname;
@property(nonatomic, copy) NSString     *content;
@property(nonatomic, copy) NSString     *add_time;
@property(nonatomic, copy) NSString     *like_id;
@property(nonatomic, copy) NSString     *like_count;
@property(nonatomic, copy) NSString     *unlike_count;
@property(nonatomic, copy) NSString     *is_show;
@property(nonatomic, copy) NSString     *img_data;
@property(nonatomic, copy) NSString     *like_type;

@property(nonatomic, strong) NSArray    *pic_urls;

@property(nonatomic ,copy) NSString     *identifier;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)commitWithDict:(NSDictionary *)dict;


/*
 
 name    type    desc
 comments_id    int(11)    评论ID
 supper_parent_id    int(11)    超父评论ID
 parent_id    int(11)    父评论ID
 uid    int(11)    用户ID, 见user表uid
 nickname    varchar(32)    昵称, 见user表nickname
 avatar    varchar(128)    头像, 见user表avatar
 ttype    tinyint(1)    第三方类型: 0.默认;
 tid    bigint(20)    第三方ID: 如商品ID等
 rating    decimal(2,1)    评分
 content    text    评论内容
 tuid    int(10)    被回复用户ID, 见user表uid
 tnickname    varchar(50)    被回复用户昵称, 见user表nickname
 tavatar    varchar(128)    被回复用户头像, 见user表avatar
 tcontent    text    被回复评论内容
 is_show    tinyint(1)    是否显示: 0.否; 1.是;
 like_count    int(10)    点赞总数
 unlike_count    int(10)    反对总数
 add_time    int(10)    添加时间
 like_id    int(11)    ID
 like_type    tinyint(1)    LIKE类型: 0.默认; 1.点赞; 2.反对; 3.收藏;
 */
@end
