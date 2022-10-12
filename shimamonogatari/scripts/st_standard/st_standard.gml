function st_standard() {
    //log(jump);
	//log(weapons[eqwp]);
	weapons[eqwp].step(attack);
	
	if debug.hit {
		//textbox_create(txt_test);
		c_spawnenemy(10 tiles, 10 tiles, en.impostor);
	}
	
	if left.hold dir = 180;
	if right.hold dir = 0;
	if down.hold dir = 270;
	if up.hold dir = 90;
	
	
    hput = right.hold-left.hold;
    vput = down.hold-up.hold;
	
	c_dosprites();
	
	if reload.hit && magazines {
		se_play(se_toss);
		magazines--;
		var chump = instance_create(x, y, o_magazine);
		chump.spd.h = spd.h*1.4;
		//chump.spd.h = mouse_x < x ? -1 : 1;
		chump.spd.v = -3;
	}
    spd.h = lerp(spd.h, hput*walkspeed, .1);
    var a = {bbox_left: bbox_left+2,
        bbox_top:bbox_top+grav,
        bbox_right: bbox_right-2,
        bbox_bottom:bbox_bottom+grav}
    var ymeeting = bread_collision(a,o_solid,COLTYPE.LESSTHANEQUALTO);
    if !ymeeting {
        spd.v += grav;
        leniance--;
        aerial = true;
    } else {
        leniance = lencount;
        if aerial {
            aerial = false;
        }
        spd.v = 0;
    }
    if leniance > 0 {
        if (jump.hit) {
            spd.v = -jumpspeed;
            leniance = 0;
        }
    }
    if spd.v < 0 {
        if (jump.drop) {
            spd.v /= 2;
        }
    }
    c_newcollision();
    x += spd.h;
    y += spd.v;
	
	var dude = collision_point(x, y, o_entity, false, false);
	if dude && !aerial && down.hit {
		if dude.interactable {
			dude.interaction();
		}
	}
}