function c_basichurting() {
	collidedbullets = ds_list_create();
	owlist = collision_circle_list(x, y, hitboxradius, o_bullet, false, false, collidedbullets, false);
	for (i=0; i<owlist; i++) {
		ow = collidedbullets[|i];
		if ow != noone && ow.friendly == true && !ow.intangible {
			method(id, ow.onhit)();
		}
	}
}