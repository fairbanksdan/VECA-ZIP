//
//  MBStoreCheck.h
//  In-AppPurchase
//
//  Created by Michael Babiy on 5/28/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

@import Foundation;
@import StoreKit;

static NSString * const kUserAuthorized = @"userAuthorized";

@interface MBStoreCheck : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, getter = isAuthorized) BOOL authorized;

+ (instancetype)sharedStoreCheck;
- (void)authorize;

@end
