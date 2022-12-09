/// @description Draw Textbox

// Draw textbox
draw_self();

// Draw text
draw_set_font(font_textbox);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_ext_color(x,y,textToShow,lineHeight,textWidth,c_black,c_black,c_black,c_black,image_alpha);