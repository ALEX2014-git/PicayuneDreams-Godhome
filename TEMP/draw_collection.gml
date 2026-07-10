function draw_collection()
{
    var var_Screenw = global.screenw;
    var var_Screenh = global.screenh;
    var var_Camx = global.camx;
    var var_Camy = global.camy;
    var var_CurrentPlayerHP = global.hp;
    var enemies_seen = 0;
    var weapons_seen = 0;
    
    if (instance_exists(obj_stats))
    {
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
                
                if (mouse_check_button_pressed(mb_left) || gamepad_button_check_pressed(0, global.gpd_accept))
                    obj_stats.bar_clicked = true;
            }
            else
            {
                bar_alph = 0.5;
            }
            
            if (obj_stats.bar_clicked == true)
            {
                bar_alph = 1;
                obj_stats.bar_prog = obj_mouse.y - var_Camy;
                
                if (global.using_gamepad == false)
                {
                    if (mouse_check_button_released(mb_left) || !mouse_check_button(mb_left))
                        obj_stats.bar_clicked = false;
                }
                
                if (global.using_gamepad == true)
                {
                    if (gamepad_button_check_released(0, global.gpd_accept) || !gamepad_button_check(0, global.gpd_accept))
                        obj_stats.bar_clicked = false;
                }
            }
            
            obj_stats.bar_prog += (mouse_wheel_down() + -mouse_wheel_up()) * 10;
            var gamepad_analog = gamepad_axis_value(0, gp_axisrv) * 5;
            
            if (global.discontrol == false)
            {
                obj_stats.bar_prog += (gamepad_button_check(0, gp_padd) + -gamepad_button_check(0, gp_padu)) * 5;
                
                if (abs(gamepad_analog) > 0.3)
                    obj_stats.bar_prog += gamepad_analog;
            }
            
            obj_stats.bar_prog = clamp(obj_stats.bar_prog, min_sidebar_y, max_sidebar_y);
            bar_percentage = return_percent(1, obj_stats.bar_prog - min_sidebar_y, max_sidebar_y - min_sidebar_y);
            draw_sprite_ext(global.sprites.spr_sett_bar_block, 0, var_Screenw - 14, obj_stats.bar_prog, 1, 1, 0, c_white, bar_alph);
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
        var timer_check = round(get_timer() / 1000000);
        var maxwrap = 3;
        
        if (obj_stat_track.stat_highest_mortality > 26)
            maxwrap = 6;
        
        var wrap3 = wrap(timer_check, 0, maxwrap);
        var wrap2 = wrap(timer_check, 0, 2);
        var lay = 0;
        var moused_over = false;
        
        for (var i = 0; i < 55; i += 1)
        {
            txt = "";
            var noshow = false;
            var toggle = false;
            var bar = false;
            var inputbox = false;
            var unlock = false;
            var curr_status = 0;
            var bar_prog = 0;
            var max_ret = 1;
            var min_ret = 0;
            var hover_ind = 0;
            var hover_alph = 1;
            var sprite_prev = global.sprites.spr_nothing;
            var sprite_scal = 0.4;
            var reward_prev = global.sprites.spr_nothing;
            var reward_scal = 0.4;
            var stat_t = 0;
            var draw_back = true;
            var mouseover = false;
            var e_hp = "";
            var e_spd = "";
            var e_desc = "";
            var extra_st = "";
            lay = 0;
            var grid_lr = 0;
            var mission_track = 0;
            var mission_complete = 0;
            var weapon_id = 0;
            
            if (obj_stats.selected == "UNLOCKS")
            {
                unlock = true;
                
                switch (i)
                {
                    case 0:
                        txt = "'DYNAMITE' - USE 10 GRENADES.";
                        sprite_prev = global.sprites.spr_pickup_bomb;
                        sprite_scal = 1;
                        reward_prev = global.sprites.spr_solid_C4;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_grenade_pickup;
                        mission_complete = 10;
                        break;
                    
                    case 1:
                        txt = "'PURGE' - USE 10 MAGNETS.";
                        sprite_prev = global.sprites.spr_pickup_magnet;
                        sprite_scal = 1;
                        reward_prev = global.sprites.spr_solid_Satellite;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_magnet_pickup;
                        mission_complete = 10;
                        break;
                    
                    case 2:
                        txt = "'TROPOSPHERE' - SURPASS 5 MORTALITY.";
                        sprite_prev = global.sprites.spr_soul_1_SE;
                        sprite_scal = 0.75;
                        reward_prev = global.sprites.spr_solid_Turret;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_highest_mortality;
                        mission_complete = 5.01;
                        break;
                    
                    case 3:
                        txt = "'STRATOSPHERE' - SURPASS 10 MORTALITY.";
                        sprite_prev = global.sprites.spr_glove_1_SE;
                        sprite_scal = 0.75;
                        reward_prev = global.sprites.spr_solid_Engine;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_highest_mortality;
                        mission_complete = 10.01;
                        break;
                    
                    case 4:
                        txt = "'MESOSPHERE' - SURPASS 15 MORTALITY.";
                        sprite_prev = global.sprites.spr_skull_1_SE;
                        sprite_scal = 0.75;
                        reward_prev = global.sprites.spr_solid_DigiWatch;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_highest_mortality;
                        mission_complete = 15.01;
                        break;
                    
                    case 5:
                        txt = "'THERMOSPHERE' - SURPASS 20 MORTALITY.";
                        sprite_prev = global.sprites.spr_skull_2_SE;
                        sprite_scal = 0.75;
                        reward_prev = global.sprites.spr_solid_Horns;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_highest_mortality;
                        mission_complete = 20.01;
                        break;
                    
                    case 6:
                        txt = "'EXOSPHERE' - COMPLETE THE MISSION.";
                        sprite_prev = global.sprites.spr_skull_3_SE;
                        sprite_scal = 0.75;
                        reward_prev = global.sprites.spr_solid_Telecom;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = global.has_beaten_game;
                        mission_complete = 1;
                        break;
                    
                    case 7:
                        txt = "'DEADLY' - BE STILL FOR 5 MINUTES.";
                        sprite_prev = global.sprites.spr_solid_ChainBelt;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_AngelWings;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_time_spent_still;
                        mission_complete = 36000;
                        break;
                    
                    case 8:
                        txt = "'MURDERER' - KILL 100000 ENEMIES.";
                        sprite_prev = global.sprites.spr_death_explosion1;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Ninja;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_total_kills;
                        mission_complete = 100000;
                        break;
                    
                    case 9:
                        txt = "'PERCEIVER' - USE 10 STATUES.";
                        sprite_prev = global.sprites.spr_statue_angel;
                        sprite_scal = 0.2;
                        reward_prev = global.sprites.spr_solid_Remote;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_statues_used;
                        mission_complete = 10;
                        break;
                    
                    case 10:
                        txt = "'UPGRADE' - EQUIP 8 CORES AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_Core;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_UltraBuster;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_core_high;
                        mission_complete = 8;
                        break;
                    
                    case 11:
                        txt = "'IMMORTAL' - EQUIP 8 IV BAGS AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_IVBag;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Halo;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_ivbag_high;
                        mission_complete = 8;
                        break;
                    
                    case 12:
                        txt = "'MEGAWATT' - EQUIP 8 CHAINBELTS AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_ChainBelt;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_SlimeSpike;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_chainbelt_high;
                        mission_complete = 8;
                        break;
                    
                    case 13:
                        txt = "'GRINDER' - EQUIP 8 LEG SAWS AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_LegSaw;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Hydrocillator;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_legsaw_high;
                        mission_complete = 8;
                        break;
                    
                    case 14:
                        txt = "'SCOURGE' - EQUIP 8 MASKS OF PLAGUE AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_PlagueMask;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_FireLighter;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_plaguemask_high;
                        mission_complete = 8;
                        break;
                    
                    case 15:
                        txt = "'PREY' - EQUIP 8 HUNTER BOWS AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_Bow;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Flamethrower;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_bow_high;
                        mission_complete = 8;
                        break;
                    
                    case 16:
                        txt = "'ELASTIC' - EQUIP 8 HYDROCILLATORS AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_Hydrocillator;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Headphones;
                        reward_scal = 0.4;
                        stat_t = obj_stat_track.unlocked_hydro;
                        mission_track = obj_stat_track.stat_hydro_high;
                        mission_complete = 8;
                        break;
                    
                    case 17:
                        txt = "'SPINOUS' - EQUIP 8 SLIME SPIKES AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_SlimeSpike;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Spear;
                        reward_scal = 0.4;
                        stat_t = obj_stat_track.unlocked_slimespike;
                        mission_track = obj_stat_track.stat_slimespike_high;
                        mission_complete = 8;
                        break;
                    
                    case 18:
                        txt = "'JOCKEY' - EQUIP 8 ENGINES AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_Engine;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_BatWings;
                        reward_scal = 0.4;
                        stat_t = obj_stat_track.unlocked_engine;
                        mission_track = obj_stat_track.stat_engine_high;
                        mission_complete = 8;
                        break;
                    
                    case 19:
                        txt = "'MARTYRDOM' - EQUIP 8 C4 AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_C4;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_ShottyVest;
                        reward_scal = 0.4;
                        stat_t = obj_stat_track.unlocked_c4;
                        mission_track = obj_stat_track.stat_C4_high;
                        mission_complete = 8;
                        break;
                    
                    case 20:
                        txt = "'FIREBUG' - EQUIP 8 FIRE LIGHTERS AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_FireLighter;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_IceCream;
                        reward_scal = 0.4;
                        stat_t = obj_stat_track.unlocked_firelighter;
                        mission_track = obj_stat_track.stat_firelighter_high;
                        mission_complete = 8;
                        break;
                    
                    case 21:
                        txt = "'PYROMANIAC' - EQUIP 8 FLAMETHROWERS AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_Flamethrower;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_SnowGlobe;
                        reward_scal = 0.4;
                        stat_t = obj_stat_track.unlocked_flamethrower;
                        mission_track = obj_stat_track.stat_flamethrower_high;
                        mission_complete = 8;
                        break;
                    
                    case 22:
                        txt = "'REFRIGERATE' - EQUIP 8 FROSTY CONES AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_IceCream;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Eel;
                        reward_scal = 0.4;
                        stat_t = obj_stat_track.unlocked_icecream;
                        mission_track = obj_stat_track.stat_icecream_high;
                        mission_complete = 8;
                        break;
                    
                    case 23:
                        txt = "'PRESERVED' - EQUIP 8 SNOW GLOBES AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_SnowGlobe;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Plasma;
                        reward_scal = 0.4;
                        stat_t = obj_stat_track.unlocked_snowglobe;
                        mission_track = obj_stat_track.stat_snowglobe_high;
                        mission_complete = 8;
                        break;
                    
                    case 24:
                        txt = "'VOLTAIC' - EQUIP 8 ELECTRIC EELS AT ONCE.";
                        sprite_prev = global.sprites.spr_solid_Eel;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Gem;
                        reward_scal = 0.4;
                        stat_t = obj_stat_track.unlocked_eel;
                        mission_track = obj_stat_track.stat_eel_high;
                        mission_complete = 8;
                        break;
                    
                    case 25:
                        txt = "'MANUAL' - FINISH A RUN WITHOUT USING AUTOAIM.";
                        sprite_prev = global.sprites.spr_cursor;
                        sprite_scal = 2;
                        reward_prev = global.sprites.spr_solid_Sword;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_noautoaim;
                        mission_complete = 1;
                        break;
                    
                    case 26:
                        txt = "'INVESTOR' - FINISH A RUN WITH ALL FISHSTOCK SKILLS.";
                        sprite_prev = global.sprites.spr_fish_1_SE;
                        sprite_scal = 0.75;
                        reward_prev = global.sprites.spr_solid_Firewall;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_fishstockrun;
                        mission_complete = 1;
                        break;
                    
                    case 27:
                        txt = "'RIGOROUS' - KILL ALL OPTIONAL BOSSES IN ONE RUN.";
                        sprite_prev = global.sprites.spr_Yuki_Idle_SE;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Death;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_killedallrun;
                        mission_complete = 1;
                        break;
                    
                    case 28:
                        txt = "'PURSUIT' - SHOW NO MERCY.";
                        sprite_prev = global.sprites.spr_black_seam;
                        sprite_scal = 1;
                        reward_prev = global.sprites.spr_solid_Corrupt;
                        reward_scal = 0.4;
                        stat_t = global.has_beaten_game;
                        mission_track = obj_stat_track.stat_ab_picayune_kills;
                        mission_complete = 1;
                        break;
                    
                    case 29:
                        txt = "'ABSORBENT' - ACTIVATE 20 BLACKHOLES IN ONE RUN.";
                        sprite_prev = global.sprites.spr_pickup_blackhole;
                        sprite_scal = 1;
                        reward_prev = global.sprites.spr_solid_Cigar;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_blackholes_used_onerun;
                        mission_complete = 20;
                        break;
                    
                    case 30:
                        txt = "'DEFACE' - DESTROY 20 STATUES.";
                        sprite_prev = global.sprites.spr_statue_2skulls;
                        sprite_scal = 0.2;
                        reward_prev = global.sprites.spr_solid_Dynamite;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_statues_destroyed;
                        mission_complete = 20;
                        break;
                    
                    case 31:
                        txt = "'DELIVERY' - GO REALLY FAR.";
                        sprite_prev = global.sprites.spr_dest_box1;
                        sprite_scal = 0.6;
                        reward_prev = global.sprites.spr_solid_Award;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_goreallyfar;
                        mission_complete = 1;
                        break;
                    
                    case 32:
                        txt = "'EUTHANASIA' - KILL INFECTED IZU.";
                        sprite_prev = global.sprites.spr_AB_Gremlin_Death_Head;
                        sprite_scal = 1;
                        reward_prev = global.sprites.spr_solid_Carrot;
                        reward_scal = 0.4;
                        stat_t = global.has_beaten_game;
                        mission_track = obj_stat_track.stat_ab_bunny_kills;
                        mission_complete = 1;
                        break;
                    
                    case 33:
                        txt = "'HUNT' - KILL ALL BASIC ENEMIES ONCE.";
                        sprite_prev = global.sprites.spr_cornchip_SE;
                        sprite_scal = 0.75;
                        reward_prev = global.sprites.spr_solid_Bees;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = sign(obj_stat_track.stat_soul_kills) + sign(obj_stat_track.stat_fish_kills) + sign(obj_stat_track.stat_glove_kills) + sign(obj_stat_track.stat_skull_kills) + sign(obj_stat_track.stat_face_kills) + sign(obj_stat_track.stat_cornchip_kills) + sign(obj_stat_track.stat_wibbler_kills) + sign(obj_stat_track.stat_burger_kills) + sign(obj_stat_track.stat_droid_kills) + sign(obj_stat_track.stat_spider_kills) + sign(obj_stat_track.stat_shielder_kills) + sign(obj_stat_track.stat_face_kills) + sign(obj_stat_track.stat_exploder_kills) + sign(obj_stat_track.stat_warper_kills) + sign(obj_stat_track.stat_wisp_kills) + sign(obj_stat_track.stat_peapod_kills) + sign(obj_stat_track.stat_centa_kills) + sign(obj_stat_track.stat_sniper_kills) + sign(obj_stat_track.stat_lob_kills) + sign(obj_stat_track.stat_bishop_kills) + sign(obj_stat_track.stat_elude_kills) + sign(obj_stat_track.stat_lidean_kills);
                        mission_complete = 22;
                        break;
                    
                    case 34:
                        txt = "'VALUABLE' - FINISH A RUN WITH 150%+ XP_MOD.";
                        sprite_prev = global.sprites.spr_xp_can;
                        sprite_scal = 1;
                        reward_prev = global.sprites.spr_solid_Monkey;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_most_xp_worth;
                        mission_complete = 1.5;
                        break;
                    
                    case 35:
                        txt = "'BANKRUPT' - SACRIFICE 25 CROWNS TO A STATUE.";
                        sprite_prev = global.sprites.spr_solid_Crown;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Midas;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_sacrificed_crowns;
                        mission_complete = 25;
                        break;
                    
                    case 36:
                        txt = "'SHIPWRECK' - KILL THE DIVER.";
                        sprite_prev = global.sprites.spr_Diver_Idle_SE;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_solid_Fish;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_diver_kills;
                        mission_complete = 1;
                        break;
                    
                    case 37:
                        txt = "'FRUGAL' - FINISH A RUN WITH 5 OR LESS SKILLS.";
                        sprite_prev = global.sprites.spr_default_death;
                        sprite_scal = 0.6;
                        reward_prev = global.sprites.spr_solid_Cheese;
                        reward_scal = 0.4;
                        stat_t = 1;
                        mission_track = 6 - obj_stat_track.stat_lowest_skills;
                        mission_complete = 1;
                        break;
                    
                    case 38:
                        txt = "'TRANSGRESS' - OUT OF BOUNDS.";
                        sprite_prev = choose(global.sprites.spr_matt_face, global.sprites.spr_nothing);
                        sprite_scal = 0.7;
                        reward_prev = global.sprites.spr_solid_Psycho;
                        reward_scal = 0.4;
                        stat_t = global.has_beaten_game;
                        mission_track = obj_stat_track.stat_outofbounds;
                        mission_complete = 1;
                        break;
                    
                    case 39:
                        txt = "'INVINCIBLE' - GET 30 FLAWLESS KILLS.";
                        sprite_prev = global.sprites.spr_pickup_floppy;
                        sprite_scal = 1;
                        reward_prev = global.sprites.spr_glass_move_se;
                        reward_scal = 0.6;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_bunny_flawless + obj_stat_track.stat_ab_bunny_flawless + obj_stat_track.stat_worm_flawless + obj_stat_track.stat_ab_worm_flawless + obj_stat_track.stat_biker_flawless + obj_stat_track.stat_ab_biker_flawless + obj_stat_track.stat_demon_flawless + obj_stat_track.stat_ab_demon_flawless + obj_stat_track.stat_picayune_flawless + obj_stat_track.stat_ab_picayune_flawless + obj_stat_track.stat_umi_flawless + obj_stat_track.stat_ghost_flawless + obj_stat_track.stat_diver_flawless + obj_stat_track.stat_yuki_flawless;
                        mission_complete = 30;
                        break;
                    
                    case 40:
                        txt = "'SLUG' - FINISH A RUN WITH 75% OR LESS COOLDOWN.";
                        sprite_prev = global.sprites.spr_solid_Driller;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_worn_move_se;
                        reward_scal = 0.6;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_lowerthanfiftycd;
                        mission_complete = 1;
                        break;
                    
                    case 41:
                        txt = "'SAVANT' - UPGRADE 300+ TIMES IN ONE RUN.";
                        sprite_prev = global.sprites.spr_xp_can;
                        sprite_scal = 1;
                        reward_prev = global.sprites.spr_absorb_move_se;
                        reward_scal = 0.6;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_highest_upgrades;
                        mission_complete = 300;
                        break;
                    
                    case 42:
                        txt = "'RESTED' - GO TO THE BEACH.";
                        sprite_prev = global.sprites.spr_nothing;
                        sprite_scal = 1;
                        reward_prev = global.sprites.spr_picaface_2;
                        reward_scal = 1;
                        stat_t = global.has_beaten_game;
                        mission_track = global.has_beaten_game;
                        mission_complete = 2;
                        break;
                    
                    case 43:
                        txt = "'DEXTEROUS' - FINISH A RUN WITH 20+ ITEMS.";
                        sprite_prev = global.sprites.spr_solid_Core;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_versatile_move_se;
                        reward_scal = 0.6;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_highest_items;
                        mission_complete = 20;
                        break;
                    
                    case 44:
                        txt = "'ORGANIZED' - FINISH A RUN WITH 4 OR LESS ITEMS.";
                        sprite_prev = global.sprites.spr_solid_Core;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_optimized_move_se;
                        reward_scal = 0.6;
                        stat_t = 1;
                        mission_track = 5 - obj_stat_track.stat_lowest_items;
                        mission_complete = 1;
                        break;
                    
                    case 45:
                        txt = "'MINIMALIST' - FINISH A RUN WITH 2 OR LESS ITEMS.";
                        sprite_prev = global.sprites.spr_solid_Core;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_perfected_move_se;
                        reward_scal = 0.6;
                        stat_t = 1;
                        mission_track = 3 - obj_stat_track.stat_lowest_items;
                        mission_complete = 1;
                        break;
                    
                    case 46:
                        txt = "'WALL' - FINISH A RUN TAKING 50+ DIRECT HITS.";
                        sprite_prev = global.sprites.spr_solid_IVBag;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_tank_move_se;
                        reward_scal = 0.6;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_most_direct_hits_in_one_run;
                        mission_complete = 50;
                        break;
                    
                    case 47:
                        txt = "'FLEET' - KILL A BOSS IN LESS THAN 20 SECONDS.";
                        sprite_prev = global.sprites.spr_Biker_Death;
                        sprite_scal = 0.6;
                        reward_prev = global.sprites.spr_spammer_move_se;
                        reward_scal = 0.6;
                        stat_t = 1;
                        mission_track = 21 - (obj_stat_track.stat_fastest_boss_death / 60);
                        mission_complete = 1;
                        break;
                    
                    case 48:
                        txt = "'CONDENSATION' - FINISH A RUN WITH ELEMENTALS ONLY.";
                        sprite_prev = global.sprites.spr_solid_Gem;
                        sprite_scal = 0.4;
                        reward_prev = global.sprites.spr_elemental_move_se;
                        reward_scal = 0.6;
                        stat_t = 1;
                        mission_track = obj_stat_track.stat_elemental_run;
                        mission_complete = 1;
                        break;
                    
                    default:
                        txt = "";
                        noshow = true;
                        break;
                }
                
                bar_power = -(long_butt_height * 50);
            }
            else if (obj_stats.selected == "STATS")
            {
                switch (i)
                {
                    case 0:
                        stat_t = obj_stat_track.stat_total_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "TOTAL KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_death_explosion1;
                            sprite_scal = 0.4;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 1:
                        stat_t = obj_stat_track.stat_bosses_killed;
                        
                        if (stat_t != 0)
                        {
                            txt = "BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_Gremlin_Death_Head;
                            sprite_scal = 0.8;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 2:
                        stat_t = obj_stat_track.stat_runs_attempted;
                        
                        if (stat_t != 0)
                            txt = "RUNS ATTEMPTED: " + string(stat_t);
                        else
                            txt = "???";
                        
                        break;
                    
                    case 3:
                        stat_t = obj_stat_track.stat_runs_completed;
                        
                        if (stat_t != 0)
                            txt = "RUNS COMPLETE: " + string(stat_t);
                        else
                            txt = "???";
                        
                        break;
                    
                    case 4:
                        stat_t = obj_stat_track.stat_total_xp;
                        
                        if (stat_t != 0)
                            txt = "TOTAL XP: " + string(stat_t);
                        else
                            txt = "???";
                        
                        break;
                    
                    case 5:
                        stat_t = obj_stat_track.stat_upgrades_chosen;
                        
                        if (stat_t != 0)
                        {
                            txt = "TOTAL UPGRADES: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_floppy;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 6:
                        stat_t = obj_stat_track.stat_upgrades_rerolled;
                        
                        if (stat_t != 0)
                        {
                            txt = "TOTAL REROLLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_dice;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 7:
                        stat_t = obj_stat_track.stat_upgrades_banned;
                        
                        if (stat_t != 0)
                        {
                            txt = "TOTAL BANS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_upg_ban;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 8:
                        stat_t = obj_stat_track.stat_locations_visited;
                        
                        if (stat_t != 0)
                            txt = "LOCATIONS VISITED: " + string(stat_t);
                        else
                            txt = "???";
                        
                        break;
                    
                    case 9:
                        stat_t = obj_stat_track.stat_areas_without_mod;
                        
                        if (stat_t != 0)
                            txt = "NORMAL LOCATIONS CHOSEN: " + string(stat_t);
                        else
                            txt = "???";
                        
                        break;
                    
                    case 10:
                        stat_t = obj_stat_track.stat_areas_with_modify;
                        
                        if (stat_t != 0)
                            txt = "MODIFIED LOCATIONS CHOSEN: " + string(stat_t);
                        else
                            txt = "???";
                        
                        break;
                    
                    case 11:
                        stat_t = obj_stat_track.stat_damage_taken;
                        
                        if (stat_t != 0)
                            txt = "DAMAGE TAKEN: " + string(stat_t) + " HP";
                        else
                            txt = "???";
                        
                        break;
                    
                    case 12:
                        stat_t = obj_stat_track.stat_times_died;
                        
                        if (stat_t != 0)
                        {
                            txt = "TIMES DIED: " + string(stat_t);
                            sprite_prev = global.sprites.spr_default_death;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 13:
                        stat_t = obj_stat_track.stat_time_spent_still;
                        
                        if (stat_t != 0)
                        {
                            txt = "TIME SPENT STILL: " + string(stat_t / 60 / 60) + " minutes";
                            sprite_prev = global.sprites.spr_default_idle_se;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 14:
                        stat_t = obj_stat_track.stat_time_spent_moving;
                        
                        if (stat_t != 0)
                        {
                            txt = "TIME SPENT MOVING: " + string(stat_t / 60 / 60) + " minutes";
                            sprite_prev = global.sprites.spr_default_move_se;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 15:
                        stat_t = obj_stat_track.stat_distance_travelled;
                        
                        if (stat_t != 0)
                        {
                            txt = "DISTANCE TRAVELLED: " + string(stat_t / 10) + "m";
                            sprite_prev = global.sprites.spr_default_move_se;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 16:
                        stat_t = obj_stat_track.stat_blackholes_used;
                        
                        if (stat_t != 0)
                        {
                            txt = "BLACKHOLES USED: " + string(stat_t);
                            sprite_prev = global.sprites.spr_blackhole;
                            sprite_scal = 0.1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 17:
                        stat_t = obj_stat_track.stat_statues_used;
                        
                        if (stat_t != 0)
                        {
                            txt = "STATUES USED: " + string(stat_t);
                            sprite_prev = global.sprites.spr_statue_angel;
                            sprite_scal = 0.2;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 18:
                        stat_t = obj_stat_track.stat_total_mortality;
                        
                        if (stat_t != 0)
                            txt = "TOTAL MORTALITY: " + string(stat_t);
                        else
                            txt = "???";
                        
                        break;
                    
                    case 19:
                        stat_t = obj_stat_track.stat_highest_mortality;
                        
                        if (stat_t != 0)
                            txt = "HIGHEST MORTALITY: " + string(stat_t);
                        else
                            txt = "???";
                        
                        break;
                    
                    case 20:
                        stat_t = obj_stat_track.stat_total_runtime;
                        
                        if (stat_t != 0)
                            txt = "TOTAL RUNTIME: " + string(stat_t) + " minutes";
                        else
                            txt = "???";
                        
                        break;
                    
                    case 21:
                        stat_t = obj_stat_track.stat_highest_runtime;
                        
                        if (stat_t != 0)
                            txt = "HIGHEST RUNTIME: " + string(stat_t) + " minutes";
                        else
                            txt = "???";
                        
                        break;
                    
                    case 22:
                        stat_t = obj_stat_track.stat_hpvial_pickup;
                        
                        if (stat_t != 0)
                        {
                            txt = "HP VIAL PICKUPS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_health;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 23:
                        stat_t = obj_stat_track.stat_grenade_pickup;
                        
                        if (stat_t != 0)
                        {
                            txt = "GRENADE PICKUPS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_bomb;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 24:
                        stat_t = obj_stat_track.stat_blackhole_pickup;
                        
                        if (stat_t != 0)
                        {
                            txt = "BLACKHOLE PICKUPS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_blackhole;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 25:
                        stat_t = obj_stat_track.stat_magnet_pickup;
                        
                        if (stat_t != 0)
                        {
                            txt = "MAGNET PICKUPS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_magnet;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 26:
                        stat_t = obj_stat_track.stat_floppy_pickup;
                        
                        if (stat_t != 0)
                        {
                            txt = "FLOPPY PICKUPS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_floppy;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 27:
                        stat_t = obj_stat_track.stat_dice_pickup;
                        
                        if (stat_t != 0)
                        {
                            txt = "DICE PICKUPS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_dice;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 28:
                        stat_t = obj_stat_track.stat_drill_pickup;
                        
                        if (stat_t != 0)
                        {
                            txt = "DRILL PICKUPS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_driller;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 29:
                        stat_t = obj_stat_track.stat_memories_visited;
                        
                        if (stat_t != 0)
                        {
                            txt = "DREAMS VISITED: " + string(stat_t);
                            sprite_prev = global.sprites.spr_rpg_picayune_walk_down;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 30:
                        stat_t = obj_stat_track.stat_bunny_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "BUNNY BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_Gremlin_Idle_SE;
                            sprite_scal = 0.6;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 31:
                        stat_t = obj_stat_track.stat_worm_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "WORM BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_Worm_1_NE;
                            sprite_scal = 0.6;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 32:
                        stat_t = obj_stat_track.stat_biker_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "BIKER BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_Biker_Drive_SE;
                            sprite_scal = 0.6;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 33:
                        stat_t = obj_stat_track.stat_demon_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "DEMON BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_Demon_Idle_SE;
                            sprite_scal = 0.4;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 34:
                        stat_t = obj_stat_track.stat_picayune_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "picayune KILLS: " + string(stat_t);
                            sprite_prev = choose(global.sprites.spr_picayune_faces, global.sprites.spr_picayune_hair, global.sprites.spr_picayunehitbox, global.sprites.spr_picayune_head, global.sprites.spr_picayune_left_socket, global.sprites.spr_picayune_right_socket);
                            sprite_scal = wave(0.065, 0.08, 0.1, random_range(-0.2, 0.2));
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 35:
                        stat_t = obj_stat_track.stat_ghost_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "GHOST BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_Ghost_Idle_SE;
                            sprite_scal = 0.6;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 36:
                        stat_t = obj_stat_track.stat_yuki_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "YUKI BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_Yuki_Idle_SE;
                            sprite_scal = 0.6;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 37:
                        stat_t = obj_stat_track.stat_diver_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "DIVER BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_Diver_Idle_SE;
                            sprite_scal = 0.6;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 38:
                        stat_t = obj_stat_track.stat_umi_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "UMI BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_Umi_Idle;
                            sprite_scal = 0.6;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 39:
                        stat_t = obj_stat_track.stat_ab_bunny_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "INFECTED BUNNY BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_AB_Gremlin_Idle_SE;
                            sprite_scal = 0.6;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 40:
                        stat_t = obj_stat_track.stat_ab_worm_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "INFECTED WORM BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_AB_Worm_Head_NE;
                            sprite_scal = 0.6;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 41:
                        stat_t = obj_stat_track.stat_ab_biker_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "INFECTED BIKER BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_AB_Biker_Fly_SE;
                            sprite_scal = 0.6;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 42:
                        stat_t = obj_stat_track.stat_ab_demon_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "INFECTED DEMON BOSS KILLS: " + string(stat_t);
                            sprite_prev = global.sprites.spr_AB_Demon_Idle_SE;
                            sprite_scal = 0.4;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 43:
                        stat_t = obj_stat_track.stat_ab_picayune_kills;
                        
                        if (stat_t != 0)
                        {
                            txt = "INFECTED FUSION SURVIVALS: " + string(stat_t);
                            sprite_prev = choose(global.sprites.spr_picayune_ab_head, global.sprites.spr_picayune_ab_torso, global.sprites.spr_picayune_ab_index, global.sprites.spr_picayune_ab_lefteye, global.sprites.spr_picayune_ab_wrist, global.sprites.spr_picayune_ab_thumb, global.sprites.spr_double_picayune);
                            sprite_scal = wave(0.065, 0.08, 0.1, random_range(-0.2, 0.2));
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 44:
                        stat_t = obj_stat_track.stat_blackholes_used_onerun;
                        
                        if (stat_t != 0)
                        {
                            txt = "MOST BLACKHOLES USED IN A RUN: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_blackhole;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 45:
                        stat_t = obj_stat_track.stat_statues_destroyed;
                        
                        if (stat_t != 0)
                        {
                            txt = "STATUES DESTROYED: " + string(stat_t);
                            sprite_prev = global.sprites.spr_statue_2skulls;
                            sprite_scal = 0.2;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 46:
                        stat_t = obj_stat_track.stat_most_xp_worth;
                        
                        if (stat_t != 0)
                        {
                            txt = "HIGHEST EVER XP_MOD: " + string(stat_t);
                            sprite_prev = global.sprites.spr_xp_can;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 47:
                        stat_t = obj_stat_track.stat_lowest_skills;
                        txt = "LOWEST SKILLS RUN: " + string(stat_t);
                        sprite_prev = global.sprites.spr_default_death;
                        sprite_scal = 0.6;
                        break;
                    
                    case 48:
                        stat_t = obj_stat_track.stat_lowest_items;
                        txt = "LOWEST ITEMS RUN: " + string(stat_t);
                        sprite_prev = global.sprites.spr_solid_Core;
                        sprite_scal = 0.4;
                        break;
                    
                    case 49:
                        stat_t = obj_stat_track.stat_highest_skills;
                        
                        if (stat_t != 0)
                        {
                            txt = "HIGHEST SKILLS RUN: " + string(stat_t);
                            sprite_prev = global.sprites.spr_default_move_se;
                            sprite_scal = 0.4;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 50:
                        stat_t = obj_stat_track.stat_highest_items;
                        
                        if (stat_t != 0)
                        {
                            txt = "HIGHEST ITEMS RUN: " + string(stat_t);
                            sprite_prev = global.sprites.spr_solid_UltraBuster;
                            sprite_scal = 0.4;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 51:
                        stat_t = obj_stat_track.stat_highest_upgrades;
                        
                        if (stat_t != 0)
                        {
                            txt = "MOST UPGRADES RUN: " + string(stat_t);
                            sprite_prev = global.sprites.spr_pickup_floppy;
                            sprite_scal = 1;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 52:
                        stat_t = obj_stat_track.stat_fastest_boss_death / 60;
                        
                        if (stat_t != 0)
                        {
                            txt = "FASTEST BOSS DEATH: " + string(stat_t);
                            sprite_prev = global.sprites.spr_Biker_Death;
                            sprite_scal = 0.5;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    case 53:
                        stat_t = obj_stat_track.stat_most_direct_hits_in_one_run;
                        
                        if (stat_t != 0)
                        {
                            txt = "MOST DIRECT HITS RUN: " + string(stat_t);
                            sprite_prev = global.sprites.spr_solid_IVBag;
                            sprite_scal = 0.4;
                        }
                        else
                        {
                            txt = "???";
                        }
                        
                        break;
                    
                    default:
                        txt = "";
                        noshow = true;
                        break;
                }
                
                bar_power = -(long_butt_height * 55);
            }
            else if (obj_stats.selected == "UPGRADES")
            {
                draw_back = false;
                long_butt_height = 84;
                start_y = 118;
                mouseover = true;
                
                switch (i)
                {
                    case 0:
                        lay = 0;
                        grid_lr = -1;
                        weapon_id = 1;
                        stat_t = 1;
                        txt = "CORE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_core_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_core_high);
                        e_desc = "The suit's built in automated defense system. Fires bullets in the direction of the cursor.";
                        extra_st = "Increases damage, bullet count and spread.";
                        sprite_prev = global.sprites.spr_solid_Core;
                        sprite_scal = 0.6;
                        break;
                    
                    case 1:
                        lay = 0;
                        grid_lr = 0;
                        weapon_id = 2;
                        stat_t = 1;
                        txt = "CHAINBELT";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_chainbelt_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_chainbelt_high);
                        e_desc = "Lasers fire out from your center, protecting you from all directions. Constantly dealing damage to enemies within its radius.";
                        extra_st = "Increases damage and size.";
                        sprite_prev = global.sprites.spr_solid_ChainBelt;
                        sprite_scal = 0.6;
                        break;
                    
                    case 2:
                        lay = 0;
                        grid_lr = 1;
                        weapon_id = 3;
                        stat_t = 1;
                        txt = "DAGGER GLOVE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_daggerglove_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_daggerglove_high);
                        e_desc = "Slashes in the direction of the cursor, dealing high damage with a high cooldown.";
                        extra_st = "Increases damage, slash count and spread.";
                        sprite_prev = global.sprites.spr_solid_DaggerGlove;
                        sprite_scal = 0.6;
                        break;
                    
                    case 3:
                        lay = 1;
                        grid_lr = -1;
                        weapon_id = 4;
                        stat_t = 1;
                        txt = "EYE2";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_eye2_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_eye2_high);
                        e_desc = "A high powered, infinitely piercing beam that deals low constant damage from your eye to as far as you can see.";
                        extra_st = "Increases damage and size.";
                        sprite_prev = global.sprites.spr_solid_Eye2;
                        sprite_scal = 0.6;
                        break;
                    
                    case 4:
                        lay = 1;
                        grid_lr = 0;
                        weapon_id = 0;
                        stat_t = 1;
                        txt = "INJECTION";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_injection_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_injection_high);
                        e_desc = "Adds some extra filling to your upgrades, making them bigger and able to hit more enemies.";
                        extra_st = "Increases weapon size.";
                        sprite_prev = global.sprites.spr_solid_Injection;
                        sprite_scal = 0.6;
                        break;
                    
                    case 5:
                        lay = 1;
                        grid_lr = 1;
                        weapon_id = 0;
                        stat_t = 1;
                        txt = "ENERGIZING BATTERY";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_battery_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_battery_high);
                        e_desc = "Overcharges your weapons, making them move faster and fly quicker.";
                        extra_st = "Increases projectile speed.";
                        sprite_prev = global.sprites.spr_solid_Battery;
                        sprite_scal = 0.6;
                        break;
                    
                    case 6:
                        lay = 2;
                        grid_lr = -1;
                        weapon_id = 0;
                        stat_t = 1;
                        txt = "IV BAG";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_ivbag_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_ivbag_high);
                        e_desc = "A juicy top-up of that red stuff! A small HP bonus and makes Health Vials more effective. Also enables Overheal, slowly decaying the points above your Max HP.";
                        extra_st = "Increases Current HP, Max HP, HP Vial Bonus and Overheal lifetime.";
                        sprite_prev = global.sprites.spr_solid_IVBag;
                        sprite_scal = 0.6;
                        break;
                    
                    case 7:
                        lay = 2;
                        grid_lr = 0;
                        weapon_id = 0;
                        stat_t = 1;
                        txt = "PLEONEXIC CROWN";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_crown_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_crown_high);
                        e_desc = "Makes you look very pretty and increases the radius at which XP sucked up.";
                        extra_st = "Increases XP absorb radius.";
                        sprite_prev = global.sprites.spr_solid_Crown;
                        sprite_scal = 0.6;
                        break;
                    
                    case 8:
                        lay = 2;
                        grid_lr = 1;
                        weapon_id = 28;
                        stat_t = 1;
                        txt = "MASK OF PLAGUE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_plaguemask_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_plaguemask_high);
                        e_desc = "Grants a small chance for any weapon to inflict the poison status effect, also increasing all poison damage universally.";
                        extra_st = "Increases poison status chance and poison status damage.";
                        sprite_prev = global.sprites.spr_solid_PlagueMask;
                        sprite_scal = 0.6;
                        break;
                    
                    case 9:
                        lay = 3;
                        grid_lr = -1;
                        weapon_id = 7;
                        stat_t = 1;
                        txt = "LEGSAW";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_legsaw_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_legsaw_high);
                        e_desc = "Periodically fires infinitely piercing sawblades in all directions around you that speed up over time.";
                        extra_st = "Increases damage and sawblade count.";
                        sprite_prev = global.sprites.spr_solid_LegSaw;
                        sprite_scal = 0.6;
                        break;
                    
                    case 10:
                        lay = 3;
                        grid_lr = 0;
                        weapon_id = 8;
                        stat_t = 1;
                        txt = "MISSILE PACK";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_missilepack_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_missilepack_high);
                        e_desc = "Fires a group of fireworks that seek out nearby enemies, then exploding into a big AoE of sparks.";
                        extra_st = "Increases damage and firework count.";
                        sprite_prev = global.sprites.spr_solid_MissilePack;
                        sprite_scal = 0.6;
                        break;
                    
                    case 11:
                        lay = 3;
                        grid_lr = 1;
                        weapon_id = 9;
                        stat_t = 1;
                        txt = "PARASIGHT";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_parasight_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_parasight_high);
                        e_desc = "Creates a parasite friend who seeks out and latches onto enemies automatically.";
                        extra_st = "Increases damage and parasite count.";
                        sprite_prev = global.sprites.spr_solid_ParaSight;
                        sprite_scal = 0.6;
                        break;
                    
                    case 12:
                        lay = 4;
                        grid_lr = -1;
                        weapon_id = 10;
                        stat_t = 1;
                        txt = "YOYO RACK";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_yoyo_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_yoyo_high);
                        e_desc = "Slings a YoYo in the direction of the cursor, and then draws it back. Hitting an enemy can make it recoil back to you much faster and more often, increasing its damage potential.";
                        extra_st = "Increases damage and YoYo count.";
                        sprite_prev = global.sprites.spr_solid_Rotator;
                        sprite_scal = 0.6;
                        break;
                    
                    case 13:
                        lay = 4;
                        grid_lr = 0;
                        weapon_id = 14;
                        stat_t = 1;
                        txt = "HUNTER'S BOW";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_bow_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_bow_high);
                        e_desc = "Fires a single piercing arrow in the direction of the cursor, homing to nearby enemies and poisoning them.";
                        extra_st = "Increases damage and lifetime of the arrow.";
                        sprite_prev = global.sprites.spr_solid_Bow;
                        sprite_scal = 0.6;
                        break;
                    
                    case 14:
                        lay = 4;
                        grid_lr = 1;
                        weapon_id = 0;
                        stat_t = obj_stat_track.unlocked_halo;
                        txt = "HALO";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_halo_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_halo_high);
                        e_desc = "Forms a protective bubble around you, cutting the next amount of damage you take in half.";
                        extra_st = "Increases max shields.";
                        sprite_prev = global.sprites.spr_solid_Halo;
                        sprite_scal = 0.6;
                        break;
                    
                    case 15:
                        lay = 5;
                        grid_lr = -1;
                        weapon_id = 5;
                        stat_t = obj_stat_track.unlocked_horns;
                        txt = "HORNS";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_horns_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_horns_high);
                        e_desc = "When getting close to a hostile, deal high damage to the nearest enemies around you.";
                        extra_st = "Increases damage, activation range and max enemies hit.";
                        sprite_prev = global.sprites.spr_solid_Horns;
                        sprite_scal = 0.6;
                        break;
                    
                    case 16:
                        lay = 5;
                        grid_lr = 0;
                        weapon_id = 6;
                        stat_t = obj_stat_track.unlocked_hydro;
                        txt = "HYDROCILLATOR";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_hydro_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_hydro_high);
                        e_desc = "Creates a bouncing ball that lasts forever, bouncing around and piercing through enemies.";
                        extra_st = "Increases damage and ball count.";
                        sprite_prev = global.sprites.spr_solid_Hydrocillator;
                        sprite_scal = 0.6;
                        break;
                    
                    case 17:
                        lay = 5;
                        grid_lr = 1;
                        weapon_id = 15;
                        stat_t = obj_stat_track.unlocked_flamethrower;
                        txt = "FLAME THROWER";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_flamethrower_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_flamethrower_high);
                        e_desc = "Constantly shoots low damage flames in the direction of the cursor, with a very high chance of setting enemies on fire.";
                        extra_st = "Increases damage of the flame projectiles and their lifetime.";
                        sprite_prev = global.sprites.spr_solid_Flamethrower;
                        sprite_scal = 0.6;
                        break;
                    
                    case 18:
                        lay = 6;
                        grid_lr = -1;
                        weapon_id = 21;
                        stat_t = obj_stat_track.unlocked_snowglobe;
                        txt = "FROST GLOBE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_snowglobe_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_snowglobe_high);
                        e_desc = "Releases a big frosty nova of ice around you, slowing all enemies within its radius.";
                        extra_st = "Increases nova damage and nova size.";
                        sprite_prev = global.sprites.spr_solid_SnowGlobe;
                        sprite_scal = 0.6;
                        break;
                    
                    case 19:
                        lay = 6;
                        grid_lr = 0;
                        weapon_id = 18;
                        stat_t = obj_stat_track.unlocked_plasmalamp;
                        txt = "PLASMA LAMP";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_plasmaglobe_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_plasmaglobe_high);
                        e_desc = "Fires electric beams at the nearest enemies, temporarily stunning them in place.";
                        extra_st = "Increases plasma damage and total enemies zapped.";
                        sprite_prev = global.sprites.spr_solid_Plasma;
                        sprite_scal = 0.6;
                        break;
                    
                    case 20:
                        lay = 6;
                        grid_lr = 1;
                        weapon_id = 20;
                        stat_t = obj_stat_track.unlocked_satellite;
                        txt = "STATIC SATELLITE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_satellite_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_satellite_high);
                        e_desc = "Calls down high, immediate damage on random enemies every few seconds.";
                        extra_st = "Increases damage and total enemies struck.";
                        sprite_prev = global.sprites.spr_solid_Satellite;
                        sprite_scal = 0.6;
                        break;
                    
                    case 21:
                        lay = 7;
                        grid_lr = -1;
                        weapon_id = 16;
                        stat_t = obj_stat_track.unlocked_walkman;
                        txt = "WICKED WALKMAN";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_headphones_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_headphones_high);
                        e_desc = "Fires a musical note in the direction of the cursor, bouncing in the opposite direction after hitting an enemy.";
                        extra_st = "Increases damage and maximum bounces.";
                        sprite_prev = global.sprites.spr_solid_Headphones;
                        sprite_scal = 0.6;
                        break;
                    
                    case 22:
                        lay = 7;
                        grid_lr = 0;
                        weapon_id = 22;
                        stat_t = obj_stat_track.unlocked_spear;
                        txt = "SOUL SPEAR";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_spear_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_spear_high);
                        e_desc = "Unleash spearing beams around you from your center that pierce through enemies.";
                        extra_st = "Increases damage and beam count.";
                        sprite_prev = global.sprites.spr_solid_Spear;
                        sprite_scal = 0.6;
                        break;
                    
                    case 23:
                        lay = 7;
                        grid_lr = 1;
                        weapon_id = 23;
                        stat_t = obj_stat_track.unlocked_turret;
                        txt = "DEFENSE TURRET";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_turret_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_turret_high);
                        e_desc = "Spawns a stationary turret that aims at the enemy closest to you, teleporting if you get too far.";
                        extra_st = "Increases turret count.";
                        sprite_prev = global.sprites.spr_solid_Turret;
                        sprite_scal = 0.6;
                        break;
                    
                    case 24:
                        lay = 8;
                        grid_lr = -1;
                        weapon_id = 17;
                        stat_t = obj_stat_track.unlocked_ninjagear;
                        txt = "SHINOBI EQUIPMENT";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_ninja_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_ninja_high);
                        e_desc = "Fires piercing ninja stars in the direction of the cursor before returning in your direction.";
                        extra_st = "Increases damage, star count and spread.";
                        sprite_prev = global.sprites.spr_solid_Ninja;
                        sprite_scal = 0.6;
                        break;
                    
                    case 25:
                        lay = 8;
                        grid_lr = 0;
                        weapon_id = 19;
                        stat_t = obj_stat_track.unlocked_strikecall;
                        txt = "STRIKE CALL";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_remote_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_remote_high);
                        e_desc = "Calls down high damage explosions in a random location around you.";
                        extra_st = "Increases damage and maximum explosions.";
                        sprite_prev = global.sprites.spr_solid_Remote;
                        sprite_scal = 0.6;
                        break;
                    
                    case 26:
                        lay = 8;
                        grid_lr = 1;
                        weapon_id = 24;
                        stat_t = obj_stat_track.unlocked_angelwings;
                        txt = "ANGEL WINGS";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_angelwings_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_angelwings_high);
                        e_desc = "The nearest enemies will be repeatedly knocked away and take low damage.";
                        extra_st = "Increases damage and maximum enemies knocked back.";
                        sprite_prev = global.sprites.spr_solid_AngelWings;
                        sprite_scal = 0.6;
                        break;
                    
                    case 27:
                        lay = 9;
                        grid_lr = -1;
                        weapon_id = 25;
                        stat_t = obj_stat_track.unlocked_demonwings;
                        txt = "DEMON WINGS";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_batwings_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_batwings_high);
                        e_desc = "While moving, constantly release a trail of demonic damage out behind you.";
                        extra_st = "Increases damage and trail lifetime.";
                        sprite_prev = global.sprites.spr_solid_BatWings;
                        sprite_scal = 0.6;
                        break;
                    
                    case 28:
                        lay = 9;
                        grid_lr = 0;
                        weapon_id = 0;
                        stat_t = obj_stat_track.unlocked_digiwatch;
                        txt = "DIGIWATCH";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_digiwatch_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_digiwatch_high);
                        e_desc = "Increases the attack speed of all other upgrades by lowering their cooldowns, making them happen more frequently.";
                        extra_st = "Increases Cooldown Rate.";
                        sprite_prev = global.sprites.spr_solid_DigiWatch;
                        sprite_scal = 0.6;
                        break;
                    
                    case 29:
                        lay = 9;
                        grid_lr = 1;
                        weapon_id = 0;
                        stat_t = obj_stat_track.unlocked_engine;
                        txt = "OVERCHARGED ENGINE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_engine_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_engine_high);
                        e_desc = "Overclocks your thrusters, allowing you to reach higher speeds.";
                        extra_st = "Increases movement speed and acceleration.";
                        sprite_prev = global.sprites.spr_solid_Engine;
                        sprite_scal = 0.6;
                        break;
                    
                    case 30:
                        lay = 10;
                        grid_lr = -1;
                        weapon_id = 26;
                        stat_t = obj_stat_track.unlocked_c4;
                        txt = "VOLATILE C4";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_C4_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_C4_high);
                        e_desc = "Grants all weapons an explosive enhancement, making enemies detonate when they die and damage those around them.";
                        extra_st = "Increases damage and maximum possible explosions.";
                        sprite_prev = global.sprites.spr_solid_C4;
                        sprite_scal = 0.6;
                        break;
                    
                    case 31:
                        lay = 10;
                        grid_lr = 0;
                        weapon_id = 31;
                        stat_t = obj_stat_track.unlocked_firelighter;
                        txt = "FIRE LIGHTER";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_firelighter_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_firelighter_high);
                        e_desc = "Grants a small chance for any weapon to inflict the fire status effect, also increasing all fire damage universally.";
                        extra_st = "Increases fire status chance and fire status damage.";
                        sprite_prev = global.sprites.spr_solid_FireLighter;
                        sprite_scal = 0.6;
                        break;
                    
                    case 32:
                        lay = 10;
                        grid_lr = 1;
                        weapon_id = 30;
                        stat_t = obj_stat_track.unlocked_icecream;
                        txt = "FROSTY CONE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_icecream_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_icecream_high);
                        e_desc = "Grants a small chance for any weapon to inflict the chilled status effect, also increasing all frost damage universally.";
                        extra_st = "Increases frost status chance and frost status damage.";
                        sprite_prev = global.sprites.spr_solid_IceCream;
                        sprite_scal = 0.6;
                        break;
                    
                    case 33:
                        lay = 11;
                        grid_lr = -1;
                        weapon_id = 29;
                        stat_t = obj_stat_track.unlocked_eel;
                        txt = "ELECTRIC EEL";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_eel_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_eel_high);
                        e_desc = "Grants a small chance for any weapon to inflict the stunned status effect, also increasing all shock damage universally.";
                        extra_st = "Increases shock status chance and shock status damage.";
                        sprite_prev = global.sprites.spr_solid_Eel;
                        sprite_scal = 0.6;
                        break;
                    
                    case 34:
                        lay = 11;
                        grid_lr = 0;
                        weapon_id = 0;
                        stat_t = obj_stat_track.unlocked_gem;
                        txt = "ELEMENT CRYSTAL";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_gem_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_gem_high);
                        e_desc = "Enhances all the powers of the elements, making fire burn, poison decay, shock fry and frost shatter that much more.";
                        extra_st = "Increases all elemental status damage and duration.";
                        sprite_prev = global.sprites.spr_solid_Gem;
                        sprite_scal = 0.6;
                        break;
                    
                    case 35:
                        lay = 11;
                        grid_lr = 1;
                        weapon_id = 27;
                        stat_t = obj_stat_track.unlocked_shotvest;
                        txt = "SHRAPNEL SHELLS";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_shottyvest_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_shottyvest_high);
                        e_desc = "Grants all weapons a buckshot enhancement, causing dead enemies to release shrapnel in all directions.";
                        extra_st = "Increases damage, shrapnel lifetime and maximum possible shrapnel.";
                        sprite_prev = global.sprites.spr_solid_ShottyVest;
                        sprite_scal = 0.6;
                        break;
                    
                    case 36:
                        lay = 12;
                        grid_lr = -1;
                        weapon_id = 12;
                        stat_t = obj_stat_track.unlocked_telecom;
                        txt = "TELECOM";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_telecom_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_telecom_high);
                        e_desc = "Allows all weapons to sometimes release an AoE blast that deals 50% of its damage on hit.";
                        extra_st = "Increases maximum AoE blasts.";
                        sprite_prev = global.sprites.spr_solid_Telecom;
                        sprite_scal = 0.6;
                        break;
                    
                    case 37:
                        lay = 12;
                        grid_lr = 0;
                        weapon_id = 11;
                        stat_t = obj_stat_track.unlocked_slimespike;
                        txt = "SLIME SPIKE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_slimespike_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_slimespike_high);
                        e_desc = "Forms translucent spikes around you, spinning and stabbing any enemies that come into contact.";
                        extra_st = "Increases damage, spike count and distance.";
                        sprite_prev = global.sprites.spr_solid_SlimeSpike;
                        sprite_scal = 0.6;
                        break;
                    
                    case 38:
                        lay = 12;
                        grid_lr = 1;
                        weapon_id = 13;
                        stat_t = obj_stat_track.unlocked_ultrabuster;
                        txt = "ULTRABUSTER";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_ultrabuster_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_ultrabuster_high);
                        e_desc = "Similar to the CORE, but fires in an accurate piercing single-line burst instead.";
                        extra_st = "Increases damage, pierce and bullet count.";
                        sprite_prev = global.sprites.spr_solid_UltraBuster;
                        sprite_scal = 0.6;
                        break;
                    
                    case 39:
                        lay = 13;
                        grid_lr = -1;
                        weapon_id = 32;
                        stat_t = obj_stat_track.unlocked_chainsword;
                        txt = "CHAINSWORD";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_chainsword_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_chainsword_high);
                        e_desc = "A dangerous repeatedly damaging weapon that swings in the direction you aim.";
                        extra_st = "Increases size, damage and lifetime.";
                        sprite_prev = global.sprites.spr_solid_Sword;
                        sprite_scal = 0.6;
                        break;
                    
                    case 40:
                        lay = 13;
                        grid_lr = 0;
                        weapon_id = 33;
                        stat_t = obj_stat_track.unlocked_popup;
                        txt = "POP UP FIREWALL";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_firewall_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_firewall_high);
                        e_desc = "A suit upgrade that potentially stops enemies before they're even a problem, spiraling the edge.";
                        extra_st = "Increases damage and amount.";
                        sprite_prev = global.sprites.spr_solid_Firewall;
                        sprite_scal = 0.6;
                        break;
                    
                    case 41:
                        lay = 13;
                        grid_lr = 1;
                        weapon_id = 34;
                        stat_t = obj_stat_track.unlocked_scythe;
                        txt = "REAPER SCYTHE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_death_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_death_high);
                        e_desc = "Warm to the touch, all enemies in existence take damage in its presence.";
                        extra_st = "Increases damage.";
                        sprite_prev = global.sprites.spr_solid_Death;
                        sprite_scal = 0.6;
                        break;
                    
                    case 42:
                        lay = 14;
                        grid_lr = -1;
                        weapon_id = 35;
                        stat_t = obj_stat_track.unlocked_tentacle;
                        txt = "CORRUPT TENTACLE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_corrupt_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_corrupt_high);
                        e_desc = "Disgusting and slimy, it bites down hard - tethering itself onto anything it touches and does repeating damage to those who try to get through.";
                        extra_st = "Increases damage and tether count.";
                        sprite_prev = global.sprites.spr_solid_Corrupt;
                        sprite_scal = 0.6;
                        break;
                    
                    case 43:
                        lay = 14;
                        grid_lr = 0;
                        weapon_id = 0;
                        stat_t = obj_stat_track.unlocked_cigar;
                        txt = "FANCY CIGAR";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_cigar_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_cigar_high);
                        e_desc = "Takes the edge off after a rough time, giving you a longer time to reorganize yourself.";
                        extra_st = "Increases Immunity Frames.";
                        sprite_prev = global.sprites.spr_solid_Cigar;
                        sprite_scal = 0.6;
                        break;
                    
                    case 44:
                        lay = 14;
                        grid_lr = 1;
                        weapon_id = 36;
                        stat_t = obj_stat_track.unlocked_dynamite;
                        txt = "BLASTIN' STICKS";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_dynamite_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_dynamite_high);
                        e_desc = "After being lit and thrown into the air, they come right back down and explode wherever you were a moment ago.";
                        extra_st = "Increases damage and amount thrown.";
                        sprite_prev = global.sprites.spr_solid_Dynamite;
                        sprite_scal = 0.6;
                        break;
                    
                    case 45:
                        lay = 15;
                        grid_lr = -1;
                        weapon_id = 0;
                        stat_t = obj_stat_track.unlocked_trophy;
                        txt = "MISSING AWARD";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_award_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_award_high);
                        e_desc = "It was gone for so long, you thought you might never see it. Its sight empowers you with hope.";
                        extra_st = "Increases Pickup Radius, Cooldown Rate, Scale, Projectile Speed, Dodge and all elements.";
                        sprite_prev = global.sprites.spr_solid_Award;
                        sprite_scal = 0.6;
                        break;
                    
                    case 46:
                        lay = 15;
                        grid_lr = 0;
                        weapon_id = 37;
                        stat_t = obj_stat_track.unlocked_carrot;
                        txt = "FUNKY CARROT";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_carrot_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_carrot_high);
                        e_desc = "Has a gross smell. Almost makes you want to throw it, and if you did, it'd leave a damaging aura wherever it lands.";
                        extra_st = "Increases thrown amount, damage and lifetime.";
                        sprite_prev = global.sprites.spr_solid_Carrot;
                        sprite_scal = 0.6;
                        break;
                    
                    case 47:
                        lay = 15;
                        grid_lr = 1;
                        weapon_id = 38;
                        stat_t = obj_stat_track.unlocked_bees;
                        txt = "LOTS OF BEES";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_bees_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_bees_high);
                        e_desc = "One hundred billion trillion zillion bees. Fly out in all directions.";
                        extra_st = "Increases damage and lifetime.";
                        sprite_prev = global.sprites.spr_solid_Bees;
                        sprite_scal = 0.6;
                        break;
                    
                    case 48:
                        lay = 16;
                        grid_lr = -1;
                        weapon_id = 0;
                        stat_t = obj_stat_track.unlocked_monkey;
                        txt = "BLESSED MONKEY";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_monkey_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_monkey_high);
                        e_desc = "Baker has a calming aura, and her eyes tell a lifetime of stories far more interesting than whatever is happening right now.";
                        extra_st = "Increases XP Modifier.";
                        sprite_prev = global.sprites.spr_solid_Monkey;
                        sprite_scal = 0.6;
                        break;
                    
                    case 49:
                        lay = 16;
                        grid_lr = 0;
                        weapon_id = 39;
                        stat_t = obj_stat_track.unlocked_midas;
                        txt = "MIDAS HAND";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_midas_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_midas_high);
                        e_desc = "The hand of Midas looms over you, damaging those who dare insult your greed by getting within your pickup radius. Does more damage the more worth your XP is, excluding Overdrive benefits.";
                        extra_st = "Increases damage.";
                        sprite_prev = global.sprites.spr_solid_Midas;
                        sprite_scal = 0.6;
                        break;
                    
                    case 50:
                        lay = 16;
                        grid_lr = 1;
                        weapon_id = 40;
                        stat_t = obj_stat_track.unlocked_fish;
                        txt = "DAGGERFISH CONCH";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_fish_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_fish_high);
                        e_desc = "Summons a dangerous school of fish, who've bonded to you and will protect you no matter what; dashing and piercing through groups of enemies.";
                        extra_st = "Increases amount and damage.";
                        sprite_prev = global.sprites.spr_solid_Fish;
                        sprite_scal = 0.6;
                        break;
                    
                    case 51:
                        lay = 17;
                        grid_lr = -1;
                        weapon_id = 41;
                        stat_t = obj_stat_track.unlocked_cheese;
                        txt = "STINKY CHEESE";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_cheese_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_cheese_high);
                        e_desc = "Lactose tolerence isn't something they've all developed, making it an effect exploding splitting cluster bomb weapon.";
                        extra_st = "Increases amount and damage.";
                        sprite_prev = global.sprites.spr_solid_Cheese;
                        sprite_scal = 0.6;
                        break;
                    
                    case 52:
                        lay = 17;
                        grid_lr = 0;
                        weapon_id = 42;
                        stat_t = obj_stat_track.unlocked_helmet;
                        txt = "PSYCHO HELMET";
                        e_hp = "TIMES PICKED: " + string(obj_stat_track.stat_psycho_picked);
                        e_spd = "HIGHEST ACQUIRED: " + string(obj_stat_track.stat_psycho_high);
                        e_desc = "Found beneath a government building, it allows you to see things you wouldn't be able to see otherwise. You can also run into these things, explode them and deal damage in all directions around it.";
                        extra_st = "Increases damage and projectile count.";
                        sprite_prev = global.sprites.spr_solid_Psycho;
                        sprite_scal = 0.6;
                        break;
                    
                    default:
                        txt = "";
                        noshow = true;
                        break;
                }
                
                bar_power = -(long_butt_height * 18);
            }
            else if (obj_stats.selected == "ENEMIES")
            {
                draw_back = false;
                long_butt_height = 84;
                start_y = 118;
                mouseover = true;
                
                switch (i)
                {
                    case 0:
                        lay = 0;
                        grid_lr = -1;
                        stat_t = obj_stat_track.stat_soul_kills;
                        txt = "OBJ_ENEM_SOUL";
                        e_hp = "100/200/300/+ HP";
                        e_spd = "0.5/1.0/1.5/+ SPEED";
                        e_desc = "A being who never was. Idle energy of the universe given sentience to do a single task.";
                        
                        if (wrap3 == 1)
                            sprite_prev = global.sprites.spr_soul_1_SE;
                        else if (wrap3 == 2)
                            sprite_prev = global.sprites.spr_soul_2_SE;
                        else if (wrap3 == 3)
                            sprite_prev = global.sprites.spr_soul_3_SE;
                        else if (wrap3 == 4)
                            sprite_prev = global.sprites.spr_soul_4_SE;
                        else if (wrap3 == 5)
                            sprite_prev = global.sprites.spr_soul_5_SE;
                        else if (wrap3 == 6)
                            sprite_prev = global.sprites.spr_soul_6_SE;
                        
                        sprite_scal = 1;
                        break;
                    
                    case 1:
                        lay = 0;
                        grid_lr = 0;
                        stat_t = obj_stat_track.stat_fish_kills;
                        txt = "OBJ_ENEM_FISH";
                        e_hp = "150/185/210/+ HP";
                        e_spd = "0.5/0.75/1.0/+ SPEED";
                        e_desc = "Without mercy, it will charge forward at great speed upon seeing its prey. Tastes good, too.";
                        
                        if (wrap3 == 1)
                            sprite_prev = global.sprites.spr_fish_1_SE;
                        else if (wrap3 == 2)
                            sprite_prev = global.sprites.spr_fish_2_SE;
                        else if (wrap3 == 3)
                            sprite_prev = global.sprites.spr_fish_3_SE;
                        else if (wrap3 == 4)
                            sprite_prev = global.sprites.spr_fish_4_SE;
                        else if (wrap3 == 5)
                            sprite_prev = global.sprites.spr_fish_5_SE;
                        else if (wrap3 == 6)
                            sprite_prev = global.sprites.spr_fish_6_SE;
                        
                        sprite_scal = 1;
                        break;
                    
                    case 2:
                        lay = 0;
                        grid_lr = 1;
                        stat_t = obj_stat_track.stat_glove_kills;
                        txt = "OBJ_ENEM_GLOVE";
                        e_hp = "30/60/90/+ HP";
                        e_spd = "1.5/2.0/2.5/+ SPEED";
                        e_desc = "Incredibly fast, but structurally weak. The hands move with intent; controlled by a higher power.";
                        
                        if (wrap3 == 1)
                            sprite_prev = global.sprites.spr_glove_1_SE;
                        else if (wrap3 == 2)
                            sprite_prev = global.sprites.spr_glove_2_SE;
                        else if (wrap3 == 3)
                            sprite_prev = global.sprites.spr_glove_3_SE;
                        else if (wrap3 == 4)
                            sprite_prev = global.sprites.spr_glove_4_SE;
                        else if (wrap3 == 5)
                            sprite_prev = global.sprites.spr_glove_5_SE;
                        else if (wrap3 == 6)
                            sprite_prev = global.sprites.spr_glove_6_SE;
                        
                        sprite_scal = 1;
                        break;
                    
                    case 3:
                        lay = 1;
                        grid_lr = -1;
                        stat_t = obj_stat_track.stat_skull_kills;
                        txt = "OBJ_ENEM_SKULL";
                        e_hp = "100/200/300/+ HP";
                        e_spd = "1.25/1.4/1.6/+ SPEED";
                        e_desc = "A vengeful undying spirit, capable of splitting its remaining energy to sustain its existence for a moment longer.";
                        
                        if (wrap3 == 1)
                            sprite_prev = global.sprites.spr_skull_1_SE;
                        else if (wrap3 == 2)
                            sprite_prev = global.sprites.spr_skull_2_SE;
                        else if (wrap3 == 3)
                            sprite_prev = global.sprites.spr_skull_3_SE;
                        else if (wrap3 == 4)
                            sprite_prev = global.sprites.spr_skull_4_SE;
                        else if (wrap3 == 5)
                            sprite_prev = global.sprites.spr_skull_5_SE;
                        else if (wrap3 == 6)
                            sprite_prev = global.sprites.spr_skull_6_SE;
                        
                        sprite_scal = 1;
                        break;
                    
                    case 4:
                        lay = 1;
                        grid_lr = 0;
                        stat_t = obj_stat_track.stat_face_kills;
                        txt = "OBJ_ENEM_FACE";
                        e_hp = "100 HP";
                        e_spd = "0.2 / 2.0 SPEED";
                        e_desc = "A seemingly friendly face, who tentuples their movement speed upon taking any damage.";
                        
                        if (wrap2 == 1)
                            sprite_prev = global.sprites.spr_boyface_1_SE;
                        else if (wrap2 == 2)
                            sprite_prev = global.sprites.spr_boyface_2_SE;
                        
                        sprite_scal = 1;
                        break;
                    
                    case 5:
                        lay = 1;
                        grid_lr = 1;
                        stat_t = obj_stat_track.stat_cornchip_kills;
                        txt = "OBJ_ENEM_CORNCHIP";
                        e_hp = "75 HP";
                        e_spd = "1.5 SPEED";
                        e_desc = "A particularly tasty individual. After spinning, they can dash their way through entire crowds of enemies.";
                        sprite_prev = global.sprites.spr_cornchip_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 6:
                        lay = 2;
                        grid_lr = -1;
                        stat_t = obj_stat_track.stat_wibbler_kills;
                        txt = "OBJ_ENEM_WIBBLER";
                        e_hp = "125 HP";
                        e_spd = "0.5 / 1.25 SPEED";
                        e_desc = "A confused anomaly, incapable of sprinting unless it sees you doing the same.";
                        sprite_prev = global.sprites.spr_wibbler_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 7:
                        lay = 2;
                        grid_lr = 0;
                        stat_t = obj_stat_track.stat_burger_kills;
                        txt = "OBJ_ENEM_BURGER";
                        e_hp = "225 HP";
                        e_spd = "0.75 SPEED";
                        e_desc = "A real heart-throb, the burger can take quite a few hits before dying. It is also very resistant to being knocked away!";
                        sprite_prev = global.sprites.spr_burger_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 8:
                        lay = 2;
                        grid_lr = 1;
                        stat_t = obj_stat_track.stat_droid_kills;
                        txt = "OBJ_ENEM_DROID";
                        e_hp = "75 HP";
                        e_spd = "0.75 SPEED";
                        e_desc = "Every so often, this creature will fire a bullet in your direction. Relatively weak otherwise.";
                        sprite_prev = global.sprites.spr_droid_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 9:
                        lay = 3;
                        grid_lr = -1;
                        stat_t = obj_stat_track.stat_spider_kills;
                        txt = "OBJ_ENEM_SPIDER";
                        e_hp = "150 HP";
                        e_spd = "0.0 / 3.0 SPEED";
                        e_desc = "Remains stationary until darting to your current position. Continuing to move at all times is recommended.";
                        sprite_prev = global.sprites.spr_spider_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 10:
                        lay = 3;
                        grid_lr = 0;
                        stat_t = obj_stat_track.stat_shielder_kills;
                        txt = "OBJ_ENEM_SHIELDER";
                        e_hp = "175 HP";
                        e_spd = "0.75 SPEED";
                        e_desc = "Slow and healthy, it will give the first enemy it comes into contact with a protective shield.";
                        sprite_prev = global.sprites.spr_shieldy_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 11:
                        lay = 3;
                        grid_lr = 1;
                        stat_t = obj_stat_track.stat_whisker_kills;
                        txt = "OBJ_ENEM_WHISKER";
                        e_hp = "60 HP";
                        e_spd = "3.0 SPEED";
                        e_desc = "One of the fastest beings, it will cut through the horde to make it to your location as quick as it possibly can.";
                        sprite_prev = global.sprites.spr_whisker_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 12:
                        lay = 4;
                        grid_lr = -1;
                        stat_t = obj_stat_track.stat_exploder_kills;
                        txt = "OBJ_ENEM_EXPLODER";
                        e_hp = "250 HP";
                        e_spd = "1.0 SPEED";
                        e_desc = "Either upon dying or getting too close, this creature will explode into several projectiles.";
                        sprite_prev = global.sprites.spr_exploder_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 13:
                        lay = 4;
                        grid_lr = 0;
                        stat_t = obj_stat_track.stat_warper_kills;
                        txt = "OBJ_ENEM_WARPER";
                        e_hp = "250 HP";
                        e_spd = "0.5 SPEED";
                        e_desc = "This freakazoid moves slowly at first but then teleports very close by, in order to surprise and cut you off.";
                        sprite_prev = global.sprites.spr_eggplant_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 14:
                        lay = 4;
                        grid_lr = 1;
                        stat_t = obj_stat_track.stat_wisp_kills;
                        txt = "OBJ_ENEM_WISP";
                        e_hp = "50 / 150 HP";
                        e_spd = "1.75 SPEED";
                        e_desc = "A small piece of severed energy. Singularly, this enemy is weak. But as a chain, they grow much more resilient.";
                        
                        if (wrap2 == 1)
                            sprite_prev = global.sprites.spr_wisp_1_SE;
                        else if (wrap2 == 2)
                            sprite_prev = global.sprites.spr_wisp_2_SE;
                        
                        sprite_scal = 1;
                        break;
                    
                    case 15:
                        lay = 5;
                        grid_lr = -1;
                        stat_t = obj_stat_track.stat_peapod_kills;
                        txt = "OBJ_ENEM_PEAPOD";
                        e_hp = "120 HP";
                        e_spd = "1.0 SPEED";
                        e_desc = "Four of them, three IQ. Not bright enough to figure out how to move diagonally.";
                        sprite_prev = global.sprites.spr_peapod_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 16:
                        lay = 5;
                        grid_lr = 0;
                        stat_t = obj_stat_track.stat_centa_kills;
                        txt = "OBJ_ENEM_CENTA";
                        e_hp = "125 HP";
                        e_spd = "1.25 SPEED";
                        e_desc = "Protects itself with spinning bullets, avoid getting too close!";
                        sprite_prev = global.sprites.spr_centa_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 17:
                        lay = 5;
                        grid_lr = 1;
                        stat_t = obj_stat_track.stat_sniper_kills;
                        txt = "OBJ_ENEM_SNIPER";
                        e_hp = "200 HP";
                        e_spd = "1.25 SPEED";
                        e_desc = "Similar to the Droid, this enemy fires bullets that travel much faster. Keep moving at all times!";
                        sprite_prev = global.sprites.spr_sniper_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 18:
                        lay = 6;
                        grid_lr = -1;
                        stat_t = obj_stat_track.stat_lob_kills;
                        txt = "OBJ_ENEM_LOB";
                        e_hp = "250 HP";
                        e_spd = "1.5 SPEED";
                        e_desc = "Constantly spilling bullets around it, picking it off before it can get close is ideal.";
                        sprite_prev = global.sprites.spr_lob_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 19:
                        lay = 6;
                        grid_lr = 0;
                        stat_t = obj_stat_track.stat_bishop_kills;
                        txt = "OBJ_ENEM_BISHOP";
                        e_hp = "150 HP";
                        e_spd = "1 SPEED";
                        e_desc = "An optimist at heart, always taking the fastest diagonal path towards you... Even if it's not optimal at all.";
                        sprite_prev = global.sprites.spr_bishop_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 20:
                        lay = 6;
                        grid_lr = 1;
                        stat_t = obj_stat_track.stat_elude_kills;
                        txt = "OBJ_ENEM_ELUDE";
                        e_hp = "250 HP";
                        e_spd = "1.25 SPEED";
                        e_desc = "Heh? You really think your pesky little bullets can hit it? That's just arrogance.";
                        sprite_prev = global.sprites.spr_elude_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 21:
                        lay = 7;
                        grid_lr = 0;
                        stat_t = obj_stat_track.stat_lidean_kills;
                        txt = "OBJ_ENEM_LIDEAN";
                        e_hp = "300 HP";
                        e_spd = "1.5 SPEED";
                        e_desc = "When it feels scared, it contorts reality to swap its approach. Always pursuing.";
                        sprite_prev = global.sprites.spr_lidean_SE;
                        sprite_scal = 1;
                        break;
                    
                    case 26:
                        lay = 9;
                        grid_lr = -1;
                        stat_t = obj_stat_track.stat_soul_kills;
                        txt = "OBJ_ENEM_SOUL%CURSED%";
                        e_hp = "400/800/1200/+ HP";
                        e_spd = "0.67/1.35/2.02/+ SPEED";
                        var myRandomString = random_string(90);
                        e_desc = myRandomString;
                        
                        if (wrap3 == 1)
                            sprite_prev = global.sprites.spr_cursed_eye_1_SE;
                        else if (wrap3 == 2)
                            sprite_prev = global.sprites.spr_cursed_eye_2_SE;
                        else if (wrap3 == 3)
                            sprite_prev = global.sprites.spr_cursed_eye_3_SE;
                        else if (wrap3 == 4)
                            sprite_prev = global.sprites.spr_cursed_eye_4_SE;
                        else if (wrap3 == 5)
                            sprite_prev = global.sprites.spr_cursed_eye_5_SE;
                        else if (wrap3 == 6)
                            sprite_prev = global.sprites.spr_cursed_eye_6_SE;
                        
                        sprite_scal = 1;
                        break;
                    
                    case 27:
                        lay = 9;
                        grid_lr = 0;
                        stat_t = obj_stat_track.stat_fish_kills;
                        txt = "OBJ_ENEM_FISH%CURSED%";
                        e_hp = "600/740/840/+ HP";
                        e_spd = "0.67/1.01/1.35/+ SPEED";
                        var myRandomString = random_string(90);
                        e_desc = myRandomString;
                        
                        if (wrap3 == 1)
                            sprite_prev = global.sprites.spr_cursed_fish_1_SE;
                        else if (wrap3 == 2)
                            sprite_prev = global.sprites.spr_cursed_fish_2_SE;
                        else if (wrap3 == 3)
                            sprite_prev = global.sprites.spr_cursed_fish_3_SE;
                        else if (wrap3 == 4)
                            sprite_prev = global.sprites.spr_cursed_fish_4_SE;
                        else if (wrap3 == 5)
                            sprite_prev = global.sprites.spr_cursed_fish_5_SE;
                        else if (wrap3 == 6)
                            sprite_prev = global.sprites.spr_cursed_fish_6_SE;
                        
                        sprite_scal = 1;
                        break;
                    
                    case 28:
                        lay = 9;
                        grid_lr = 1;
                        stat_t = obj_stat_track.stat_glove_kills;
                        txt = "OBJ_ENEM_GLOVE%CURSED%";
                        e_hp = "120/240/360/+ HP";
                        e_spd = "2.02/2.7/3.37/+ SPEED";
                        var myRandomString = random_string(90);
                        e_desc = myRandomString;
                        
                        if (wrap3 == 1)
                            sprite_prev = global.sprites.spr_cursed_glove_1_SE;
                        else if (wrap3 == 2)
                            sprite_prev = global.sprites.spr_cursed_glove_2_SE;
                        else if (wrap3 == 3)
                            sprite_prev = global.sprites.spr_cursed_glove_3_SE;
                        else if (wrap3 == 4)
                            sprite_prev = global.sprites.spr_cursed_glove_4_SE;
                        else if (wrap3 == 5)
                            sprite_prev = global.sprites.spr_cursed_glove_5_SE;
                        else if (wrap3 == 6)
                            sprite_prev = global.sprites.spr_cursed_glove_6_SE;
                        
                        sprite_scal = 1;
                        break;
                    
                    case 30:
                        lay = 10;
                        grid_lr = 0;
                        stat_t = obj_stat_track.stat_skull_kills;
                        txt = "OBJ_ENEM_SKULL%CURSED%";
                        e_hp = "400/800/1200/+ HP";
                        e_spd = "1.62/1.89/2.16/+ SPEED";
                        var myRandomString = random_string(90);
                        e_desc = myRandomString;
                        
                        if (wrap3 == 1)
                            sprite_prev = global.sprites.spr_cursed_skull_1_SE;
                        else if (wrap3 == 2)
                            sprite_prev = global.sprites.spr_cursed_skull_2_SE;
                        else if (wrap3 == 3)
                            sprite_prev = global.sprites.spr_cursed_skull_3_SE;
                        else if (wrap3 == 4)
                            sprite_prev = global.sprites.spr_cursed_skull_4_SE;
                        else if (wrap3 == 5)
                            sprite_prev = global.sprites.spr_cursed_skull_5_SE;
                        else if (wrap3 == 6)
                            sprite_prev = global.sprites.spr_cursed_skull_6_SE;
                        
                        sprite_scal = 1;
                        break;
                    
                    default:
                        txt = "";
                        noshow = true;
                        break;
                }
                
                bar_power = -(long_butt_height * 8);
            }
            
            if (bar_power == -1)
                long_butt_spr = global.sprites.spr_sett_long_butt_save;
            
            var roughcalc = start_y + (long_butt_height * i) + (bar_power * bar_percentage);
            
            if (noshow == false)
            {
                if (draw_back == true && is_between(roughcalc, 64, 500) && unlock == false)
                {
                    draw_sprite_ext(long_butt_spr, 0, 1 + long_butt_h_width, start_y + (long_butt_height * i) + (bar_power * bar_percentage), 1, 1, 0, c_white, 1);
                    draw_text(1 + long_butt_h_width, start_y + (long_butt_height * i) + (bar_power * bar_percentage), txt);
                    
                    if (txt != "???")
                        draw_sprite_ext(sprite_prev, get_timer() / 100000, (1 + long_butt_h_width) - 264, start_y + (long_butt_height * i) + (bar_power * bar_percentage), sprite_scal, sprite_scal, 0, c_white, 1);
                }
                else if (unlock == true && is_between(roughcalc, 64, 500))
                {
                    draw_sprite_ext(long_butt_spr, 0, 1 + long_butt_h_width, start_y + (long_butt_height * i) + (bar_power * bar_percentage), 1, 1, 0, c_white, 1);
                    var complet_amm = return_percent(1, clamp(mission_track, 0, mission_complete), mission_complete);
                    var new_award = false;
                    var bar_color = 65280;
                    
                    if (stat_t == false)
                    {
                        complet_amm = 0;
                        mission_track = 0;
                        mission_complete = 1;
                        txt = "???";
                    }
                    
                    if (complet_amm == 1)
                    {
                        var unlocked_something_new = false;
                        
                        switch (i)
                        {
                            case 0:
                                if (obj_stat_track.unlocked_c4 != 1)
                                {
                                    obj_stat_track.unlocked_c4 = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 1:
                                if (obj_stat_track.unlocked_satellite != 1)
                                {
                                    obj_stat_track.unlocked_satellite = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 2:
                                if (obj_stat_track.unlocked_turret != 1)
                                {
                                    obj_stat_track.unlocked_turret = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 3:
                                if (obj_stat_track.unlocked_engine != 1)
                                {
                                    obj_stat_track.unlocked_engine = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 4:
                                if (obj_stat_track.unlocked_digiwatch != 1)
                                {
                                    obj_stat_track.unlocked_digiwatch = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 5:
                                if (obj_stat_track.unlocked_horns != 1)
                                {
                                    obj_stat_track.unlocked_horns = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 6:
                                if (obj_stat_track.unlocked_telecom != 1)
                                {
                                    obj_stat_track.unlocked_telecom = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 7:
                                if (obj_stat_track.unlocked_angelwings != 1)
                                {
                                    obj_stat_track.unlocked_angelwings = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 8:
                                if (obj_stat_track.unlocked_ninjagear != 1)
                                {
                                    obj_stat_track.unlocked_ninjagear = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 9:
                                if (obj_stat_track.unlocked_strikecall != 1)
                                {
                                    obj_stat_track.unlocked_strikecall = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 10:
                                if (obj_stat_track.unlocked_ultrabuster != 1)
                                {
                                    obj_stat_track.unlocked_ultrabuster = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 11:
                                if (obj_stat_track.unlocked_halo != 1)
                                {
                                    obj_stat_track.unlocked_halo = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 12:
                                if (obj_stat_track.unlocked_slimespike != 1)
                                {
                                    obj_stat_track.unlocked_slimespike = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 13:
                                if (obj_stat_track.unlocked_hydro != 1)
                                {
                                    obj_stat_track.unlocked_hydro = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 14:
                                if (obj_stat_track.unlocked_firelighter != 1)
                                {
                                    obj_stat_track.unlocked_firelighter = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 15:
                                if (obj_stat_track.unlocked_flamethrower != 1)
                                {
                                    obj_stat_track.unlocked_flamethrower = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 16:
                                if (obj_stat_track.unlocked_walkman != 1)
                                {
                                    obj_stat_track.unlocked_walkman = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 17:
                                if (obj_stat_track.unlocked_spear != 1)
                                {
                                    obj_stat_track.unlocked_spear = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 18:
                                if (obj_stat_track.unlocked_demonwings != 1)
                                {
                                    obj_stat_track.unlocked_demonwings = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 19:
                                if (obj_stat_track.unlocked_shotvest != 1)
                                {
                                    obj_stat_track.unlocked_shotvest = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 20:
                                if (obj_stat_track.unlocked_icecream != 1)
                                {
                                    obj_stat_track.unlocked_icecream = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 21:
                                if (obj_stat_track.unlocked_snowglobe != 1)
                                {
                                    obj_stat_track.unlocked_snowglobe = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 22:
                                if (obj_stat_track.unlocked_eel != 1)
                                {
                                    obj_stat_track.unlocked_eel = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 23:
                                if (obj_stat_track.unlocked_plasmalamp != 1)
                                {
                                    obj_stat_track.unlocked_plasmalamp = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 24:
                                if (obj_stat_track.unlocked_gem != 1)
                                {
                                    obj_stat_track.unlocked_gem = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 25:
                                if (obj_stat_track.unlocked_chainsword != 1)
                                {
                                    obj_stat_track.unlocked_chainsword = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 26:
                                if (obj_stat_track.unlocked_popup != 1)
                                {
                                    obj_stat_track.unlocked_popup = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 27:
                                if (obj_stat_track.unlocked_scythe != 1)
                                {
                                    obj_stat_track.unlocked_scythe = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 28:
                                if (obj_stat_track.unlocked_tentacle != 1)
                                {
                                    obj_stat_track.unlocked_tentacle = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 29:
                                if (obj_stat_track.unlocked_cigar != 1)
                                {
                                    obj_stat_track.unlocked_cigar = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 30:
                                if (obj_stat_track.unlocked_dynamite != 1)
                                {
                                    obj_stat_track.unlocked_dynamite = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 31:
                                if (obj_stat_track.unlocked_trophy != 1)
                                {
                                    obj_stat_track.unlocked_trophy = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 32:
                                if (obj_stat_track.unlocked_carrot != 1)
                                {
                                    obj_stat_track.unlocked_carrot = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 33:
                                if (obj_stat_track.unlocked_bees != 1)
                                {
                                    obj_stat_track.unlocked_bees = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 34:
                                if (obj_stat_track.unlocked_monkey != 1)
                                {
                                    obj_stat_track.unlocked_monkey = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 35:
                                if (obj_stat_track.unlocked_midas != 1)
                                {
                                    obj_stat_track.unlocked_midas = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 36:
                                if (obj_stat_track.unlocked_fish != 1)
                                {
                                    obj_stat_track.unlocked_fish = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 37:
                                if (obj_stat_track.unlocked_cheese != 1)
                                {
                                    obj_stat_track.unlocked_cheese = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 38:
                                if (obj_stat_track.unlocked_helmet != 1)
                                {
                                    obj_stat_track.unlocked_helmet = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 39:
                                if (obj_stat_track.unlocked_suit_glass != 1)
                                {
                                    obj_stat_track.unlocked_suit_glass = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 40:
                                if (obj_stat_track.unlocked_suit_worn != 1)
                                {
                                    obj_stat_track.unlocked_suit_worn = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 41:
                                if (obj_stat_track.unlocked_suit_absorb != 1)
                                {
                                    obj_stat_track.unlocked_suit_absorb = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 42:
                                if (obj_stat_track.unlocked_suit_picayune != 1)
                                {
                                    obj_stat_track.unlocked_suit_picayune = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 43:
                                if (obj_stat_track.unlocked_suit_efficient != 1)
                                {
                                    obj_stat_track.unlocked_suit_efficient = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 44:
                                if (obj_stat_track.unlocked_suit_optimized != 1)
                                {
                                    obj_stat_track.unlocked_suit_optimized = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 45:
                                if (obj_stat_track.unlocked_suit_perfected != 1)
                                {
                                    obj_stat_track.unlocked_suit_perfected = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 46:
                                if (obj_stat_track.unlocked_suit_tank != 1)
                                {
                                    obj_stat_track.unlocked_suit_tank = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 47:
                                if (obj_stat_track.unlocked_suit_spammer != 1)
                                {
                                    obj_stat_track.unlocked_suit_spammer = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            case 48:
                                if (obj_stat_track.unlocked_suit_elemental != 1)
                                {
                                    obj_stat_track.unlocked_suit_elemental = 1;
                                    unlocked_something_new = true;
                                }
                                
                                break;
                            
                            default:
                                break;
                        }
                        
                        if (unlocked_something_new == true)
                        {
                            playsnd(global.sounds.snd_Menu_Open_1, 1.25, false, 1, 0);
                            var unlock_len = array_length(obj_stats.newly_unlocked);
                            array_set(obj_stats.newly_unlocked, unlock_len, i);
                            unlocked_something_new = false;
                        }
                    }
                    
                    draw_rectangle_color((1 + long_butt_h_width) - 150, start_y + (long_butt_height * i) + (bar_power * bar_percentage) + 4, 1 + long_butt_h_width + 150, start_y + (long_butt_height * i) + (bar_power * bar_percentage) + 16, c_black, c_black, c_black, c_black, false);
                    var txt_color = 16777215;
                    
                    if (complet_amm < 1 && complet_amm > 0)
                    {
                        complet_amm *= random_range(0.99, 1);
                    }
                    else if (complet_amm == 1)
                    {
                        if (array_contains(obj_stats.newly_unlocked, i))
                        {
                            new_award = true;
                            bar_color = c_rainbow(get_timer() / 5000);
                            txt_color = c_rainbow(get_timer() / 10000);
                        }
                    }
                    
                    draw_rectangle_color((1 + long_butt_h_width) - 148, start_y + (long_butt_height * i) + (bar_power * bar_percentage) + 6, 1 + (long_butt_h_width - 148) + (296 * complet_amm), start_y + (long_butt_height * i) + (bar_power * bar_percentage) + 14, bar_color, bar_color, bar_color, bar_color, false);
                    draw_set_font(fnt_freddy);
                    outline_text(string(clamp(mission_track, 0, mission_complete)) + " / " + string(mission_complete), 1 + long_butt_h_width, start_y + (long_butt_height * i) + (bar_power * bar_percentage) + 14, 16777215, 0, 1, -1, 9999);
                    draw_set_font(fnt_cambria);
                    draw_set_color(txt_color);
                    draw_text(1 + long_butt_h_width, (start_y + (long_butt_height * i) + (bar_power * bar_percentage)) - 5, txt);
                    draw_set_color(c_white);
                    
                    if (txt != "???")
                    {
                        var reward_col = 0;
                        
                        if (complet_amm >= 1)
                            reward_col = 16777215;
                        
                        draw_sprite_ext(sprite_prev, get_timer() / 100000, (1 + long_butt_h_width) - 264, start_y + (long_butt_height * i) + (bar_power * bar_percentage), sprite_scal, sprite_scal, 0, c_white, 1);
                        var reward_adj = 1;
                        
                        if (txt_color != 16777215)
                            reward_adj = wave(0.9, 1.2, 1, 0);
                        
                        draw_sprite_ext(reward_prev, get_timer() / 100000, 1 + long_butt_h_width + 264, start_y + (long_butt_height * i) + (bar_power * bar_percentage), reward_scal * reward_adj, reward_scal * reward_adj, 0, reward_col, 1);
                    }
                }
                else if (draw_back == false)
                {
                    if (mouseover == true && collision_rectangle((1 + long_butt_h_width + (grid_lr * 148)) - 32, (start_y + (long_butt_height * lay) + (bar_power * bar_percentage)) - 32, 32 + long_butt_h_width + (grid_lr * 148), start_y + 32 + (long_butt_height * lay) + (bar_power * bar_percentage), obj_mouse, false, false))
                    {
                        hover_ind = 0;
                        hover_alph = 0.6;
                        
                        if (obj_stats.bar_clicked == false && obj_stats.mouse_released == true)
                        {
                            moused_over = true;
                            
                            if (stat_t > 0)
                            {
                                var extra_string = "";
                                var add_dmg = "";
                                
                                if (weapon_id > 0)
                                    add_dmg = "\n\n You have done " + string(get_weapon_stat(weapon_id, 0, 1)) + " damage with this weapon and killed " + string(get_weapon_stat(weapon_id, 1, 1)) + " enemies using it.";
                                
                                if (obj_stats.selected == "ENEMIES")
                                {
                                    if (i > 25)
                                        stat_t = irandom_range(100, 9999999);
                                    
                                    extra_string = "\n\nYou have exterminated " + string(stat_t) + " of them.";
                                }
                                
                                if (obj_stats.selected == "UPGRADES")
                                    extra_string = "\n\nEACH UPGRADE: " + extra_st + add_dmg;
                                
                                obj_stats.draw_name = txt;
                                obj_stats.draw_hp = e_hp;
                                obj_stats.draw_spd = e_spd;
                                obj_stats.draw_descr = e_desc + extra_string;
                                var spr_get_nam = sprite_get_name(sprite_prev);
                                collection_upgrade_goal = string_replace(spr_get_nam, "solid", "bs");
                                collection_upgrade_goal = asset_mod_get_index(collection_upgrade_goal);
                                
                                if (!sprite_exists(collection_upgrade_goal))
                                    collection_upgrade_goal = global.sprites.spr_nothing;
                                
                                if (collection_upgrade_spr == global.sprites.spr_nothing)
                                    collection_upgrade_spr = collection_upgrade_goal;
                            }
                            else
                            {
                                obj_stats.draw_name = "???";
                                obj_stats.draw_hp = "";
                                obj_stats.draw_spd = "";
                                obj_stats.draw_descr = "";
                            }
                        }
                    }
                    else if (obj_stats.selected == "ENEMIES")
                    {
                        if (i > 25)
                            sprite_prev = global.sprites.spr_nothing;
                    }
                    
                    if (stat_t > 0)
                    {
                        if (obj_stats.selected == "ENEMIES")
                        {
                            enemies_seen += 1;
                            
                            if (enemies_seen == 22)
                                obj_stats.has_seen_every_enemy = true;
                        }
                        
                        if (obj_stats.selected == "UPGRADES")
                        {
                            weapons_seen += 1;
                            
                            if (weapons_seen == 53)
                                obj_stats.has_seen_every_weapon = true;
                        }
                        
                        draw_sprite_ext(sprite_prev, get_timer() / 100000, 1 + long_butt_h_width + (grid_lr * 148), start_y + (long_butt_height * lay) + (bar_power * bar_percentage), sprite_scal, sprite_scal, 0, c_white, 1);
                    }
                    else
                    {
                        draw_sprite_ext(global.sprites.spr_dust_explosion_3, get_timer() / 100000, 1 + long_butt_h_width + (grid_lr * 148), start_y + (long_butt_height * lay) + (bar_power * bar_percentage), 0.5, 0.5, 0, c_red, 1);
                        draw_sprite_ext(global.sprites.spr_dust_explosion_3, get_timer() / 100000, 1 + long_butt_h_width + (grid_lr * 148), start_y + (long_butt_height * lay) + (bar_power * bar_percentage), 1, 1, 0, c_red, 1);
                        draw_sprite_ext(sprite_prev, get_timer() / 100000, 1 + long_butt_h_width + (grid_lr * 148), start_y + (long_butt_height * lay) + (bar_power * bar_percentage), sprite_scal, sprite_scal, 0, c_black, 1);
                    }
                }
            }
        }
        
        if (obj_stats.selected == "UPGRADES")
        {
            if (moused_over == true && collection_upgrade_goal == collection_upgrade_spr && obj_stats.draw_name != "???")
                collection_upgrade_ind = approach(collection_upgrade_ind, 4, 0.25);
            else if (collection_upgrade_ind > 0)
                collection_upgrade_ind -= 0.25;
            else
                collection_upgrade_spr = global.sprites.spr_nothing;
            
            draw_sprite(global.sprites.spr_bodyscan_nobot, 0, var_Screenw - ((sprite_get_width(global.sprites.spr_bodyscan) / 2) + 28), (var_Screenh / 2) + 78);
            draw_sprite(collection_upgrade_spr, collection_upgrade_ind, var_Screenw - ((sprite_get_width(global.sprites.spr_bodyscan) / 2) + 28), (var_Screenh / 2) + 69);
        }
        
        if (moused_over == true && obj_stats.draw_name != "")
        {
            draw_text_setup(16777215, 1, 1, fnt_cambria);
            outline_text(obj_stats.draw_name, obj_mouse.x, obj_mouse.y + 24, 16777215, 0, 1, -1, 9999);
            draw_text_setup(16777215, 0, 1, fnt_freddy);
            outline_text(obj_stats.draw_hp, obj_mouse.x, obj_mouse.y + 25 + 12, 16777215, 0, 1, -1, 9999);
            outline_text(obj_stats.draw_spd, obj_mouse.x, obj_mouse.y + 25 + 24, 16777215, 0, 1, -1, 9999);
            outline_text(obj_stats.draw_descr, obj_mouse.x, obj_mouse.y + 25 + 36, 16777215, 0, 1, -1, 200);
            draw_text_setup(16777215, 1, 1, fnt_cambria);
        }
        
        for (var i = 0; i < 4; i += 1)
        {
            var tex_alpha = 0;
            
            if (i == 0)
                txt = "UNLOCKS";
            else if (i == 1)
                txt = "STATS";
            else if (i == 2)
                txt = "UPGRADES";
            else if (i == 3)
                txt = "ENEMIES";
            
            if (obj_stats.selected == txt)
                tex_alpha = 1;
            else
                tex_alpha = 0.35;
            
            if (obj_stats.bar_clicked == false && collision_rectangle(var_Camx + 1 + (top_butt_width * i), var_Camy + 2, (var_Camx + 1 + (top_butt_width * i) + (top_butt_h_width * 2)) - 2, var_Camy + 2 + (top_butt_h_height * 2), obj_mouse, false, false))
            {
                tex_alpha = 0.75;
                
                if (obj_stats.bar_clicked == false && obj_stats.mouse_released == true)
                {
                    if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
                    {
                        playsnd(global.sounds.snd_opt_tab_change, 0.9 + (i / 10), 0, 1);
                        obj_stats.selected = txt;
                        obj_stats.changekey = false;
                        obj_stats.editing = "";
                        obj_stats.bar_prog = 0;
                        obj_stats.alarm[1] = 2;
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
        
        if (collision_rectangle(var_Camx + (var_Screenw - finished_butt_width), var_Camy + (var_Screenh - finished_butt_height), var_Camx + var_Screenw, var_Camy + var_Screenh, obj_mouse, false, false) && obj_stats.mouse_released == true)
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
                obj_stats.alarm[0] = 1;
            }
        }
        
        draw_sprite_ext(global.sprites.spr_sett_finished, 0, var_Screenw - finished_butt_h_width - 1, var_Screenh - finished_butt_h_height - 1, 1, 1, 0, c_white, finished_hover_alph);
        draw_text_reset();
    }
}
