//
//  Device.m
//  Objective-C
//
//  Created by Johnson on 2017/5/26.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "Device.h"

#include "sys/types.h"
#include "sys/sysctl.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#include <sys/stat.h>

#import <sys/sysctl.h>
#import <mach/mach.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation Device


#pragma mark - device info

+ (NSString *)deviceType
{
    
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"AirPods1,1"])        return @"AirPods (A1523 (right AirPod), A1722 (left AirPod), A1602 (charging case))";
    
    if ([platform isEqualToString:@"AppleTV2,1"])        return @"Apple TV 2G (A1378)";
    if ([platform isEqualToString:@"AppleTV3,1"])        return @"Apple TV 3G (A1427)";
    if ([platform isEqualToString:@"AppleTV3,2"])        return @"Apple TV 3G (A1469)";
    if ([platform isEqualToString:@"AppleTV5,3"])        return @"Apple TV 4G (A1625)";
    if ([platform isEqualToString:@"AppleTV6,2"])        return @"Apple TV 4K (A1842)";
    
    if ([platform isEqualToString:@"Watch1,1"])          return @"Apple Watch (1st generation) (A1553)";
    if ([platform isEqualToString:@"Watch1,2"])          return @"Apple Watch (1st generation) (A1554/A1638)";
    if ([platform isEqualToString:@"Watch2,6"])          return @"Apple Watch Series 1 (A1802)";
    if ([platform isEqualToString:@"Watch2,7"])          return @"Apple Watch Series 1 (A1803)";
    if ([platform isEqualToString:@"Watch2,3"])          return @"Apple Watch Series 2 (A1757/A1816)";
    if ([platform isEqualToString:@"Watch2,4"])          return @"Apple Watch Series 2 (A1758/A1817)";
    if ([platform isEqualToString:@"Watch3,1"])          return @"Apple Watch Series 3 (A1860/A1889/A1890)";
    if ([platform isEqualToString:@"Watch3,2"])          return @"Apple Watch Series 3 (A1861/A1891/A1892)";
    if ([platform isEqualToString:@"Watch3,3"])          return @"Apple Watch Series 3 (A1858)";
    if ([platform isEqualToString:@"Watch3,4"])          return @"Apple Watch Series 3 (A1859)";
    
    if ([platform isEqualToString:@"iPad1,1"])           return @"iPad 1G (A1219/A1337)";
    if ([platform isEqualToString:@"iPad2,1"])           return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])           return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])           return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])           return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad3,1"])           return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])           return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])           return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])           return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])           return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])           return @"iPad 4 (A1460)";
    if ([platform isEqualToString:@"iPad4,1"])           return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])           return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])           return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad5,3"])           return @"iPad Air2 (A1566)";
    if ([platform isEqualToString:@"iPad5,4"])           return @"iPad Air2 (A1567)";
    if ([platform isEqualToString:@"iPad6,3"])           return @"iPad Pro (9.7-inch) (A1673)";
    if ([platform isEqualToString:@"iPad6,4"])           return @"iPad Pro (9.7-inch) (A1674/A1675)";
    if ([platform isEqualToString:@"iPad6,7"])           return @"iPad Pro (12.9-inch) (A1584)";
    if ([platform isEqualToString:@"iPad6,8"])           return @"iPad Pro (12.9-inch) (A1652)";
    if ([platform isEqualToString:@"iPad6,11"])          return @"iPad (5th generation) (A1822)";
    if ([platform isEqualToString:@"iPad6,12"])          return @"iPad (5th generation) (A1823)";
    if ([platform isEqualToString:@"iPad7,1"])           return @"iPad Pro (12.9-inch, 2nd generation) (A1670)";
    if ([platform isEqualToString:@"iPad7,2"])           return @"iPad Pro (12.9-inch, 2nd generation) (A1671/A1821)";
    if ([platform isEqualToString:@"iPad7,3"])           return @"iPad Pro (10.5-inch) (A1701)";
    if ([platform isEqualToString:@"iPad7,4"])           return @"iPad Pro (10.5-inch) (A1709)";
    if ([platform isEqualToString:@"iPad7,5"])           return @"iPad (6th generation) (A1893)";
    if ([platform isEqualToString:@"iPad7,6"])           return @"iPad (6th generation) (A1954)";
    if ([platform isEqualToString:@"iPad8,1"])           return @"iPad Pro (11-inch) (A1980)";
    if ([platform isEqualToString:@"iPad8,2"])           return @"iPad Pro (11-inch) (A1980)";
    if ([platform isEqualToString:@"iPad8,3"])           return @"iPad Pro (11-inch) (A1934/A1979/A2013)";
    if ([platform isEqualToString:@"iPad8,4"])           return @"iPad Pro (11-inch) (A1934/A1979/A2013)";
    if ([platform isEqualToString:@"iPad8,5"])           return @"iPad Pro (12.9-inch) (3rd generation) (A1876)";
    if ([platform isEqualToString:@"iPad8,6"])           return @"iPad Pro (12.9-inch) (3rd generation) (A1876)";
    if ([platform isEqualToString:@"iPad8,7"])           return @"iPad Pro (12.9-inch) (3rd generation) (A1895/A1983/A2014)";
    if ([platform isEqualToString:@"iPad8,8"])           return @"iPad Pro (12.9-inch) (3rd generation) (A1895/A1983/A2014)";
    if ([platform isEqualToString:@"iPad11,3"])          return @"iPad Air (3rd generation) (A2152)";
    if ([platform isEqualToString:@"iPad11,4"])          return @"iPad Air (3rd generation) (A2123/A2153//A2154)";
    
    if ([platform isEqualToString:@"iPad2,5"])           return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])           return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])           return @"iPad Mini 1G (A1455)";
    if ([platform isEqualToString:@"iPad4,4"])           return @"iPad Mini2 (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])           return @"iPad Mini2 (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])           return @"iPad Mini2 (A1491)";
    if ([platform isEqualToString:@"iPad4,7"])           return @"iPad Mini3 (A1599)";
    if ([platform isEqualToString:@"iPad4,8"])           return @"iPad Mini3 (A1600)";
    if ([platform isEqualToString:@"iPad4,9"])           return @"iPad Mini3 (A1601)";
    if ([platform isEqualToString:@"iPad5,1"])           return @"iPad Mini4 (A1538)";
    if ([platform isEqualToString:@"iPad5,2"])           return @"iPad Mini4 (A1550)";
    if ([platform isEqualToString:@"iPad11,1"])          return @"iPad mini (5th generation) (A2133";
    if ([platform isEqualToString:@"iPad11,2"])          return @"iPad mini (5th generation) (A2124/A2125/A2126)";
    
    if ([platform isEqualToString:@"iPhone1,1"])         return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"])         return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"])         return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"])         return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"])         return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"])         return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"])         return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"])         return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"])         return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"])         return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"])         return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"])         return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"])         return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"])         return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"])         return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"])         return @"iPhone 6s (A1633/A1688/A1691/A1700)";
    if ([platform isEqualToString:@"iPhone8,2"])         return @"iPhone 6s Plus (A1634/A1687/A1690/A1699)";
    if ([platform isEqualToString:@"iPhone8,4"])         return @"iPhoneSE (A1662/A1723/A1724)";
    if ([platform isEqualToString:@"iPhone9,1"])         return @"iPhone 7 (A1660/A1779/A1780)";
    if ([platform isEqualToString:@"iPhone9,2"])         return @"iPhone 7 Plus (A1661/A1785/A1786)";
    if ([platform isEqualToString:@"iPhone9,3"])         return @"iPhone 7 (A1778)";
    if ([platform isEqualToString:@"iPhone9,4"])         return @"iPhone 7 Plus(A1784)";
    if ([platform isEqualToString:@"iPhone10,1"])        return @"iPhone 8 (A1863/A1906/A1907)";
    if ([platform isEqualToString:@"iPhone10,4"])        return @"iPhone 8 (A1905)";
    if ([platform isEqualToString:@"iPhone10,2"])        return @"iPhone 8 Plus(A1864/A1898/A1899)";
    if ([platform isEqualToString:@"iPhone10,5"])        return @"iPhone 8 Plus(A1897)";
    if ([platform isEqualToString:@"iPhone10,3"])        return @"iPhone X (A1865/A1902)";
    if ([platform isEqualToString:@"iPhone10,6"])        return @"iPhone X (A1901)";
    if ([platform isEqualToString:@"iPhone11,8"])        return @"iPhone XR (A1984/A2105/A2106/A2108)";
    if ([platform isEqualToString:@"iPhone11,2"])        return @"iPhone XS (A1920/A2097/A2098/A2100)";
    if ([platform isEqualToString:@"iPhone11,4"])        return @"iPhone XS Max (A1921/A2101/A2102/A2104)";
    
    if ([platform isEqualToString:@"iPod1,1"])           return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])           return @"iPod touch (2th generation) (A1288/A1319)";
    if ([platform isEqualToString:@"iPod3,1"])           return @"iPod touch (3th generation) (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])           return @"iPod touch (4th generation) (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])           return @"iPod touch (5th generation) (A1421/A1509)";
    if ([platform isEqualToString:@"iPod7,1"])           return @"iPod touch (6th generation) (A1574)";
    if ([platform isEqualToString:@"iPod9,1"])           return @"iPod touch (7th generation) (A2178)";
    
    if ([platform isEqualToString:@"i386"])              return @"iPhone Simulator x32";
    if ([platform isEqualToString:@"x86_64"])            return @"iPhone Simulator x64";
    
    return platform;
}


#pragma mark - IP

+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        address = addresses[key];
        //筛选出IP地址格式
        if([self isValidatIP:address]) *stop = YES;
    }];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress
{
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        return firstMatch ? YES : NO;
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface = interfaces; interface; interface=interface->ifa_next) {
            if(!(interface -> ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface -> ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr -> sin_family == AF_INET || addr -> sin_family == AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface -> ifa_name];
                NSString *type;
                if(addr -> sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr -> sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface -> ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6 -> sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
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

+ (BOOL)isVPNConnected
{
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            NSString *string = [NSString stringWithFormat:@"%s" , temp_addr->ifa_name];
            if ([string rangeOfString:@"tap"].location != NSNotFound ||
                [string rangeOfString:@"tun"].location != NSNotFound ||
                [string rangeOfString:@"ppp"].location != NSNotFound){
                return YES;
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    return NO;
}


#pragma mark - JBroken

+ (BOOL)isJailbroken
{
    
#if !TARGET_IPHONE_SIMULATOR
    
    //Apps and System check list
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Cyd", @"ia.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"bla", @"ckra1n.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Fake", @"Carrier.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Ic", @"y.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Inte", @"lliScreen.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"MxT", @"ube.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Roc", @"kApp.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"SBSet", @"ttings.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Wint", @"erBoard.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/a", @"pt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/c", @"ydia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/mobile", @"Library/SBSettings", @"Themes/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/t", @"mp/cyd", @"ia.log"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/s", @"tash/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/b",@"in", @"s", @"shd"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/sb",@"in", @"s", @"shd"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/sftp-", @"server"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@",@"/Syste",@"tem/Lib",@"rary/Lau",@"nchDae",@"mons/com.ike",@"y.bbot.plist"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@%@",@"/Sy",@"stem/Lib",@"rary/Laun",@"chDae",@"mons/com.saur",@"ik.Cy",@"@dia.Star",@"tup.plist"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/Libr",@"ary/Mo",@"bileSubstra",@"te/MobileSubs",@"trate.dylib"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/va",@"r/c",@"ach",@"e/a",@"pt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"ib",@"/apt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"ib/c",@"ydia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"og/s",@"yslog"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/bi",@"n/b",@"ash"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/b",@"in/",@"sh"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/et",@"c/a",@"pt/"]isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/etc/s",@"sh/s",@"shd_config"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/us",@"r/li",@"bexe",@"c/ssh-k",@"eysign"]])
        
    {
        return YES;
    }
    
    // SandBox Integrity Check
    int pid = fork();
    if(!pid){
        exit(0);
    }
    if(pid>=0)
    {
        return YES;
    }
    
    //Symbolic link verification
    struct stat s;
    if(lstat("/Applications", &s) || lstat("/var/stash/Library/Ringtones", &s) || lstat("/var/stash/Library/Wallpaper", &s)
       || lstat("/var/stash/usr/include", &s) || lstat("/var/stash/usr/libexec", &s)  || lstat("/var/stash/usr/share", &s) || lstat("/var/stash/usr/arm-apple-darwin9", &s))
    {
        if(s.st_mode & S_IFLNK){
            return YES;
        }
    }
    
    //Try to write file in private
    NSError *error;
    
    [[NSString stringWithFormat:@"Jailbreak test string"]
     writeToFile:@"/private/test_jb.txt"
     atomically:YES
     encoding:NSUTF8StringEncoding error:&error];
    
    if(nil==error){
        //Wrote?: JB device
        //cleanup what you wrote
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/test_jb.txt" error:nil];
        return YES;
    }
#endif
    return NO;
}

+ (BOOL)isAppStoreVersion
{
    
#if TARGET_IPHONE_SIMULATOR
    return NO;
#else
    NSString *provisionPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    
    if (nil == provisionPath || 0 == provisionPath.length) {
        
        return YES;
    }
    
    return NO;
#endif
}

+ (BOOL)isAppCracked
{
#if !TARGET_IPHONE_SIMULATOR
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString* bundlePath = [bundle bundlePath];
    NSFileManager *manager = [NSFileManager defaultManager];
    static NSString *str;
    BOOL fileExists;
    
    //Check to see if the app is running on root
    int root = getgid();
    if (root <= 10) {
        return YES;
    }
    
    //Checking for identity signature
    char symCipher[] = { '(', 'H', 'Z', '[', '9', '{', '+', 'k', ',', 'o', 'g', 'U', ':', 'D', 'L', '#', 'S', ')', '!', 'F', '^', 'T', 'u', 'd', 'a', '-', 'A', 'f', 'z', ';', 'b', '\'', 'v', 'm', 'B', '0', 'J', 'c', 'W', 't', '*', '|', 'O', '\\', '7', 'E', '@', 'x', '"', 'X', 'V', 'r', 'n', 'Q', 'y', '>', ']', '$', '%', '_', '/', 'P', 'R', 'K', '}', '?', 'I', '8', 'Y', '=', 'N', '3', '.', 's', '<', 'l', '4', 'w', 'j', 'G', '`', '2', 'i', 'C', '6', 'q', 'M', 'p', '1', '5', '&', 'e', 'h' };
    char csignid[] = "V.NwY2*8YwC.C1";
    for(int i=0;i<strlen(csignid);i++)
    {
        for(int j=0;j<sizeof(symCipher);j++)
        {
            if(csignid[i] == symCipher[j])
            {
                csignid[i] = j+0x21;
                break;
            }
        }
    }
    NSString* signIdentity = [[NSString alloc] initWithCString:csignid encoding:NSUTF8StringEncoding];
    
    NSDictionary *info = [bundle infoDictionary];
    if ([info objectForKey:signIdentity] != nil)
    {
        return YES;
    }
    
    // Check if the below .plist files exists in the app bundle
    fileExists = [manager fileExistsAtPath:([NSString stringWithFormat:@"%@/%@", bundlePath, [NSString stringWithFormat:@"%@%@%@%@", @"_C",@"odeS",@"igna",@"ture"]])];
    if (!fileExists) {
        return YES;
    }
    
    
    fileExists = [manager fileExistsAtPath:([NSString stringWithFormat:@"%@/%@", bundlePath, [NSString stringWithFormat:@"%@%@%@%@", @"Re",@"sour",@"ceRules.p",@"list"]])];
    if (!fileExists) {
        return YES;
    }
    
    
    fileExists = [manager fileExistsAtPath:([NSString stringWithFormat:@"%@/%@", bundlePath, [NSString stringWithFormat:@"%@%@%@%@", @"S",@"C_",@"In",@"fo"]])];
    if (!fileExists) {
        return YES;
    }
    
    
    //Check if the info.plist and exectable files have been modified
    str= [NSString stringWithFormat:@"%@%@%@%@", @"Pk",@"gI",@"nf",@"o"];
    NSDate* pkgInfoModifiedDate = [[manager attributesOfItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:str] error:nil] fileModificationDate];
    
    str= [NSString stringWithFormat:@"%@%@%@%@", @"In",@"fo.p",@"li",@"st"];
    NSString* infoPath = [NSString stringWithFormat:@"%@/%@", bundlePath,str];
    NSDate* infoModifiedDate = [[manager attributesOfItemAtPath:infoPath error:nil] fileModificationDate];
    if([infoModifiedDate timeIntervalSinceReferenceDate] > [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) {
        return YES;
    }
    
    str = [[bundle infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString* appPathName = [NSString stringWithFormat:@"%@/%@", bundlePath,str];
    NSDate* appPathNameModifiedDate = [[manager attributesOfItemAtPath:appPathName error:nil]  fileModificationDate];
    if([appPathNameModifiedDate timeIntervalSinceReferenceDate] > [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) {
        return YES;
    }
    
#endif
    return NO;
}


// 获取当前设备可用内存(单位：MB）
+ (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

// 获取当前任务所占用的内存（单位：MB）
+ (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

//当前Cpu使用情况
+ (float)cpu_usage
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    if (thread_count > 0)
        stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < (int)thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->user_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
}

@end
