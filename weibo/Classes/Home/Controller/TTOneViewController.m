//
//  TTOneViewController.m
//  weibo
//
//  Created by leo on 16/2/1.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTOneViewController.h"
#import "TTTwoViewController.h"

@implementation TTOneViewController

// init底层会调用initWithNibName
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    TTLog(@"%s", __func__);
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}
- (IBAction)JumpToTwo:(id)sender {
    TTTwoViewController *two = [[TTTwoViewController alloc] init];
    
    [self.navigationController pushViewController:two animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}



//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *ID = @"cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        cell.backgroundColor = [UIColor clearColor];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
//    return cell;
//}

@end
