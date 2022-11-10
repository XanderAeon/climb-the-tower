weapongen({
	step: function(input, alt) {
		if input.hit && !cooldown {
			c_bang(DEFINE.x, DEFINE.y, point_direction(DEFINE.x, DEFINE.y, mouse_x, mouse_y), 4, 0, 20, hsn.normal, c_yellow, function() {
				c
				color = make_color_hsv(40, 255-count*24, 255);
				width -= .5;
				damage = 1.6;
			});
			se_play(se_revolver, 1.8, .6);
			cooldown = .49 sec;
		}
		cooldown = floor(cooldown-1);
		if cooldown == 0 se_play(se_revclick, 1.2+random(.4));
		coins = min(coins+1/3/60, 4);
		if alt.hit && coins >= 1 {
			var chump = scriptable_create(function() {
				if place_meeting(x, y, o_solid) instance_destroy();
				var dude = collision_circle(x, y, 3, o_hitscan, false, false);
				if dude log(x, y, dude.friendly, dude);
				if dude && dude.friendly {
					var myguy;
					var dudes = tag_get_instances("coin");
					myguy = {x: irandom(room_width), y: irandom(room_height)}
					if instance_exists(o_enemy) myguy = instance_nearest(x, y, o_enemy);
					if array_length(dudes) {
						log(dudes);
						var i;
						for (i=0; i<array_length(dudes); i++) {
							if dudes[i] != id {
								myguy = dudes[i];
								break;
							}
						}
					}
					var laz = c_bang(x, y, point_direction(x, y, myguy.x, myguy.y), 4, 0, 20, hsn.normal, c_yellow, function() {
						width -= .5;
					});
					laz.damage = dude.damage*1.5;
					laz.width = dude.width*1.5;
					dude.size = point_distance(dude.x, dude.y, x, y);
					instance_destroy();
				}
				spd.v += .07;
				x += spd.h;
				y += spd.v;
			}, draw_self);
			chump.sprite_index = s_magazine;
			chump.spd = new vec2();
			chump.spd.h = df.spd.h;
			chump.spd.v = df.spd.v-3;
			chump.x = df.x;
			chump.y = df.y;
			tag("coin", chump);
			se_play(se_toss, .7+random(.6));
			coins--;
		}
	},
	draw: function() {
		draw_set_color(c_white);
		if cooldown draw_circle_width(df.x, df.y, cooldown/(.49 sec)*320, 3, true);
		draw_set_color(c_yellow);
		if coins%1 > 0 draw_circle_width(df.x, df.y, 320-(coins%1)*320, 3, true);
	},
	ammo: 0,
	ammomax: 0,
	cooldown: 0,
	coins: 4,
	name: "coin",
});