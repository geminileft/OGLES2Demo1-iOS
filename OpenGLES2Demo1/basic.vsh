uniform mat4 uViewMatrix;
uniform mat4 uProjectionMatrix;
uniform mat4 uTextureMatrix;

attribute vec4 aVertices;
attribute vec2 aTextureCoords;
attribute vec4 aColor;

varying vec4 vTextureCoord;
varying vec4 vColor;

void main() {
	gl_Position = (uProjectionMatrix * uViewMatrix) * aVertices;
    vTextureCoord = vec4(aTextureCoords.s, aTextureCoords.t, 0.0, 1.0) * uTextureMatrix;
    vColor = aColor;
}
