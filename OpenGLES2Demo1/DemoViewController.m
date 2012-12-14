//
//  DemoViewController.m
//  StencilDemo
//
//  Created by dev on 12/12/12.
//  Copyright (c) 2012 forest friendly services. All rights reserved.
//

#import "DemoViewController.h"
#import "GraphicsUtils.h"

@interface DemoViewController (private)

-(void) initGL;

@end

@implementation DemoViewController

- (id) init {
    self = [super init];
    if (self) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        [EAGLContext setCurrentContext:context];
        const CGRect frame = [[UIScreen mainScreen] bounds];
        mWidth = frame.size.width;
        mHeight = frame.size.height;
        GLKView* glView = [[GLKView alloc] initWithFrame:frame context:context];
        glView.delegate = self;
        self.view = glView;
        [context release];
        [glView release];
        [self initGL];
        self.preferredFramesPerSecond = 60;
    }
    return self;
}

-(void) initGL {
    NSString* vSource;
    NSString* fSource;
    vSource = [GraphicsUtils readShaderFile:@"basic.vsh"];
    fSource = [GraphicsUtils readShaderFile:@"basic.fsh"];
    const uint progId = [GraphicsUtils createProgramVertexSource:vSource fragmentSource:fSource];
    [GraphicsUtils activateProgram:progId];
    //set clear color
    glClearColor(.25f, .25f, .25f, 1);
    //read attribute locations and enable
    maColor = glGetAttribLocation(progId, "aColor");
    glEnableVertexAttribArray(maColor);
    maVertices = glGetAttribLocation(progId, "aVertices");
    glEnableVertexAttribArray(maVertices);
    
    glViewport(0, 0, mWidth, mHeight);
    
    //set matrices and pass to shader
    GLKMatrix4 projMatrix = GLKMatrix4MakeOrtho(0, mWidth, 0, mHeight, -1, 1);
    uint uProjectionMatrix = glGetUniformLocation(progId, "uProjectionMatrix");
    glUniformMatrix4fv(uProjectionMatrix, 1, false, &projMatrix.m[0]);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClear(GL_COLOR_BUFFER_BIT);
    float vertices[] = {
        110, 190
        , 210, 190
        , 110, 290
        , 210, 290
    };
    float colors[] = {
        0.0f, 1.0f, 1.0f, 1.0f
        , 0.0f, 1.0f, 1.0f, 1.0f
        , 0.0f, 1.0f, 1.0f, 1.0f
        , 0.0f, 1.0f, 1.0f, 1.0f
    };
    unsigned short indices[] = {
        0, 1, 2, 1, 2, 3
    };
    glVertexAttribPointer(maVertices, 2, GL_FLOAT, false, 0, vertices);
    glVertexAttribPointer(maColor, 4, GL_FLOAT, false, 0, colors);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, indices);
    /*
    //clear screen
    glClear(GL_COLOR_BUFFER_BIT);
    
    //set color buffer and pass to shader
    float colors[] = {
        1.0f, 0.0f, 0.0f, 0.0f
        , 1.0f, 0.0f, 0.0f, 0.0f
        , 1.0f, 0.0f, 0.0f, 0.0f
        , 1.0f, 0.0f, 0.0f, 0.0f
        , 1.0f, 0.0f, 0.0f, 0.0f
        , 1.0f, 0.0f, 0.0f, 0.0f
    };
    glVertexAttribPointer(maColor, 4, GL_FLOAT, false, 0, &colors[0]);
    
    //to move quad around screen for drawing modes
    const float offset = 50;
    
    //measure out vertices and set for quad
    const float SIZE = 50;
    const float HALF_WIDTH = mWidth / 2.0f;
    const float HALF_HEIGHT = mHeight / 2.0f;
    
    const float leftX = HALF_WIDTH - SIZE;
    const float rightX = HALF_WIDTH + SIZE;
    const float topY = HALF_HEIGHT + SIZE;
    const float bottomY = HALF_HEIGHT - SIZE;
    
    //triangle strip
    const float verticesTriangleStrip[] = {
        leftX - offset, bottomY + offset
        , leftX - offset, topY + offset
        , rightX - offset, bottomY + offset
        , rightX - offset, topY + offset
    };
    glVertexAttribPointer(maVertices, 2, GL_FLOAT, false, 0, &verticesTriangleStrip[0]);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    //triangle fan
    const float verticesTriangleFan[] = {
        leftX + offset, bottomY + offset
        , leftX + offset, topY + offset
        , rightX + offset, topY + offset
        , rightX + offset, bottomY + offset
    };
    glVertexAttribPointer(maVertices, 2, GL_FLOAT, false, 0, &verticesTriangleFan[0]);
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    
    //triangles
    const float verticesTriangle[] = {
        leftX, bottomY - offset
        , rightX, bottomY - offset
        , leftX, topY - offset
        , rightX, bottomY - offset
        , leftX, topY - offset
        , rightX, topY - offset
    };
    glVertexAttribPointer(maVertices, 2, GL_FLOAT, false, 0, &verticesTriangle[0]);
    glDrawArrays(GL_TRIANGLES, 0, 6);
    NSLog(@"draw frame");
    */
}

@end
