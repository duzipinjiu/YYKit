//
//  YYKVOExample.m
//  YYKitDemo
//
//  Created by TW on 2018/2/24.
//  Copyright © 2018年 ibireme. All rights reserved.
//

#import "YYKVOExample.h"
#import "YYKit.h"

////////////////////////////////////////////////////////////////////////////////
#pragma mark Simple Object Example

@interface YYKVOBook : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@end

@implementation YYKVOBook
@end


@interface YYKVOExample ()

@property (nonatomic, strong) YYKVOBook *book;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation YYKVOExample

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.book = [[YYKVOBook alloc] init];
    self.book.name = @"default name";
    self.book.desc = @"default desc";

    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    self.titleLabel = label;
    self.titleLabel.text = self.book.name;

    @weakify(self);
    [self.book addObserverBlockForKeyPath:@"name" block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
        @strongify(self);
        if (!self) return;
        //当self.book.name的值改变的时候，会走这里的方法
        self.titleLabel.text = newVal;
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *arr = @[@"book_name0",@"book_name1",@"book_name2",@"book_name3"];
    self.book.name = arr[arc4random() % 3];
}

-(void)dealloc{
    [self.book removeObserverBlocks];
    self.book = nil;
}


@end
