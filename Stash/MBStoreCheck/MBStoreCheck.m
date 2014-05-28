//
//  MBStoreCheck.m
//  In-AppPurchase
//
//  Created by Michael Babiy on 5/28/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

static NSString * const kProductIdentifier = @"com.minddiaper.Stash.StashPro";

#import "MBStoreCheck.h"

@implementation MBStoreCheck

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (BOOL)isAuthorized
{
    return [[NSUserDefaults standardUserDefaults]boolForKey:kUserAuthorized];
}

+ (instancetype)sharedStoreCheck
{
    static MBStoreCheck *sharedStoreCheck = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStoreCheck = [[[self class]alloc]init];
    });
    
    return sharedStoreCheck;
}

- (void)authorize
{
    if ([SKPaymentQueue canMakePayments]) {
        SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:kProductIdentifier]];
        request.delegate = self;
        
        // Starting the request.
        [request start];
    } else {
        [[[UIAlertView alloc]initWithTitle:@"Prohibited"
                                   message:@"Parental Control is enabled, cannot make a purchase!"
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil, nil]show];
        
    }
}

#pragma mark - SKProductsRequestDelegate

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Processing...");
                break;
                
            case SKPaymentTransactionStatePurchased:
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kUserAuthorized];
                NSLog(@"Purchase complete. Unlock the feature.");
                break;
                
            case SKPaymentTransactionStateRestored:
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Previous purchase restored...");
                break;
                
            case SKPaymentTransactionStateFailed:
                if (transaction.error.code != SKErrorPaymentCancelled) { NSLog(@"Error payment cancelled"); }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Purchase error.");
                break;
                
            default:
                break;
        }
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    if ([response.products count]) {
        NSLog(@"Retrieved Products: %@", response.products);
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:[SKPayment paymentWithProduct:response.products[0]]]; // Transaction happening... cool.
    } else {
        [[[UIAlertView alloc]initWithTitle:@"Not Available"
                                   message:@"No products to purchase"
                                  delegate:self
                         cancelButtonTitle:nil
                         otherButtonTitles:@"Ok", nil]show];
    }
}

@end
