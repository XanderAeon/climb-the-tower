function tiletype(name_, sprite_, index_, tileset_=TILESET.MISC, shape_=TILESHAPE.SQUARE, durability_=infinity, step_=c_null, draw_=draw_self, ontouch_=c_null, onstay_=c_null, onleave_=c_null) constructor {
	name = name_;
	sprite = sprite_;
	index = index_;
	cover = shape_;
	durability = durability_;
	step = step_;
	draw = draw_;
	ontouch = ontouch_;
	onstay = onstay_;
	onleave = onleave_;
	tl[tileset_][$name] = self;
}

enum TILESHAPE {
	EMPTY,
	SQUARE,
	SEMICIRCLEU,
	SEMICIRCLED,
	L45,
	R45,
	UL45,
	UR45,
	LCS1,
	LCS2,
	RCS1,
	RCS2,
	ULCS1,
	ULCS2,
	URCS1,
	URCS2,
}

enum TILESET {
	MISC,
	ISLE,
	TOWER,
	HELL,
	GENSOKYO,
	SNOW,
	SIZE,
}