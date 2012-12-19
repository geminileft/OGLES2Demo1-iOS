@interface GraphicsUtils : NSObject

+ (NSString*) readShaderFile:(NSString*) filename;
+ (unsigned) createProgramVertexSource:(NSString*) vSource fragmentSource:(NSString*) fSource;
+ (unsigned) loadShaderForType:(unsigned) shaderType source:(NSString*) source;
+ (void) activateProgram:(unsigned) programId;
+ (unsigned) currentProgramId;

@end
