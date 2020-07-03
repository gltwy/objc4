//
//  main.m
//  LTTarget
//
//  Created by 高刘通 on 2020/6/20.
//
//  https://opensource.apple.com/source/
//  https://opensource.apple.com/tarballs/objc4/
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#include <malloc/malloc.h>

@interface Person : NSObject

@end

@implementation Person

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        {
            Person *p = [[Person alloc] init];
            NSLog(@"%ld", class_getInstanceSize([p class]));
            NSLog(@"%ld", malloc_size((__bridge const void *)(p)));
            NSLog(@"%ld", sizeof(p));
        }
        getchar();
    }
    return 0;
}
