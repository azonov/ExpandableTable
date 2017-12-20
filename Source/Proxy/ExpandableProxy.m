//
//  ExpandableProxy.m
//  ExpandableCell
//
//  Created by Andrey Zonov on 18/10/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

#import "ExpandableProxy.h"

@interface ExpandableProxy()

@property (nonatomic, weak) id proxyDelegate;
@property (nonatomic, weak) id tableDelegate;

@end

@implementation ExpandableProxy

- (instancetype)initWithTableDelegate:(id <UITableViewDelegate, UITableViewDataSource>)tableDelegate
                        proxyDelegate:(id <UITableViewDelegate, UITableViewDataSource>)proxyDelegate
{
    self.tableDelegate = tableDelegate;
    self.proxyDelegate = proxyDelegate;
    
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.proxyDelegate respondsToSelector:aSelector]) {
        return self.proxyDelegate;
    } else if ([self.tableDelegate respondsToSelector:aSelector]) {
        return self.tableDelegate;
    }
    return nil;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.proxyDelegate respondsToSelector:aSelector]) {
        return YES;
    } else if ([self.tableDelegate respondsToSelector:aSelector]) {
        return YES;
    }
    return NO;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.tableDelegate];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.tableDelegate methodSignatureForSelector:sel];
}

@end
