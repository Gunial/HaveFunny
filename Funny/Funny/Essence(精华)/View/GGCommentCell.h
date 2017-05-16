//
//  GGCommentCell.h
//  Funny
//
//  Created by Mr.Gu on 2017/5/9.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GGCommentModel;

@interface GGCommentCell : UITableViewCell
/** 评论模型 */
@property (nonatomic, strong) GGCommentModel *commentModel;

@end
