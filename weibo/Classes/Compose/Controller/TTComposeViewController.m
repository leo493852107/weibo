//
//  TTComposeViewController.m
//  weibo
//
//  Created by leo on 16/2/16.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTComposeViewController.h"
#import "TTTextView.h"
#import "TTComposeToolBar.h"
#import "TTComposePhotosView.h"

#import "TTComposeTool.h"
#import "MBProgressHUD+MJ.h"


@interface TTComposeViewController () <UITextViewDelegate,TTComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) TTTextView *textView;
@property (nonatomic, weak) TTComposeToolBar *toolBar;
@property (nonatomic, weak) TTComposePhotosView *photosView;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation TTComposeViewController

- (NSMutableArray *)images {
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加导航条
    [self setUpNavigationBar];
    
    // 添加textView
    [self setUpTextView];
    
    // 添加工具条
    [self setUpToolBar];
    
    // 监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 添加相册视图
    [self setUpPhotosView];
    
}

#pragma mark - 添加相册视图
- (void)setUpPhotosView {
    TTComposePhotosView *photosView = [[TTComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    _photosView = photosView;
    [_textView addSubview:photosView];
}

#pragma mark - 键盘的frame改变的时候调用
- (void)keyboardFrameChange:(NSNotification *)note {
//    TTLog(@"%@", note.userInfo);
    // duration
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y == self.view.height) {
        // 表示没有弹出键盘
        // 包装成动画
        [UIView animateWithDuration:duration animations:^{
            _toolBar.transform = CGAffineTransformIdentity;
        }];
       
    } else {
        // 弹出键盘
        // 工具条向上移动 键盘的高度
        [UIView animateWithDuration:duration animations:^{
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
    
}

#pragma mark - 添加工具条
- (void)setUpToolBar {
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    TTComposeToolBar *toolBar = [[TTComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    
}

#pragma mark - 点击工具条按钮的时候调用
- (void)composeToolBar:(TTComposeToolBar *)toolBar didClickBtn:(NSInteger)indexPath {
    if (indexPath == 0) {
        // 点击相册 弹出系统相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 设置相册类型（可选）
        // 相册集
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark - 选择图片完成的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 获取选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    _photosView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    _rightItem.enabled = YES;
}

#pragma mark - 添加textView
- (void)setUpTextView {
    TTTextView *textView = [[TTTextView alloc] initWithFrame:self.view.bounds];
    _textView = textView;
    
    // 设置占位符
    textView.placeHolder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:textView];
    
    // 默认允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    
    // 监听文本框的输入
    /*
     Observer 谁需要监听通知
     name 监听的通知的名称
     object 监听谁发送的通知 , nil 表示谁发送我都监听
    */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    
    // 监听拖拽
    _textView.delegate = self;
    
    
}

#pragma mark - 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - 文字改变的时候调用
- (void)textChange {
    // 判断下textView有没有内容
    if (_textView.text.length) {
        // 有内容
        _textView.hidePlaceHolder = YES;
        _rightItem.enabled = YES;
    } else {
        _textView.hidePlaceHolder = NO;
        _rightItem.enabled = NO;
        
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setUpNavigationBar {
    self.title = @"发微博";

    // left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    // right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    
    // 监听按钮的点击
    // 监听按钮的点击
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    _rightItem = rightItem;
    
}

#pragma mark - 发送文字
- (void)compose {

    // 新浪上传：文字不能为空，分享图片
    // 二进制参数不能拼接url的参数，只能使用formdata
    // 判断下有没有图片
    if (self.images.count) {
        // 发送图片和文字
        [self sendPictureAndTitle];
        
    } else {
        // 发送文字
        [self sendTitle];

    }
    
}

#pragma mark - 发送图片和文字
- (void)sendPictureAndTitle {
    UIImage *image = _images[0];
    
    NSString *status = _textView.text.length ? _textView.text : @"分享图片";
    
    _rightItem.enabled = NO;
    
    [TTComposeTool composeWithStatus:status image:image success:^{
        // 提示用户发送成功
        [MBProgressHUD showMessage:@"发送图片成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        _rightItem.enabled = YES;
    } failure:^(NSError *error) {
        //
        [MBProgressHUD showMessage:@"发送图片失败"];
        _rightItem.enabled = YES;
    }];
}

#pragma mark - 发送文字
- (void)sendTitle {
    
    [TTComposeTool composeWithStatus:_textView.text success:^{
        
        // 提示用户发送成功
        [MBProgressHUD showMessage:@"发送成功"];
        
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        TTLog(@"%@", error);
    }];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
