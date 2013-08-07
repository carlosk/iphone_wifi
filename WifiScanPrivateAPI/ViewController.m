//
//  ViewController.m
//  WifiScanPrivateAPI
//
//  Created by carlos on 13-8-7.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        stumbler= [[SOLStumbler alloc]init];
//    });


    
    [self scanWifis];

}
//扫描网络
-(void)scanWifis{
    
    self.stumbler= [[SOLStumbler alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.stumbler scanNetworks];
        self.dicts = self.stumbler.networkDicts;
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.mTableV reloadData];
        });
    });
}

#pragma mark UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dicts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *key = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:key];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:key];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    NSDictionary *tempDict = [_dicts objectAtIndex:indexPath.row];
    cell.textLabel.text = [tempDict objectForKey:@"SSID_STR"];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self selectIndex:indexPath.row];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  30.0f;
}

//选中了其中一个
-(void)selectIndex:(int)index{
    
    NSDictionary *tempDict = [_dicts objectAtIndex:index];
    NSString *title = [NSString stringWithFormat:@"连接到%@",[tempDict objectForKey:@"SSID_STR"]];
    NSString *msg = @"请输入密码";
    
    UIAlertView *alerV = [[UIAlertView alloc]initWithTitle:title
                                                   message:msg
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定", nil];
    alerV.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *tf=[alerV textFieldAtIndex:0];
    tf.text = @"9876543210";
    alerV.tag = index;
    [alerV show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    NSLog(@"alert button index %d",buttonIndex);
    if (buttonIndex != 1) {
        return;
    }

//    UITextField *tf=[alertView textFieldAtIndex:0];
//    NSString *password = tf.text;
//    NSDictionary *tempDict = [_dicts objectAtIndex:alertView.tag];
//    NSString *name = [tempDict objectForKey:@"SSID_STR"];;
//    NSLog(@"password=%@",password);
//    
//
//    SOLStumbler *sblr = [[SOLStumbler alloc] init];
//    int msgInt = [sblr associateToNetwork:name withPassword:password];
//    [sblr release];
//    
//    NSString *msg = msgInt >0 ?@"连接成功":@"连接失败";
//    NSLog(@"lianjie return msg %d",msgInt);
//    UIAlertView *alerV = [[UIAlertView alloc]initWithTitle:name
//                                                   message:msg
//                                                  delegate:self
//                                         cancelButtonTitle:@"确定"
//                                         otherButtonTitles:nil];
//    
//    [alerV show];
//    
//    return;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UITextField *tf=[alertView textFieldAtIndex:0];
        NSString *password = tf.text;
        NSDictionary *tempDict = [_dicts objectAtIndex:alertView.tag];
        NSString *name = [tempDict objectForKey:@"SSID_STR"];;
        int msgInt = [self.stumbler associateToNetwork:name withPassword:password];
        NSString *msg = msgInt >=0 ?@"连接成功":@"连接失败";
        NSLog(@"lianjie return msg %d",msgInt);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alerV = [[UIAlertView alloc]initWithTitle:name
                                                           message:msg
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];

            [alerV show];
        });
    });
}

- (void)dealloc{
    [super dealloc];
    self.stumbler = nil;
    self.dicts = nil;
}


@end
