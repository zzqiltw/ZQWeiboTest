//
//  ZQSendStatusController.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-2-2.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQSendStatusController.h"
#import "ZQTextView.h"
#import "ZQHTTPTool.h"
#import "ZQAccountTool.h"
#import "MBProgressHUD+ZQ.h"
#import "ZQSendStatusToolBar.h"
#import "ZQStatusPicsView.h"

@interface ZQSendStatusController ()<UITextViewDelegate, ZQSendStatusToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) ZQTextView *textView;
@property (nonatomic, weak) ZQSendStatusToolBar *toolBar;
@property (nonatomic, weak) ZQStatusPicsView *picsView;

@end

@implementation ZQSendStatusController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavItem];
    [self setupTextView];
    [self setupToolbar];
    [self setupPicsView];

}

- (void)setupPicsView
{
    ZQStatusPicsView *picsView = [[ZQStatusPicsView alloc] init];
    picsView.frame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height);
    [self.textView addSubview:picsView];
    self.picsView = picsView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)setupToolbar
{
    ZQSendStatusToolBar *toolBar = [[ZQSendStatusToolBar alloc] init];
    CGFloat toolBarH = 44;
    toolBar.frame = CGRectMake(0, self.view.bounds.size.height - toolBarH, self.view.bounds.size.width, toolBarH);
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}

- (void)toolBar:(ZQSendStatusToolBar *)toolBar didClickBtnAtToolBarWithTag:(ZQSendStatusToolBarButtonType)tag
{
    switch (tag) {
        case ZQSendStatusToolBarButtonTypeCamera:
            ZQLog(@"camera");
            break;
            
        case ZQSendStatusToolBarButtonTypePicture:
            [self openPhotoLibrary];
            break;
           
        case ZQSendStatusToolBarButtonTypeMention:
            ZQLog(@"mention");
            break;
            
        case ZQSendStatusToolBarButtonTypeTrend:
            ZQLog(@"trend");
            break;
            
        case ZQSendStatusToolBarButtonTypeEmotion:
            ZQLog(@"emotion");
            break;
            
        default:
            break;
    }
}

- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *selecedPhoto = info[UIImagePickerControllerOriginalImage];
    [self.picsView addImage:selecedPhoto];
}

- (void)setupNavItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(clickCancel:)];
    self.navigationItem.title = @"发微博";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(clickSend:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setupTextView
{
    ZQTextView *textView = [[ZQTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.frame;
    textView.placeholder = @"分享新鲜事";
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 注意这里要指定被观察对象为self.textView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self.textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat keyboardH = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;

    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}

// 有通知或者KVO一定有移除!!!!
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)textDidChange:(NSNotification *)notification
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.text.length != 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textView endEditing:YES];
}

- (void)clickCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickSend:(id)sender
{
    if (self.picsView.selectedPhotos.count) {
        // 有图片
        [self sendImageTextStatus];
    } else {
        [self sendTextStatus];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendTextStatus
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"status"] = self.textView.text;
    dict[@"access_token"] = [ZQAccountTool readAccount].access_token;
    
    [ZQHTTPTool postWithUrlStr:@"https://api.weibo.com/2/statuses/update.json"  params:dict success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:ZQPostSuccessNotificationName object:self];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];

}

- (void)sendImageTextStatus
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"status"] = self.textView.text;
    dict[@"access_token"] = [ZQAccountTool readAccount].access_token;
    
    NSArray *imageArray = self.picsView.selectedPhotos;
    NSMutableArray *formDataArray = [NSMutableArray array];
    for (UIImage *image in imageArray) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.01);
        ZQFormData *formData = [[ZQFormData alloc] init];
        formData.contentData = imageData;
        formData.mimeType = @"image/jpeg";
        formData.paramName = @"pic";
        formData.filename = @"";
        [formDataArray addObject:formData];
    }
    
    [ZQHTTPTool postWithUrlStr:@"https://upload.api.weibo.com/2/statuses/upload.json" params:dict formDataArray:formDataArray success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:ZQPostSuccessNotificationName object:self];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}


@end
