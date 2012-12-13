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
        EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        [EAGLContext setCurrentContext:context];
        GLKView* glView = [[GLKView alloc] initWithFrame:[[UIScreen mainScreen] bounds] context:context];
        glView.drawableStencilFormat = GLKViewDrawableStencilFormat8;
        self.delegate = self;
        glView.delegate = self;
        self.view = glView;
        [context release];
        [glView release];
        [self initGL];
    }
    return self;
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller {
    //NSLog(@"Not sure what to do here");
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    //glClear(GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    unsigned uProjectionMatrix = glGetUniformLocation([GraphicsUtils currentProgramId], "uProjectionMatrix");
    unsigned uViewMatrix = glGetUniformLocation([GraphicsUtils currentProgramId], "uViewMatrix");
    unsigned uTextureMatrix = glGetUniformLocation([GraphicsUtils currentProgramId], "uTextureMatrix");
    GLKMatrix4 projMatrix = GLKMatrix4MakeOrtho(0, 320, 0, 480, -1, 1);
    GLKMatrix4 viewMatrix = GLKMatrix4Identity;
    GLKMatrix4 texMatrix = GLKMatrix4Identity;
    glUniformMatrix4fv(uProjectionMatrix, 1, false, &projMatrix.m[0]);
    glUniformMatrix4fv(uViewMatrix, 1, false, &viewMatrix.m[0]);
    glUniformMatrix4fv(uTextureMatrix, 1, false, &texMatrix.m[0]);
    unsigned uColorOnly = glGetUniformLocation([GraphicsUtils currentProgramId], "uColorOnly");
    unsigned aVertices = glGetAttribLocation([GraphicsUtils currentProgramId], "aVertices");
    //unsigned aTextureCoords = glGetAttribLocation([GraphicsUtils currentProgramId], "aTextureCoords");
    unsigned aColor = glGetAttribLocation([GraphicsUtils currentProgramId], "aColor");
    float vertices[] = {
        110, 190
        , 210, 190
        , 110, 290
        , 210, 290
    };
    /*
     float colors[] = {
     1.0, 1.0, 0.0, 1.0
     , 1.0, 1.0, 0.0, 1.0
     , 1.0, 1.0, 0.0, 1.0
     , 1.0, 1.0, 0.0, 1.0
     };
     */
    float colors[] = {
        0.0f, 0.0f, 0.0f, 0.0f
        , 0.0f, 0.0f, 0.0f, 0.0f
        , 0.0f, 0.0f, 0.0f, 0.0f
        , 0.0f, 0.0f, 0.0f, 0.0f
    };
    unsigned short indices[] = {
        0, 1, 2, 1, 2, 3
    };
    glUniform1f(uColorOnly, true);
    glVertexAttribPointer(aVertices, 2, GL_FLOAT, false, 0, vertices);
    //glVertexAttribPointer(aTextureCoords, 2, GL_FLOAT, false, 0, NULL);
    glVertexAttribPointer(aColor, 4, GL_FLOAT, false, 0, colors);
    
    BOOL stencil = YES;
    if (stencil) {
        glEnable(GL_STENCIL_TEST);
        glColorMask( GL_FALSE, GL_FALSE, GL_FALSE, GL_FALSE );
        glStencilFunc(GL_ALWAYS, 8, ~0);
        glStencilOp(GL_REPLACE, GL_REPLACE, GL_REPLACE);
        
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, indices);
    }
    
    float drawColors[] = {
        0.0f, 1.0f, 1.0f, 1.0f
        , 0.0f, 1.0f, 1.0f, 1.0f
        , 0.0f, 1.0f, 1.0f, 1.0f
        , 0.0f, 1.0f, 1.0f, 1.0f
    };
    float drawVertices[] = {
        0, 0
        , 320, 0
        , 0, 480
        , 320, 480
    };
    
    if (stencil) {
        glColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE);
        glStencilFunc(GL_EQUAL, 8, ~0);
        glStencilOp(GL_KEEP, GL_KEEP, GL_KEEP);
    }
    
    glVertexAttribPointer(aColor, 4, GL_FLOAT, false, 0, drawColors);
    glVertexAttribPointer(aVertices, 2, GL_FLOAT, false, 0, drawVertices);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, indices);
    
    if (stencil) {
        glDisable(GL_STENCIL_TEST);
    }
}

-(void) initGL {
    NSString* vSource;
    NSString* fSource;
    vSource = [GraphicsUtils readShaderFile:@"basic.vsh"];
    fSource = [GraphicsUtils readShaderFile:@"basic.fsh"];
    unsigned progId = [GraphicsUtils createProgramVertexSource:vSource fragmentSource:fSource];
    [GraphicsUtils activateProgram:progId];
    glClearColor(0.0, 0.0, 0.0, 1.0);
    glClearStencil(0);
    glClear(GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    unsigned aVertices = glGetAttribLocation([GraphicsUtils currentProgramId], "aVertices");
    //unsigned aTextureCoords = glGetAttribLocation([GraphicsUtils currentProgramId], "aTextureCoords");
    unsigned aColor = glGetAttribLocation([GraphicsUtils currentProgramId], "aColor");
    glEnableVertexAttribArray(aVertices);
    //glEnableVertexAttribArray(aTextureCoords);
    glEnableVertexAttribArray(aColor);
    CGRect bounds = [[UIScreen mainScreen] bounds];
    glViewport(0, 0, bounds.size.width, bounds.size.height);
}
@end
