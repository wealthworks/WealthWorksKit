//
//  WWKDevice.m
//  WealthWorksKit
//
//  Created by JianLei on 16/7/6.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "WWKDevice.h"
#import <AdSupport/AdSupport.h>
#import <OpenUDID/OpenUDID.h>
#import <FCUUID/FCUUID.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import "NSString+Additions.h"

#define WWK_IPADDRESS_IOS_CELLULAR    @"pdp_ip0"
#define WWK_IPADDRESS_IOS_WIFI        @"en0"
#define WWK_IPADDRESS_IOS_VPN         @"utun0"
#define WWK_IPADDRESS_IP_ADDR_IPv4    @"ipv4"
#define WWK_IPADDRESS_IP_ADDR_IPv6    @"ipv6"

@implementation WWKDevice

+ (NSString *)IDFA
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)uuid
{
    NSString* openUDID = [OpenUDID value];
    return openUDID;
}

+ (NSString *)identifier
{
    NSString *idfa = [self IDFA];
    NSLog(@"IDFA is %@",idfa);
    if (idfa == nil || [idfa hasPrefix:@"000000"]) {
        idfa = [FCUUID uuidForDevice];
        NSLog(@"IDFA is nil ,FCUUID is %@",idfa);
    }
    return [[idfa md5] uppercaseString];
}


+ (NSString *)model
{
    return [UIDevice currentDevice].model;
}

+ (NSString *)systemName
{
    return [UIDevice currentDevice].systemName;
}

+ (NSString *)systemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSDictionary *)IPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = WWK_IPADDRESS_IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = WWK_IPADDRESS_IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString *)IPAddress
{
    NSArray *searchArray = @[
                             WWK_IPADDRESS_IOS_WIFI @"/" WWK_IPADDRESS_IP_ADDR_IPv6,
                             WWK_IPADDRESS_IOS_WIFI @"/" WWK_IPADDRESS_IP_ADDR_IPv4,
                             WWK_IPADDRESS_IOS_CELLULAR @"/" WWK_IPADDRESS_IP_ADDR_IPv6,
                             WWK_IPADDRESS_IOS_CELLULAR @"/" WWK_IPADDRESS_IP_ADDR_IPv4
                             ];
    
    NSDictionary *IPAddresses = [self IPAddresses];
    __block NSString *address = nil;
    [searchArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        address = IPAddresses[obj];
        if(address) *stop = YES;
    }];
    
    return address ? : @"0.0.0.0";
}

@end
