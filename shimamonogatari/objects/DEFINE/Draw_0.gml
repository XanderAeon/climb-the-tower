draw_self();
c_drawinput();
weapons[eqwp][altpos].draw();
st_drawui();
var j, ang, dude, color;
iterate weapons to {
	j=0
	//for (j=0; j<array_length(weapons[i]); j++) {
		if i == eqwp /*&& j == altpos*/ {
			ang = point_mouse();
			color = c_white;
		} else {
			ang = mod_negative(point_mouse()-180+i*20, 360);
			color = c_grey;
		}
		dude = distabs(ang, 12);
		draw_sprite_ext(
			weapons[i][j].sprite, 0,
			df.x+dude.x, df.y+dude.y, 1,
			ineg(ang >= 90 && ang <= 270), ang, color, 1
		);
	//}
}