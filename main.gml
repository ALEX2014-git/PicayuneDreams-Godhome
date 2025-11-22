self.MOD_VERSION = "1.0.3";
self.MOD_VERSION_REPO = "http://raw.githubusercontent.com/ALEX2014-git/PicayuneDreams-Godhome/main/version_latest.txt";
self.MOD_REPO_URL = "https://github.com/ALEX2014-git/PicayuneDreams-Godhome";
self.MOD_REPO_RELEASES_URL = "https://github.com/ALEX2014-git/PicayuneDreams-Godhome/releases";

self.dirRunVerCheck = "mods/godhome/ver_check/fetch_latest.bat";
self.dirVerFile = "mods/godhome/ver_check/latest_version.ini";
self.dirDisableVerCheck = "mods/godhome/DISABLE_VER_CHECK.txt";

self.isGodHome = false;
self.isInitGodHome = false;

self.version_check_status = -1; // -2 Error -1 Fetching 0 Latest 1 Old //
self.isFetchedVersion = false;
self.version_fetch_timer = 1200;

self.upkeepBossMusic = noone;
self.picayuneSpawned = false;

self.isInitGodHomeGame = false;
self.isInitGodHomeBoss = false;
self.isInitPlayerState = false;

self.isWaitForLevelUp = false;
self.LEVEL_UP_WAIT_TIMER = 240;
self.levelUpWaitTimer = LEVEL_UP_WAIT_TIMER;

self.isWaitForBossDeath = false;
self.bossDieList = [];
self.winGO = false;
self.WIN_DELAY = 120;
self.winDelay = WIN_DELAY;

self.isFinishedBossSpawn = false;
self.MULTI_BOSS_SPAWN_DELAY = 60;
self.multiBossSpawnDelay = 0;
self.spawnedBossCount = 0;
self.bossesKilled = 0;
self.bossesKilledPending = 0;

self.isGodHomeLocked = false;

self.isInitGHBtns = false;

self.isWinTriggered = false;

self.myPlayer = noone;
self.myBossList = [];
self.myStatTracker = noone;
self.myControl = noone;
self.myView = noone;

self.bossHPControlList = [];

self.START_DELAY = 180;
self.startDelay = START_DELAY;

self.bossList = [];
self.selectedBoss = -1;

self.isAllBossesKilledPending = false;

self.ghBossKillTimer = 0;

self.ghIsCheckedBossFlawless = false;
self.ghBossFlawless = -1;
self.isRecordedPlayerDeath = false;

// Godhome Button //
/////////////////////////////
self.btnGH = noone;
self.btnGHX = 450;
self.btnGHY = 350; 
/////////////////////////////

// Boss Selector Arrows //
/////////////////////////////
self.btnPrevBoss = noone;
self.btnPrevBossX = 75;
self.btnPrevBossY = 235;

self.btnNextBoss = noone;
self.btnNextBossX = 230;
self.btnNextBossY = 235;
/////////////////////////////

// One Shot//
/////////////////////////////
self.btnIsOneShot = noone;
self.isOneShot = false;
self.sprIsOneShot = noone;
self.btnIsOneShotX = 270;
self.btnIsOneShotY = 265;
/////////////////////////////

// Instant Restart //
/////////////////////////////
self.btnIsInstaRestart = noone;
self.isInstaRestart = false;
self.sprIsInstaRestart = noone;
self.btnIsInstaRestartX = 220;
self.btnIsInstaRestartY = 265;
/////////////////////////////

// Equipment amount //
/////////////////////////////
self.lvlAmount = 30;

self.btnLvlSub = noone;
self.btnLvlSubX = 120;
self.btnLvlSubY = 300;

self.btnLvlAdd = noone;
self.btnLvlAddX = 160;
self.btnLvlAddY = 300;

self.btnLvl0 = noone;
self.btnLvl0X = 180;
self.btnLvl0Y = 296;
/////////////////////////////

// Boss HP Mult //
/////////////////////////////
self.bossHP = 1.00;

self.btnBossHPSub = noone;
self.btnBossHPSubX = 115;
self.btnBossHPSubY = 320;

self.btnBossHPAdd = noone;
self.btnBossHPAddX = 165;
self.btnBossHPAddY = 320;

self.btnBossHP1 = noone;
self.btnBossHP1X = 180;
self.btnBossHP1Y = 316;
/////////////////////////////

// Boss Amount //
/////////////////////////////
self.bossAmount = 1; 

self.btnBossAmountSub = noone;
self.btnBossAmountSubX = 120;
self.btnBossAmountSubY = 340;

self.btnBossAmountAdd = noone;
self.btnBossAmountAddX = 160;
self.btnBossAmountAddY = 340;

self.btnBossAmount1 = noone;
self.btnBossAmount1X = 180;
self.btnBossAmount1Y = 336;
/////////////////////////////

// Credits //
/////////////////////////////
self.btnCredits = noone;
self.btnCreditsX = 40;
self.btnCreditsY = -1; //Set up in Create event
/////////////////////////////

// Version Info //
/////////////////////////////
self.sprVersionInfo = noone;
self.sprVersionInfoX = 72;
self.sprVersionInfoY = -1; //Set up in Create event
/////////////////////////////

// Stats //
/////////////////////////////
self.ghStatsPath = "godhome/stats/boss_stats.ini";
self.statRounds = 0;
self.statWins = 0;
self.statLoses = 0;
self.statBestTime = "-:-:-";
self.statIsFlawless = false;
self.statIsTrueFlawless = false;
/////////////////////////////

self.isAutoScale = false;

self.isRenderDopButtons = true;

self.isCheckedSpecialSettings = false;

self.IS_DEBUG = false;
self.IS_DRAW_DEBUG_SPRITES = false;
self.IS_SHOW_NETWORKING_MESSAGES = false;

self.IS_DISABLE_VER_CHECK = false;

self.isInit = false;

// First Run //
/////////////////////////////
self.firstTimeRunCheckPath = "godhome/first_run.ini";
self.firstTimeRunBackupPath = "godhome/backup/game.sav.backup";
self.FIRST_TIME_RUN_WARNING = ">>> GODHOME SYSTEM ALERT <<<\n
WARNING: This mod may cause irreversible changes
to your save file — especially in regards to endings and boss interactions.
A backup of your save file has been created at:
<save folder>/godhome/backup\n
Proceed with caution.";
/////////////////////////////

OnCreate = function()
{
	if (IS_DEBUG)
	{
		audio_play_sound(snd_computer_hack, 999 , false);
		lvlAmount = 150;
	};
	
	if (not isCheckedSpecialSettings)
	{
		if (file_exists(working_directory_get() + dirDisableVerCheck))
		{
			IS_DISABLE_VER_CHECK = true;
			if (IS_DEBUG)
			{
				show_message("Disabled version check via special file!");
			}
		}
		isCheckedSpecialSettings = true;
	}
	myStatTracker = instance_find(obj_stat_track, 0);
	InitializeBossList();
	InitModSprites();
	
	if (os_type == os_windows && not IS_DISABLE_VER_CHECK)
	{
		DefExtFuncs();
	}
	else
	{
		isFetchedVersion = true;
		version_check_status = -2;
		if (IS_DEBUG)
		{
			show_message("Not in Windows OS or forced via special configuration, aborting version check");
		}
	}
	sprVersionInfoY = global.screenh - 36;
	btnCreditsY = global.screenh - 32;
}

FirstRunStartupProcedure = function()
{
	if (file_exists("game.sav"))
	{
		file_copy("game.sav", self.firstTimeRunBackupPath);
	}
	ini_open(self.firstTimeRunCheckPath);
	ini_write_real("FirstTimeRun", "Seen_Message", 1);
	ini_close();
	audio_play_sound(snd_picayune_laugh_2, 999 , false);	
	show_message(FIRST_TIME_RUN_WARNING);
}

OnDraw = function()
{	
	if (not isInit) { return; }
	if (IS_DEBUG)
	{
		draw_text(60, 60, "SelBoss: " + string(selectedBoss));
		draw_text(60, 80, "Version check timer: " + string(version_fetch_timer));
		draw_text(60, 100, "Is render dop buttons? " + string(isRenderDopButtons));
		draw_text(60, 120, "LVL UP Wait timer " + string(levelUpWaitTimer));
		draw_text(60, 140, "Bosses killed pending " + string(bossesKilledPending));
		draw_text(60, 160, "isFinishedBossSpawn " + string(isFinishedBossSpawn));
		draw_text(60, 180, "Bosses spawned " + string(spawnedBossCount));
		draw_text(60, 200, "Bosses killed " + string(bossesKilled));
		if (isInitGodHome)
		{
			draw_text(myPlayer.x + 40, myPlayer.y, "ghBossKillTimer: " + string(ghBossKillTimer)); 
			draw_text(myPlayer.x + 40, myPlayer.y + 10, GetBossKillReadableTime(ghBossKillTimer));
			draw_text(myPlayer.x + 40, myPlayer.y + 20, "globalFlawless: " + string(global.flawless_boss)); 
			draw_text(myPlayer.x + 40, myPlayer.y + 30, "ghFlawless: " + string(ghBossFlawless));
			draw_text(myPlayer.x + 40, myPlayer.y + 40, "global.song: " + string(global.song));
			draw_text(myPlayer.x + 40, myPlayer.y + 50, "upkeepSong: " + string(upkeepBossMusic));
		}
	}
	if (instance_exists(btnGH))
	{
		with (btnGH)
		{
			if (hover && !locked)
			{
				other.DrawGodHomeStats();
			}
			if (hover && locked && other.selectedBoss == -1)
			{
				draw_text_setup(65280, 0, 1, fnt_freddy);
				var warnText = "Defeat bosses to unlock them for battle!";
				draw_text_ext_color(x - 280 + random_range(-0.5, 0.5), y - 115 + random_range(-0.5, 0.5), warnText, 99999, -1, c_red, c_red, c_red, c_red, 1);	
				draw_text_reset();			
			}
			if (other.IS_DRAW_DEBUG_SPRITES)
			{
				other.draw_debug_rectangle_transparent(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, 0.3, false);
			}	
		}
	}
	if (instance_exists(btnPrevBoss))
	{
		with (btnPrevBoss)
		{						
			if (other.selectedBoss <> -1)
			{
				draw_text_setup(65280, 0, 1, fnt_freddy);
				var bossName = string_upper(string(other.bossList[other.selectedBoss].code));
				draw_text_ext_color(x + 80, y - 4, bossName, 99999, -1, c_lime, c_lime, c_lime, c_lime, 1);	
				draw_text_reset();
			}
		};
	};
	if (instance_exists(sprIsOneShot) && instance_exists(btnIsOneShot))
	{
		with (sprIsOneShot)
		{
			draw_sprite_ext(global.sprites.spr_skilltree_icos, 37, x, y, image_xscale, image_yscale, 0, other.btnIsOneShot.ico_blend, 1);
		}
	};
	if (instance_exists(sprIsInstaRestart) && instance_exists(btnIsInstaRestart))
	{
		with (sprIsInstaRestart)
		{
			draw_sprite_ext(global.sprites.spr_skilltree_icos, 3, x, y, image_xscale, image_yscale, 0, other.btnIsInstaRestart.ico_blend, 1);
		}
	};
	if (isRenderDopButtons)
	{
		if (instance_exists(btnLvlSub))
		{			
			with (btnLvlSub)
			{
				image_alpha = 1;
				draw_text_setup(65280, 0, 1, fnt_freddy);
				draw_text_ext_color(x - 60, y - 4, "Equipment amount:", 99999, -1, c_lime, c_lime, c_lime, c_lime, 1);	
				draw_text_ext_color(x + 20, y - 4, string(other.lvlAmount), 99999, -1, c_lime, c_lime, c_lime, c_lime, 1);
				draw_text_reset();
			}
		};
		if (instance_exists(btnLvlAdd))
		{
			btnLvlAdd.image_alpha = 1;
		};
		if (instance_exists(btnLvl0))
		{
			with (btnLvl0)
			{
				image_alpha = 1;
				draw_text_setup(65280, 0, 1, fnt_freddy);
				draw_text_ext_color(x + 20, y, "Set to 0", 99999, -1, c_lime, c_lime, c_lime, c_lime, 1);	
				draw_text_reset();
				
				if (other.IS_DRAW_DEBUG_SPRITES)
				{
					other.draw_debug_rectangle_transparent(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, 0.3, false);
				}
			}
		};
		var colBossHP = c_lime;
		if (instance_exists(btnBossHPSub))
		{
			with (btnBossHPSub)
			{
				image_alpha = 1;
				draw_text_setup(65280, 0, 1, fnt_freddy);
				draw_text_ext_color(x - 82, y - 4, "Boss HP:", 99999, -1, colBossHP, colBossHP, colBossHP, colBossHP, 1);	
				draw_text_ext_color(x + 25, y - 4, string(other.bossHP) + "x", 99999, -1, colBossHP, colBossHP, colBossHP, colBossHP, 1);
				draw_text_reset();				
			}
		}
		if (instance_exists(btnBossHPAdd))
		{
			with (btnBossHPAdd)
			{
				image_blend = colBossHP;
				image_alpha = 1;
			}
		}
		if (instance_exists(btnBossHP1))
		{
			with(btnBossHP1)
			{
				image_alpha = 1;
				draw_text_setup(65280, 0, 1, fnt_freddy);
				draw_text_ext_color(x + 15, y, "Reset", 99999, -1, colBossHP, colBossHP, colBossHP, colBossHP, 1);	
				draw_text_reset();	

				if (other.IS_DRAW_DEBUG_SPRITES)
				{
					other.draw_debug_rectangle_transparent(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, 0.3, false);		
				}
			}
		}
		var colBossAmount = c_lime;
		var isBossAmountUnlocked = true;
		if (selectedBoss == 4)
		{
			colBossAmount = c_red;
			isBossAmountUnlocked = false;
		}
		if (instance_exists(btnBossAmountSub))
		{
			with(btnBossAmountSub)
			{
				image_blend = colBossAmount;
				image_alpha = 1;
				draw_text_setup(65280, 0, 1, fnt_freddy);
				draw_text_ext_color(x - 77, y - 4, "Boss amount:", 99999, -1, colBossAmount, colBossAmount, colBossAmount, colBossAmount, 1);	
				draw_text_ext_color(x + 20, y - 4, string(other.bossAmount), 99999, -1, colBossAmount, colBossAmount, colBossAmount, colBossAmount, 1);
				draw_text_reset();	

				if (not isBossAmountUnlocked)
				{
					image_alpha = 0;
					draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * scal, image_yscale * scal, 0, c_red, 1); //Color doesn't changes because blend is hardcoded and GMS is weird. Too bad!
				}				
			}
		}
		if (instance_exists(btnBossAmountAdd))
		{
			with(btnBossAmountAdd)
			{
				image_blend = colBossAmount;
				image_alpha = 1;
				
				if (not isBossAmountUnlocked)
				{
					image_alpha = 0;
					draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * scal, image_yscale * scal, 0, c_red, 1);
				}
			}
		}
		if (instance_exists(btnBossAmount1))
		{
			with(btnBossAmount1)
			{
				image_blend = colBossAmount;
				image_alpha = 1;
				draw_text_setup(65280, 0, 1, fnt_freddy);
				draw_text_ext_color(x + 15, y, "Reset", 99999, -1, colBossAmount, colBossAmount, colBossAmount, colBossAmount, 1);	
				draw_text_reset();	

				if (other.IS_DRAW_DEBUG_SPRITES)
				{
					other.draw_debug_rectangle_transparent(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, 0.3, false);
				}	
			}
		}
	}
	else
	{
		if (instance_exists(btnLvlSub))
		{
			btnLvlSub.image_alpha = 0;
		}
		if (instance_exists(btnLvlAdd))
		{
			btnLvlAdd.image_alpha = 0;
		}
		if (instance_exists(btnLvl0))
		{
			btnLvl0.image_alpha = 0;
		}
		if (instance_exists(btnBossHP1))
		{
			btnBossHP1.image_alpha = 0;
		}
		if (instance_exists(btnBossHPSub))
		{
			btnBossHPSub.image_alpha = 0;
		}
		if (instance_exists(btnBossHPAdd))
		{
			btnBossHPAdd.image_alpha = 0;
		}
		if (instance_exists(btnBossHP1))
		{
			btnBossHP1.image_alpha = 0;
		}
		if (instance_exists(btnBossAmountSub))
		{
			btnBossAmountSub.image_alpha = 0;
		}
		if (instance_exists(btnBossAmountAdd))
		{
			btnBossAmountAdd.image_alpha = 0;
		}
		if (instance_exists(btnBossAmount1))
		{
			btnBossAmount1.image_alpha = 0;
		}
	}
	if (instance_exists(sprVersionInfo))
	{
		with (sprVersionInfo)
		{
			if (other.version_check_status == 1 || other.IS_DEBUG)
			{				
				image_alpha = 1;
				draw_text_setup(65280, 0, 1, fnt_freddy);
				var verText = string(other.GetVersionFlavor());
				var rain = c_rainbow(get_timer() / 10000);
				outline_text_ext(verText, x + 75, y, rain, 0, 1, -1, 200, 1, 1, 0);
				draw_text_reset();
			}
			if (other.IS_DRAW_DEBUG_SPRITES)
			{
				other.draw_debug_rectangle_transparent(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, 0.3, false);
			}			
		}
	};
	if (instance_exists(btnCredits))
	{
		with (btnCredits)
		{
			if (instance_place(x, y, obj_mouse))
			{
				draw_text_setup(65280, 0, 1, fnt_freddy);
				var creditsText = "Godhome mod v. " + other.MOD_VERSION + " by ALEX2014\nClick to open GitHub page.";
				var mouse = instance_find(obj_mouse, 0);
				outline_text_ext(creditsText, mouse.x + 100, mouse.y - 10, c_white, 0, 1, -1, 200, 1, 1, 0);
				draw_text_reset();
			}
		}
	}
}

draw_debug_rectangle_transparent = function(_x1, _y1, _x2, _y2, _col, _alpha, _outline)
{
    var old_alpha = draw_get_alpha();
    draw_set_alpha(_alpha);
    draw_rectangle_color(_x1, _y1, _x2, _y2, _col, _col, _col, _col, _outline);
    draw_set_alpha(old_alpha);
}

OnDrawGUI = function()
{
	if (room == rm_test && isGodHome)
	{
		draw_text_setup(65280, 1, 2, fnt_equipment);
		outline_text(GetBossKillReadableTime(ghBossKillTimer), global.screenw - 16, 32, 65280, 0, 1, -1, 9999);
		draw_text_reset();
	}
}

GetTrueFalseText = function(boolVar)
{
	if (boolVar)
	{
		return "TRUE";
	}
	else
	{
		return "FALSE";
	}
}

DrawGodHomeStats = function()
{
	if (selectedBoss == -1) { return; }
	draw_text_setup(16777215, 0, 0, fnt_freddy);
	outline_text_ext("STATS: [" + bossList[selectedBoss].code + "]", 16, 16, 16777215, 0, 1, -1, 200, 2, 2, 0);
	outline_text_ext("Rounds: " + string(statRounds), 16 + wave(-4, 4, 4, 1 / 10), 36, 16777215, 0, 1, -1, 200, 1, 1, 0);
	outline_text_ext("Wins: " + string(statWins), 16 + wave(-4, 4, 4, 2 / 10), 48, 16777215, 0, 1, -1, 200, 1, 1, 0);
	outline_text_ext("Loses: " + string(statLoses), 16 + wave(-4, 4, 4, 3 / 10), 60, 16777215, 0, 1, -1, 200, 1, 1, 0);
	outline_text_ext("Flawless: " + GetTrueFalseText(statIsFlawless), 16 + wave(-4, 4, 4, 4 / 10), 72, 16777215, 0, 1, -1, 200, 1, 1, 0);
	outline_text_ext("True Flawless: " + GetTrueFalseText(statIsTrueFlawless), 16 + wave(-4, 4, 4, 5 / 10), 84, 16777215, 0, 1, -1, 200, 1, 1, 0);
	outline_text_ext("Best Beat IGT: " + string(statBestTime), 16 + wave(-4, 4, 4, 6 / 10), 96, 16777215, 0, 1, -1, 200, 1, 1, 0);
	if (bossAmount > 1)
	{
		outline_text_ext("<!> WARNING: STATS TRACKING IS DISABLED FOR MULTI-BOSS ENCOUNTERS!", 16 + random_range(-0.5, 0.5), 108 + random_range(-0.5, 0.5), 255, 0, 1, -1, 200, 1, 1, 0);
	}
	draw_text_reset();
}

InitDopBtns = function()
{
	btnPrevBoss = instance_create_depth(btnPrevBossX, btnPrevBossY, 55, obj_overdrive_arrow);
	btnNextBoss = instance_create_depth(btnNextBossX, btnNextBossY, 55, obj_overdrive_arrow);
	btnLvlSub = instance_create_depth(btnLvlSubX, btnLvlSubY, 55, obj_overdrive_arrow);
	btnLvlAdd = instance_create_depth(btnLvlAddX, btnLvlAddY, 55, obj_overdrive_arrow);	
	btnBossHPAdd = instance_create_depth(btnBossHPAddX, btnBossHPAddY, 55, obj_overdrive_arrow);
	btnBossHPSub = instance_create_depth(btnBossHPSubX, btnBossHPSubY, 55, obj_overdrive_arrow);
	btnBossAmountSub = instance_create_depth(btnBossAmountSubX, btnBossAmountSubY, 55, obj_overdrive_arrow);
	btnBossAmountAdd = instance_create_depth(btnBossAmountAddX, btnBossAmountAddY, 55, obj_overdrive_arrow);
}

OnStep = function()
{
	if (!isInit)
	{
		selectedBoss = FindNextUnlockedBossIndex(other.selectedBoss);
		ReadGodHomeStats();
		isInit = true;
	}
	if (not file_exists(self.firstTimeRunCheckPath))
	{
		FirstRunStartupProcedure();
	}
	if (IS_DISABLE_VER_CHECK)
	{
		isFetchedVersion = true;
		version_check_status = -2;
		version_fetch_timer = -9999;
	}
	if (not isFetchedVersion)
	{
		var bat_path = working_directory_get() + dirRunVerCheck;
		RunBatSilent(bat_path);
		isFetchedVersion = true;
	};
	if (isFetchedVersion && (version_check_status == -1 && version_fetch_timer > 0))
	{	
		var timerRemainder = version_fetch_timer mod 100;
		if (timerRemainder == 0)
		{
			var checkPath = working_directory_get() + dirVerFile;
			CheckVersion(checkPath);
		}
	}
	if (version_check_status == -1 && version_fetch_timer > 0)
	{
		version_fetch_timer-=1;
	}
	if (version_fetch_timer == 0)
	{
		version_fetch_timer = -999;
		version_check_status = -2;
	}
	if (room == rm_mainmenu)
	{
		isRenderDopButtons = true;
		if (not isInitGHBtns)
		{
			sprVersionInfo = instance_create_depth(sprVersionInfoX, sprVersionInfoY, 50, obj_rpg_wall);
			sprVersionInfo.image_xscale = 9.5;
			sprVersionInfo.image_yscale = 0.5;				
			
			sprite_set_offset(global.sprites.spr_menu_github, 16, 16);
			btnCredits = instance_create_depth(btnCreditsX, btnCreditsY, 100, obj_discord);
			btnCredits.version = "ghGithub";	
			btnCredits.sprite_index = global.sprites.spr_menu_github;
			btnCredits.image_xscale = 1;
			btnCredits.image_yscale = 1;
			btnCredits.image_speed = 0.3;


			btnGH = instance_create_depth(btnGHX, btnGHY, 350, obj_menu_button);
			btnGH.butt = "godhome";
			
			btnGH.idlespr = global.sprites.spr_butt_chall_idle;	
			btnGH.highspr = global.sprites.spr_butt_chall_high;
			btnGH.image_speed = 0.3;
			var checkGHLock = FindNextUnlockedBossIndex(-1);
			if (checkGHLock == -1)
			{			
				btnGH.locked = true;
				isGodHomeLocked = true;
				isInitGHBtns = true;
			}
			else
			{
				ReadGodHomeStats();
			}
			
			if (not isGodHomeLocked)
			{
				if (myStatTracker != noone)
				{
					var realOverMax = myStatTracker.overdrive_max;
					var isNeedOverdriveHack = realOverMax == 0;
					try
					{
						if (isNeedOverdriveHack)
						{
							myStatTracker.overdrive_max = -1; //Dirty horrible hack, since overdrive_arrows destroy itself in Create event otherwise //						
						}
						InitDopBtns(); //Needs to be called via function, otherwise compiler optimises calls and 0-OD save gets null reference! //
					}
					finally
					{
						if (isNeedOverdriveHack)
						{
							myStatTracker.overdrive_max = realOverMax;
						}
					}		
					btnPrevBoss.image_xscale = -1;
					btnLvlSub.image_xscale = -1;
					btnBossHPSub.image_xscale = -1;
					btnBossAmountSub.image_xscale = -1;
					
					btnLvlSub.hold_timer = 0;
					btnLvlSub.is_held = false;
					
					btnLvlAdd.hold_timer = 0;
					btnLvlAdd.is_held = false;
					
					btnBossHPSub.hold_timer = 0;
					btnBossHPSub.is_held = false;
					
					btnBossHPAdd.hold_timer = 0;
					btnBossHPAdd.is_held = false;
					
					btnBossAmountSub.hold_timer = 0;
					btnBossAmountSub.is_hled = false;
					
					btnBossAmountAdd.hold_timer = 0;
					btnBossAmountAdd.is_held = false;
				}

				sprIsOneShot = instance_create_depth(btnIsOneShotX, btnIsOneShotY, 50, obj_rpg_wall);
				sprIsOneShot.image_xscale = 1;
				sprIsOneShot.image_yscale = 1;				
				
				btnIsOneShot = instance_create_depth(btnIsOneShotX, btnIsOneShotY, 100, obj_toggle_button);
				btnIsOneShot.variable = "ghIsOneShot";
				btnIsOneShot.title = "Glass Core";
				btnIsOneShot.desc = "Caps Cyl's Max HP at 1.\nDisables on-death protections skills effects.";		
				btnIsOneShot.image_xscale = 1;
				btnIsOneShot.image_yscale = 1;
				btnIsOneShot.ico_ind = 4;	
				btnIsOneShot.toggled = isOneShot;

				sprIsInstaRestart = instance_create_depth(btnIsInstaRestartX, btnIsInstaRestartY, 50, obj_rpg_wall);
				sprIsInstaRestart.image_xscale = 1;
				sprIsInstaRestart.image_yscale = 1;
				
				btnIsInstaRestart = instance_create_depth(btnIsInstaRestartX, btnIsInstaRestartY, 100, obj_toggle_button);
				btnIsInstaRestart.variable = "ghIsInstaRestart";
				btnIsInstaRestart.title = "Instant Restart";
				btnIsInstaRestart.desc = "Restarts the fight on Cyl's death instead of going into game over.";		
				btnIsInstaRestart.image_xscale = 1;
				btnIsInstaRestart.image_yscale = 1;
				btnIsInstaRestart.ico_ind = 4;	
				btnIsInstaRestart.toggled = isInstaRestart;	

				btnLvl0	= instance_create_depth(btnLvl0X, btnLvl0Y, 50, obj_rpg_wall);
				btnLvl0.image_xscale = 2.5;
				btnLvl0.image_yscale = 0.5;
				
				btnBossHP1 = instance_create_depth(btnBossHP1X, btnBossHP1Y, 50, obj_rpg_wall);
				btnBossHP1.image_xscale = 2;
				btnBossHP1.image_yscale = 0.5;
				
				btnBossAmount1 = instance_create_depth(btnBossAmount1X, btnBossAmount1Y, 50, obj_rpg_wall);
				btnBossAmount1.image_xscale = 2;
				btnBossAmount1.image_yscale = 0.5;
				
				isInitGHBtns = true;
			}
		}
		if (instance_exists(btnGH))
		{
			with (btnGH) 
			{
				if (locked == false && other.isGodHomeLocked == false && other.selectedBoss <> -1)
				{
					if (hover && (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed))
					{
						var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
						ftr.rm = rm_fadetogame;
						global.gamestart_ind = 1;
						
						global.gamemode = "freeplay";						
						other.isGodHome = true;
						
						if (other.selectedBoss == 4)
						{
							other.bossAmount = 1;
						}
					}
				}
			};		
		};
		if (instance_exists(btnPrevBoss))
		{
			with (btnPrevBoss)
			{
				if (not other.isGodHomeLocked)
				{
					if (instance_place(x, y, obj_mouse)) && ((mouse_check_button_pressed(mb_left) || global.gp_accept_pressed))
					{
						audio_play_sound(snd_crit, 999 , false);
						other.selectedBoss = other.FindPrevUnlockedBossIndex(other.selectedBoss);
						other.ReadGodHomeStats();
					}				
				}				
			};
		};
		if (instance_exists(btnNextBoss))
		{
			with (btnNextBoss)
			{
				if (not other.isGodHomeLocked)
				{
				if (instance_place(x, y, obj_mouse)) && ((mouse_check_button_pressed(mb_left) || global.gp_accept_pressed))
					{
						audio_play_sound(snd_crit, 999 , false);
						other.selectedBoss = other.FindNextUnlockedBossIndex(other.selectedBoss);
						other.ReadGodHomeStats();
					}		
				}				
			}
		};
		if (instance_exists(btnIsOneShot))
		{
			isOneShot = btnIsOneShot.toggled;
			if (btnIsOneShot.hovering)
			{
				isRenderDopButtons = false;
			}
		};
		if (instance_exists(btnIsInstaRestart))
		{
			isInstaRestart = btnIsInstaRestart.toggled;
			if (btnIsInstaRestart.hovering)
			{
				isRenderDopButtons = false;
			}
		};
		btnLvlSubUpdate();
		btnLvlAddUpdate();
		btnBossHPSubUpdate();
		btnBossHPAddUpdate();
		btnBossAmountSubUpdate();
		btnBossAmountAddUpdate();
		if (instance_exists(btnLvl0))
		{
			with (btnLvl0)
			{
				if (not other.isGodHomeLocked)
				{
					if (instance_place(x, y, obj_mouse)) && ((mouse_check_button_pressed(mb_left) || global.gp_accept_pressed))
					{
						audio_play_sound(snd_crit, 999 , false);
						other.lvlAmount = 0;
					}		
				}				
			}		
		};
		if (instance_exists(btnBossHP1))
		{
			with (btnBossHP1)
			{
				if (not other.isGodHomeLocked)
				{
					if (instance_place(x, y, obj_mouse)) && ((mouse_check_button_pressed(mb_left) || global.gp_accept_pressed))
					{
						audio_play_sound(snd_crit, 999 , false);
						other.bossHP = 1;
					}		
				}				
			}		
		};
		if (instance_exists(btnBossAmount1))
		{
			with (btnBossAmount1)
			{
				if (not other.isGodHomeLocked)
				{
					if (instance_place(x, y, obj_mouse)) && ((mouse_check_button_pressed(mb_left) || global.gp_accept_pressed))
					{
						audio_play_sound(snd_crit, 999 , false);
						other.bossAmount = 1;
					}		
				}				
			}		
		};	
		if (instance_exists(sprVersionInfo))
		{
			with (sprVersionInfo)
			{
				if (other.version_check_status == 1 || other.IS_DEBUG)
				{
					if (instance_place(x, y, obj_mouse)) && ((mouse_check_button_pressed(mb_left) || global.gp_accept_pressed))
					{
						audio_play_sound(snd_phone_ring, 999 , false);
						url_open(other.MOD_REPO_RELEASES_URL);
					}				
				}
			}
		}
		if (instance_exists(btnCredits))
		{
			with (btnCredits)
			{
				if (instance_place(x, y, obj_mouse))
				{
					if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
					{
						url_open(other.MOD_REPO_URL);
					}
				}
			}
		}
	}
	if (room == rm_test)
	{
		if (not isGodHome)
		{
			return;
		}		
		if (levelUpWaitTimer > 0 && isInitGodHomeGame)
		{
			myControl.free_reroll = 1;
		}
		if (not isInitGodHome)
		{
			if (not isInitGodHomeGame)
			{
				if (startDelay == START_DELAY)
				{
					with (obj_player)
					{
						other.myPlayer = self;
					}
					with (obj_view)
					{
						other.myView = self;
					}
					with (obj_control)
					{
						other.myControl = self;
					}
					InitGHGameState();					
				}
				if (startDelay > 0)
				{
					startDelay = startDelay - 1;
					return;
				}
			

				global.dialog = diag_placeholder;
				global.dialog_code = 0;
				global.spr_player_face_idle = global.sprites.spr_nothing;
				global.spr_player_face_talk = global.sprites.spr_nothing;
				global.spr_player_face = global.sprites.spr_nothing;
				global.spr_enemy_face_idle = global.sprites.spr_nothing;
				global.spr_enemy_face_talk = global.sprites.spr_nothing;
				global.spr_enemy_face = global.sprites.spr_nothing;
				with (obj_control)
				{
					dialog_finished = 1;
					dialog_index = 1;
				}
				isInitGodHomeGame = true;
			}		
			if (not isInitPlayerState)
			{
				InitGHPlayerState();
			}
			if (instance_exists(myView) && instance_exists(myControl))
			{
				if (myView.showtabmen == false && myControl.levelupscreen == 0)
				{
					levelUpWaitTimer -= 1;
				}
				else
				{
					levelUpWaitTimer = LEVEL_UP_WAIT_TIMER;								
				}
			}
			isWaitForLevelUp = levelUpWaitTimer >= 0;
			if (not isInitGodHomeBoss)
			{		
				if (not isWaitForLevelUp)
				{
					myControl.mod_anyenemy = false;					
				}
			}
			if (isInitGodHomeGame && isInitGodHomeBoss)
			{
				isInitGodHome = true;
			}
		}		
		SpawnGHBoss();					
		InitGHBossState();
		GodHomeUpdate();
	}
};

AllBossesKilledPendingCheck = function()
{
	if (selectedBoss != 1 && selectedBoss != 9)
	{
		if (bossesKilledPending + bossesKilled == bossAmount) { return true; }
		else { return false; } 
	}
	else
	{
		if (bossesKilledPending > 0 || bossesKilled > 0) { return true; }
		else { return false; } 
	}
	return false;
}

AllBossesKilledCheck = function()
{
	if (selectedBoss != 1 && selectedBoss != 9)
	{
		if (bossesKilled == bossAmount) { return true; }
		else { return false; } 
	}
	else
	{
		if (bossesKilled > 0) { return true; }
		else { return false; } 	
	}
	return false;
}

UpkeepBossMusic = function()
{
	if (not isInitGodHome || not isFinishedBossSpawn) { return; }
	if (selectedBoss == 4) { return; }
	if (upkeepBossMusic != noone && not ((bossesKilledPending + bossesKilled) >= bossAmount))
	{
		if (global.song == global.sounds.mus_silence)
		{
			global.song = upkeepBossMusic;
		}
	}
	if (upkeepBossMusic == noone)
	{
		if (upkeepBossMusic != global.sounds.mus_silence)
		{
			upkeepBossMusic = global.song;
		}
	}
}

GodHomeUpdate = function()
{
	if (not isGodHome) { return; }

	if (not isFinishedBossSpawn)
	{
		MakeAllEnemiesImmortal(20);
	}
	if (isFinishedBossSpawn && not isInitGodHomeBoss)
	{
		MakeAllEnemiesImmortal(10);
	}

	if (myControl.player_death)
	{
		upkeepBossMusic = noone;
		if (not isRecordedPlayerDeath)
		{
			GodHomeDeathStat();
			isRecordedPlayerDeath = true;
		}
	}
	
	myView.show_destins = 0;
	myView.show_ending = 0;
	myControl.true_end_flawlesses = 0;

	if (not isInitGodHome) { return; }

	if (isFinishedBossSpawn && not isAllBossesKilledPending)
	{
		var dt = (delta_time / 1000) * myControl.gameSpeed;
		ghBossKillTimer += dt;
	}

	if (isOneShot)
	{
		global.hpmax = 1;
		if (global.hp > 1)
		{
			global.hp = 1;
		}
	}
	
	UpdateBossState();

	if ((selectedBoss == 5 || selectedBoss == 6 || selectedBoss == 7) && bossAmount > 1)
	{
		PicayuneMultiBossUpdate();
	}
	
	if (myControl.player_death && isInstaRestart) 
	{
		if (global.killed_by != "CAPACITOR OVERCHARGE")
		{
			var ftr_rest = instance_create_depth(x, y, -9999999, obj_fadetoroom);
			ftr_rest.rm = rm_test;
		}
	}
		
	for (var i = 0; i < instance_number(obj_boss_die); i+=1)
	{
		var boss_die = instance_find(obj_boss_die, i);
		if ((selectedBoss != 4) || (selectedBoss == 4 && boss_die.boss == "Picayune_3"))
		{
			var result = array_add_unique(bossDieList, boss_die);
			bossDieList = result[0];
			var isChanged = result[1];
			if (isChanged)
			{
				bossesKilledPending+=1;
			}
		}
		if (bossesKilledPending > 0)
		{
			isWaitForBossDeath = true;
		}
	}
	
	if (AllBossesKilledPendingCheck())
	{
		isAllBossesKilledPending = true;
	}

	if (isWaitForBossDeath)
	{
		for (j = array_length(bossDieList) - 1; j >= 0; j-=1)
		{
			if (!instance_exists(bossDieList[j]))
			{
				BossDied(bossDieList[j]);
			}
		}
		if (array_length(bossDieList) == 0)
		{
			isWaitForBossDeath = false;
		}
	}
	if (AllBossesKilledCheck())
	{
		winGO = true;
	}
	if (winGO)
	{
		winDelay-=1;
	}
	if (winDelay <= 0 && not isWinTriggered)
	{
		WinGodHome();
	}
	
	if (not winGO)
	{
		if (not instance_exists(obj_boss_die))
		{
			ghBossFlawless = global.flawless_boss;
		}
	}
	UpkeepBossMusic();
}

UpdateBossState = function()
{
	with (obj_boss_parent)
	{
		//if (not variable_instance_exists(isAutoScaled))
		//{
			//PLACEHOLDER
			//isAutoScaled = true;
		//}
		if (not variable_instance_exists(self, "isScaledHP"))
		{
			self.hp = self.hp * other.bossHP;
			isScaledHP = true;
		}
	}	
}

KillPlayer = function()
{
	playsnd(global.sounds.snd_glass_shatter, 1, false, 1);
	global.hpmax = 0;
	myControl.player_death = true;		
	with(obj_player)
	{
		alarm[0] = 1;
	}
	
	global.killed_by = "Weight of their sins";
}

OnEndStep = function()
{	
	if (not isInitGodHome || not isGodHome) { return; }
	
	if (global.hp <= 0 && isOneShot && myControl.player_death == false)
	{
		KillPlayer();
	}		
}

WinGodHome = function()
{
	isWinTriggered = true;
	scr_copygamedata();
	var ftr = instance_create_depth(x, y, depth - 99999, obj_fadetoroom);
	ftr.rm = rm_console;
	global.willingly_ended_run = 2;
	global.ds_mortality = 25;
	SaveGodHomeWinStats();
}

GodHomeRoundsStat = function()
{
	if (bossAmount > 1) { return; }

	var filePath = ghStatsPath;
	
	ini_open(filePath);	
	
	var oldRounds = ini_read_real(bossList[selectedBoss].code, "Rounds", 0);	
	var rounds = oldRounds + 1;
	
	ini_write_real(bossList[selectedBoss].code, "Rounds", rounds);
	
	ini_close();	
}

GodHomeDeathStat = function()
{
	if (bossAmount > 1) { return; }

	var filePath = ghStatsPath;
	
	ini_open(filePath);	
	
	var oldDeaths = ini_read_real(bossList[selectedBoss].code, "Lost", 0);	
	var deaths = oldDeaths + 1;
	
	ini_write_real(bossList[selectedBoss].code, "Lost", deaths);
	
	ini_close();		
}

SaveGodHomeWinStats = function()
{
	if (bossAmount > 1) { return; }

	var filePath = ghStatsPath;
	
	ini_open(filePath);	
	
	var oldIsFlawless = ini_read_real(bossList[selectedBoss].code, "Flawless", 0);
	
	if (oldIsFlawless == 0)
	{
		var isFlawless = (ghBossFlawless > 0);
		ini_write_real(bossList[selectedBoss].code, "Flawless", isFlawless);
	}
	
	var oldIsTrueFlawless = ini_read_real(bossList[selectedBoss].code, "True_Flawless", 0);
	
	if (oldIsTrueFlawless == 0)
	{	
		var isTrueFlawless = (ghBossFlawless > 1);
		ini_write_real(bossList[selectedBoss].code, "True_Flawless", isTrueFlawless);
	}
	
	var oldBestTime = ini_read_real(bossList[selectedBoss].code, "Best_Time", -1);
	if (oldBestTime > ghBossKillTimer || oldBestTime == -1)
	{
		ini_write_real(bossList[selectedBoss].code, "Best_Time", ghBossKillTimer);
	}
	
	var oldWins = ini_read_real(bossList[selectedBoss].code, "Won", 0);	
	var wins = oldWins + 1;
	
	ini_write_real(bossList[selectedBoss].code, "Won", wins);
	
	ini_close();	
}

ReadGodHomeStats = function()
{
	if (selectedBoss == -1) { return; }

	var filePath = ghStatsPath;
	
	if (not file_exists(filePath)) { return; }
	
	ini_open(filePath);	

	var rounds = ini_read_real(bossList[selectedBoss].code, "Rounds", 0);
	statRounds = rounds;
	
	var wins = ini_read_real(bossList[selectedBoss].code, "Won", 0);
	statWins = wins;

	var loses = ini_read_real(bossList[selectedBoss].code, "Lost", 0);
	statLoses = loses;	

	var best_time = ini_read_real(bossList[selectedBoss].code, "Best_Time", -1);
	if (best_time == -1)
	{
		statBestTime = "-:-:-";
	}
	else
	{
		statBestTime = GetBossKillReadableTime(best_time);
	}	

	var flawless = ini_read_real(bossList[selectedBoss].code, "Flawless", 0);
	statIsFlawless = flawless;	
	
	var trueFlawless = ini_read_real(bossList[selectedBoss].code, "True_Flawless", 0);
	statIsTrueFlawless = trueFlawless;
	
	ini_close();	
}

OnRoomStart = function()
{
	if (string_starts_with(room_get_name(room), "rm_rpgmaker")) //Destroy ourselves if we're in RPG maker room in order to prevent obj_mod_container duplication
	{
		if (IS_DEBUG)
		{
			audio_play_sound(snd_EntitySpawn, 999 , false);
		}
		instance_destroy(self);
		return;
	}
	myPlayer = noone;
	myBossList = [];
	myControl = noone;
	bossDieList = [];
	picayuneDieObjList = [];
	bossHPControlList = [];
	
	if (room != rm_mainmenu)
	{
		if (isGodHome)
		{
			isInitGodHome = false;
			isInitGodHomeGame = false;
			isInitGodHomeBoss = false;
			isWaitForBossDeath = false;
			isInitPlayerState = false;
			winGO = false;
			winDelay = WIN_DELAY;
			startDelay = START_DELAY;
			levelUpWaitTimer = LEVEL_UP_WAIT_TIMER;
			multiBossSpawnDelay = 0;
			isFinishedBossSpawn = false;
			spawnedBossCount = 0;
			bossesKilled = 0;
			bossesKilledPending = 0;
			upkeepBossMusic = noone;
			picayuneSpawned = false;
			ghBossKillTimer = 0;
			ghIsCheckedBossFlawless = false;
			ghBossFlawless = -1;
			isRecordedPlayerDeath = false;
			isWinTriggered = false;
			isAllBossesKilledPending = false;
		}
		if (instance_exists(btnGH)) { instance_destroy(btnGH); }
		if (instance_exists(btnPrevBoss)) { instance_destroy(btnPrevBoss); }
		if (instance_exists(btnNextBoss)) { instance_destroy(btnNextBoss); }
		if (instance_exists(btnIsOneShot)) { instance_destroy(btnIsOneShot); }
		if (instance_exists(btnIsInstaRestart)) { instance_destroy(btnIsInstaRestart); }
		if (instance_exists(btnIsInstaRestart)) { instance_destroy(btnIsInstaRestart); }		
		if (instance_exists(btnLvlAdd)) { instance_destroy(btnLvlAdd); }
		if (instance_exists(btnLvlSub)) { instance_destroy(btnLvlSub); }
		if (instance_exists(btnLvlSub)) { instance_destroy(btnLvlSub); }
		if (instance_exists(btnLvl0)) { instance_destroy(btnLvl0); }
		if (instance_exists(btnBossHPSub)) { instance_destroy(btnBossHPSub); }
		if (instance_exists(btnBossHPAdd)) { instance_destroy(btnBossHPAdd); }
		if (instance_exists(btnBossHP1)) { instance_destroy(btnBossHP1); }
		if (instance_exists(btnBossAmountSub)) { instance_destroy(btnBossAmountSub); }
		if (instance_exists(btnBossAmountAdd)) { instance_destroy(btnBossAmountAdd); }
		if (instance_exists(btnBossAmount1)) { instance_destroy(btnBossAmount1); }
		
		if (instance_exists(sprIsInstaRestart)) { instance_destroy(sprIsInstaRestart); }
		if (instance_exists(sprIsOneShot)) { instance_destroy(sprIsOneShot); }
		if (instance_exists(sprVersionInfo)) { instance_destroy(sprVersionInfo); }
		
		btnGH = noone;
		btnPrevBoss = noone;
		btnNextBoss = noone;
		btnIsOneShot = noone;		
		btnIsInstaRestart = noone;
		btnLvlAdd = noone;
		btnLvlSub = noone;
		btnLvl0 = noone;
		btnBossHP1 = noone;
		btnBossAmount1 = noone;
		sprIsInstaRestart = noone;
		sprIsOneShot = noone;
		sprVersionInfo = noone;
		
		isInitGHBtns = false;		
	}
	if (room == rm_mainmenu)
	{
		bossList = [];
		InitializeBossList();

		isGodHome = false;
		isInitGodHome = false;
		isInitGodHomeGame = false;
		isInitGodHomeBoss = false;
		isWaitForBossDeath = false;
		isInitPlayerState = false;
		winGO = false;
		winDelay = WIN_DELAY;
		startDelay = START_DELAY;
		levelUpWaitTimer = LEVEL_UP_WAIT_TIMER;
		multiBossSpawnDelay = 0;
		isFinishedBossSpawn = false;
		spawnedBossCount = 0;
		bossesKilled = 0;
		bossesKilledPending = 0;
		upkeepBossMusic = noone;
		picayuneSpawned = false;
		ghBossKillTimer = 0;
		ghIsCheckedBossFlawless = false;
		ghBossFlawless = -1;
		isRecordedPlayerDeath = false;
		isWinTriggered = false;
		isAllBossesKilledPending = false;
	}
};

SpawnGHBoss = function ()
{
	if (isFinishedBossSpawn) { return; }

	if (isWaitForLevelUp && spawnedBossCount == 0) { return; }

	if (multiBossSpawnDelay > 0)
	{
		multiBossSpawnDelay-=1;
		return;
	}
	
	if (selectedBoss == 4 || selectedBoss == 5 || selectedBoss == 6 || selectedBoss == 7 || selectedBoss == 12)
	{
		PicayuneSpawnUpdate();
		return;
	}
		
	var bossStart = bossList[selectedBoss].start;
	var bossInstance = noone;

	if (selectedBoss == 1 || selectedBoss == 15)
	{
		bossInstance = instance_create_layer(myPlayer.x, myPlayer.y + 600, "Boss", bossStart);
		array_push(myBossList, bossInstance);
	}
	else
	{
		bossInstance = instance_create_layer(myPlayer.x, myPlayer.y - 350, "Boss", bossStart);
		array_push(myBossList, bossInstance);		
	}
	
	multiBossSpawnDelay = MULTI_BOSS_SPAWN_DELAY;
	
	spawnedBossCount+=1;
	
	if (spawnedBossCount == bossAmount)
	{
		isFinishedBossSpawn = true;
	}
}

PicayuneSpawnUpdate = function()
{
	var bossStart = bossList[selectedBoss].start;
	bossInstance = noone;
	
	var indexes = [5, 6, 7, 12];

	for (var idx = 0; idx < array_length(indexes); idx += 1)
	{
		var i = indexes[idx];
		for (var j = 0; j < instance_number(bossList[i].start); j += 1)
		{
			var findBossInstance = instance_find(bossList[i].start, j);
			var result = array_add_unique(myBossList, findBossInstance);
			myBossList = result[0];
			isChanged = result[1];
			if (isChanged)
			{
				spawnedBossCount += 1;
			}
		}
	}

	if (spawnedBossCount == bossAmount)
	{
		isFinishedBossSpawn = true;
	}

	if (isFinishedBossSpawn) { return; }
	
	if (selectedBoss == 4 || selectedBoss == 5)
	{
		SpawnBossPicayune();		
	}
	else if (selectedBoss == 6)
	{
		SpawnPicayuneEye();		
	}
	else if (selectedBoss == 7)
	{
		 SpawnTruePicayune();		
	}
	else if (selectedBoss == 12)
	{
		bossInstance = instance_create_layer(myPlayer.x, myPlayer.y, "Instances", bossStart);	
	}
	
	multiBossSpawnDelay = max(MULTI_BOSS_SPAWN_DELAY, 60);
}

SpawnBossPicayune = function()
{
	var bossCtrl = noone;
	if (not instance_exists(obj_picayune_fight_start))
	{
		bossCtrl = instance_create_layer(myPlayer.x, myPlayer.y, "Boss", obj_picayune_fight_start);
	}
	else	
	{
		bossCtrl = instance_find(obj_picayune_fight_start, 0);
	}
	if (spawnedBossCount > 0)
	{
		picaBoss = instance_create_layer(myPlayer.x, myPlayer.y, "Boss", obj_boss_picayune);
		playsnd_at(global.sounds.snd_picayune_laugh_1, 1, false, 2, bossCtrl.x, bossCtrl.y);
	}
}

SpawnPicayuneEye = function()
{
	var bossCtrl = noone;
	if (not instance_exists(obj_picayune_fight_start))
	{
		bossCtrl = instance_create_layer(myPlayer.x, myPlayer.y, "Boss", obj_picayune_fight_start);
		bossCtrl.ready = true;
		bossCtrl.changed_bg = false;		
	}
	else
	{
		bossCtrl = instance_find(obj_picayune_fight_start, 0);
	}
	with (bossCtrl)
	{
		alarm[1] = 50;
	}
	bossCtrl.fog_app_final = 5;
}

SpawnTruePicayune = function()
{
	var bossCtrl = noone;
	if (not instance_exists(obj_picayune_fight_start))
	{
		bossCtrl = instance_create_layer(myPlayer.x, myPlayer.y, "Boss", obj_picayune_fight_start);
		bossCtrl.ready = true;
		bossCtrl.changed_bg = true;
		bossCtrl.finish = true;
		bossCtrl.fog_app_final = 0;		
	}
	else
	{
		bossCtrl = instance_find(obj_picayune_fight_start, 0);
	}
	with (bossCtrl)
	{
		alarm[2] = 50;
	}
}

InitGHGameState = function()
{
	ghBossFlawless = 2;
	myControl.spawnenemies = false;
	myView.show_destins = 0;	
	myControl.mod_anyenemy = true;	
	myControl.rerolls = 999;	
	myControl.free_reroll = 99999999;	
	for (var i = 0; i < lvlAmount; i+=1)
	{
		var pickup = instance_create_layer(myPlayer.x, myPlayer.y, "Effects", obj_unique_pickup);
		pickup.sprite_index = global.sprites.spr_pickup_floppy;
	};
	if (lvlAmount == 0)
	{
		levelUpWaitTimer = -99;
		global.song = global.sounds.mus_ship_alarm;
	}
	else
	{
		global.song = global.sounds.mus_rpg_chill_ride_idea;
	}
	GodHomeRoundsStat();
}

InitGHPlayerState = function()
{
	global.ds_enemieskilled = 1;
	isInitPlayerState = true;
}

MakeAllEnemiesImmortal = function(im_time)
{
    with (obj_enemy_parent)
    {
		immortal = im_time;
    }
}

InitGHBossState = function()
{
	if (not isFinishedBossSpawn || isInitGodHomeBoss) { return; }

	if (array_length(myBossList) == 0) { return; }
	
	if (array_length(myBossList) < bossAmount) { return; }

	with (obj_enemy_parent)
	{
		self.immortal = 0;
	}
	
	isInitGodHomeBoss = true;
}

GetBossKillReadableTime = function(time_ms)
{
	var minutes = floor(time_ms / 60000);
	var seconds = floor((time_ms mod 60000) / 1000);
	var milliseconds = floor(time_ms mod 1000);

	return string(minutes) + ":" + string(seconds) + ":" + string(milliseconds);
}

BossDied = function(bossIndex)
{
	bossesKilled+=1;
	bossesKilledPending-=1;
	bossDieList = array_remove_index(bossDieList, j);
	global.flawless_boss = ghBossFlawless;
}

PicayuneMultiBossUpdate = function()
{
	if (not isFinishedBossSpawn) { return; }

	if (not instance_exists(obj_picayune_fight_start) && bossesKilled < bossAmount)
	{
		SpawnPicayuneFightStartObject();
	}

	if (not picayuneSpawned && array_length(myBossList) == bossAmount)
	{
		picayuneSpawned = true;
	}
	if (picayuneSpawned)
	{
		with(obj_picayune_fight_start)
		{
			alarm[0] = -999;
			alarm[1] = -999;
			alarm[2] = -999;
			alarm[3] = -999;			
		}
	}
}

SpawnPicayuneFightStartObject = function()
{
	var bossCtrl = instance_create_layer(myPlayer.x, myPlayer.y, "Boss", obj_picayune_fight_start);
	with(obj_picayune_fight_start)
	{
		alarm[0] = -999;
		alarm[1] = -999;
		alarm[2] = -999;
		alarm[3] = -999;
		
		if (selectedBoss == 5)
		{
			self.ready = true;
			layer_background_sprite(other.myControl.bg1_id, global.sprites.spr_picayune_scroll_yellow);
			layer_set_visible(effect_layer_warb, true);
			layer_set_visible(effect_layer_tunnel, true);
			global.song = global.sounds.mus_picayune_song1;
		}
		else if (selectedBoss == 6)
		{
			self.ready = true;
			self.changed_bg = false;
			self.fog_app_final = 5;	
			self.finish = true;		
			global.song = global.sounds.mus_picayune_song2;			
		}
		else if (selectedBoss == 7)
		{
			enem_mod = 0;
			layer_background_sprite(other.myControl.bg1_id, bg_backdrop_darkblue);
			global.song = global.sounds.mus_picayune_song3;			
		}
	}
}

InitializeBossList = function()
{
	bossList = [
		{ code: "obj_boss_rabbit",  		start: obj_boss_rabbit,  		   unlocked: myStatTracker.stat_bunny_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_worm",    		start: obj_boss_worm_manager,      unlocked: myStatTracker.stat_worm_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_biker",   		start: obj_boss_biker,   		   unlocked: myStatTracker.stat_biker_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_demon",  			start: obj_boss_demon,   		   unlocked: myStatTracker.stat_demon_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_picayune_full", 	start: obj_boss_picayune,           unlocked: myStatTracker.stat_picayune_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_picayune",         start: obj_boss_picayune,           unlocked: myStatTracker.stat_picayune_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_picayune_eye",     start: obj_boss_picayune_eye,   	   unlocked: myStatTracker.stat_picayune_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_true_picayune",    start: obj_boss_true_picayune,      unlocked: myStatTracker.stat_picayune_kills > 0 or IS_DEBUG },
		{ code: "obj_ab_rabbit",    		start: obj_ab_rabbit,   		   unlocked: myStatTracker.stat_ab_bunny_kills > 0 or IS_DEBUG },
		{ code: "obj_ab_worm",              start: obj_ab_worm_manager, 	   unlocked: myStatTracker.stat_ab_worm_kills > 0 or IS_DEBUG },
		{ code: "obj_ab_biker",     		start: obj_ab_biker,  		   	   unlocked: myStatTracker.stat_ab_biker_kills > 0 or IS_DEBUG },
		{ code: "obj_ab_demon",     		start: obj_ab_demon,     		   unlocked: myStatTracker.stat_ab_demon_kills > 0 or IS_DEBUG },
		{ code: "picayune",     		    start: picayune,     		   	   unlocked: myStatTracker.stat_ab_picayune_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_yuki",   		    start: obj_boss_yuki,   		   unlocked: myStatTracker.stat_yuki_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_ghost",   		start: obj_boss_ghost,   		   unlocked: myStatTracker.stat_ghost_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_diver",  			start: obj_boss_diver,   		   unlocked: myStatTracker.stat_diver_kills > 0 or IS_DEBUG },
		{ code: "obj_boss_umi",     		start: obj_boss_umi,     		   unlocked: myStatTracker.stat_umi_kills > 0 or IS_DEBUG }
	];
};

FindPrevUnlockedBossIndex = function(argSelectedBoss) {
    var total = array_length(bossList);
    if (total == 0) { return -1; }
    
    var start = (argSelectedBoss - 1 + total) % total;
    
    for (var i = 0; i < total; i+=1)
	{
        var index = (start - i + total) % total;
        
        if (bossList[index].unlocked > 0)
		{
            return index;
        }
    }
    
    return -1;
};

FindNextUnlockedBossIndex = function(argSelectedBoss) {
    var total = array_length(bossList);
    if (total == 0) { return -1; }
    
    var start = (argSelectedBoss + 1) % total;
    
    for (var i = 0; i < total; i+=1)
	{
        var index = (start + i) % total;
        
        if (bossList[index].unlocked)
		{
            return index;
        }
    }
    
    return -1;
};

btnLvlSubUpdate = function()
{
	if (instance_exists(btnLvlSub))
	{
		with (btnLvlSub)
		{
			if (not other.isGodHomeLocked)
			{
				var mouse_over = instance_place(x, y, obj_mouse);
				
				if (mouse_over)
				{
					if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
					{
						audio_play_sound(snd_crit, 999, false);
						if (other.lvlAmount > 0)
						{
							other.lvlAmount = other.lvlAmount - 1;
						}
						
						hold_timer = 0;
						is_held = true;
					}
					else if (mouse_check_button(mb_left) || global.gp_accept)
					{
						if (!is_held)
						{
							is_held = true;
							hold_timer = 0;
						}
						else
						{
							hold_timer+=1;
							
							var initial_delay = 30;
							var repeat_rate = 5;
							
							if (hold_timer >= initial_delay && (hold_timer - initial_delay) mod repeat_rate == 0)
							{
								if (other.lvlAmount > 0)
								{
									audio_play_sound(snd_crit, 999, false);
									other.lvlAmount = other.lvlAmount - 1;
								}
							}
						}
					}
					else
					{
						is_held = false;
						hold_timer = 0;
					}
				}
				else
				{
					is_held = false;
					hold_timer = 0;
				}
			}
		}
	}
}

btnLvlAddUpdate = function()
{
	if (instance_exists(btnLvlAdd))
	{
		with (btnLvlAdd)
		{
			if (not other.isGodHomeLocked)
			{
				var mouse_over = instance_place(x, y, obj_mouse);
				
				if (mouse_over)
				{
					if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
					{
						audio_play_sound(snd_crit, 999, false);
						other.lvlAmount = other.lvlAmount + 1;
						
						hold_timer = 0;
						is_held = true;
					}
					else if (mouse_check_button(mb_left) || global.gp_accept)
					{
						if (!is_held)
						{
							is_held = true;
							hold_timer = 0;
						}
						else
						{
							hold_timer+=1;
							
							var initial_delay = 30;
							var repeat_rate = 5;
							
							if (hold_timer >= initial_delay && (hold_timer - initial_delay) mod repeat_rate == 0)
							{
								audio_play_sound(snd_crit, 999, false);
								other.lvlAmount = other.lvlAmount + 1;
							}
						}
					}
					else
					{
						is_held = false;
						hold_timer = 0;
					}
				}
				else
				{
					is_held = false;
					hold_timer = 0;
				}
			}
		}
	}
}

btnBossHPSubUpdate = function()
{
	if (instance_exists(btnLvlSub))
	{
		with (btnBossHPSub)
		{
			if (not other.isGodHomeLocked)
			{
				var mouse_over = instance_place(x, y, obj_mouse);
				
				if (mouse_over)
				{
					if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
					{
						audio_play_sound(snd_crit, 999, false);
						if (other.bossHP > 0.25)
						{
							other.bossHP = other.bossHP - 0.25;
						}
						
						hold_timer = 0;
						is_held = true;
					}
					else if (mouse_check_button(mb_left) || global.gp_accept)
					{
						if (!is_held)
						{
							is_held = true;
							hold_timer = 0;
						}
						else
						{
							hold_timer+=1;
							
							var initial_delay = 30;
							var repeat_rate = 5;
							
							if (hold_timer >= initial_delay && (hold_timer - initial_delay) mod repeat_rate == 0)
							{
								if (other.bossHP > 0.25)
								{
									audio_play_sound(snd_crit, 999, false);
									other.bossHP = other.bossHP - 0.25;
								}	
							}
						}
					}
					else
					{
						is_held = false;
						hold_timer = 0;
					}
				}
				else
				{
					is_held = false;
					hold_timer = 0;
				}
			}
		}
	}
}

btnBossHPAddUpdate = function()
{
	if (instance_exists(btnLvlSub))
	{
		with (btnBossHPAdd)
		{
			if (not other.isGodHomeLocked)
			{
				var mouse_over = instance_place(x, y, obj_mouse);
				
				if (mouse_over)
				{
					if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
					{
						audio_play_sound(snd_crit, 999, false);
						other.bossHP = other.bossHP + 0.25;
						
						hold_timer = 0;
						is_held = true;
					}
					else if (mouse_check_button(mb_left) || global.gp_accept)
					{
						if (!is_held)
						{
							is_held = true;
							hold_timer = 0;
						}
						else
						{
							hold_timer+=1;
							
							var initial_delay = 30;
							var repeat_rate = 5;
							
							if (hold_timer >= initial_delay && (hold_timer - initial_delay) mod repeat_rate == 0)
							{
								audio_play_sound(snd_crit, 999, false);
								other.bossHP = other.bossHP + 0.25;	
							}
						}
					}
					else
					{
						is_held = false;
						hold_timer = 0;
					}
				}
				else
				{
					is_held = false;
					hold_timer = 0;
				}
			}
		}
	}
}

btnBossAmountSubUpdate = function()
{
	if (instance_exists(btnBossAmountSub))
	{
		with (btnBossAmountSub)
		{
			if (not other.isGodHomeLocked)
			{
				var mouse_over = instance_place(x, y, obj_mouse);
				
				if (mouse_over)
				{
					if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
					{
						audio_play_sound(snd_crit, 999, false);
						if (other.bossAmount > 1)
						{
							other.bossAmount-=1;
						}
						
						hold_timer = 0;
						is_held = true;
					}
					else if (mouse_check_button(mb_left) || global.gp_accept)
					{
						if (!is_held)
						{
							is_held = true;
							hold_timer = 0;
						}
						else
						{
							hold_timer+=1;
							
							var initial_delay = 30;
							var repeat_rate = 5;
							
							if (hold_timer >= initial_delay && (hold_timer - initial_delay) mod repeat_rate == 0)
							{
								if (other.bossAmount > 1)
								{
									audio_play_sound(snd_crit, 999, false);
									other.bossAmount-=1;
								}
							}
						}
					}
					else
					{
						is_held = false;
						hold_timer = 0;
					}
				}
				else
				{
					is_held = false;
					hold_timer = 0;
				}
			}
		}
	}
}

btnBossAmountAddUpdate = function()
{
	if (instance_exists(btnBossAmountAdd))
	{
		with (btnBossAmountAdd)
		{
			if (not other.isGodHomeLocked)
			{
				var mouse_over = instance_place(x, y, obj_mouse);
				
				if (mouse_over)
				{
					if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
					{
						audio_play_sound(snd_crit, 999, false);
						other.bossAmount+=1;
						
						hold_timer = 0;
						is_held = true;
					}
					else if (mouse_check_button(mb_left) || global.gp_accept)
					{
						if (!is_held)
						{
							is_held = true;
							hold_timer = 0;
						}
						else
						{
							hold_timer+=1;
							
							var initial_delay = 30;
							var repeat_rate = 5;
							
							if (hold_timer >= initial_delay && (hold_timer - initial_delay) mod repeat_rate == 0)
							{
								audio_play_sound(snd_crit, 999, false);
								other.bossAmount+=1;
							}
						}
					}
					else
					{
						is_held = false;
						hold_timer = 0;
					}
				}
				else
				{
					is_held = false;
					hold_timer = 0;
				}
			}
		}
	}
}


InitModSprites = function()
{
	var spr_idle = global.sprites.spr_butt_chall_idle;					
	sprite_collision_mask(spr_idle, false, 2, 0, 0, 117, 28, 2, 128);
	sprite_set_offset(spr_idle, 355, 150);
	
	var spr_high = global.sprites.spr_butt_chall_high;	
	sprite_collision_mask(spr_high, false, 2, 0, 0, 117, 28, 2, 128);
	sprite_set_offset(spr_high, 355, 150);
}

GetVersionFlavor = function()
{
	if (IS_DEBUG)
	{
		if (version_check_status == -2)
		{
			return "Unable to check version.";
		};
		if (version_check_status == -1)
		{
			return "Checking version...";
		};
		if (version_check_status == 0)
		{
			return "Version is up to date";
		};
	};
	if (version_check_status == 1)
	{
		return "New version available. Click me!";
	}
	else
	{
		return "";
	};
}

CheckVersion = function(checkPath)
{
	if (not (file_exists(checkPath))) { return; }
	ini_open(checkPath);
	var latestVer = ini_read_string("Version", "Latest", "");
	ini_close();
	if (MOD_VERSION != latestVer)
	{
		version_check_status = 1;
	}
	else
	{
		version_check_status = 0;
	}
	DeleteFileSilent(checkPath);
}

RunBatSilent = function(bat_path)
{	
	if (IS_SHOW_NETWORKING_MESSAGES)
	{
		show_message("Call: " + bat_path);	
	}
	var verFile = working_directory_get() + dirVerFile;
	if (file_exists(verFile))
	{
		DeleteFileSilent(verFile);
	}
    if (file_exists(bat_path))
    {
        external_call(global.fn_winexec, bat_path, 0);
		if (IS_SHOW_NETWORKING_MESSAGES)
		{
			show_message("Silent run: " + bat_path);
		}		
    }
    else
    {	
		if (IS_SHOW_NETWORKING_MESSAGES)
		{
			show_message("Run bath error: file not found -> " + bat_path);
		}
    }
}

DeleteFileSilent = function(file_path)
{
    if (file_exists(file_path))
    {
        var result = external_call(global.fn_delete_file, file_path);

        if (result != 0 || !file_exists(file_path))
        {
            if (IS_SHOW_NETWORKING_MESSAGES)
            {
                show_message("File deleted: " + file_path);
            }
            return true;
        }
        else
        {
            if (IS_SHOW_NETWORKING_MESSAGES)
            {
                var err = external_call(global.fn_get_last_error);
                show_message("Error occurred while deleting file: " + file_path + "/n Code: " + string(err));
            }
            return false;
        }
    }
    else
    {
        if (IS_SHOW_NETWORKING_MESSAGES)
        {
            show_message("File for deletion not found: " + file_path);
        }
        return false;
    }
}

DefExtFuncs = function()
{
	global.fn_winexec = external_define(
		"kernel32.dll",
		"WinExec",   
		dll_cdecl,     
		ty_real,       
		2,              
		ty_string,      
		ty_real          
	);	
	global.fn_delete_file = external_define(
		"kernel32.dll",
		"DeleteFileA", 
		dll_cdecl,   
		ty_real,      
		1,            
		ty_string    
	);
	global.fn_get_last_error = external_define(
	"kernel32.dll",
	"GetLastError", 
	dll_cdecl,   
	ty_real,      
	0               
	);
}

array_add_unique = function(arr, value)
{
	var values = "";
    for (var i = 0; i < array_length(arr); i += 1)
    {
        if (arr[i] == value)
		{
            return [arr, false];
		}
    }
    array_push(arr, value);
    return [arr, true];
}


array_remove_index = function(arr, index)
{
    var len = array_length(arr);
    if (index < 0 || index >= len) { return arr; }

    var new_arr = [];
    for (var i = 0; i < len; i+=1)
    {
        if (i != index)
		{
            array_push(new_arr, arr[i]);
		}
    }
    return new_arr;
}