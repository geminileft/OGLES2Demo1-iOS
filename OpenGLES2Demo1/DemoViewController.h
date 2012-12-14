//
//  DemoViewController.h
//  StencilDemo
//
//  Created by dev on 12/12/12.
//  Copyright (c) 2012 forest friendly services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface DemoViewController : GLKViewController <GLKViewDelegate> {
@private
    uint maVertices;
    uint maColor;
    float mWidth;
    float mHeight;
}

@end
