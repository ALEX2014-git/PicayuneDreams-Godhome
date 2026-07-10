function draw_settings()
{
    var var_Screenw = global.screenw;
    var var_Screenh = global.screenh;
    var var_Camx = global.camx;
    var var_Camy = global.camy;
    draw_sprite_ext(global.sprites.spr_black_seam, 0, 0, 0, 999, 999, 0, c_white, 0.8);
    draw_text_setup(16777215, 1, 1, fnt_cambria);
    var top_butt_spr = global.sprites.spr_sett_top_butt;
    var top_butt_width = sprite_get_width(top_butt_spr);
    var top_butt_height = sprite_get_height(top_butt_spr);
    var top_butt_h_width = top_butt_width / 2;
    var top_butt_h_height = top_butt_height / 2;
    var txt = "";
    var bar_percentage;
    
    if (bar_power != -1)
    {
        var min_sidebar_y = 83;
        var max_sidebar_y = 478;
        
        if (collision_rectangle((var_Screenw - 24) + var_Camx, 68 + var_Camy, var_Screenw + 12 + var_Camx, (var_Screenh - 50) + var_Camy, obj_mouse, false, false))
        {
            bar_alph = 0.75;
            
            if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
                obj_settings.bar_clicked = true;
        }
        else
        {
            bar_alph = 0.5;
        }
        
        if (obj_settings.bar_clicked == true)
        {
            bar_alph = 1;
            obj_settings.bar_prog = obj_mouse.y - var_Camy;
            
            if (global.using_gamepad == false)
            {
                if (mouse_check_button_released(mb_left) || !mouse_check_button(mb_left))
                    obj_settings.bar_clicked = false;
            }
            
            if (global.using_gamepad == true)
            {
                if (gamepad_button_check_released(0, global.gpd_accept) || !gamepad_button_check(0, global.gpd_accept))
                    obj_settings.bar_clicked = false;
            }
        }
        
        obj_settings.bar_prog += (mouse_wheel_down() + -mouse_wheel_up()) * 10;
        
        if (global.using_gamepad == true)
        {
            obj_settings.bar_prog += (gamepad_button_check(0, gp_padd) + -gamepad_button_check(0, gp_padu)) * 3;
            var gamepad_analog = gamepad_axis_value(0, gp_axisrv) * 5;
            
            if (abs(gamepad_analog) > 0.3)
                obj_settings.bar_prog += gamepad_analog;
        }
        
        obj_settings.bar_prog = clamp(obj_settings.bar_prog, min_sidebar_y, max_sidebar_y);
        bar_percentage = return_percent(1, obj_settings.bar_prog - min_sidebar_y, max_sidebar_y - min_sidebar_y);
        draw_sprite_ext(global.sprites.spr_sett_bar_block, 0, var_Screenw - 14, obj_settings.bar_prog, 1, 1, 0, c_white, bar_alph);
    }
    else
    {
        bar_percentage = 0;
    }
    
    var long_butt_spr = global.sprites.spr_sett_long_butt;
    var long_butt_width = sprite_get_width(long_butt_spr);
    var long_butt_height = sprite_get_height(long_butt_spr);
    var long_butt_h_width = long_butt_width / 2;
    var long_butt_h_height = long_butt_height / 2;
    var start_y = 90;
    var hovering = false;
    
    for (var i = 0; i < 20; i += 1)
    {
        txt = "";
        var noshow = false;
        var toggle = false;
        var bar = false;
        var inputbox = false;
        var curr_status = 0;
        var bar_prog = 0;
        var max_ret = 1;
        var min_ret = 0;
        var hover_ind = 0;
        var hover_alph = 1;
        
        if (obj_settings.selected == "GAMEPLAY")
        {
            bar_power = -540.5;
            
            if (i == 0)
            {
                txt = "FULLSCREEN";
                toggle = true;
                curr_status = obj_settings.opt_fullscreen;
            }
            else if (i == 1)
            {
                txt = "VSYNC";
                toggle = true;
                curr_status = obj_settings.opt_vsync;
            }
            else if (i == 2)
            {
                txt = "SCREENSHAKE";
                bar = true;
                curr_status = obj_settings.opt_screenshake;
                max_ret = 2;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 3)
            {
                txt = "HIT FLASHES";
                bar = true;
                curr_status = obj_settings.opt_hitflash;
                max_ret = 2;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 4)
            {
                txt = "DISABLE 3D BACKGROUNDS";
                toggle = true;
                curr_status = obj_settings.opt_disable3D;
            }
            else if (i == 5)
            {
                txt = "WEAPON VISIBILITY";
                bar = true;
                curr_status = obj_settings.opt_weaptrans;
                max_ret = 1;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 6)
            {
                txt = "BACKGROUND ALPHA";
                bar = true;
                curr_status = obj_settings.opt_bgalpha;
                max_ret = 1;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 7)
            {
                txt = "AUTO-UPGRADE AT FULL BUILD";
                toggle = true;
                curr_status = obj_settings.opt_autoupgrade;
            }
            else if (i == 8)
            {
                txt = "AUTO-UPGRADE IF ALL 3 ARE ALREADY OWNED";
                toggle = true;
                curr_status = obj_settings.opt_autoupgrade_owned;
            }
            else if (i == 9)
            {
                txt = "AUTO-UPGRADE PRIORITIZE HIGHEST (OVER LOWEST)";
                toggle = true;
                curr_status = obj_settings.opt_autoupgrade_highest;
            }
            else if (i == 10)
            {
                txt = "PERMANENT HITBOX";
                toggle = true;
                curr_status = obj_settings.opt_permahitbox;
            }
            else if (i == 11)
            {
                txt = "PIXEL PERFECT";
                toggle = true;
                curr_status = obj_settings.opt_pixelperfect;
            }
            else if (i == 12)
            {
                txt = "LOW HEALTH EFFECTS";
                toggle = true;
                curr_status = obj_settings.opt_lowhpeff;
            }
            else if (i == 13)
            {
                txt = "ALWAYS SHOW XP CIRCLE";
                toggle = true;
                curr_status = obj_settings.opt_show_circle_always;
            }
            else if (i == 14)
            {
                txt = "GROUP XP CLUMPS INTO CANISTERS";
                toggle = true;
                curr_status = obj_settings.opt_xp_cans;
            }
            else if (i == 15)
            {
                txt = "BORDERLESS WINDOW";
                toggle = true;
                curr_status = obj_settings.opt_borderless;
            }
            else if (i == 16)
            {
                txt = "DIALOG SPEED";
                bar = true;
                curr_status = obj_settings.opt_dialogspd;
                max_ret = 2;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 17)
            {
                txt = "AUTOMATIC ANTILAG";
                toggle = true;
                curr_status = obj_settings.opt_auto_antilag;
            }
            else if (i == 18)
            {
                txt = "MANUAL ANTILAG LEVEL";
                bar = true;
                curr_status = round(obj_settings.opt_manual_antilag);
                max_ret = 5;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else
            {
                txt = "";
                noshow = true;
            }
        }
        else if (obj_settings.selected == "AUDIO")
        {
            bar_power = -1;
            
            if (i == 0)
            {
                txt = "MASTER VOLUME";
                bar = true;
                curr_status = obj_settings.opt_mastervol;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 1)
            {
                txt = "MUSIC AND SONGS";
                bar = true;
                curr_status = obj_settings.opt_musvol;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 2)
            {
                txt = "SOUND EFFECTS";
                bar = true;
                curr_status = obj_settings.opt_sndvol;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 3)
            {
                txt = "WEAPON HITS";
                bar = true;
                curr_status = obj_settings.opt_weaponhitvol;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 4)
            {
                txt = "DIALOG SOUNDS";
                bar = true;
                curr_status = obj_settings.opt_dialogvol;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 5)
            {
                txt = "BITCRUSH EFFECTS";
                toggle = true;
                curr_status = obj_settings.opt_ae_bitcrush;
            }
            else if (i == 6)
            {
                txt = "REVERB EFFECTS";
                toggle = true;
                curr_status = obj_settings.opt_ae_reverb;
            }
            else if (i == 7)
            {
                txt = "HIGHPASS EFFECTS";
                toggle = true;
                curr_status = obj_settings.opt_ae_highpass;
            }
            else if (i == 8)
            {
                txt = "MUTE IF FOCUS LOST";
                toggle = true;
                curr_status = obj_settings.opt_mutenofocus;
            }
            else
            {
                txt = "";
                noshow = true;
            }
        }
        else if (obj_settings.selected == "KEYBOARD")
        {
            bar_power = -329;
            
            if (i == 0)
            {
                txt = "ACCEPT / INTERACT";
                inputbox = true;
                curr_status = global.kb_accept;
            }
            else if (i == 1)
            {
                txt = "TOGGLE AUTOAIM";
                inputbox = true;
                curr_status = global.kb_togaa;
            }
            else if (i == 2)
            {
                txt = "MOVE UP";
                inputbox = true;
                curr_status = global.kb_up;
            }
            else if (i == 3)
            {
                txt = "MOVE DOWN";
                inputbox = true;
                curr_status = global.kb_down;
            }
            else if (i == 4)
            {
                txt = "MOVE LEFT";
                inputbox = true;
                curr_status = global.kb_left;
            }
            else if (i == 5)
            {
                txt = "MOVE RIGHT";
                inputbox = true;
                curr_status = global.kb_right;
            }
            else if (i == 6)
            {
                txt = "SNEAK";
                inputbox = true;
                curr_status = global.kb_tiptoe;
            }
            else if (i == 7)
            {
                txt = "BLACKHOLE BOMB";
                inputbox = true;
                curr_status = global.kb_bomb;
            }
            else if (i == 8)
            {
                txt = "PAUSE";
                inputbox = true;
                curr_status = global.kb_pause;
            }
            else if (i == 9)
            {
                txt = "INFO DOCK";
                inputbox = true;
                curr_status = global.kb_tabmen;
            }
            else if (i == 10)
            {
                txt = "FAST FORWARD";
                inputbox = true;
                curr_status = global.kb_ff;
            }
            else if (i == 11 && global.has_beaten_game > 0)
            {
                txt = "RANDOMIZE STAGE SONG";
                inputbox = true;
                curr_status = global.kb_changesong;
            }
            else
            {
                txt = "";
                noshow = true;
            }
        }
        else if (obj_settings.selected == "CONTROLLER")
        {
            bar_power = -376;
            
            if (i == 0)
            {
                txt = "TOGGLE AUTOAIM";
                inputbox = true;
                curr_status = global.gpd_togaa;
            }
            else if (i == 1)
            {
                txt = "SNEAK";
                inputbox = true;
                curr_status = global.gpd_tiptoe;
            }
            else if (i == 2)
            {
                txt = "BLACKHOLE BOMB";
                inputbox = true;
                curr_status = global.gpd_bomb;
            }
            else if (i == 3)
            {
                txt = "PAUSE";
                inputbox = true;
                curr_status = global.gpd_pause;
            }
            else if (i == 4)
            {
                txt = "ACCEPT / INTERACT";
                inputbox = true;
                curr_status = global.gpd_accept;
            }
            else if (i == 5)
            {
                txt = "INFO DOCK";
                inputbox = true;
                curr_status = global.gpd_tabmen;
            }
            else if (i == 6)
            {
                txt = "FAST FORWARD";
                inputbox = true;
                curr_status = global.gpd_ff;
            }
            else if (i == 7)
            {
                txt = "CURSOR SENSITIVITY";
                bar = true;
                curr_status = obj_settings.opt_sens;
                max_ret = 10;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 8)
            {
                txt = "DEADZONE";
                bar = true;
                curr_status = obj_settings.opt_deadzone;
                max_ret = 1;
                bar_prog = return_percent(1, curr_status, max_ret);
            }
            else if (i == 9)
            {
                txt = "DPAD UPGRADE SHORTCUTS";
                toggle = true;
                curr_status = obj_settings.opt_gp_dpadupg;
            }
            else if (i == 10)
            {
                txt = "ALLOW MOUSE MOVEMENT";
                toggle = true;
                curr_status = obj_settings.opt_gp_allowmouse;
            }
            else if (i == 11)
            {
                txt = "DISABLE AUTOAIM WHILE AIMING";
                toggle = true;
                curr_status = obj_settings.opt_gp_autoaimdeadzone;
            }
            else if (i == 12)
            {
                txt = "DISABLE ALL CONTROLLER INPUTS";
                toggle = true;
                curr_status = obj_settings.opt_discontrol;
            }
            else if (i == 13 && global.has_beaten_game > 0)
            {
                txt = "RANDOMIZE STAGE SONG";
                inputbox = true;
                curr_status = global.gpd_changesong;
            }
            else
            {
                txt = "";
                noshow = true;
            }
        }
        
        if (bar_power == -1)
            long_butt_spr = global.sprites.spr_sett_long_butt_save;
        
        var roughcalc = start_y + (long_butt_height * i) + (bar_power * bar_percentage);
        
        if (noshow == false && is_between(roughcalc, 64, 500))
        {
            draw_sprite_ext(long_butt_spr, 0, 1 + long_butt_h_width, start_y + (long_butt_height * i) + (bar_power * bar_percentage), 1, 1, 0, c_white, 1);
            draw_text(1 + long_butt_h_width, start_y + (long_butt_height * i) + (bar_power * bar_percentage), txt);
            hover_ind = 0;
            hover_alph = 1;
            
            if (toggle == true && collision_rectangle(var_Camx + 1, var_Camy + (start_y - 23) + (long_butt_height * i) + (bar_power * bar_percentage), (var_Camx + 1 + (long_butt_h_width * 2)) - 32, (var_Camy + (start_y - 20) + (long_butt_height * i) + (long_butt_h_height * 2) + (bar_power * bar_percentage)) - 5, obj_mouse, false, false))
            {
                hover_ind = 0;
                hover_alph = 0.6;
                
                if (obj_settings.bar_clicked == false && obj_settings.mouse_released == true)
                {
                    if (mouse_check_button(mb_left) || global.gp_accept)
                    {
                        hover_ind = 0;
                        hover_alph = 0.3;
                    }
                    
                    if (mouse_check_button_released(mb_left) || global.gp_accept_pressed)
                    {
                        if (txt == "FULLSCREEN")
                        {
                            obj_settings.opt_fullscreen = !obj_settings.opt_fullscreen;
                            window_set_fullscreen(obj_settings.opt_fullscreen);
                            global.fullscreen = obj_settings.opt_fullscreen;
                        }
                        
                        if (txt == "VSYNC")
                        {
                            obj_settings.opt_vsync = !obj_settings.opt_vsync;
                            display_reset(0, obj_settings.opt_vsync);
                            global.vsync = obj_settings.opt_vsync;
                        }
                        
                        if (txt == "PERMANENT HITBOX")
                        {
                            obj_settings.opt_permahitbox = !obj_settings.opt_permahitbox;
                            global.permahitbox = obj_settings.opt_permahitbox;
                        }
                        
                        if (txt == "PIXEL PERFECT")
                        {
                            obj_settings.opt_pixelperfect = !obj_settings.opt_pixelperfect;
                            global.pixelperfect = obj_settings.opt_pixelperfect;
                            
                            if (global.pixelperfect == true)
                                surface_resize(application_surface, global.screenw, global.screenh);
                            else
                                surface_resize(application_surface, 1920, 1080);
                        }
                        
                        if (txt == "LOW HEALTH EFFECTS")
                        {
                            obj_settings.opt_lowhpeff = !obj_settings.opt_lowhpeff;
                            global.lowhpeff = obj_settings.opt_lowhpeff;
                        }
                        
                        if (txt == "AUTO-UPGRADE AT FULL BUILD")
                        {
                            obj_settings.opt_autoupgrade = !obj_settings.opt_autoupgrade;
                            global.autoupgrade = obj_settings.opt_autoupgrade;
                        }
                        
                        if (txt == "AUTO-UPGRADE IF ALL 3 ARE ALREADY OWNED")
                        {
                            obj_settings.opt_autoupgrade_owned = !obj_settings.opt_autoupgrade_owned;
                            global.autoupgrade_owned = obj_settings.opt_autoupgrade_owned;
                        }
                        
                        if (txt == "AUTO-UPGRADE PRIORITIZE HIGHEST (OVER LOWEST)")
                        {
                            obj_settings.opt_autoupgrade_highest = !obj_settings.opt_autoupgrade_highest;
                            global.autoupgrade_highest = obj_settings.opt_autoupgrade_highest;
                        }
                        
                        if (txt == "DISABLE 3D BACKGROUNDS")
                        {
                            obj_settings.opt_disable3D = !obj_settings.opt_disable3D;
                            global.disable3D = obj_settings.opt_disable3D;
                        }
                        
                        if (txt == "ALWAYS SHOW XP CIRCLE")
                        {
                            obj_settings.opt_show_circle_always = !obj_settings.opt_show_circle_always;
                            global.show_circle_always = obj_settings.opt_show_circle_always;
                        }
                        
                        if (txt == "GROUP XP CLUMPS INTO CANISTERS")
                        {
                            obj_settings.opt_xp_cans = !obj_settings.opt_xp_cans;
                            global.xp_cans = obj_settings.opt_xp_cans;
                        }
                        
                        if (txt == "BORDERLESS WINDOW")
                        {
                            obj_settings.opt_borderless = !obj_settings.opt_borderless;
                            global.borderless = obj_settings.opt_borderless;
                            
                            if (global.borderless == true)
                                window_set_showborder(false);
                            else
                                window_set_showborder(true);
                        }
                        
                        if (txt == "AUTOMATIC ANTILAG")
                        {
                            obj_settings.opt_auto_antilag = !obj_settings.opt_auto_antilag;
                            global.auto_antilag = obj_settings.opt_auto_antilag;
                        }
                        
                        if (txt == "REDUCE WEAPON VISIBILITY PER UPGRADE")
                        {
                            obj_settings.opt_autoalpha = !obj_settings.opt_autoalpha;
                            global.autoalpha = obj_settings.opt_autoalpha;
                        }
                        
                        if (txt == "BITCRUSH EFFECTS")
                        {
                            obj_settings.opt_ae_bitcrush = !obj_settings.opt_ae_bitcrush;
                            global.ae_bitcrush = obj_settings.opt_ae_bitcrush;
                        }
                        
                        if (txt == "REVERB EFFECTS")
                        {
                            obj_settings.opt_ae_reverb = !obj_settings.opt_ae_reverb;
                            global.ae_reverb = obj_settings.opt_ae_reverb;
                        }
                        
                        if (txt == "HIGHPASS EFFECTS")
                        {
                            obj_settings.opt_ae_highpass = !obj_settings.opt_ae_highpass;
                            global.ae_highpass = obj_settings.opt_ae_highpass;
                        }
                        
                        if (txt == "MUTE IF FOCUS LOST")
                        {
                            obj_settings.opt_mutenofocus = !obj_settings.opt_mutenofocus;
                            global.mutenofocus = obj_settings.opt_mutenofocus;
                        }
                        
                        if (txt == "MOUSE AUTOAIM")
                        {
                            obj_mouse.autoaim_mouse = !obj_mouse.autoaim_mouse;
                            global.autoaim_gamepad = obj_mouse.autoaim_mouse;
                        }
                        
                        if (txt == "CONTROLLER AUTOAIM")
                        {
                            obj_mouse.autoaim_gamepad = !obj_mouse.autoaim_gamepad;
                            global.autoaim_gamepad = obj_mouse.autoaim_gamepad;
                        }
                        
                        if (txt == "ALLOW MOUSE MOVEMENT")
                        {
                            obj_settings.opt_gp_allowmouse = !obj_settings.opt_gp_allowmouse;
                            global.gp_allowmouse = obj_settings.opt_gp_allowmouse;
                        }
                        
                        if (txt == "DPAD UPGRADE SHORTCUTS")
                        {
                            obj_settings.opt_gp_dpadupg = !obj_settings.opt_gp_dpadupg;
                            global.gp_dpadupg = obj_settings.opt_gp_dpadupg;
                        }
                        
                        if (txt == "DISABLE AUTOAIM WHILE AIMING")
                        {
                            obj_settings.opt_gp_autoaimdeadzone = !obj_settings.opt_gp_autoaimdeadzone;
                            global.gp_autoaimdeadzone = obj_settings.opt_gp_autoaimdeadzone;
                        }
                        
                        if (txt == "DISABLE ALL CONTROLLER INPUTS")
                        {
                            obj_settings.opt_discontrol = !obj_settings.opt_discontrol;
                            global.discontrol = obj_settings.opt_discontrol;
                        }
                        
                        if (curr_status == true)
                            playsnd(global.sounds.snd_opt_toggle_false, 1, 0, 1);
                        else
                            playsnd(global.sounds.snd_opt_toggle_true, 1, 0, 1);
                    }
                }
            }
            
            if (bar == true)
            {
                draw_sprite_ext(global.sprites.spr_sett_bar, 0, (long_butt_h_width + 300) - 32, start_y + (long_butt_height * i) + (bar_power * bar_percentage), 1, 1, 0, c_white, 1);
                draw_sprite_ext(global.sprites.spr_sett_bar_block, 0, (long_butt_h_width + 145 + (310 * bar_prog)) - 32, start_y + (long_butt_height * i) + (bar_power * bar_percentage), 1, 1, 0, c_white, 1 * hover_alph);
            }
            
            if (bar == true && collision_rectangle((605 + var_Camx) - 32, (long_butt_height * i) + 75 + var_Camy + (bar_power * bar_percentage), (950 + var_Camx) - 32, (long_butt_height * i) + 105 + var_Camy + (bar_power * bar_percentage), obj_mouse, false, false))
            {
                hover_ind = 0;
                hover_alph = 0.8;
                
                if (mouse_check_button(mb_left) || global.gp_accept)
                {
                    if (obj_settings.bar_clicked == false && obj_settings.mouse_released == true)
                    {
                        if (!audio_is_playing(global.sounds.snd_opt_sliding_bar))
                            playsnd(global.sounds.snd_opt_sliding_bar, 0.8 + (curr_status / 4), 0, 1);
                        
                        hover_ind = 2;
                        hover_alph = 0.5;
                        var min_x = 618;
                        var return_perce = return_percent(max_ret, obj_mouse.x - var_Camx - (min_x - 32), sprite_get_width(global.sprites.spr_sett_bar));
                        return_perce = clamp(round_to_decimal(return_perce, 2), min_ret, max_ret);
                        
                        if (txt == "SCREENSHAKE")
                        {
                            obj_settings.opt_screenshake = return_perce;
                            global.screenshake = return_perce;
                        }
                        else if (txt == "HIT FLASHES")
                        {
                            obj_settings.opt_hitflash = return_perce;
                            global.hitflash = return_perce;
                        }
                        else if (txt == "WEAPON VISIBILITY")
                        {
                            obj_settings.opt_weaptrans = return_perce;
                            global.weapon_trans = return_perce;
                        }
                        else if (txt == "BACKGROUND ALPHA")
                        {
                            obj_settings.opt_bgalpha = return_perce;
                            global.bg_alpha = return_perce;
                        }
                        else if (txt == "XP SCALE")
                        {
                            obj_settings.opt_xp_scalemod = return_perce;
                            global.xp_scalemod = return_perce;
                        }
                        else if (txt == "DIALOG SPEED")
                        {
                            obj_settings.opt_dialogspd = return_perce;
                            global.dialogspd = return_perce;
                        }
                        else if (txt == "MANUAL ANTILAG LEVEL")
                        {
                            obj_settings.opt_manual_antilag = return_perce;
                            global.manual_antilag = round(return_perce);
                        }
                        else if (txt == "MASTER VOLUME")
                        {
                            obj_settings.opt_mastervol = return_perce;
                            global.master_vol = return_perce;
                        }
                        else if (txt == "MUSIC AND SONGS")
                        {
                            obj_settings.opt_musvol = return_perce;
                            global.musvol = return_perce;
                        }
                        else if (txt == "SOUND EFFECTS")
                        {
                            obj_settings.opt_sndvol = return_perce;
                            global.sndvol = return_perce;
                        }
                        else if (txt == "WEAPON HITS")
                        {
                            obj_settings.opt_weaponhitvol = return_perce;
                            global.weapon_hit_vol = return_perce;
                        }
                        else if (txt == "DIALOG SOUNDS")
                        {
                            obj_settings.opt_dialogvol = return_perce;
                            global.dialog_vol = return_perce;
                        }
                        else if (txt == "CURSOR SENSITIVITY")
                        {
                            obj_settings.opt_sens = return_perce;
                            global.gpd_sens = return_perce;
                        }
                        else if (txt == "DEADZONE")
                        {
                            obj_settings.opt_deadzone = return_perce;
                            global.gp_deadzone = return_perce;
                        }
                        
                        draw_text_setup(16777215, 0, 0, fnt_freddy);
                        outline_text_ext(string(return_perce), (obj_mouse.x + 8) - var_Camx, obj_mouse.y - var_Camy, 16777215, 0, 1, 999, 999, 1, 1, 0);
                        draw_text_setup(16777215, 1, 1, fnt_cambria);
                    }
                }
            }
            
            if (inputbox == true)
            {
                hover_ind = 0;
                hover_alph = 1;
                
                if (collision_rectangle(var_Camx + 600, var_Camy + (long_butt_height * i) + 75 + (bar_power * bar_percentage), (var_Camx + 940) - 32, var_Camy + (long_butt_height * i) + 105 + (bar_power * bar_percentage), obj_mouse, false, false))
                {
                    hover_ind = 1;
                    hover_alph = 0.6;
                    
                    if (obj_settings.bar_clicked == false && obj_settings.mouse_released == true)
                    {
                        if (mouse_check_button(mb_left) || global.gp_accept)
                        {
                            hover_ind = 2;
                            hover_alph = 0.3;
                        }
                        
                        if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed == 1)
                        {
                            if (obj_settings.changekey == false)
                            {
                                playsnd(global.sounds.snd_opt_rebind_select_option, 1, 0, 1);
                                obj_settings.editing = txt;
                                keyboard_lastkey = -1;
                                gamepadkey = 0;
                                obj_settings.changekey = true;
                                obj_settings.gp_cd = 10;
                            }
                            else if (obj_settings.changekey == true)
                            {
                                playsnd(global.sounds.snd_opt_rebind_select_option, 0.5, 0, 1);
                                obj_settings.changekey = false;
                                obj_settings.editing = "";
                            }
                        }
                    }
                }
                
                if (obj_settings.changekey == true)
                {
                    if (keyboard_lastkey != -1 && obj_settings.selected == "KEYBOARD")
                    {
                        if (obj_settings.editing == "TOGGLE AUTOAIM")
                            global.kb_togaa = keyboard_lastkey;
                        else if (obj_settings.editing == "ACCEPT / INTERACT")
                            global.kb_accept = keyboard_lastkey;
                        else if (obj_settings.editing == "INFO DOCK")
                            global.kb_tabmen = keyboard_lastkey;
                        else if (obj_settings.editing == "MOVE UP")
                            global.kb_up = keyboard_lastkey;
                        else if (obj_settings.editing == "MOVE DOWN")
                            global.kb_down = keyboard_lastkey;
                        else if (obj_settings.editing == "MOVE LEFT")
                            global.kb_left = keyboard_lastkey;
                        else if (obj_settings.editing == "MOVE RIGHT")
                            global.kb_right = keyboard_lastkey;
                        else if (obj_settings.editing == "SNEAK")
                            global.kb_tiptoe = keyboard_lastkey;
                        else if (obj_settings.editing == "BLACKHOLE BOMB")
                            global.kb_bomb = keyboard_lastkey;
                        else if (obj_settings.editing == "PAUSE")
                            global.kb_pause = keyboard_lastkey;
                        else if (obj_settings.editing == "FAST FORWARD")
                            global.kb_ff = keyboard_lastkey;
                        else if (obj_settings.editing == "RANDOMIZE STAGE SONG")
                            global.kb_changesong = keyboard_lastkey;
                        
                        obj_settings.changekey = false;
                        obj_settings.editing = "";
                        playsnd(global.sounds.snd_opt_rebind_key, 1, 0, 1);
                    }
                    
                    if (obj_settings.selected == "CONTROLLER" && gamepadkey != 0)
                    {
                        if (obj_settings.editing == "TOGGLE AUTOAIM")
                            global.gpd_togaa = gamepadkey;
                        else if (obj_settings.editing == "INFO DOCK")
                            global.gpd_tabmen = gamepadkey;
                        else if (obj_settings.editing == "SNEAK")
                            global.gpd_tiptoe = gamepadkey;
                        else if (obj_settings.editing == "BLACKHOLE BOMB")
                            global.gpd_bomb = gamepadkey;
                        else if (obj_settings.editing == "PAUSE")
                            global.gpd_pause = gamepadkey;
                        else if (obj_settings.editing == "ACCEPT / INTERACT")
                            global.gpd_accept = gamepadkey;
                        else if (obj_settings.editing == "FAST FORWARD")
                            global.gpd_ff = gamepadkey;
                        else if (obj_settings.editing == "RANDOMIZE STAGE SONG")
                            global.gpd_changesong = gamepadkey;
                        
                        obj_settings.changekey = false;
                        obj_settings.editing = "";
                        playsnd(global.sounds.snd_opt_rebind_key, 1, 0, 1);
                    }
                    
                    if (obj_settings.gp_cd == 0)
                        gamepadkey = gamepad_return_buttons();
                    else if (gamepad_return_buttons() == 0)
                        obj_settings.gp_cd -= 1;
                }
            }
            
            if (toggle == true)
                draw_sprite_ext(global.sprites.spr_sett_toggle_butt, curr_status, (long_butt_h_width + 300) - 32, start_y + (long_butt_height * i) + (bar_power * bar_percentage), 1, 1, 0, c_white, 1 * hover_alph);
            
            if (inputbox == true)
            {
                if (obj_settings.editing == txt)
                    box_alp = 0.2;
                else
                    box_alp = 1;
                
                draw_sprite_ext(global.sprites.spr_sett_input, 0, long_butt_h_width + 300, start_y + (long_butt_height * i) + (bar_power * bar_percentage), 1, 1, 0, c_white, box_alp * hover_alph);
                var name_ind;
                
                if (obj_settings.selected == "KEYBOARD")
                    name_ind = string(keyparse(curr_status));
                else
                    name_ind = string(gpparse(curr_status));
                
                draw_text_ext(long_butt_h_width + 300, start_y + (long_butt_height * i) + (bar_power * bar_percentage), name_ind, -1, 9999);
            }
        }
    }
    
    for (var i = 0; i < 4; i += 1)
    {
        var tex_alpha = 0;
        
        if (i == 0)
            txt = "GAMEPLAY";
        else if (i == 1)
            txt = "AUDIO";
        else if (i == 2)
            txt = "KEYBOARD";
        else if (i == 3)
            txt = "CONTROLLER";
        
        if (obj_settings.selected == txt)
            tex_alpha = 1;
        else
            tex_alpha = 0.35;
        
        if (obj_settings.bar_clicked == false && collision_rectangle(var_Camx + 1 + (top_butt_width * i), var_Camy + 2, (var_Camx + 1 + (top_butt_width * i) + (top_butt_h_width * 2)) - 2, var_Camy + 2 + (top_butt_h_height * 2), obj_mouse, false, false))
        {
            tex_alpha = 0.75;
            
            if (obj_settings.bar_clicked == false && obj_settings.mouse_released == true)
            {
                if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
                {
                    playsnd(global.sounds.snd_opt_tab_change, 0.9 + (i / 10), 0, 1);
                    obj_settings.selected = txt;
                    obj_settings.changekey = false;
                    obj_settings.editing = "";
                    obj_settings.bar_prog = 0;
                }
            }
        }
        
        draw_sprite_ext(top_butt_spr, 0, 1 + (top_butt_width * i) + top_butt_h_width, 2 + top_butt_h_height, 1, 1, 0, c_white, 1);
        draw_set_alpha(tex_alpha);
        draw_text(1 + (top_butt_width * i) + top_butt_h_width, 2 + top_butt_h_height, txt);
        draw_set_alpha(1);
    }
    
    var finished_spr = global.sprites.spr_sett_finished;
    var finished_butt_width = sprite_get_width(finished_spr);
    var finished_butt_height = sprite_get_height(finished_spr);
    var finished_butt_h_width = finished_butt_width / 2;
    var finished_butt_h_height = finished_butt_height / 2;
    var finished_hover_ind = 0;
    var finished_hover_alph = 1;
    
    if (collision_rectangle(var_Camx + (var_Screenw - finished_butt_width), var_Camy + (var_Screenh - finished_butt_height), var_Camx + var_Screenw, var_Camy + var_Screenh, obj_mouse, false, false) && obj_settings.mouse_released == true)
    {
        finished_hover_ind = 1;
        finished_hover_alph = 0.8;
        
        if (mouse_check_button(mb_left) || global.gp_accept)
        {
            finished_hover_ind = 2;
            finished_hover_alph = 0.4;
        }
        
        if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
        {
            playsnd(global.sounds.snd_opt_save_and_finish, 1, 0, 1);
            obj_settings.alarm[0] = 1;
            
            if (obj_settings.opt_screenshake >= 2 && obj_settings.opt_hitflash >= 2)
                attempt_to_unlock_achievement("Vlambeer");
        }
    }
    
    draw_sprite_ext(global.sprites.spr_sett_finished, 0, var_Screenw - finished_butt_h_width - 1, var_Screenh - finished_butt_h_height - 1, 1, 1, 0, c_white, finished_hover_alph);
    var reset_spr = global.sprites.spr_sett_reset_butt;
    var reset_butt_width = sprite_get_width(reset_spr);
    var reset_butt_height = sprite_get_height(reset_spr);
    var reset_butt_h_width = reset_butt_width / 2;
    var reset_butt_h_height = reset_butt_height / 2;
    var reset_hover_ind = 0;
    var reset_hover_alph = 1;
    
    if (collision_rectangle(var_Camx + 0, (var_Camy + (var_Screenh - reset_butt_height)) - 1, var_Camx + reset_butt_width, var_Camy + var_Screenh, obj_mouse, false, false) && obj_settings.mouse_released == true)
    {
        reset_hover_ind = 1;
        reset_hover_alph = 0.8;
        
        if (mouse_check_button(mb_left) || global.gp_accept)
        {
            reset_hover_ind = 2;
            reset_hover_alph = 0.4;
        }
        
        if (mouse_check_button_released(mb_left) || global.gp_accept_pressed)
        {
            playsnd(global.sounds.snd_opt_reset_to_default, 1, 0, 1);
            
            if (obj_settings.selected == "GAMEPLAY")
            {
                obj_settings.opt_fullscreen = global.def_fullscreen;
                window_set_fullscreen(obj_settings.opt_fullscreen);
                obj_settings.opt_vsync = global.def_vsync;
                display_reset(0, obj_settings.opt_vsync);
                obj_settings.opt_screenshake = global.def_screenshake;
                global.screenshake = obj_settings.opt_screenshake;
                obj_settings.opt_hitflash = global.def_hitflash;
                global.hitflash = obj_settings.opt_hitflash;
                obj_settings.opt_weaptrans = 1;
                obj_settings.opt_autoupgrade = 0;
                obj_settings.opt_autoupgrade_owned = 0;
                obj_settings.opt_autoupgrade_highest = 0;
                obj_settings.opt_xp_scalemod = 1;
                global.xp_scalemod = 1;
                obj_settings.opt_bgalpha = 1;
                obj_settings.opt_permahitbox = 0;
                obj_settings.opt_lowhpeff = 1;
                obj_settings.opt_disable3D = 0;
                obj_settings.opt_show_circle_always = 0;
                global.show_circle_always = 0;
                obj_settings.xp_cans = 1;
                global.xp_cans = 1;
                obj_settings.xp_borderless = 0;
                global.xp_borderless = 0;
                obj_settings.opt_dialogspd = 1;
                obj_settings.opt_manual_antilag = 0;
                global.manual_antilag = 0;
                obj_settings.opt_auto_antilag = 1;
                global.auto_antilag = 1;
                obj_settings.opt_autoalpha = 0;
                global.autoalpha = 0;
                obj_settings.opt_pixelperfect = 1;
                global.pixelperfect = true;
                surface_resize(application_surface, global.screenw, global.screenh);
            }
            else if (obj_settings.selected == "AUDIO")
            {
                obj_settings.opt_mastervol = global.def_mastervol;
                global.master_vol = obj_settings.opt_mastervol;
                obj_settings.opt_musvol = global.def_musvol;
                global.musvol = obj_settings.opt_musvol;
                obj_settings.opt_sndvol = global.def_sndvol;
                global.sndvol = obj_settings.opt_sndvol;
                obj_settings.opt_weaponhitvol = global.def_weaponhitvol;
                global.weapon_hit_vol = obj_settings.opt_weaponhitvol;
                obj_settings.opt_dialogvol = global.def_dialogvol;
                global.dialogvol = obj_settings.opt_dialogvol;
                obj_settings.opt_ae_highpass = 1;
                global.ae_highpass = 1;
                obj_settings.opt_ae_reverb = 1;
                global.ae_reverb = 1;
                obj_settings.opt_ae_bitcrush = 1;
                global.ae_bitcrush = 1;
                obj_settings.opt_mutenofocus = 0;
                global.mutenofocus = obj_settings.opt_mutenofocus;
            }
            else if (obj_settings.selected == "KEYBOARD")
            {
                obj_mouse.autoaim_mouse = global.def_autoaim_mouse;
                global.kb_accept = global.def_kb_accept;
                global.kb_up = global.def_kb_up;
                global.kb_down = global.def_kb_down;
                global.kb_left = global.def_kb_left;
                global.kb_right = global.def_kb_right;
                global.kb_tiptoe = global.def_kb_tiptoe;
                global.kb_bomb = global.def_kb_bomb;
                global.kb_pause = global.def_kb_pause;
                global.kb_ff = global.def_kb_ff;
                global.kb_changesong = global.def_kb_changesong;
            }
            else if (obj_settings.selected == "CONTROLLER")
            {
                obj_mouse.autoaim_gamepad = global.def_autoaim_gamepad;
                global.gpd_togaa = global.def_gp_togaa;
                global.gpd_tiptoe = global.def_gp_tiptoe;
                global.gpd_bomb = global.def_gp_bomb;
                global.gpd_pause = global.def_gp_pause;
                global.gpd_accept = global.def_gp_accept;
                global.gpd_ff = global.def_gp_ff;
                global.gpd_changesong = global.def_gp_changesong;
                obj_settings.opt_sens = 5;
                global.gpd_sens = 5;
                obj_settings.opt_deadzone = 0.1;
                global.gp_deadzone = 0.1;
                obj_settings.opt_gp_allowmouse = 0;
                global.gp_allowmouse = 0;
                obj_settings.opt_gp_dpadupg = 1;
                global.gp_dpadupg = 1;
                obj_settings.opt_gp_autoaimdeadzone = 0;
                global.gp_autoaimdeadzone = 0;
                obj_settings.opt_discontrol = 0;
                global.gp_discontrol = 0;
            }
        }
    }
    
    draw_sprite_ext(reset_spr, 0, reset_butt_h_width + 1, var_Screenh - reset_butt_h_height - 1, 1, 1, 0, c_white, reset_hover_alph);
    
    if (room == rm_test && global.hp > 0 && obj_player.visible == true)
    {
        var sui_spr = global.sprites.spr_sett_suicide;
        var sui_butt_width = sprite_get_width(sui_spr);
        var sui_butt_height = sprite_get_height(sui_spr);
        var sui_butt_h_width = sui_butt_width / 2;
        var sui_butt_h_height = sui_butt_height / 2;
        var sui_hover_ind = 0;
        var sui_hover_alph = 1;
        
        if (collision_rectangle(var_Camx + 0 + 150, (var_Camy + (var_Screenh - sui_butt_height)) - 1, var_Camx + sui_butt_width + 150, var_Camy + var_Screenh, obj_mouse, false, false))
        {
            sui_hover_ind = 1;
            sui_hover_alph = 0.8;
            
            if (mouse_check_button(mb_left) || global.gp_accept)
            {
                sui_hover_ind = 2;
                sui_hover_alph = 0.4;
            }
            
            if (mouse_check_button_released(mb_left) || global.gp_accept_pressed)
            {
                playsnd(global.sounds.snd_opt_reset_to_default, 1, 0, 1);
                obj_settings.alarm[0] = 1;
                global.hp = 0;
                obj_player.alarm[0] = 1;
                global.killed_by = "CAPACITOR OVERCHARGE";
            }
        }
        
        draw_sprite_ext(sui_spr, 0, sui_butt_h_width + 150, var_Screenh - sui_butt_h_height - 2, 1, 1, 0, c_white, sui_hover_alph);
        
        if (global.gamemode != "daily" && global.gamemode != "monthly" && global.has_beaten_game > 0)
        {
            sui_spr = global.sprites.spr_sett_restart;
            sui_butt_width = sprite_get_width(sui_spr);
            sui_butt_height = sprite_get_height(sui_spr);
            sui_butt_h_width = sui_butt_width / 2;
            sui_butt_h_height = sui_butt_height / 2;
            sui_hover_ind = 0;
            sui_hover_alph = 1;
            
            if (collision_rectangle(var_Camx + 0 + 300, (var_Camy + (var_Screenh - sui_butt_height)) - 1, var_Camx + sui_butt_width + 300, var_Camy + var_Screenh, obj_mouse, false, false))
            {
                sui_hover_ind = 1;
                sui_hover_alph = 0.8;
                
                if (mouse_check_button(mb_left) || global.gp_accept)
                {
                    sui_hover_ind = 2;
                    sui_hover_alph = 0.4;
                }
                
                if (mouse_check_button_released(mb_left) || global.gp_accept_pressed)
                {
                    playsnd(global.sounds.snd_opt_reset_to_default, 1, 0, 1);
                    scr_save_settings();
                    global.hp = 0;
                    screenshake(10, 10);
                    obj_player.visible = false;
                    global.song = global.sounds.mus_silence;
                    
                    with (obj_hair_small_part)
                        instance_destroy();
                    
                    var deathspr = instance_create_depth(obj_player.x, obj_player.y, depth, obj_player_death_anim);
                    obj_view.targ = deathspr;
                    scr_saveallgamestats();
                    var ftr_rest = instance_create_depth(x, y, -9999999, obj_fadetoroom);
                    ftr_rest.rm = rm_test;
                    instance_destroy(obj_settings);
                    
                    if (global.gamemode != "freeplay")
                    {
                        obj_stat_track.stat_total_kills += global.ds_enemieskilled;
                        obj_stat_track.stat_upgrades_chosen += global.ds_upgrades;
                        obj_stat_track.stat_total_xp += global.ds_xpearned;
                        obj_stat_track.stat_total_mortality += global.ds_mortality;
                        obj_stat_track.stat_bosses_killed += global.ds_bosseskilled;
                        obj_stat_track.stat_total_runtime += round((global.ds_timesurvivedseconds / 60) + global.ds_timesurvivedminutes);
                        
                        if (((global.ds_timesurvivedseconds / 60) + global.ds_timesurvivedminutes) > obj_stat_track.stat_highest_runtime)
                            obj_stat_track.stat_highest_runtime = (global.ds_timesurvivedseconds / 60) + global.ds_timesurvivedminutes;
                        
                        if (global.ds_mortality > obj_stat_track.stat_highest_mortality)
                            obj_stat_track.stat_highest_mortality = global.ds_mortality;
                        
                        if (global.ds_mortality > 25)
                            obj_stat_track.stat_total_kills += 1;
                        
                        var prestige_add = 0;
                        
                        if (global.prestige > 0)
                        {
                            prestige_add = (global.ds_xpearned / 10) * global.prestige;
                            global.ds_xpearned += round(prestige_add);
                        }
                        
                        global.profile_xp = round(global.profile_xp);
                        
                        repeat (global.game_level_cap)
                        {
                            if (global.profile_level < global.game_level_cap)
                            {
                                global.profile_xp += global.ds_xpearned;
                                global.ds_xpearned = 0;
                                var amount_to_level = global.profile_level * global.level_mod * (1 + (global.profile_level / 20));
                                
                                if (global.profile_xp > amount_to_level)
                                {
                                    global.profile_xp -= amount_to_level;
                                    global.profile_level += 1;
                                }
                            }
                            else
                            {
                                global.profile_level = global.game_level_cap;
                                global.profile_xp = global.profile_level * global.level_mod;
                            }
                        }
                        
                        global.total_runs += 1;
                        ini_open(global.save);
                        ini_write_real("stats", "profile_level", global.profile_level);
                        ini_write_real("stats", "profile_xp", global.profile_xp);
                        ini_write_real("stats", "total_runs", global.total_runs);
                        ini_close();
                        global.points_avaliable = global.profile_level + clamp(obj_stat_track.overdrive_max - 1, 0, 9999);
                        global.ds_itemsandstats = 0;
                        add_damage_to_stats();
                        submit_highscores();
                    }
                }
            }
            
            draw_sprite_ext(sui_spr, 0, sui_butt_h_width + 299, var_Screenh - sui_butt_h_height - 2, 1, 1, 0, c_white, sui_hover_alph);
            
            if (instance_exists(obj_treasure))
            {
                draw_text_setup(16777215, 0, 0, fnt_freddy);
                draw_set_alpha(0.25);
                draw_text_outline(sui_butt_h_width + 299 + 84, var_Screenh - 12, "X: " + string(obj_treasure.x) + "; Y: " + string(obj_treasure.y), -1, 9999, 65280, 0, 1);
                draw_set_alpha(1);
            }
        }
    }
    
    draw_text_reset();
}
