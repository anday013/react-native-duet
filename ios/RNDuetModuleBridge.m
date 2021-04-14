//
//  RNDuetModuleBridge.m
//  ttoko
//
//  Created by Anday on 12.02.21.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNDuetModule, NSObject)

RCT_EXTERN_METHOD(duetFunction: (NSString *)firstVideoUrlString secondVideoUrlString: (NSString *)secondVideoUrlString orientation: (NSString *)orientation reverse: (BOOL *)reverse isMuted: (BOOL *)isMuted success: (RCTResponseSenderBlock)success);


@end
