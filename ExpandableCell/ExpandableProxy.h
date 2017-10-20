//
//  ExpandableProxy.h
//  ExpandableCell
//
//  Created by Andrey Zonov on 18/10/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ExpandableProxy : NSProxy <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithTableDelegate:(id <UITableViewDelegate, UITableViewDataSource>)tableDelegate
                        proxyDelegate:(id <UITableViewDelegate, UITableViewDataSource>)proxyDelegate;

@end
