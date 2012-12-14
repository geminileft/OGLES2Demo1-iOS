precision mediump float;

varying vec4 vTextureCoord;
varying vec4 vColor;

uniform sampler2D sTexture;
uniform bool uColorOnly;

void main() {
    vec4 color;
    if (uColorOnly) {
        color = vColor;
    } else {
        color = texture2DProj(sTexture, vTextureCoord) * vColor;
    }
	gl_FragColor = color;
}
