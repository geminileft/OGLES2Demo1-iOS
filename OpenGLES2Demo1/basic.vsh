uniform mat4 uProjectionMatrix;

attribute vec4 aVertices;
attribute vec4 aColor;

varying vec4 vColor;

void main() {
	gl_Position = uProjectionMatrix * aVertices;
    vColor = aColor;
}
