/// @description Status / Frame Advance
//Draw player status
var _fade = (1 - obj_background_manager.background_clear_amount);
for(var i = 0; i < number_of_players; i++)
	{
	//Get accent color
	var _accent = c_white;
	var _player = instance_find(obj_player, instance_number(obj_player)-1 - i);
	_accent = palette_get_color(_player.palettes[_player.player_color], 0);
	//Character profile sprite
	draw_sprite_ext
		(
		spr_player_status,
		0,
		status_bar_space * (i + 1),
		player_status_y,
		2,
		2,
		0,
		_accent,
		_fade
		);
	shader_set(shd_palette);
	shader_set_uniform_f_array(uni_s, _player.palettes[0]);
	shader_set_uniform_f_array(uni_r, _player.palettes[_player.player_color]);
	draw_sprite_ext
		(
		_player.portrait,
		0,
		status_bar_space * (i + 1),
		player_status_y,
		2,
		2,
		0,
		c_white,
		round(_fade) //round so the replacement shader still works
					//alternate way would be to draw to surfaces and then draw the surfaces with alpha
		);
	for(var m = 0; m < _player.stock; m++)
		{
		draw_sprite_ext
			(
			_player.stock_sprite,
			0,
			status_bar_space * (i + 1) + (m * 18) + 48,
			player_status_y - 48,
			2,
			2,
			0,
			c_white,
			round(_fade) 
			);
		}
	shader_reset();
	draw_sprite_ext
		(
		spr_player_status,
		1,
		status_bar_space * (i + 1),
		player_status_y,
		2,
		2,
		0,
		_accent,
		_fade
		);
	//Damage
	draw_text_sprite
		(
		46 + status_bar_space * (i + 1),
		player_status_y,
		string(_player.damage),
		spr_damage_font,
		34, //38
		_player.damage_text_x,
		_player.damage_text_y,
		2,
		calculate_damage_color(_player.damage),
		_fade
		);
	}

//Startup sequence
if (countdown > 0)
	{
	//Countdown
	var _frame = countdown div count_time;
	var _scale = lerp(2.2, 2, (countdown % count_time) / count_time);
	var _alpha = lerp(0, 1, (countdown % count_time) / count_time);
	draw_sprite_ext(spr_countdown, _frame, camera_width div 2, camera_height div 2, _scale, _scale, 0, c_white, _alpha);
	}

//Frame Advance
if (state == GAME_STATE.paused)
	{
	draw_set_font(fnt_consolas);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_black);
	draw_text(32, 16, "Press Start to advance the game");
	draw_text(32, 32, "Total Frames: " + string(current_frame));
	draw_text(32, 48, "Frame Number: " + string(frames_advanced));
	}