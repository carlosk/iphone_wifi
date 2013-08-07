//
//  ViewController.h
//  WifiScanPrivateAPI
//
//  Created by carlos on 13-8-7.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOLStumbler.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{

}
@property(nonatomic,strong)    SOLStumbler *stumbler;
@property(nonatomic,strong)IBOutlet UITableView *mTableV;
@property(nonatomic,strong)NSArray  *dicts;

@end
