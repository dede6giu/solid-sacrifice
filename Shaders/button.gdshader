shader_type canvas_item;

uniform vec4 setColor : source_color;
uniform vec4 chosenColor1 : source_color;
uniform vec4 chosenColor2 : source_color;
uniform vec4 chosenColor3 : source_color;
uniform vec4 chosenColor4 : source_color;
void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	if (tex_color == chosenColor1 || tex_color == chosenColor2 || tex_color == chosenColor3 || tex_color == chosenColor4)  //adadad
	    COLOR = tex_color * setColor;
    else
        COLOR = tex_color;
}
