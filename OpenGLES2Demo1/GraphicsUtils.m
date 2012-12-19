#import "GraphicsUtils.h"
#import <OpenGLES/ES2/glext.h>

static unsigned mCurrentProgram;

@implementation GraphicsUtils

+ (NSString*) readShaderFile:(NSString*) filename {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* resourcePath = [bundle resourcePath];
    NSString* fullpath = [resourcePath stringByAppendingPathComponent:filename];
    NSString* contents = [NSString stringWithContentsOfFile:fullpath encoding:NSUTF8StringEncoding error:nil];
    return contents;
}

+ (unsigned) createProgramVertexSource:(NSString*) vSource fragmentSource:(NSString*) fSource {
    unsigned programId = glCreateProgram();
    NSAssert1(programId != 0, @"Failed creating program, %@", @"GraphicsUtils:createProgramVertexSource");
    unsigned vertexShader = [self loadShaderForType:GL_VERTEX_SHADER source:vSource];
    glAttachShader(programId, vertexShader);
    unsigned fragmentShader =[self loadShaderForType:GL_FRAGMENT_SHADER source:fSource];
    glAttachShader(programId, fragmentShader);
    glLinkProgram(programId);
    int linkStatus[1];
    glGetProgramiv(programId, GL_LINK_STATUS, linkStatus);
    if (linkStatus[0] != GL_TRUE) {
        NSLog(@"Error");
        glDeleteProgram(programId);
        programId = 0;
    }
    return programId;
}

+ (unsigned) loadShaderForType:(unsigned) shaderType source:(NSString*) source {
    uint shader = glCreateShader(shaderType);
    if (shader == 0) {
        NSLog(@"Big problem!");
    }
    const char* str = [source UTF8String];
    glShaderSource(shader, 1, &str, NULL);
    glCompileShader(shader);
    return shader;
}

+ (void) activateProgram:(unsigned) programId {
    mCurrentProgram = programId;
    glUseProgram(programId);
}

+ (unsigned) currentProgramId {
    return mCurrentProgram;
}

@end
