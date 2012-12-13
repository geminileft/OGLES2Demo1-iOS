@interface GraphicsUtils : NSObject

+ (unsigned) createProgramVertexSource:(NSString*) vSource fragmentSource:(NSString*) fSource;
+ (unsigned) loadShaderForType:(unsigned) shaderType source:(NSString*) source;
+ (NSString*) readShaderFile:(NSString*) filename;
+ (void) activateProgram:(unsigned) programId;
+ (unsigned) currentProgramId;

@end
