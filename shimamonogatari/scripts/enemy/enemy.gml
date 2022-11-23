global.enemies = {};
function enemy(name_, sprite_, hp_,  step_=c_null, draw_=draw_self) constructor {
	sprite = sprite_;
	hp = hp_;
	step = munction(step_);
	draw = munction(draw_);
	variable_struct_set(global.enemies, name_, self);
}

function c_spawnenemy(x, y, archetype) {
	var chump  = instance_create(x, y, o_enemy);
	chump.hp = archetype.hp;
	chump.maxhp = archetype.hp;
	chump.sprite_index = archetype.sprite;
	chump.step = archetype.step;
	chump.draw = archetype.draw;
	return chump;
}

nu enemy("impostor", s_when_im, 100);

nu enemy("filth", s_when_im, 100, function() {
	static grav = .14;
	static aerial = false;
	static charge = 0;
	static attacking = false;
	static boul = noone;
	
	if !attacking {
		if x < df.x-40 {
			spd.h = min(spd.h+.1, 2);
			charge = 0;
		} else if x > df.x+40 {
			spd.h = max(spd.h-.1, -2);
			charge = 0;
		} else if abs(y-df.y) < 32 {
			spd.h = lerp(spd.h, 0, .2);
			charge++;
			if charge > 16 {
				spd.v = -2.3;
				y--;
				aerial = true;
				if x < df.x spd.h = 4 else spd.h = -4;
				charge = 0;
				attacking = true;
				var boul = c_shoot(x, y, 0, 0, bul.big, c_red, function() {x=owner.x; y=owner.y});
				boul.owner = id;
				boul.friendly = false;
			}
		} else charge = 0;
	}
	
	var a = {bbox_left: bbox_left+2,
        bbox_top:bbox_top+grav,
        bbox_right: bbox_right-2,
        bbox_bottom:bbox_bottom+grav}
	
	var ymeeting = bread_collision(a,o_solid,COLTYPE.LESSTHANEQUALTO);
    if !ymeeting {
        spd.v += grav;
        aerial = true;
    } else {
        if aerial {
            aerial = false;
        }
        if attacking {
            attacking = false;
			if boul instance_destroy(boul);
        }
        spd.v = 0;
    }
    c_newcollision();
	
	x += spd.h;
	y += spd.v;
});

//everybody wants to be
//my enemy