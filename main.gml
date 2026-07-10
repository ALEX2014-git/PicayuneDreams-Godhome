self.MOD_VERSION = "1.1.0";
self.MOD_VERSION_REPO = "http://raw.githubusercontent.com/ALEX2014-git/PicayuneDreams-Godhome/main/version_latest.txt";
self.MOD_REPO_URL = "https://github.com/ALEX2014-git/PicayuneDreams-Godhome";
self.MOD_REPO_RELEASES_URL = "https://github.com/ALEX2014-git/PicayuneDreams-Godhome/releases";

self.dirRunVerCheck = "mods/godhome/ver_check/fetch_latest.bat";
self.dirVerFile = "mods/godhome/ver_check/latest_version.ini";
self.dirDisableVerCheck = "mods/godhome/DISABLE_VER_CHECK.txt";

global.GodHome = noone;

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

self.START_DELAY = 180;
self.startDelay = START_DELAY;

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

self.isCheckedSpecialSettings = false;

self.IS_DEBUG = true;
self.IS_DRAW_DEBUG_SPRITES = false;
self.IS_SHOW_NETWORKING_MESSAGES = false;

self.IS_DISABLE_VER_CHECK = false;

self.isInit = false;
global.rm_godhome = -1;
self.is_transitioning_to_gh_settings = false;

global.isInitiatedModSprites = false;

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

self.global_settings = {
	isOneShot: false,
	isInstaRestart: false,
	bossHP: 1.00,
	bossAmount: 1,
	isUseVanillaEquipSystem: false,
	lvlAmount: 30
	};

InitalizeDBRepository = function()
{
	self.db = {
		tabs: ["MAIN", "UPGRADES"],
		current_tab: "MAIN",
		
		upgrades_list: {
			"core": { id: "core", codename: "core", name: "CORE", spr: global.sprites.spr_solid_Core, sel_lvl: 0, is_unlocked: true },
			"chainbelt": { id: "chainbelt", codename: "chainsaw", name: "CHAINBELT", spr: global.sprites.spr_solid_ChainBelt, sel_lvl: 0, is_unlocked: true },
			"daggerglove": { id: "daggerglove", codename: "slash", name: "DAGGER GLOVE", spr: global.sprites.spr_solid_DaggerGlove, sel_lvl: 0, is_unlocked: true },
			"eye2": { id: "eye2", codename: "laser", name: "EYE2", spr: global.sprites.spr_solid_Eye2, sel_lvl: 0, is_unlocked: true },
			"injection": { id: "injection", codename: "injection", name: "INJECTION", spr: global.sprites.spr_solid_Injection, sel_lvl: 0, is_unlocked: true },
			"battery": { id: "battery", codename: "battery", name: "ENERGIZING BATTERY", spr: global.sprites.spr_solid_Battery, sel_lvl: 0, is_unlocked: true },
			"ivbag": { id: "ivbag", codename: "ivbag", name: "IV BAG", spr: global.sprites.spr_solid_IVBag, sel_lvl: 0, is_unlocked: true },
			"crown": { id: "crown", codename: "crown", name: "PLEONEXIC CROWN", spr: global.sprites.spr_solid_Crown, sel_lvl: 0, is_unlocked: true },
			"plague": { id: "plague", codename: "plague", name: "MASK OF PLAGUE", spr: global.sprites.spr_solid_PlagueMask, sel_lvl: 0, is_unlocked: true },
			"legsaw": { id: "legsaw", codename: "sawblade", name: "LEGSAW", spr: global.sprites.spr_solid_LegSaw, sel_lvl: 0, is_unlocked: true },
			"missile": { id: "missile", codename: "missile", name: "MISSILE PACK", spr: global.sprites.spr_solid_MissilePack, sel_lvl: 0, is_unlocked: true },
			"parasight": { id: "parasight", codename: "parasite", name: "PARASIGHT", spr: global.sprites.spr_solid_ParaSight, sel_lvl: 0, is_unlocked: true },
			"puckrack": { id: "puckrack", codename: "puck", name: "YOYO RACK", spr: global.sprites.spr_solid_Rotator, sel_lvl: 0, is_unlocked: true },
			"bow": { id: "bow", codename: "dart", name: "HUNTER'S BOW", spr: global.sprites.spr_solid_Bow, sel_lvl: 0, is_unlocked: true },
			"halo": { id: "halo", codename: "shield", name: "HALO", spr: global.sprites.spr_solid_Halo, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_halo },
			"horns": { id: "horns", codename: "chomp", name: "HORNS", spr: global.sprites.spr_solid_Horns, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_horns },
			"hydro": { id: "hydro", codename: "bouncy", name: "HYDROCILLATOR", spr: global.sprites.spr_solid_Hydrocillator, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_hydro },
			"flamethrower": { id: "flamethrower", codename: "flamethrower", name: "FLAME THROWER", spr: global.sprites.spr_solid_Flamethrower, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_flamethrower },
			"snowglobe": { id: "snowglobe", codename: "snowglobe", name: "FROST GLOBE", spr: global.sprites.spr_solid_SnowGlobe, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_snowglobe },
			"plasmalamp": { id: "plasmalamp", codename: "plasma", name: "PLASMA LAMP", spr: global.sprites.spr_solid_Plasma, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_plasmalamp },
			"satellite": { id: "satellite", codename: "satellite", name: "STATIC SATELLITE", spr: global.sprites.spr_solid_Satellite, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_satellite },
			"walkman": { id: "walkman", codename: "dj", name: "WICKED WALKMAN", spr: global.sprites.spr_solid_Headphones, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_walkman },
			"spear": { id: "spear", codename: "spear", name: "SOUL SPEAR", spr: global.sprites.spr_solid_Spear, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_spear },
			"turret": { id: "turret", codename: "turret", name: "DEFENSE TURRET", spr: global.sprites.spr_solid_Turret, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_turret },
			"ninja": { id: "ninja", codename: "ninja", name: "SHINOBI EQUIPMENT", spr: global.sprites.spr_solid_Ninja, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_ninjagear },
			"strikecall": { id: "strikecall", codename: "strikecall", name: "STRIKE CALL", spr: global.sprites.spr_solid_Remote, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_strikecall },
			"angelwings": { id: "angelwings", codename: "angelwings", name: "ANGEL WINGS", spr: global.sprites.spr_solid_AngelWings, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_angelwings },
			"batwings": { id: "batwings", codename: "demonwings", name: "DEMON WINGS", spr: global.sprites.spr_solid_BatWings, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_demonwings },
			"watch": { id: "watch", codename: "watch", name: "DIGIWATCH", spr: global.sprites.spr_solid_DigiWatch, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_digiwatch },
			"engine": { id: "engine", codename: "engine", name: "OVERCHARGED ENGINE", spr: global.sprites.spr_solid_Engine, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_engine },
			"c4": { id: "c4", codename: "c4", name: "VOLATILE C4", spr: global.sprites.spr_solid_C4, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_c4 },
			"firelighter": { id: "firelighter", codename: "fire", name: "FIRE LIGHTER", spr: global.sprites.spr_solid_FireLighter, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_firelighter },
			"sundae": { id: "sundae", codename: "ice", name: "FROSTY CONE", spr: global.sprites.spr_solid_IceCream, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_icecream },
			"eel": { id: "eel", codename: "shock", name: "ELECTRIC EEL", spr: global.sprites.spr_solid_Eel, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_eel },
			"crystal": { id: "crystal", codename: "crystal", name: "ELEMENT CRYSTAL", spr: global.sprites.spr_solid_Gem, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_gem },
			"shrapnel": { id: "shrapnel", codename: "shrapnel", name: "SHRAPNEL SHELLS", spr: global.sprites.spr_solid_ShottyVest, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_shotvest },
			"telecom": { id: "telecom", codename: "radio", name: "TELECOM", spr: global.sprites.spr_solid_Telecom, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_telecom },
			"slimespike": { id: "slimespike", codename: "knife", name: "SLIME SPIKE", spr: global.sprites.spr_solid_SlimeSpike, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_slimespike },
			"ultrabuster": { id: "ultrabuster", codename: "cannon", name: "ULTRABUSTER", spr: global.sprites.spr_solid_UltraBuster, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_ultrabuster },
			"sword": { id: "sword", codename: "sword", name: "CHAINSWORD", spr: global.sprites.spr_solid_Sword, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_chainsword },
			"popup": { id: "popup", codename: "popup", name: "POP UP FIREWALL", spr: global.sprites.spr_solid_Firewall, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_popup },
			"death": { id: "death", codename: "death", name: "REAPER SCYTHE", spr: global.sprites.spr_solid_Death, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_scythe },
			"corrupt": { id: "corrupt", codename: "corrupt", name: "CORRUPT TENTACLE", spr: global.sprites.spr_solid_Corrupt, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_tentacle },
			"immunity": { id: "immunity", codename: "immune", name: "FANCY CIGAR", spr: global.sprites.spr_solid_Cigar, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_cigar },
			"dynamite": { id: "dynamite", codename: "dynamite", name: "BLASTIN' STICKS", spr: global.sprites.spr_solid_Dynamite, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_dynamite },
			"award": { id: "award", codename: "award", name: "MISSING AWARD", spr: global.sprites.spr_solid_Award, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_trophy },
			"splash": { id: "splash", codename: "splash", name: "FUNKY CARROT", spr: global.sprites.spr_solid_Carrot, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_carrot },
			"bees": { id: "bees", codename: "bee", name: "LOTS OF BEES", spr: global.sprites.spr_solid_Bees, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_bees },
			"monkey": { id: "monkey", codename: "xpworth", name: "BLESSED MONKEY", spr: global.sprites.spr_solid_Monkey, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_monkey },
			"midas": { id: "midas", codename: "midas", name: "MIDAS HAND", spr: global.sprites.spr_solid_Midas, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_midas },
			"fish": { id: "fish", codename: "flydag", name: "DAGGERFISH CONCH", spr: global.sprites.spr_solid_Fish, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_fish },
			"cheese": { id: "cheese", codename: "cluster", name: "STINKY CHEESE", spr: global.sprites.spr_solid_Cheese, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_cheese },
			"psycho": { id: "psycho", codename: "helmet", name: "PSYCHO HELMET", spr: global.sprites.spr_solid_Psycho, sel_lvl: 0, is_unlocked: myStatTracker.unlocked_helmet },
			"skateboard": { id: "skateboard", codename: "skateboard", name: "PRO SKATEBOARD", spr: global.sprites.spr_solid_placeholder, sel_lvl: 0, is_unlocked: true },
			"bubble": { id: "bubble", codename: "bubble", name: "BULLET BUBBLE", spr: global.sprites.spr_solid_placeholder, sel_lvl: 0, is_unlocked: true }
		},
		
		upgrades_order: [
			"core",
			"chainbelt",
			"daggerglove",
			"eye2",
			"injection",
			"battery",
			"ivbag",
			"crown",
			"plague",
			"legsaw",
			"missile",
			"parasight",
			"puckrack",
			"bow",
			"halo",
			"horns",
			"hydro",
			"flamethrower",
			"snowglobe",
			"plasmalamp",
			"satellite",
			"walkman",
			"spear",
			"turret",
			"ninja",
			"strikecall",
			"angelwings",
			"batwings",
			"watch",
			"engine",
			"c4",
			"firelighter",
			"sundae",
			"eel",
			"crystal",
			"shrapnel",
			"telecom",
			"slimespike",
			"ultrabuster",
			"sword",
			"popup",
			"death",
			"corrupt",
			"immunity",
			"dynamite",
			"award",
			"splash",
			"bees",
			"monkey",
			"midas",
			"fish",
			"cheese",
			"psycho",
			"skateboard",
			"bubble"
		]
	};
};

InitializeBossList = function()
{
	self.db.bossList = [
		{ code: "obj_boss_rabbit",  		start: obj_boss_rabbit,  		   unlocked: myStatTracker.stat_bunny_kills > 0 or IS_DEBUG,       sprite: global.sprites.spr_Gremlin_Move_SE,         scale_mod: 1.2, x_offset: 0, y_offset: 0},
		{ code: "obj_boss_worm",    		start: obj_boss_worm_manager,      unlocked: myStatTracker.stat_worm_kills > 0 or IS_DEBUG,        sprite: global.sprites.spr_Worm_4_NE,               scale_mod: 1.5, x_offset: 0, y_offset: -5},
		{ code: "obj_boss_biker",   		start: obj_boss_biker,   		   unlocked: myStatTracker.stat_biker_kills > 0 or IS_DEBUG,       sprite: global.sprites.spr_Biker_Idle_SE,           scale_mod: 1.0, x_offset: 0, y_offset: 0},
		{ code: "obj_boss_demon",  			start: obj_boss_demon,   		   unlocked: myStatTracker.stat_demon_kills > 0 or IS_DEBUG,       sprite: global.sprites.spr_Demon_Idle_SE,           scale_mod: 0.8, x_offset: 0, y_offset: 0},
		{ code: "obj_boss_picayune_full", 	start: obj_boss_picayune,          unlocked: myStatTracker.stat_picayune_kills > 0 or IS_DEBUG,    sprite: noone,                                      scale_mod: 0.8, x_offset: 0, y_offset: 0},
		{ code: "obj_boss_picayune",        start: obj_boss_picayune,          unlocked: myStatTracker.stat_picayune_kills > 0 or IS_DEBUG,    sprite: global.sprites.spr_picayune_faces,          scale_mod: 1.0, x_offset: 0, y_offset: 0},
		{ code: "obj_boss_picayune_eye",    start: obj_boss_picayune_eye,      unlocked: myStatTracker.stat_picayune_kills > 0 or IS_DEBUG,    sprite: noone,                                      scale_mod: 1.0, x_offset: 0, y_offset: 0},
		{ code: "obj_boss_true_picayune",   start: obj_boss_true_picayune,     unlocked: myStatTracker.stat_picayune_kills > 0 or IS_DEBUG,    sprite: global.sprites.spr_picayune_idle_se,        scale_mod: 1.0, x_offset: 0, y_offset: 0},
		{ code: "obj_ab_rabbit",    		start: obj_ab_rabbit,   		   unlocked: myStatTracker.stat_ab_bunny_kills > 0 or IS_DEBUG,    sprite: global.sprites.spr_AB_Gremlin_Move_SE,      scale_mod: 1.0, x_offset: 0, y_offset: 0},
		{ code: "obj_ab_worm",              start: obj_ab_worm_manager, 	   unlocked: myStatTracker.stat_ab_worm_kills > 0 or IS_DEBUG,     sprite: global.sprites.spr_AB_Worm_Stomach_NE,      scale_mod: 1.2, x_offset: 0, y_offset: -1},
		{ code: "obj_ab_biker",     		start: obj_ab_biker,  		   	   unlocked: myStatTracker.stat_ab_biker_kills > 0 or IS_DEBUG,    sprite: global.sprites.spr_AB_Biker_Drive_SE,       scale_mod: 2.0, x_offset: 0, y_offset: 0},
		{ code: "obj_ab_demon",     		start: obj_ab_demon,     		   unlocked: myStatTracker.stat_ab_demon_kills > 0 or IS_DEBUG,    sprite: global.sprites.spr_AB_Demon_Idle_SE,        scale_mod: 1.0, x_offset: 0, y_offset: 0},
		{ code: "picayune",     		    start: picayune,     		   	   unlocked: myStatTracker.stat_ab_picayune_kills > 0 or IS_DEBUG, sprite: global.sprites.spr_dialog_picayune_ab_idle, scale_mod: 2.0, x_offset: -60, y_offset: 0},
		{ code: "obj_boss_yuki",   		    start: obj_boss_yuki,   		   unlocked: myStatTracker.stat_yuki_kills > 0 or IS_DEBUG,        sprite: global.sprites.spr_Yuki_Idle_SE,            scale_mod: 1.5, x_offset: 0, y_offset: 0},
		{ code: "obj_boss_ghost",   		start: obj_boss_ghost,   		   unlocked: myStatTracker.stat_ghost_kills > 0 or IS_DEBUG,       sprite: global.sprites.spr_Ghost_Idle_SE,           scale_mod: 1.0, x_offset: 0, y_offset: 0},
		{ code: "obj_boss_diver",  			start: obj_boss_diver,   		   unlocked: myStatTracker.stat_diver_kills > 0 or IS_DEBUG,       sprite: global.sprites.spr_Diver_Idle_SE,           scale_mod: 1.0, x_offset: 0, y_offset: 0},
		{ code: "obj_boss_umi",     		start: obj_boss_umi,     		   unlocked: myStatTracker.stat_umi_kills > 0 or IS_DEBUG,         sprite: global.sprites.spr_Umi_Idle,                scale_mod: 1.0, x_offset: 0, y_offset: 0}
	];	
};

OnCreate = function()
{
	global.GodHome = self;	
	if (IS_DEBUG)
	{
		audio_play_sound(snd_computer_hack, 999 , false);
		global.GodHome.global_settings.lvlAmount = 100;
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
			//love <3 you 
		}
		isCheckedSpecialSettings = true;
	}
	myStatTracker = instance_find(obj_stat_track, 0);
	InitModSprites();
	InitalizeDBRepository();
	InitializeBossList();
	
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

GetRainbowColor = function()
{
	return c_rainbow(get_timer() / 10000);
}

OnDraw = function()
{	
	if (not isInit) { return; }
	if (IS_DEBUG)
	{
		if (room == rm_mainmenu || room == rm_test)
		{
			draw_text(60, 60, "SelBoss: " + string(selectedBoss));
			draw_text(60, 80, "Version check timer: " + string(version_fetch_timer));
			draw_text(60, 100, "LVL UP Wait timer " + string(levelUpWaitTimer));
			draw_text(60, 120, "Bosses killed pending " + string(bossesKilledPending));
			draw_text(60, 140, "isFinishedBossSpawn " + string(isFinishedBossSpawn));
			draw_text(60, 160, "Bosses spawned " + string(spawnedBossCount));
			draw_text(60, 180, "Bosses killed " + string(bossesKilled));
		}
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
	outline_text_ext("STATS: [" + db.bossList[selectedBoss].code + "]", 16, 16, 16777215, 0, 1, -1, 200, 2, 2, 0);
	outline_text_ext("Rounds: " + string(statRounds), 16 + wave(-4, 4, 4, 1 / 10), 36, 16777215, 0, 1, -1, 200, 1, 1, 0);
	outline_text_ext("Wins: " + string(statWins), 16 + wave(-4, 4, 4, 2 / 10), 48, 16777215, 0, 1, -1, 200, 1, 1, 0);
	outline_text_ext("Loses: " + string(statLoses), 16 + wave(-4, 4, 4, 3 / 10), 60, 16777215, 0, 1, -1, 200, 1, 1, 0);
	outline_text_ext("Flawless: " + GetTrueFalseText(statIsFlawless), 16 + wave(-4, 4, 4, 4 / 10), 72, 16777215, 0, 1, -1, 200, 1, 1, 0);
	outline_text_ext("True Flawless: " + GetTrueFalseText(statIsTrueFlawless), 16 + wave(-4, 4, 4, 5 / 10), 84, 16777215, 0, 1, -1, 200, 1, 1, 0);
	outline_text_ext("Best Beat IGT: " + string(statBestTime), 16 + wave(-4, 4, 4, 6 / 10), 96, 16777215, 0, 1, -1, 200, 1, 1, 0);
	if (global_settings.bossAmount > 1)
	{
		outline_text_ext("<!> WARNING: STATS TRACKING IS DISABLED FOR MULTI-BOSS ENCOUNTERS!", 16 + random_range(-0.5, 0.5), 108 + random_range(-0.5, 0.5), 255, 0, 1, -1, 200, 1, 1, 0);
	}
	draw_text_reset();
}

OnStep = function()
{
	if (!isInit)
	{
		selectedBoss = FindNextUnlockedBossIndex(other.selectedBoss);
		ReadGodHomeStats();
		isInit = true;
	}
	GodHomeRoomUpdate();
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
		if (not isInitGHBtns)
		{			
			if (!instance_exists(self.btnGH))
			{
				self.btnGH = global.GodHome.CreateModMenuObject(btnGHX, btnGHY, 350, global.GodHome.MenuObjectType.MenuButton);	
				self.btnGH.idlespr = global.sprites.spr_butt_godhome_idle;	
				self.btnGH.highspr = global.sprites.spr_butt_godhome_high;
				self.btnGH.image_speed = 0.3;
				self.btnGH.OnButtonClick = method(self.btnGH, global.GodHome.OnGodHomeMenuButtonClick);
				var checkGHLock = global.GodHome.FindNextUnlockedBossIndex(-1) == -1;
				global.GodHome.ReadGodHomeStats();
			}							
			isInitGHBtns = true;
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
					with (obj_control)
					{
						other.myControl = self;
					}
					with (obj_view)
					{
						other.myView = self;
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
		if (bossesKilledPending + bossesKilled == global_settings.bossAmount) { return true; }
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
		if (bossesKilled == global_settings.bossAmount) { return true; }
		else { return false; } 
	}
	else
	{
		if (bossesKilled > 0) { return true; }
		else { return false; } 	
	}
	return false;
}

UpkeepBossBackground = function()
{
//PLACEHOLDER
}

UpkeepBossMusic = function()
{
	if (not isInitGodHome || not isFinishedBossSpawn) { return; }
	if (selectedBoss == 4) { return; }
	if (upkeepBossMusic != noone && not ((bossesKilledPending + bossesKilled) >= global_settings.bossAmount))
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

	if (global_settings.isOneShot)
	{
		global.hpmax = 1;
		if (global.hp > 1)
		{
			global.hp = 1;
		}
	}
	
	UpdateBossState();

	if ((selectedBoss == 5 || selectedBoss == 6 || selectedBoss == 7) && global_settings.bossAmount > 1)
	{
		PicayuneMultiBossUpdate();
	}
	
	if (myControl.player_death && global_settings.isInstaRestart) 
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
			self.hp = self.hp * global.GodHome.global_settings.bossHP;
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
	
	if (global.hp <= 0 && global_settings.isOneShot && myControl.player_death == false)
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
	if (global_settings.bossAmount > 1) { return; }

	var filePath = ghStatsPath;
	
	ini_open(filePath);	
	
	var oldRounds = ini_read_real(db.bossList[selectedBoss].code, "Rounds", 0);	
	var rounds = oldRounds + 1;
	
	ini_write_real(db.bossList[selectedBoss].code, "Rounds", rounds);
	
	ini_close();	
}

GodHomeDeathStat = function()
{
	if (global_settings.bossAmount > 1) { return; }

	var filePath = ghStatsPath;
	
	ini_open(filePath);	
	
	var oldDeaths = ini_read_real(db.bossList[selectedBoss].code, "Lost", 0);	
	var deaths = oldDeaths + 1;
	
	ini_write_real(db.bossList[selectedBoss].code, "Lost", deaths);
	
	ini_close();		
}

SaveGodHomeWinStats = function()
{
	if (global_settings.bossAmount > 1) { return; }

	var filePath = ghStatsPath;
	
	ini_open(filePath);	
	
	var oldIsFlawless = ini_read_real(db.bossList[selectedBoss].code, "Flawless", 0);
	
	if (oldIsFlawless == 0)
	{
		var isFlawless = (ghBossFlawless > 0);
		ini_write_real(db.bossList[selectedBoss].code, "Flawless", isFlawless);
	}
	
	var oldIsTrueFlawless = ini_read_real(db.bossList[selectedBoss].code, "True_Flawless", 0);
	
	if (oldIsTrueFlawless == 0)
	{	
		var isTrueFlawless = (ghBossFlawless > 1);
		ini_write_real(db.bossList[selectedBoss].code, "True_Flawless", isTrueFlawless);
	}
	
	var oldBestTime = ini_read_real(db.bossList[selectedBoss].code, "Best_Time", -1);
	if (oldBestTime > ghBossKillTimer || oldBestTime == -1)
	{
		ini_write_real(db.bossList[selectedBoss].code, "Best_Time", ghBossKillTimer);
	}
	
	var oldWins = ini_read_real(db.bossList[selectedBoss].code, "Won", 0);	
	var wins = oldWins + 1;
	
	ini_write_real(db.bossList[selectedBoss].code, "Won", wins);
	
	ini_close();
}

ReadGodHomeStats = function()
{
	if (selectedBoss == -1) { return; }

	var filePath = ghStatsPath;
	
	if (not file_exists(filePath)) { return; }
	
	ini_open(filePath);	

	var rounds = ini_read_real(db.bossList[selectedBoss].code, "Rounds", 0);
	statRounds = rounds;
	
	var wins = ini_read_real(db.bossList[selectedBoss].code, "Won", 0);
	statWins = wins;

	var loses = ini_read_real(db.bossList[selectedBoss].code, "Lost", 0);
	statLoses = loses;	

	var best_time = ini_read_real(db.bossList[selectedBoss].code, "Best_Time", -1);
	if (best_time == -1)
	{
		statBestTime = "-:-:-";
	}
	else
	{
		statBestTime = GetBossKillReadableTime(best_time);
	}	

	var flawless = ini_read_real(db.bossList[selectedBoss].code, "Flawless", 0);
	statIsFlawless = flawless;	
	
	var trueFlawless = ini_read_real(db.bossList[selectedBoss].code, "True_Flawless", 0);
	statIsTrueFlawless = trueFlawless;

	ini_close();	
}

GotoRoomGodhome = function()
{
	self.orig_camx = global.camx;
	self.orig_camy = global.camy;
	global.rm_godhome = room_add();
	room_set_width(global.rm_godhome, 960);
    room_set_height(global.rm_godhome, 540);
	room_set_background_color(global.rm_godhome, c_black, true);
	room_set_view_enabled(global.rm_godhome, true);
	self.is_transitioning_to_gh_settings = true;
	var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
	ftr.rm = global.rm_godhome;
}

GodHomeRoomUpdate = function()
{
	if (self.is_transitioning_to_gh_settings && room == global.rm_godhome)
	{	
		self.is_transitioning_to_gh_settings = false;
		var cam_w = global.screenw;
		var cam_h = global.screenh;
		var new_cam = camera_create_view(orig_camx, orig_camy, cam_w, cam_h);
		room_set_camera(global.rm_godhome, 0, new_cam);
		view_set_camera(0, new_cam);
		view_set_visible(0, true);
		
		var view_spawn_x = self.orig_camx + (cam_w / 2);
		var view_spawn_y = self.orig_camy + (cam_h / 2);
		var custom_view = instance_create_depth(view_spawn_x, view_spawn_y, 0, obj_view);
		custom_view.x = view_spawn_x;
		custom_view.y = view_spawn_y;
		
		instance_create_depth(0, 0, 0, obj_fadein);
		instance_create_depth(0, 0, 0, obj_stats);
		CreateModObject(0, 0, 0, ModObjectType.SettingsMenu);	
	}
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
	bossDieList = [];
	picayuneDieObjList = [];
	
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
		
		btnGH = noone;
		myControl = noone;
		
		isInitGHBtns = false;		
	}
	if (room == rm_mainmenu)
	{
		db.bossList = [];
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

OnDestroy = function()
{
	if (IS_DEBUG)
	{
		audio_play_sound(snd_gremlin_death_scream, 999 , false);
	}
}

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
		
	var bossStart = db.bossList[selectedBoss].start;
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
	
	if (spawnedBossCount == global_settings.bossAmount)
	{
		isFinishedBossSpawn = true;
	}
}

PicayuneSpawnUpdate = function()
{
	var bossStart = db.bossList[selectedBoss].start;
	bossInstance = noone;
	
	var indexes = [5, 6, 7, 12];

	for (var idx = 0; idx < array_length(indexes); idx += 1)
	{
		var i = indexes[idx];
		for (var j = 0; j < instance_number(db.bossList[i].start); j += 1)
		{
			var findBossInstance = instance_find(db.bossList[i].start, j);
			var result = array_add_unique(myBossList, findBossInstance);
			myBossList = result[0];
			isChanged = result[1];
			if (isChanged)
			{
				spawnedBossCount += 1;
			}
		}
	}

	if (spawnedBossCount == global_settings.bossAmount)
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

SpawnBlueFloppyPickup = function(_x, _y, amount)
{
	var giveAmount = amount;
	if (amount == undefined)
	{
		giveAmount = 1;
	}
	for (var i = 0; i < giveAmount; i+=1)
	{
		var pickup = instance_create_layer(_x, _y, "Effects", obj_unique_pickup);
		pickup.sprite_index = global.sprites.spr_pickup_floppy;
	};	
}

InitGHGameState = function()
{
	ghBossFlawless = 2;
	myControl.spawnenemies = false;
	myView.show_destins = 0;	
	myControl.mod_anyenemy = true;	
	myControl.rerolls = 999;	
	myControl.free_reroll = 99999999;
	if (global.GodHome.global_settings.isUseVanillaEquipSystem)
	{
		SpawnBlueFloppyPickup(myPlayer.x, myPlayer.y, global.GodHome.global_settings.lvlAmount);		
		if (global.GodHome.global_settings.lvlAmount == 0)
		{
			levelUpWaitTimer = -99;
			global.song = global.sounds.mus_ship_alarm;
		}
		else
		{
			global.song = global.sounds.mus_rpg_chill_ride_idea;
		}
	}
	else
	{
		levelUpWaitTimer = -99;
	}
	GodHomeRoundsStat();
}

InitGHPlayerState = function()
{
	global.ds_enemieskilled = 1;
	if (IS_DEBUG)
	{		
		var keys = variable_struct_get_names(self.db.upgrades_list);
		var total_items = array_length(keys);
		for (var i = 0; i < total_items; i+=1)
		{
			var key = keys[i];
			var item = self.db.upgrades_list[$ key];
			set_player_item_amount_by_id(myPlayer, item.id, item.sel_lvl);		
		}
	}
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
	
	if (array_length(myBossList) < global_settings.bossAmount) { return; }

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

	if (not instance_exists(obj_picayune_fight_start) && bossesKilled < global_settings.bossAmount)
	{
		SpawnPicayuneFightStartObject();
	}

	if (not picayuneSpawned && array_length(myBossList) == global_settings.bossAmount)
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

FindPrevUnlockedBossIndex = function(argSelectedBoss)
{
    var total = array_length(db.bossList);
    if (total == 0) { return -1; }
    
    var start = (argSelectedBoss - 1 + total) % total;
    
    for (var i = 0; i < total; i+=1)
	{
        var index = (start - i + total) % total;
        
        if (db.bossList[index].unlocked > 0)
		{
            return index;
        }
    }   
    return -1;
};

FindNextUnlockedBossIndex = function(argSelectedBoss)
{
    var total = array_length(db.bossList);
    if (total == 0) { return -1; }
    
    var start = (argSelectedBoss + 1) % total;
    
    for (var i = 0; i < total; i+=1)
	{
        var index = (start + i) % total;
        
        if (db.bossList[index].unlocked)
		{
            return index;
        }
    }   
    return -1;
};

InitModSprites = function()
{
	if (global.isInitiatedModSprites) { return; }
	var spr_chall_butt_idle = global.sprites.spr_butt_chall_idle;					
	sprite_collision_mask(spr_chall_butt_idle, false, 2, 0, 0, 117, 28, 2, 128);
	sprite_set_offset(spr_chall_butt_idle, 355, 150);
	
	var spr_chall_butt_high = global.sprites.spr_butt_chall_high;	
	sprite_collision_mask(spr_chall_butt_high, false, 2, 0, 0, 117, 28, 2, 128);
	sprite_set_offset(spr_chall_butt_high, 355, 150);
	
	var spr_chall_butt_flat_idle = global.sprites.spr_butt_chall_flat_idle;					
	sprite_collision_mask(spr_chall_butt_flat_idle, false, 2, 0, 0, 117, 28, 2, 128);
	
	var spr_chall_butt_flat_high = global.sprites.spr_butt_chall_flat_high;	
	sprite_collision_mask(spr_chall_butt_flat_high, false, 2, 0, 0, 117, 28, 2, 128);

	var spr_godhome_butt_idle = global.sprites.spr_butt_godhome_idle;					
	sprite_collision_mask(spr_godhome_butt_idle, false, 2, 0, 0, 101, 28, 2, 128);
	sprite_set_offset(spr_godhome_butt_idle, 355, 150);
	
	var spr_godhome_butt_high = global.sprites.spr_butt_godhome_high;					
	sprite_collision_mask(spr_godhome_butt_high, false, 2, 0, 0, 101, 28, 2, 128);
	sprite_set_offset(spr_godhome_butt_high, 355, 150);
	
	sprite_set_offset(global.sprites.spr_menu_github, 16, 16);

	global.isInitiatedModSprites = true;
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
				try
				{
					var err = external_call(global.fn_get_last_error);
					show_message("Error occurred while deleting file: " + file_path + "/n Code: " + string(err));
				}
				catch (exception)
				{
					show_message("Error occured while attempting to get last error!/n" + exception);	
				}				                
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
	try
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
	catch (err)
	{
        if (IS_DEBUG) { show_message("Failed to load kernel32.dll. Disabling ver check."); }
        
        self.IS_DISABLE_VER_CHECK = true;
        self.version_check_status = -2;
        self.isFetchedVersion = true;	
	}
}

array_add_unique = function(arr, value)
{
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

set_player_item_amount_by_id = function(playerObj, itemID, count, isForceSet)
{	
	if (isForceSet == undefined)
	{
		isForceSet = false;
	}
	if (count == 0 && !isForceSet) { return; }
	itemData = self.db.upgrades_list[$ itemID];
	if (!itemData.is_unlocked && !isForceSet) { return; }
	itemRecord = variable_instance_get(myControl, "item_" + itemID);
	variable_instance_set(playerObj, "powerup_" + itemData.codename, count);
	ds_list_add(playerObj.equipped_items, itemRecord);
}

////////////////////////////////////////////////////////////////////
//Custom Menu Buttons Logic
////////////////////////////////////////////////////////////////////

OnGodHomeStartButtonClick = function()
{
	if (!global.GodHome.isGodHomeLocked && global.GodHome.selectedBoss <> -1)
	{
		var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
		ftr.rm = rm_fadetogame;
		global.gamestart_ind = 1;
		
		global.gamemode = "freeplay";						
		global.GodHome.isGodHome = true;
		
		if (global.GodHome.selectedBoss == 4)
		{
			global.GodHome.global_settings.bossAmount = 1;
		}
	}
}

OnGodHomeStartButtonDraw = function()
{
	if (is_hovering && !is_locked)
	{
		global.GodHome.DrawGodHomeStats();
	}
	if (is_hovering && is_locked && global.GodHome.selectedBoss == -1)
	{
		draw_text_setup(65280, 0, 1, fnt_freddy);
		var warnText = "Defeat bosses to unlock them for battle!";
		draw_text_ext_color(x - 280 + random_range(-0.5, 0.5), y - 115 + random_range(-0.5, 0.5), warnText, 99999, -1, c_red, c_red, c_red, c_red, 1);	
		draw_text_reset();			
	}
}

OnGodHomeMenuButtonClick = function()
{
	global.GodHome.GotoRoomGodhome();
}

////////////////////////////////////////////////////////////////////
//Custom Menu Arrows Logic
////////////////////////////////////////////////////////////////////

IncreaseBossHPVar = function()
{
	global.GodHome.global_settings.bossHP = global.GodHome.global_settings.bossHP + 0.25;	
}

DecreaseBossHPVar = function()
{
	if (global.GodHome.global_settings.bossHP > 0.25)
	{
		global.GodHome.global_settings.bossHP = global.GodHome.global_settings.bossHP - 0.25;
	}	
}

ResetBossHPVar = function()
{
	global.GodHome.global_settings.bossHP = 1;
}

IncreaseBossAmountVar = function()
{
	global.GodHome.global_settings.bossAmount = global.GodHome.global_settings.bossAmount + 1;
}

DecreaseBossAmountVar = function()
{
	if (global.GodHome.global_settings.bossAmount > 1)
	{
		global.GodHome.global_settings.bossAmount = global.GodHome.global_settings.bossAmount - 1;
	}	
}

ResetBossAmountVar = function()
{
	global.GodHome.global_settings.bossAmount = 1;
}

DecreaseLvlAmountVar = function()
{
	if (global.GodHome.global_settings.lvlAmount > 1)
	{
		global.GodHome.global_settings.lvlAmount -= 1;
	}
}

IncreaseLvlAmountVar = function()
{
	global.GodHome.global_settings.lvlAmount += 1;
}

ResetLvlAmountVar = function()
{
	global.GodHome.global_settings.lvlAmount = 1;
}

DecreaseItemsAmountVar = function()
{
	var total_items = array_length(global.GodHome.db.upgrades_order);
	for (var i = 0; i < total_items; i+=1)
	{
		var key = global.GodHome.db.upgrades_order[i];
		var item = global.GodHome.db.upgrades_list[$ key];
		if (not item.is_unlocked) { continue };
		if (item.sel_lvl > 0)
		{
			item.sel_lvl -= 1;
		}
	}
}

DecreaseBigItemsAmountVar = function()
{
	var total_items = array_length(global.GodHome.db.upgrades_order);
	for (var i = 0; i < total_items; i+=1)
	{
		var key = global.GodHome.db.upgrades_order[i];
		var item = global.GodHome.db.upgrades_list[$ key];
		if (not item.is_unlocked) { continue };
		if (item.sel_lvl < 10)
		{
			item.sel_lvl = 0;
		}
		else
		{
			item.sel_lvl -= 10;
		}	
	}
}

IncreaseItemsAmountVar = function()
{
	var total_items = array_length(global.GodHome.db.upgrades_order);
	for (var i = 0; i < total_items; i+=1)
	{
		var key = global.GodHome.db.upgrades_order[i];
		var item = global.GodHome.db.upgrades_list[$ key];
		if (not item.is_unlocked) { continue };
		item.sel_lvl += 1;
	}
}

IncreaseBigItemsAmountVar = function()
{
	var total_items = array_length(global.GodHome.db.upgrades_order);
	for (var i = 0; i < total_items; i+=1)
	{		
		var key = global.GodHome.db.upgrades_order[i];
		var item = global.GodHome.db.upgrades_list[$ key];
		if (not item.is_unlocked) { continue };
		item.sel_lvl += 10;
	}
}

ResetItemsAmountVar = function()
{
	var total_items = array_length(global.GodHome.db.upgrades_order);
	for (var i = 0; i < total_items; i+=1)
	{
		var key = global.GodHome.db.upgrades_order[i];
		var item = global.GodHome.db.upgrades_list[$ key];
		if (not item.is_unlocked) { continue };
		item.sel_lvl = 0;
	}
}

////////////////////////////////////////////////////////////////////
//Custom Menu Labels Logic
////////////////////////////////////////////////////////////////////

OpenReleasesRepoPage = function()
{
	audio_play_sound(snd_phone_ring, 999 , false);
	url_open_ext(global.GodHome.MOD_REPO_RELEASES_URL, "_blank");
}

////////////////////////////////////////////////////////////////////
//Custom Objects Defininition
////////////////////////////////////////////////////////////////////

instance_mod_exists = function(obj_type_, inst_type)
{
	if (inst_type == undefined)
	{
		inst_type = obj_mod_instance;
	}
	with (inst_type)
	{
		if (self.obj_type == obj_type_) { return true; }
	}
	return false;
}

ModObjectType =
{
	SettingsMenu: 1000
}

CreateModObject = function(x_, y_, depth_, type, struct)
{
	if (struct == undefined)
    {
        struct = {}; 
    }

	var inst = instance_create_depth(x_, y_, depth_, obj_mod_instance);
	inst.obj_type = type;
	
	if (type == ModObjectType.SettingsMenu)
	{		
		inst.OnCustomCreate = method(inst, OnSettingsMenuCreate);
		inst.OnStep = method(inst, OnSettingsMenuStep);
		inst.OnDraw = method(inst, OnSettingsMenuDraw);
		inst.OnDestroy = method(inst, OnSettingsMenuDestroy);
		inst.OnSettingsMenuStart = method(inst, OnSettingsMenuStart);
		inst.OnTabChange = method(inst, OnSettingsMenuTabChange);
	}
	
	if (variable_instance_exists(inst, "OnCustomCreate"))
	{
        inst.OnCustomCreate();
    }
	
	var keys = variable_struct_get_names(struct);
    for (var i = 0; i < array_length(keys); i+=1)
    {
        var key = keys[i];
        var val = variable_struct_get(struct, key);
        variable_instance_set(inst, key, val);
    }
	return inst;	
}

/////////
//Settings Menu
////////

OnSettingsMenuCreate = function()
{
	self.bkgSpriteList = [global.sprites.bg_backdrop_clouds,
						  global.sprites.bg_backdrop_darkblue,
						  global.sprites.bg_backdrop_green,
						  global.sprites.bg_backdrop_lightblue,
						  global.sprites.bg_backdrop_medblue,
						  global.sprites.bg_backdrop_pink,
						  global.sprites.bg_backdrop_purple,
						  global.sprites.bg_backdrop_red,
						  global.sprites.bg_backdrop_yellow,
						  global.sprites.bg_background_0
						 ];
	self.bkgSpriteIndex = irandom(array_length(bkgSpriteList) - 1);	
	
	self.SIDEBAR_SIZE = 3;
	
    //Upgrades
	self.grid_cols = 6;
    self.item_size = 64;
    self.item_pad = 64;
	self.upgrades_left_pad = 200;

    //Bosses
	self.boss_grid_cols = 6;
    self.boss_item_size = 64;
    self.boss_item_pad = 64;
	self.boss_left_pad = 200;
	
	self.scroll_y = 0;
	self.scroll_speed = 45;
    self.max_scroll = 0;
	
    self.bar_clicked = false;  
    self.bar_alph = 0.5;
	self.click_offset_y = 0;	
	self.bar_height = sprite_get_height(global.sprites.spr_sett_bar_block) * SIDEBAR_SIZE;
	self.bar_half_height = self.bar_height / 2;

	self.min_sidebar_y = self.bar_half_height; 
	self.max_sidebar_y = global.screenh - self.bar_half_height;

	self.bar_prog = self.min_sidebar_y;
	
	self.is_held = false;
	self.hold_timer = 0;
    self.old_tab = "";
	
    self.db_ref = global.GodHome.db; 
   
	self.last_tab = db_ref.current_tab;
	
	self.godHomeStartButton = noone;
	self.godHomeToggleOneShot = noone;
	self.godHomeToggleInstantRestart = noone;
	self.godHomeToggleOldEquipmentSystem = noone;
	
	///////////////////////////
	//Boss HP Controls
	///////////////////////////
	self.labelBossHP = noone;
	self.labelBossHPReset = noone;
	self.labelBossHPValue = noone;	
	self.arrowBossHPSub = noone;
	self.arrowBossHPAdd = noone;
	///////////////////////////
	
	///////////////////////////
	//Boss Amount Controls
	///////////////////////////	
	self.labelBossAmount = noone;
	self.labelBossAnountReset = noone;
	self.labelBossAmountValue = noone;
	self.arrowBossAmountAdd = noone;
	self.arrowBossAmountSub = noone;
	///////////////////////////

	///////////////////////////
	//Equipment Amount
	///////////////////////////	
	self.toggleUseVanillaEquipSys = noone;
	self.arrowLvlAmountSub = noone;
	self.arrowLvlAmountAdd = noone;
	self.labelLvlAmount = noone;
	self.labelLvlAmountValue = noone;
	self.labelLvlReset = noone;
	
	self.labelItemsControls = noone;	
	self.labelItemsSub = noone;
	self.labelItemsSubBig = noone;	
	self.labelItemsAdd = noone;
	self.labelItemsAddBig = noone;
	self.labelItemsReset = noone;
	///////////////////////////

	///////////////////////////
	//Credits
	///////////////////////////		
	self.labelModVersion = noone;
	self.buttonGithubCredits = noone;
	///////////////////////////			
	
	self.sub_btn_layout = [
		{ name: "sub",   label: "-",  rx: 10,                  ry: self.item_size + 10, hold: true },
		{ name: "add",   label: "+",  rx: self.item_size - 10, ry: self.item_size + 10, hold: true },
		{ name: "reset", label: "x",  rx: self.item_size / 2,  ry: self.item_size + 30, hold: false },
		{ name: "prev",  label: "<<", rx: 10,                  ry: self.item_size + 30, hold: true },
		{ name: "next",  label: ">>", rx: self.item_size - 10, ry: self.item_size + 30, hold: true }
	];
	
	self.tabsPadX = 160;
	self.tabsPadY = 20;
	
	self.held_btn_id = -1;

	RefreshCachedUpgradesList = method(self, global.GodHome.SettingsMenuRefreshCachedUpgradesList);
	RefreshCachedUpgradesList();
	
	OnTabChange(old_tab, db_ref.current_tab);
	OnSettingsMenuStart();
}

SettingsMenuRefreshCachedUpgradesList = function()
{
	self.cached_upgrades = [];
	self.equip_list_order_len = array_length(self.db_ref.upgrades_order);
	for (var i = 0; i < equip_list_order_len; i+=1)
	{
	    var key = self.db_ref.upgrades_order[i];
	    array_push(self.cached_upgrades, self.db_ref.upgrades_list[$ key]);
	}
}

OnSettingsMenuStart = function()
{
	if (!instance_exists(self.godHomeStartButton))
	{
		self.godHomeStartButton = global.GodHome.CreateModMenuObject(global.screenw - sprite_get_width(global.sprites.spr_butt_chall_flat_idle) - 40, global.camy + 25, -350, global.GodHome.MenuObjectType.MenuButton);	
		self.godHomeStartButton.idlespr = global.sprites.spr_butt_chall_flat_idle;	
		self.godHomeStartButton.highspr = global.sprites.spr_butt_chall_flat_high;
		self.godHomeStartButton.image_speed = 0.3;
		self.godHomeStartButton.OnButtonClick = method(self.godHomeStartButton, global.GodHome.OnGodHomeStartButtonClick);
		self.godHomeStartButton.OnCustomDraw = method(self.godHomeStartButton, global.GodHome.OnGodHomeStartButtonDraw);
		var checkGHLock = global.GodHome.FindNextUnlockedBossIndex(-1) == -1;
		if (checkGHLock)
		{			
			self.godHomeStartButton.is_locked = true;
			global.GodHome.isGodHomeLocked = true;
			global.GodHome.isInitGHBtns = true;
		}
		else
		{
			global.GodHome.ReadGodHomeStats();			
		}
	}
	if (!instance_exists(self.buttonGithubCredits))
	{
		self.buttonGithubCredits = global.GodHome.CreateModMenuObject(40, global.screenh - 32, -350, global.GodHome.MenuObjectType.MenuSocialButton);	
		self.buttonGithubCredits.sprite_index = global.sprites.spr_menu_github;
		self.buttonGithubCredits.image_speed = 0.3;
		self.buttonGithubCredits.text = "Godhome mod v. " + global.GodHome.MOD_VERSION + " by ALEX2014\nClick to open GitHub page.";
		self.buttonGithubCredits.social_url = global.GodHome.MOD_REPO_URL;
		if (global.GodHome.version_check_status == 1 || global.GodHome.IS_DEBUG)
		{
			self.buttonGithubCredits.is_rainbow_sprite = true;	
		}		
	}	
	if (!instance_exists(self.labelModVersion))
	{
		self.labelModVersion = global.GodHome.CreateModMenuObject(72, global.screenh - 36, -350, global.GodHome.MenuObjectType.MenuLabel);	
		self.labelModVersion.text = global.GodHome.GetVersionFlavor();
		self.labelModVersion.is_rainbow = true;
		self.labelModVersion.is_clickable = true;
		self.labelModVersion.OnLabelClick = method(self.labelModVersion, global.GodHome.OpenReleasesRepoPage);		
	}	
}

OnSettingsMenuStep = function()
{
	with (obj_mouse)
	{
		other.mx = self.x;
		other.my = self.y;
	}
    var click = mouse_check_button_pressed(mb_left) || global.gp_accept_pressed;
	var click_hold = mouse_check_button(mb_left) || global.gp_accept;
	var var_Screenw = global.screenw;
    var var_Screenh = global.screenh;

    var tab_w = 120;
    for (var i = 0; i < array_length(self.db_ref.tabs); i+=1)
	{
        var tx = global.camx + tabsPadX + (i * (tab_w + 10));
        var ty = global.camy + tabsPadY;
        
        if (mx >= tx && mx <= tx + tab_w && my >= ty && my <= ty + 40)
		{
            if (click)
			{
                self.db_ref.current_tab = self.db_ref.tabs[i];
                audio_play_sound(snd_crit, 999, false);
            }
        }
    }
	
	if (old_tab != db_ref.current_tab)
	{
		OnTabChange(old_tab, db_ref.current_tab);
	}
	old_tab = db_ref.current_tab;

	if (!click_hold)
	{
		self.is_held = false;
		self.hold_timer = 0;
		self.held_btn_id = -1;
	}
    
    var total_items = 0;
    var current_cols = 1;
    var current_item_size = 64;
    var current_item_pad = 64;

    if (self.db_ref.current_tab == "MAIN")
	{
        total_items = array_length(global.GodHome.db.bossList);
        current_cols = self.boss_grid_cols;
        current_item_size = self.boss_item_size;
        current_item_pad = self.boss_item_pad;
    }
	else if (self.db_ref.current_tab == "UPGRADES") 
	{
        total_items = array_length(self.db_ref.upgrades_order);
        current_cols = self.grid_cols;
        current_item_size = self.item_size;
        current_item_pad = self.item_pad;
    }

    var total_rows = ceil(total_items / current_cols);
    var grid_height = total_rows * (current_item_size + current_item_pad + 30);
    var visible_height = global.screenh - 100;
    self.max_scroll = max(0, grid_height - visible_height);

    if (self.max_scroll > 0)
    {
        var bar_hitbox_x1 = global.camx + var_Screenw - 30;
        var bar_hitbox_x2 = global.camx + var_Screenw;

        var bar_hitbox_y1 = global.camy + self.bar_prog - self.bar_half_height;
        var bar_hitbox_y2 = global.camy + self.bar_prog + self.bar_half_height;

        if (mx >= bar_hitbox_x1 && mx <= bar_hitbox_x2 && my >= bar_hitbox_y1 && my <= bar_hitbox_y2)
        {
            self.bar_alph = 0.75;
            if (click) 
            { 
                self.bar_clicked = true; 
                self.click_offset_y = (my - global.camy) - self.bar_prog;
            }
        }
        else
        {
            if (!self.bar_clicked) { self.bar_alph = 0.5; }
        }
        
        if (self.bar_clicked)
        {
            self.bar_alph = 1.0;
            self.bar_prog = (my - global.camy) - self.click_offset_y;
            
            if (mouse_check_button_released(mb_left) || !mouse_check_button(mb_left))
            {
                self.bar_clicked = false;
            }
        }

        self.bar_prog += (mouse_wheel_down() - mouse_wheel_up()) * 30;
        self.bar_prog = clamp(self.bar_prog, self.min_sidebar_y, self.max_sidebar_y);

        var bar_percentage = (self.bar_prog - self.min_sidebar_y) / (self.max_sidebar_y - self.min_sidebar_y);
        self.scroll_y = self.max_scroll * bar_percentage;
    }
    else
    {
        self.scroll_y = 0;
        self.bar_prog = self.min_sidebar_y;
    }

	if (self.db_ref.current_tab == "MAIN")
	{
        for (var i = 0; i < total_items; i+=1)
        {
            var boss = global.GodHome.db.bossList[i];
            var col = i % self.boss_grid_cols;
            var row = floor(i / self.boss_grid_cols);

            var ix = global.camx + self.boss_left_pad + (col * (self.boss_item_size + self.boss_item_pad));
            var iy = global.camy + 100 + (row * (self.boss_item_size + self.boss_item_pad + 10)) - self.scroll_y; 

            if (iy < (global.camy - (self.boss_item_size + 10)) || iy > global.camy + global.screenh) { continue; }

            var x1 = ix;
            var y1 = iy;
            var x2 = ix + self.boss_item_size;
            var y2 = iy + self.boss_item_size;

            if (mx >= x1 && mx <= x2 && my >= y1 && my <= y2)
            {
                if (click && boss.unlocked)
                {
                    global.GodHome.selectedBoss = i;
                    global.GodHome.ReadGodHomeStats();
                    audio_play_sound(snd_crit, 999, false);
                }
            }
        }
	}
	else if (self.db_ref.current_tab == "UPGRADES")
    {
        var btn_count = array_length(self.sub_btn_layout); 

        for (var i = 0; i < total_items; i+=1)
        {
            var row = i div self.grid_cols;
            var iy = global.camy + 100 + (row * (self.item_size + self.item_pad + 10)) - self.scroll_y;
            
            if (iy < (global.camy - (self.item_size + 10)) || iy > global.camy + global.screenh) { continue; }      
            
			var item = self.cached_upgrades[i];
            if (not item.is_unlocked) { continue; }

            var col = i mod self.grid_cols;
            var ix = global.camx + upgrades_left_pad + (col * (self.item_size + self.item_pad));
            
            for (var b = 0; b < btn_count; b+=1)
            {
                var btn = self.sub_btn_layout[b];
                var bx = ix + btn.rx;
                var by = iy + btn.ry;
                
                var x1 = bx - 10;
                var y1 = by - 10;
                var x2 = bx + 10;
                var y2 = by + 10;
                
                var triggered = false;
                var btn_unique_id = (i * 10) + b;
                
                if (mx >= x1 && mx <= x2 && my >= y1 && my <= y2)
                {
                    if (btn.hold)
                    {
                        if (click)
                        {
                            self.is_held = true;
                            self.hold_timer = 0;
                            self.held_btn_id = btn_unique_id;
                            triggered = true;
                        }
                        else if (click_hold && self.held_btn_id == btn_unique_id)
                        {
                            self.hold_timer += 1;
                            var init_delay = 20;
                            var rep_rate = 3;
                            
                            if (self.hold_timer >= init_delay && (self.hold_timer - init_delay) mod rep_rate == 0)
                            {
                                triggered = true;
                            }
                        }
                    }
                    else if (click)
                    {
                        triggered = true;
                    }
                }
                
                if (triggered)
                {
                    audio_play_sound(snd_crit, 999, false);
                    switch (btn.name)
                    {
                        case "sub":   if (item.sel_lvl > 0) { item.sel_lvl -= 1; } break;
                        case "add":   item.sel_lvl += 1; break;
                        case "reset": item.sel_lvl = 0; break;
                        case "prev":  if (item.sel_lvl > 0) { item.sel_lvl = max(0, item.sel_lvl - 10); } break;
                        case "next":  item.sel_lvl += 10; break;
                    }
                }
            }
        }
    }
}

OnSettingsMenuDraw = function()
{   
    draw_sprite_tiled(bkgSpriteList[bkgSpriteIndex], 0, 0, 0);
    
    draw_text_setup(16777215, 1, 1, fnt_cambria);
    var var_Screenw = global.screenw;
	
    if (self.max_scroll > 0)
    {
        draw_sprite_ext(global.sprites.spr_sett_bar_block, 0, global.camx + var_Screenw - 14, global.camy + self.bar_prog, 1, SIDEBAR_SIZE, 0, c_white, self.bar_alph);
    }
	
	self.labelModVersion.is_visible = global.GodHome.version_check_status == 1 || global.GodHome.IS_DEBUG;
	
	if (self.db_ref.current_tab == "MAIN")
	{
		if (instance_exists(self.labelBossHPValue))
		{
			self.labelBossHPValue.text = string_format(global.GodHome.global_settings.bossHP, 0, 2) + "x";
		}
		var boss_amount_color = global.GodHome.selectedBoss == 4 ? c_red : c_lime;
		if (instance_exists(self.labelBossAmountValue))
		{
			self.labelBossAmountValue.text = string(global.GodHome.global_settings.bossAmount);
			self.labelBossAmountValue.color_idle = boss_amount_color; 
		}
		if (instance_exists(self.labelBossAmount))
		{
			self.labelBossAmount.color_idle = boss_amount_color; 
		}
		if (instance_exists(self.labelBossAnountReset))
		{
			self.labelBossAnountReset.color_idle = boss_amount_color; 
		}
		if (instance_exists(arrowBossAmountAdd))
		{
			arrowBossAmountAdd.image_blend = boss_amount_color;
		}
		if (instance_exists(arrowBossAmountSub))
		{
			arrowBossAmountSub.image_blend = boss_amount_color;
		}
	
		var total_bosses = array_length(global.GodHome.db.bossList);
        for (var i = 0; i < total_bosses; i+=1)
        {
            var boss = global.GodHome.db.bossList[i];
            var col = i % self.boss_grid_cols;
            var row = floor(i / self.boss_grid_cols);

            var ix = global.camx + self.boss_left_pad + (col * (self.boss_item_size + self.boss_item_pad));
            var iy = global.camy + 100 + (row * (self.boss_item_size + self.boss_item_pad + 10)) - self.scroll_y;

            if (iy < (global.camy - (self.boss_item_size + 10)) || iy > global.camy + global.screenh) { continue; }

            var is_selected = (global.GodHome.selectedBoss == i);

			var cell_cx = ix + (self.boss_item_size / 2);
            var cell_cy = iy + (self.boss_item_size / 2);
			
			if (is_selected)
			{
				var sel_spr = global.sprites.spr_upgrade_button_spawn;

				var target_w = self.boss_item_size * 1.4;
				var target_h = self.boss_item_size * 1.4;

				var sel_draw_x = cell_cx - (target_w / 2);
				var sel_draw_y = cell_cy - (target_h / 2);

				draw_sprite_stretched_ext(sel_spr, get_timer() / 100000, sel_draw_x, sel_draw_y, target_w, target_h, c_white, 1);
			}
			
			var boss_item_size_mult = 1.4;
			var boss_sprite = boss.sprite;
            if (boss.sprite != noone) 
            {							
                var spr_w = sprite_get_width(boss_sprite);
                var spr_h = sprite_get_height(boss_sprite);
                var spr_ox = sprite_get_xoffset(boss_sprite);
                var spr_oy = sprite_get_yoffset(boss_sprite);
                
                var max_side = max(spr_w, spr_h);
                var target_size = self.boss_item_size * boss_item_size_mult;
                var dynamic_scale = target_size / max_side;
                var manual_mod = boss.scale_mod;
                var final_scale = dynamic_scale * manual_mod;

                var x_off = boss.x_offset;
                var y_off = boss.y_offset;

                var draw_x = cell_cx - ((spr_w / 2) - spr_ox) * final_scale + x_off;
                var draw_y = cell_cy - ((spr_h / 2) - spr_oy) * final_scale + y_off;

                var anim_frame = get_timer() / 100000;
				
                if (boss.unlocked)
                {
                    draw_sprite_ext(boss_sprite, anim_frame, draw_x, draw_y, final_scale, final_scale, 0, c_white, 1);
					if (boss.code == "obj_boss_true_picayune")
					{
						draw_sprite_ext(global.sprites.spr_picayune_hair, anim_frame, draw_x, draw_y - 16, 0.05 * final_scale, 0.05 * final_scale, 1, c_white, 1);
						draw_sprite_ext(global.sprites.spr_picayune_faces, anim_frame, draw_x, draw_y - 16, 0.05 * final_scale, 0.05 * final_scale, 1, c_white, 0.7);
					}
				}
                else
                {
                    draw_sprite_ext(boss_sprite, anim_frame, draw_x, draw_y, final_scale, final_scale, 0, c_black, 0.5);
                }
            }
			else if (boss.code == "obj_boss_picayune_eye")
			{
				var spr_w = sprite_get_width(spr_picayune_right_socket);
				var spr_h = sprite_get_height(spr_picayune_right_socket);
				var spr_ox = sprite_get_xoffset(spr_picayune_right_socket);
				var spr_oy = sprite_get_yoffset(spr_picayune_right_socket);
				
				var max_side = max(spr_w, spr_h);
				var target_size = self.boss_item_size * boss_item_size_mult;
				var dynamic_scale = target_size / max_side;
				var manual_mod = boss.scale_mod;
				var final_scale = dynamic_scale * manual_mod;

				var x_off = boss.x_offset;
				var y_off = boss.y_offset;

				var draw_x = cell_cx - ((spr_w / 2) - spr_ox) * final_scale + x_off;
				var draw_y = cell_cy - ((spr_h / 2) - spr_oy) * final_scale + y_off;
				
				var posx = random_range(-0.2, 0.7);
				var posy = random_range(-0.2, 0.7);
				
				if (boss.unlocked)
				{			
					draw_sprite_ext(global.sprites.spr_picayune_right_socket, 0, draw_x + posx, draw_y + posy, final_scale, final_scale, 0, c_white, 1);
					draw_sprite_ext(global.sprites.spr_picayune_right_eye, 0, draw_x + posx, draw_y + posy, final_scale, final_scale, 0, c_white, 1);
					draw_sprite_ext(global.sprites.spr_picayune_right_pupil, 0, draw_x + posx, draw_y + posy, final_scale, final_scale, 0, c_white, 1);				
				}
				else
				{
					draw_sprite_ext(global.sprites.spr_picayune_right_socket, 0, draw_x + posx, draw_y + posy, final_scale, final_scale, 0, c_black, 0.5);
					draw_sprite_ext(global.sprites.spr_picayune_right_eye, 0, draw_x + posx, draw_y + posy, final_scale, final_scale, 0, c_black, 0.5);
					draw_sprite_ext(global.sprites.spr_picayune_right_pupil, 0, draw_x + posx, draw_y + posy, final_scale, final_scale, 0, c_black, 0.5);								
				}
			}
			else if (boss.code == "obj_boss_picayune_full")
			{
				var anim_frame_sec = get_timer() / 100000;
				var interval = 2;
				var is_flash = (anim_frame_sec div interval) mod 2;
				if (!is_flash)
				{
					boss_sprite = global.sprites.spr_picayune_scroll_white;
				}
				else
				{
					boss_sprite = global.sprites.spr_picayune_scroll_yellow;
				}

                var spr_w = sprite_get_width(boss_sprite);
                var spr_h = sprite_get_height(boss_sprite);
                var spr_ox = sprite_get_xoffset(boss_sprite);
                var spr_oy = sprite_get_yoffset(boss_sprite);
                
                var max_side = max(spr_w, spr_h);
                var target_size = self.boss_item_size * boss_item_size_mult;
                var dynamic_scale = target_size / max_side;
                var manual_mod = boss.scale_mod;
                var final_scale = dynamic_scale * manual_mod;

                var x_off = boss.x_offset;
                var y_off = boss.y_offset;

                var draw_x = cell_cx - ((spr_w / 2) - spr_ox) * final_scale + x_off;
                var draw_y = cell_cy - ((spr_h / 2) - spr_oy) * final_scale + y_off;

                var anim_frame = get_timer() / 100000;
				
                if (boss.unlocked)
                {
                    draw_sprite_ext(boss_sprite, anim_frame, draw_x, draw_y, final_scale, final_scale, 0, c_white, 1);
				}
                else
                {
                    draw_sprite_ext(boss_sprite, anim_frame, draw_x, draw_y, final_scale, final_scale, 0, c_black, 0.5);
                }				
			}
			
            draw_set_font(fnt_freddy);
            var text_col = c_red;
            var b_name = "LOCKED";
            
            if (boss.unlocked)
            {
                b_name = string_upper(boss.code);
                text_col = is_selected ? c_lime : c_white;
            }           
            outline_text(b_name, cell_cx, iy + self.boss_item_size + 13, text_col, 0, 1, -1, 9999);
        }
	}
    else if (self.db_ref.current_tab == "UPGRADES")
	{
		var is_enabled_vanilla_lvls = global.GodHome.global_settings.isUseVanillaEquipSystem;
		var vanilla_equip_color = is_enabled_vanilla_lvls ? c_lime : c_red;
		if (instance_exists(self.labelLvlAmountValue))
		{
			self.labelLvlAmountValue.text = string(global.GodHome.global_settings.lvlAmount);
			self.labelLvlAmountValue.color_idle = vanilla_equip_color; 
		}
		if (instance_exists(self.labelLvlAmount))
		{
			self.labelLvlAmount.color_idle = vanilla_equip_color; 
		}
		if (instance_exists(labelLvlReset))
		{
			labelLvlReset.color_idle = vanilla_equip_color;
		}
		if (instance_exists(self.arrowLvlAmountAdd))
		{
			self.arrowLvlAmountAdd.image_blend = vanilla_equip_color; 
		}
		if (instance_exists(self.arrowLvlAmountSub))
		{
			self.arrowLvlAmountSub.image_blend = vanilla_equip_color; 
		}
	
		var _camx = global.camx;
		var _camy = global.camy;
		var _screenh = global.screenh;
		var _scroll_y = self.scroll_y;
		var _item_size = self.item_size;
		var _pad = self.item_pad;
		var _cols = self.grid_cols;
		var _left_pad = self.upgrades_left_pad;
		var _layout = self.sub_btn_layout;
		var _btn_count = array_length(_layout);
		var anim_frame = get_timer() / 100000;
		
		var base_y = _camy + 100 - _scroll_y;
		var item_stride = _item_size + _pad;
		var y_stride = item_stride + 10;
		var cull_top = _camy - (_item_size + 10);
		var cull_bottom = _camy + _screenh;
		var half_size = _item_size / 2;
		var text_y_pos = _item_size + 13;
		var total_items = equip_list_order_len;

		for (var i = 0; i < total_items; i+=1)
		{       
			var row = i div _cols;
			var iy = base_y + (row * y_stride);
			if (iy < cull_top || iy > cull_bottom) { continue; }         
			
			var item = self.cached_upgrades[i];
			var col = i mod _cols;
			var ix = _camx + _left_pad + (col * item_stride);
			
			var alpha = item.is_unlocked ? 1 : 0.5;
			var color = item.is_unlocked ? c_white : c_black;
			var frame = item.is_unlocked ? anim_frame : 0;
			draw_sprite_ext(item.spr, frame, ix + half_size, iy + half_size, 0.6, 0.6, 0, color, alpha);
		}

		//Experimental optimisation by swapping outline_text to the text wrap
		draw_set_font(fnt_freddy);
		for (var i = 0; i < total_items; i+=1)
		{       
			var row = i div _cols;
			var iy = base_y + (row * y_stride);
			if (iy < cull_top || iy > cull_bottom) { continue; }         
			
			var item = self.cached_upgrades[i];
			var col = i mod _cols;
			var ix = _camx + _left_pad + (col * item_stride);
			
			if (item.is_unlocked)
			{
				var txt = string(item.sel_lvl);
				var tx = ix + half_size;
				var ty = iy + text_y_pos;
				var inner_col = (item.sel_lvl > 0) ? c_lime : c_red;
				
				draw_set_color(c_black);
				draw_text(tx - 1, ty, txt);
				draw_text(tx + 1, ty, txt);
				draw_text(tx, ty - 1, txt);
				draw_text(tx, ty + 1, txt);
				
				draw_set_color(inner_col);
				draw_text(tx, ty, txt);
			}
			else
			{
				draw_set_color(c_red);
				draw_text(ix + half_size, iy + half_size, "???");
			}
		}
		draw_set_color(c_white);
		
		/* Old pass 2 code
		draw_set_font(fnt_freddy);
		for (var i = 0; i < total_items; i+=1)
		{       
			var row = i div _cols;
			var iy = base_y + (row * y_stride);
			if (iy < cull_top || iy > cull_bottom) { continue; }         
			
			var item = _list[$ _order[i]];
			var col = i mod _cols;
			var ix = _camx + _left_pad + (col * item_stride);
			
			if (item.is_unlocked)
			{
				var is_more_than_zero = item.sel_lvl > 0;
				outline_text(string(item.sel_lvl), ix + half_size, iy + text_y_pos, is_more_than_zero ? c_lime : c_red, 0, 1, -1, 9999);
			}
			else
			{
				draw_text_color(ix + half_size, iy + half_size, "???", c_red, c_red, c_red, c_red, 1);
			}
		}
		
		*/

		draw_set_font(fnt_cambria);		
		var rx1 = 10; ry1 = _item_size + 10; lbl1 = "-";
		var rx2 = _item_size - 10; ry2 = _item_size + 10; lbl2 = "+";
		var rx3 = _item_size / 2; ry3 = _item_size + 30; lbl3 = "x";
		var rx4 = 10; ry4 = _item_size + 30; lbl4 = "<<";
		var rx5 = _item_size - 10; ry5 = _item_size + 30; lbl5 = ">>";

		for (var i = 0; i < total_items; i+=1)
		{       
			var row = i div _cols;
			var iy = base_y + (row * y_stride);
			if (iy < cull_top || iy > cull_bottom) { continue; }         
			
			var item = self.cached_upgrades[i];
			if (not item.is_unlocked) { continue; }
			
			var col = i mod _cols;
			var ix = _camx + _left_pad + (col * item_stride);
			
			draw_text(ix + rx1, iy + ry1, lbl1);
			draw_text(ix + rx2, iy + ry2, lbl2);
			draw_text(ix + rx3, iy + ry3, lbl3);
			draw_text(ix + rx4, iy + ry4, lbl4);
			draw_text(ix + rx5, iy + ry5, lbl5);
		}

		/* Old pass 3 code
		draw_set_font(fnt_cambria);
		for (var i = 0; i < total_items; i+=1)
		{       
			var row = i div _cols;
			var iy = base_y + (row * y_stride);
			if (iy < cull_top || iy > cull_bottom) { continue; }         
			
			var item = self.cached_upgrades[i];
			if (not item.is_unlocked) { continue; }
			
			var col = i mod _cols;
			var ix = _camx + _left_pad + (col * item_stride);
			
			for (var b = 0; b < _btn_count; b+=1)
			{
				var btn = _layout[b];
				draw_text(ix + btn.rx, iy + btn.ry, btn.label);
			}
		}
		*/
	}
	
	draw_text_setup(16777215, 1, 1, fnt_cambria);
    var tab_w = 120; 
    for (var i = 0; i < array_length(self.db_ref.tabs); i+=1)
	{
        var tx = global.camx + tabsPadX + (i * (tab_w + 10));
        var ty = global.camy + tabsPadY;
        var alpha = (self.db_ref.current_tab == self.db_ref.tabs[i]) ? 1.0 : 0.5;
        
        draw_set_alpha(alpha);
        draw_text(tx + (tab_w/2), ty + 20, self.db_ref.tabs[i]);
        draw_set_alpha(1);
    }	
    draw_text_reset();
}

OnSettingsMenuTabChange = function(OldTab, NewTab)
{ 
	if (NewTab == "MAIN")
	{
		if (!instance_exists(self.godHomeToggleInstantRestart))
		{
			self.godHomeToggleInstantRestart = global.GodHome.CreateModMenuObject(40, 110, -350, global.GodHome.MenuObjectType.MenuToggleButton);	
			self.godHomeToggleInstantRestart.sprite_index = global.sprites.spr_skilltree_icos;
			self.godHomeToggleInstantRestart.spr_subind = 3;
			self.godHomeToggleInstantRestart.title = "Instant Restart";
			self.godHomeToggleInstantRestart.description = "Restarts the fight on Cyl's death unstead of going into game over.";
			self.godHomeToggleInstantRestart.is_rainbow = true;
			self.godHomeToggleInstantRestart.variable_structure = global.GodHome.global_settings;
			self.godHomeToggleInstantRestart.variable_name = "isInstaRestart";
			self.godHomeToggleInstantRestart.toggled = global.GodHome.global_settings.isInstaRestart; 
		}
		if (!instance_exists(self.godHomeToggleOneShot))
		{
			self.godHomeToggleOneShot = global.GodHome.CreateModMenuObject(100, 110, -350, global.GodHome.MenuObjectType.MenuToggleButton);	
			self.godHomeToggleOneShot.sprite_index = global.sprites.spr_skilltree_icos;
			self.godHomeToggleOneShot.spr_subind = 37;
			self.godHomeToggleOneShot.title = "Glass Core";
			self.godHomeToggleOneShot.description = "Caps Cyl's Max HP at 1.\nDisables on-death protections skills effects.";
			self.godHomeToggleOneShot.is_rainbow = true;
			self.godHomeToggleOneShot.variable_structure = global.GodHome.global_settings;
			self.godHomeToggleOneShot.variable_name = "isOneShot";
			self.godHomeToggleOneShot.toggled = global.GodHome.global_settings.isOneShot;
		}
		if (!instance_exists(self.labelBossHP))
		{
			self.labelBossHP = global.GodHome.CreateModMenuObject(20, 150, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelBossHP.text = "Boss HP:";
			self.labelBossHP.is_clickable = false;
		}
		if (!instance_exists(self.labelBossHPValue))
		{
			self.labelBossHPValue = global.GodHome.CreateModMenuObject(100, 150, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelBossHPValue.is_clickable = false;
			self.labelBossHPValue.halign = fa_center;
		}
		if (!instance_exists(self.labelBossHPReset))
		{
			self.labelBossHPReset = global.GodHome.CreateModMenuObject(140, 150, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelBossHPReset.text = "Reset";
			self.labelBossHPReset.OnLabelClick = method(labelBossHPReset, global.GodHome.ResetBossHPVar);
		}
		if (!instance_exists(self.arrowBossHPSub))
		{
			self.arrowBossHPSub = global.GodHome.CreateModMenuObject(75, 154, -350, global.GodHome.MenuObjectType.MenuArrow);
			self.arrowBossHPSub.image_xscale = -1;
			self.arrowBossHPSub.OnArrowClick = method(arrowBossHPSub, global.GodHome.DecreaseBossHPVar);
			self.arrowBossHPSub.OnArrowHoldTick = method(arrowBossHPSub, global.GodHome.DecreaseBossHPVar);
		}
		if (!instance_exists(self.arrowBossHPAdd))
		{
			self.arrowBossHPAdd = global.GodHome.CreateModMenuObject(125, 154, -350, global.GodHome.MenuObjectType.MenuArrow); 
			self.arrowBossHPAdd.OnArrowClick = method(arrowBossHPAdd, global.GodHome.IncreaseBossHPVar);
			self.arrowBossHPAdd.OnArrowHoldTick = method(arrowBossHPAdd, global.GodHome.IncreaseBossHPVar);		
		}
		if (!instance_exists(self.labelBossAmount))
		{
			self.labelBossAmount = global.GodHome.CreateModMenuObject(52, 170, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelBossAmount.text = "Boss amount:";
			self.labelBossAmount.is_clickable = false;
			self.labelBossAmount.halign = fa_center;		
		}
		if (!instance_exists(self.labelBossAnountReset))
		{
			self.labelBossAnountReset = global.GodHome.CreateModMenuObject(85, 185, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelBossAnountReset.text = "Set to 0";
			self.labelBossAnountReset.OnLabelClick = method(labelBossAnountReset, global.GodHome.ResetBossAmountVar);			
		}
		if (!instance_exists(self.labelBossAmountValue))
		{
			self.labelBossAmountValue = global.GodHome.CreateModMenuObject(49, 185, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelBossAmountValue.is_clickable = false;
			self.labelBossAmountValue.halign = fa_center;
		}
		if (!instance_exists(self.arrowBossAmountSub))
		{
			self.arrowBossAmountSub = global.GodHome.CreateModMenuObject(25, 189, -350, global.GodHome.MenuObjectType.MenuArrow);
			self.arrowBossAmountSub.OnArrowClick = method(arrowBossAmountSub, global.GodHome.DecreaseBossAmountVar);
			self.arrowBossAmountSub.OnArrowHoldTick = method(arrowBossAmountSub, global.GodHome.DecreaseBossAmountVar);				
			self.arrowBossAmountSub.image_xscale = -1;
		}	
		if (!instance_exists(self.arrowBossAmountAdd))
		{
			self.arrowBossAmountAdd = global.GodHome.CreateModMenuObject(70, 189, -350, global.GodHome.MenuObjectType.MenuArrow);
			self.arrowBossAmountAdd.OnArrowClick = method(arrowBossAmountAdd, global.GodHome.IncreaseBossAmountVar);
			self.arrowBossAmountAdd.OnArrowHoldTick = method(arrowBossAmountAdd, global.GodHome.IncreaseBossAmountVar);				
		}		
	}	
	else if (NewTab == "UPGRADES")
	{
		if (!instance_exists(self.toggleUseVanillaEquipSys))
		{
			self.toggleUseVanillaEquipSys = global.GodHome.CreateModMenuObject(45, 160, -350, global.GodHome.MenuObjectType.MenuToggleButton);	
			self.toggleUseVanillaEquipSys.sprite_index = global.sprites.spr_skilltree_icos;
			self.toggleUseVanillaEquipSys.spr_subind = 80;
			self.toggleUseVanillaEquipSys.title = "Vanilla Equipment";
			self.toggleUseVanillaEquipSys.description = "Enables vanilla equipment distribution system.";
			self.toggleUseVanillaEquipSys.is_rainbow = true;
			self.toggleUseVanillaEquipSys.variable_structure = global.GodHome.global_settings;
			self.toggleUseVanillaEquipSys.variable_name = "isUseVanillaEquipSystem";
			self.toggleUseVanillaEquipSys.toggled = global.GodHome.global_settings.isUseVanillaEquipSystem;
		}
		if (!instance_exists(self.arrowLvlAmountSub))
		{
			self.arrowLvlAmountSub = global.GodHome.CreateModMenuObject(120, 194, -350, global.GodHome.MenuObjectType.MenuArrow);
			self.arrowLvlAmountSub.OnArrowClick = method(arrowLvlAmountSub, global.GodHome.DecreaseLvlAmountVar);
			self.arrowLvlAmountSub.OnArrowHoldTick = method(arrowLvlAmountSub, global.GodHome.DecreaseLvlAmountVar);				
			self.arrowLvlAmountSub.image_xscale = -1;
		}				
		if (!instance_exists(self.arrowLvlAmountAdd))
		{
			self.arrowLvlAmountAdd = global.GodHome.CreateModMenuObject(160, 194, -350, global.GodHome.MenuObjectType.MenuArrow);
			self.arrowLvlAmountAdd.OnArrowClick = method(arrowLvlAmountAdd, global.GodHome.IncreaseLvlAmountVar);
			self.arrowLvlAmountAdd.OnArrowHoldTick = method(arrowLvlAmountAdd, global.GodHome.IncreaseLvlAmountVar);
		}				
		if (!instance_exists(self.labelLvlAmountValue))
		{
			self.labelLvlAmountValue = global.GodHome.CreateModMenuObject(140, 190, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelLvlAmountValue.is_clickable = false;
			self.labelLvlAmountValue.halign = fa_center;
		}		
		if (!instance_exists(self.labelLvlAmount))
		{
			self.labelLvlAmount = global.GodHome.CreateModMenuObject(25, 190, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelLvlAmount.text = "Levels amount:";
			self.labelLvlAmount.is_clickable = false;
		}		
		if (!instance_exists(self.labelLvlReset))
		{
			self.labelLvlReset = global.GodHome.CreateModMenuObject(25, 210, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelLvlReset.text = "Set to 0";
			self.labelLvlReset.is_clickable = true;
			self.labelLvlReset.OnLabelClick = method(labelLvlReset, global.GodHome.ResetLvlAmountVar);			
		}
		if (!instance_exists(self.labelItemsControls))
		{
			self.labelItemsControls = global.GodHome.CreateModMenuObject(25, 70, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelItemsControls.text = "Equipment amount controls:";
			self.labelItemsControls.is_clickable = false;		
		}
		if (!instance_exists(self.labelItemsSubBig))
		{
			self.labelItemsSubBig = global.GodHome.CreateModMenuObject(35, 90, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelItemsSubBig.text = "<<";
			self.labelItemsSubBig.font = fnt_cambria;
			self.labelItemsSubBig.image_xscale = 1;
			self.labelItemsSubBig.image_yscale = 1;
			self.labelItemsSubBig.is_clickable = true;
			self.labelItemsSubBig.is_holdable = true;
			self.labelItemsSubBig.OnLabelClick = method(labelItemsSubBig, global.GodHome.DecreaseBigItemsAmountVar);
			self.labelItemsSubBig.OnLabelHoldTick = method(labelItemsSubBig, global.GodHome.DecreaseBigItemsAmountVar);
			self.labelItemsSubBig.halign = fa_center;		
		}
		if (!instance_exists(self.labelItemsSub))
		{
			self.labelItemsSub = global.GodHome.CreateModMenuObject(65, 90, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelItemsSub.text = "<";
			self.labelItemsSub.font = fnt_cambria;
			self.labelItemsSub.image_xscale = 1;
			self.labelItemsSub.image_yscale = 1;
			self.labelItemsSub.is_clickable = true;
			self.labelItemsSub.is_holdable = true;
			self.labelItemsSub.OnLabelClick = method(labelItemsSub, global.GodHome.DecreaseItemsAmountVar);
			self.labelItemsSub.OnLabelHoldTick = method(labelItemsSub, global.GodHome.DecreaseItemsAmountVar);
			self.labelItemsSub.halign = fa_center;			
		}
		if (!instance_exists(self.labelItemsReset))
		{
			self.labelItemsReset = global.GodHome.CreateModMenuObject(95, 90, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelItemsReset.text = "X";
			self.labelItemsReset.font = fnt_cambria;
			self.labelItemsReset.image_xscale = 1;
			self.labelItemsReset.image_yscale = 1;	
			self.labelItemsReset.is_clickable = true;
			self.labelItemsReset.OnLabelClick = method(labelItemsReset, global.GodHome.ResetItemsAmountVar);			
			self.labelItemsReset.halign = fa_center;	
		}		
		if (!instance_exists(self.labelItemsAdd))
		{
			self.labelItemsAdd = global.GodHome.CreateModMenuObject(125, 90, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelItemsAdd.text = ">";
			self.labelItemsAdd.font = fnt_cambria;
			self.labelItemsAdd.image_xscale = 1;
			self.labelItemsAdd.image_yscale = 1;
			self.labelItemsAdd.is_clickable = true;
			self.labelItemsAdd.is_holdable = true;
			self.labelItemsAdd.OnLabelClick = method(labelItemsAdd, global.GodHome.IncreaseItemsAmountVar);
			self.labelItemsAdd.OnLabelHoldTick = method(labelItemsAdd, global.GodHome.IncreaseItemsAmountVar);
			self.labelItemsAdd.halign = fa_center;	
		}
		if (!instance_exists(self.labelItemsAddBig))
		{
			self.labelItemsAddBig = global.GodHome.CreateModMenuObject(155, 90, -350, global.GodHome.MenuObjectType.MenuLabel);
			self.labelItemsAddBig.text = ">>";
			self.labelItemsAddBig.font = fnt_cambria;
			self.labelItemsAddBig.image_xscale = 1;
			self.labelItemsAddBig.image_yscale = 1;			
			self.labelItemsAddBig.is_clickable = true;
			self.labelItemsAddBig.is_holdable = true;
			self.labelItemsAddBig.OnLabelClick = method(labelItemsAddBig, global.GodHome.IncreaseBigItemsAmountVar);
			self.labelItemsAddBig.OnLabelHoldTick = method(labelItemsAddBig, global.GodHome.IncreaseBigItemsAmountVar);			
			self.labelItemsAddBig.halign = fa_center;	
		}
	}
	if (OldTab == "MAIN")
	{
		if (instance_exists(self.godHomeToggleInstantRestart))
		{
			instance_destroy(self.godHomeToggleInstantRestart);
			self.godHomeToggleInstantRestart = noone;		
		}
		if (instance_exists(self.godHomeToggleOneShot))
		{
			instance_destroy(self.godHomeToggleOneShot);
			self.godHomeToggleOneShot = noone;		
		}
		if (instance_exists(self.labelBossHP))
		{
			instance_destroy(self.labelBossHP);
			self.labelBossHP = noone;		
		}
		if (instance_exists(self.labelBossHPValue))
		{
			instance_destroy(self.labelBossHPValue);
			self.labelBossHPValue = noone;		
		}
		if (instance_exists(self.labelBossHPReset))
		{
			instance_destroy(self.labelBossHPReset);
			self.labelBossHPReset = noone;		
		}		
		if (instance_exists(self.arrowBossHPSub))
		{
			instance_destroy(self.arrowBossHPSub);
			self.arrowBossHPSub = noone;		
		}
		if (instance_exists(self.arrowBossHPAdd))
		{
			instance_destroy(self.arrowBossHPAdd);
			self.arrowBossHPAdd = noone;		
		}
		if (instance_exists(self.labelBossAmount))
		{
			instance_destroy(self.labelBossAmount);
			self.labelBossAmount = noone;		
		}
		if (instance_exists(self.labelBossAnountReset))
		{
			instance_destroy(self.labelBossAnountReset);
			self.labelBossAnountReset = noone;		
		}
		if (instance_exists(self.labelBossAmountValue))
		{
			instance_destroy(self.labelBossAmountValue);
			self.labelBossAmountValue = noone;		
		}
		if (instance_exists(self.arrowBossAmountAdd))
		{
			instance_destroy(self.arrowBossAmountAdd);
			self.arrowBossAmountAdd = noone;		
		}		
		if (instance_exists(self.arrowBossAmountSub))
		{
			instance_destroy(self.arrowBossAmountSub);
			self.arrowBossAmountSub = noone;		
		}	
	}
	else if (OldTab == "UPGRADES")
	{
		if (instance_exists(self.toggleUseVanillaEquipSys))
		{
			instance_destroy(self.toggleUseVanillaEquipSys);
			self.toggleUseVanillaEquipSys = noone;		
		}	
		if (instance_exists(self.arrowLvlAmountSub))
		{
			instance_destroy(self.arrowLvlAmountSub);
			self.arrowLvlAmountSub = noone;		
		}
		if (instance_exists(self.arrowLvlAmountAdd))
		{
			instance_destroy(self.arrowLvlAmountAdd);
			self.arrowLvlAmountAdd = noone;		
		}						
		if (instance_exists(self.labelLvlAmountValue))
		{
			instance_destroy(self.labelLvlAmountValue);
			self.labelLvlAmountValue = noone;		
		}		
		if (instance_exists(self.labelLvlAmount))
		{
			instance_destroy(self.labelLvlAmount);
			self.labelLvlAmount = noone;		
		}
		if (instance_exists(self.labelLvlReset))
		{
			instance_destroy(self.labelLvlReset);
			self.labelLvlReset = noone;		
		}		
		if (instance_exists(self.labelItemsControls))
		{
			instance_destroy(self.labelItemsControls);
			self.labelItemsControls = noone;		
		}	
		if (instance_exists(self.labelItemsSub))
		{
			instance_destroy(self.labelItemsSub);
			self.labelItemsSub = noone;		
		}	
		if (instance_exists(self.labelItemsSubBig))
		{
			instance_destroy(self.labelItemsSubBig);
			self.labelItemsSubBig = noone;		
		}		
		if (instance_exists(self.labelItemsAdd))
		{
			instance_destroy(self.labelItemsAdd);
			self.labelItemsAdd = noone;		
		}		
		if (instance_exists(self.labelItemsAddBig))
		{
			instance_destroy(self.labelItemsAddBig);
			self.labelItemsAddBig = noone;		
		}			
		if (instance_exists(self.labelItemsReset))
		{
			instance_destroy(self.labelItemsReset);
			self.labelItemsReset = noone;		
		}			
	}
}

OnSettingsMenuDestroy = function()
{
	if (instance_exists(self.godHomeStartButton))
	{
		instance_destroy(self.godHomeStartButton);
		self.godHomeStartButton = noone;
	}
	if (instance_exists(self.buttonGithubCredits))
	{
		instance_destroy(self.buttonGithubCredits);
		self.buttonGithubCredits = noone;
	}
	if (instance_exists(self.labelModVersion))
	{
		instance_destroy(self.labelModVersion);
		self.labelModVersion = noone;
	}
	self.db_ref.current_tab = "MAIN";
}

//////////////////////////////////////////////////////////////////////
//Menu Objects
/////////////////////////////////////////////////////////////////////

MenuObjectType =
{
    MenuArrow: 2000,
	MenuButton: 2001,
	MenuToggleButton: 2002,
	MenuLabel: 2003,
	MenuSocialButton: 2004
};

CreateModMenuObject = function(x_, y_, depth_, type, struct)
{
	if (struct == undefined)
    {
        struct = {}; 
    }
	var inst = instance_create_depth(x_, y_, depth_, obj_mod_instance);
	inst.obj_type = type;
	
	if (type == MenuObjectType.MenuArrow)
	{
		inst.OnCustomCreate = method(inst, OnMenuArrowCreate);
		inst.OnStep = method(inst, OnMenuArrowStep);
		inst.OnDraw = method(inst, OnMenuArrowDraw);
	}	
	else if (type == MenuObjectType.MenuButton)
	{
		inst.OnCustomCreate = method(inst, OnMenuButtonCreate);
		inst.OnStep = method(inst, OnMenuButtonStep);
		inst.OnDraw = method(inst, OnMenuButtonDraw);
	}
	else if (type == MenuObjectType.MenuToggleButton)
	{
		inst.OnCustomCreate = method(inst, OnMenuToggleButtonCreate);
		inst.OnStep = method(inst, OnMenuToggleButtonStep);
		inst.OnDraw = method(inst, OnMenuToggleButtonDraw);	
	}
	else if (type == MenuObjectType.MenuLabel)
	{
		inst.OnCustomCreate = method(inst, OnMenuLabelCreate);
		inst.OnStep = method(inst, OnMenuLabelStep);
		inst.OnDraw = method(inst, OnMenuLabelDraw);
	}
	else if (type == MenuObjectType.MenuSocialButton)
	{
		inst.OnCustomCreate = method(inst, OnMenuSocialButtonCreate);
		inst.OnStep = method(inst, OnMenuSocialButtonStep);
		inst.OnDraw = method(inst, OnMenuSocialButtonDraw);		
	}
	
	if (variable_instance_exists(inst, "OnCustomCreate"))
	{
        inst.OnCustomCreate();
    }
	
    var keys = variable_struct_get_names(struct);
    for (var i = 0; i < array_length(keys); i+=1)
    {
        var key = keys[i];
        var val = variable_struct_get(struct, key);
        variable_instance_set(inst, key, val);
    }
	
	return inst;
}

////////////////////////////////////////////////////////////////////
//Arrow//

OnMenuArrowCreate = function()
{
	self.scal = 0;
	self.sprite_index = global.sprites.spr_menu_arrow;
	self.image_blend = c_lime;
	
	self.hold_repeate_rate = 5;
	self.initial_repeat_delay = 30;
	self.is_can_hold = true;
	
	OnArrowClick = noone;
	OnArrowHoldTick = noone;
	OnCustomStep = noone;
	OnCustomDraw = noone;
}

OnMenuArrowStep = function()
{
	if (image_alpha == 1)
	{
		if (instance_place(x, y, obj_mouse))
		{
			scal = approach(scal, wave(1.25, 1.5, 0.5, 0), 0.1);
		}
		else
		{
			scal = approach(scal, 1, 0.1);
		}
	}


	var mouse_over = instance_place(x, y, obj_mouse);
	
	if (mouse_over)
	{
		if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed)
		{
			audio_play_sound(snd_crit, 999, false);
			if (OnArrowClick != noone)
			{
				OnArrowClick();
			}			
			self.hold_timer = 0;
			self.is_held = true;
		}
		else if (is_can_hold && (mouse_check_button(mb_left) || global.gp_accept))
		{
			if (!self.is_held)
			{
				self.is_held = true;
				self.hold_timer = 0;
			}
			else
			{
				self.hold_timer+=1;						
				if (self.hold_timer >= initial_repeat_delay && (self.hold_timer - initial_repeat_delay) mod hold_repeate_rate == 0)
				{
					audio_play_sound(snd_crit, 999, false);
					if (OnArrowHoldTick != noone)
					{
						OnArrowHoldTick();
					}
				}
			}
		}
		else
		{
			self.is_held = false;
			self.hold_timer = 0;
		}
	}
	else
	{
		self.is_held = false;
		self.hold_timer = 0;
	}

	if (OnCustomStep != noone)
	{
		OnCustomStep();
	}
} 

OnMenuArrowDraw = function()
{	
	gpu_set_fog(true, image_blend, 0, 0);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * scal, image_yscale * scal, 0, image_blend, image_alpha);
	gpu_set_fog(false, c_white, 0, 0);

	if (OnCustomDraw != noone)
	{
		OnCustomDraw();
	}
}

////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////
//MenuButton//

OnMenuButtonCreate = function()
{
	is_hovering = false;
	idlespr = global.sprites.spr_butt_start_idle;
	highspr = global.sprites.spr_butt_start_high;
	sprite_index = idlespr;
	is_locked = false;
	is_visible = true;
	scale = 1;
	ready = false;
	image_blend = c_white;
	image_alpha = 1;
	
	OnCustomStep = noone;
	OnCustomDraw = noone;
	OnButtonClick = noone;
}

OnMenuButtonStep = function()
{
	if (OnCustomStep != noone)
	{
		OnCustomStep();
	}
} 

OnMenuButtonDraw = function()
{
	if (!is_visible) { return; }
		
	var mouse_over = instance_place(x, y, obj_mouse);
	
    if (mouse_over)
    {
        if (is_hovering == false)
        {
			scale = 0.9;
		}
        
        is_hovering = true;
        
        if (sprite_index != highspr)
        {
            sprite_index = highspr;
            playsnd_at(global.sounds.snd_menu_hover, 1, false, 1, x, y);
        }

		if (mouse_check_button_released(mb_left) || global.gp_accept_released)
        {
           playsnd_at(global.sounds.snd_menu_click, 1, false, 1, x, y, -1);           
            if (!is_locked)
            {
				playsnd_at(global.sounds.snd_menu_click, 1, false, 1, x, y, 0);
				if (OnButtonClick != noone)
				{
					OnButtonClick();
				}			
            }
        }	
	}
	else
    {
        is_hovering = false;
        
        if (sprite_index != idlespr)
		{
            sprite_index = idlespr;
		}
    }
	
	if (is_locked == true)
	{
		image_blend = c_gray;
	}
	else
	{
		image_blend = c_white;
	}
	
	scale = approach(scale, 1, 0.025);
	draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, image_angle, image_blend, image_alpha);

	if (OnCustomDraw != noone)
	{
		OnCustomDraw();
	}
}

////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////
//MenuToggleButton//

OnMenuToggleButtonCreate = function()
{
	hovering = false;
	toggled = false;
	sprite_index = noone;
	spr_subind = 0;
	is_locked = false;
	is_visible = true;
	scale = 1;
	image_blend = c_white;
	image_alpha = 1;
	variable_structure = noone;
	variable_name = "";
	title = "";
	description = "";
	is_hold = false;
	is_button = false;
	hold_timer = 30;
	ico_blend = 16777215;
	is_rainbow = false;
	
	OnCustomStep = noone;
	OnCustomDraw = noone;
	OnButtonHold = noone;
	OnButtonClick = noone;	
}

OnMenuToggleButtonStep = function()
{
	if (OnCustomStep != noone)
	{
		OnCustomStep();
	}
} 

OnMenuToggleButtonDraw = function()
{
	if (!is_visible) { return; }
		
	draw_set_font(fnt_freddy);
	var hover_alph = 1;
		
	if (instance_place(x, y, obj_mouse))
	{		
		if (hovering == false)
		{
			hovering = true;
			playsnd(global.sounds.snd_opt_rebind_select_option, 0.8, false, 0.3);
		}
		
		hover_alph = 0.6;
		
		if (mouse_check_button(mb_left) || global.gp_accept)
		{
			hover_alph = 0.3;
			
			if (is_hold)
			{
				if (!audio_is_playing(global.sounds.snd_bunny_jump))
				{
					playsnd(global.sounds.snd_bunny_jump, 0.75, true, 0.5);
				}
				
				audio_sound_pitch(global.sounds.snd_bunny_jump, 0.75 + (hold_timer / 4));
				hold_timer += 0.1;
				
				if (hold_timer > hold_time_max)
				{
					hold_timer = 0;
					playsnd(global.sounds.snd_opt_toggle_true, 1, 0, 1);
					audio_stop_sound(global.sounds.snd_bunny_jump);
					playsnd(global.sounds.snd_Menu_Open_1, 1, false, 1);
                    
					if (OnButtonHold != noone) { OnButtonHold() }; 
				}
			}
		}
		else if (is_hold)
		{
			hold_timer = 0;
			audio_stop_sound(global.sounds.snd_bunny_jump);
			audio_sound_pitch(global.sounds.snd_bunny_jump, 1);
		}	
		
		if (mouse_check_button_released(mb_left) || global.gp_accept_pressed)
		{
			if (is_button) 
			{
				image_xscale = 0.25;
				image_yscale = 0.25;
				playsnd(global.sounds.snd_opt_toggle_true, 1, 0, 1);
				
				if (OnButtonClick != noone) { OnButtonClick() };
			}
			else
			{
				var old_toggled = toggled;
				toggled = !toggled;
				
				playsnd(toggled ? global.sounds.snd_opt_toggle_true : global.sounds.snd_opt_toggle_false, 1, 0, 1);
				
				if (old_toggled != toggled && variable_structure != noone)
				{
					variable_structure[$ variable_name] = toggled;
				}
			}
		}
	}
	else
	{
		if (is_hold)
		{
			hold_timer = 0;
			audio_stop_sound(global.sounds.snd_bunny_jump);
			audio_sound_pitch(global.sounds.snd_bunny_jump, 1);
		}
		hovering = false;
	}
	
	if (!is_button)
	{
		ico_blend = toggled ? 16777215 : 8421504;
	}
	else
	{
		image_xscale = approach(image_xscale, 1, 0.1);
		image_yscale = approach(image_yscale, 1, 0.1);
		
		ico_blend = hovering ? 16777215 : 8421504;
	}
		
	draw_sprite_ext(global.sprites.spr_skilltree_box, 0, x, y, image_xscale, image_yscale, 0, c_black, 1);
	draw_sprite_ext(global.sprites.spr_skilltree_box, 0, x, y, image_xscale, image_yscale, 0, c_white, hover_alph);
	draw_sprite_ext(sprite_index, spr_subind, x, y, image_xscale, image_yscale, 0, ico_blend, 1);

	if (hovering)
	{
		self.my_mouse_x = 0;
		self.my_mouse_y = 0;
		with (obj_mouse)
		{
			other.my_mouse_x = self.x;
			other.my_mouse_y = self.y;
		}	

		var draw_col = is_rainbow ? c_rainbow(get_timer() / 10000) : c_white;
		
		if (is_button)
		{
			outline_text_ext(string(title), my_mouse_x + 12, my_mouse_y + 16, draw_col, 0, 1, -1, 99999, 1, 1, 0);
		}
		else if (is_hold)
		{
			outline_text_ext(string(title), my_mouse_x + 12 + random_range(-1, 1), my_mouse_y + 16 + random_range(-1, 1), draw_col, 0, 1, -1, 99999, 1, 1, 0);
		}
		else
		{
			outline_text_ext(string(title) + " [" + string(toggled) + "/1]", my_mouse_x - 12, my_mouse_y + 16, draw_col, 0, 1, -1, 99999, 1, 1, 0);
		}
		
		outline_text_ext(string(description), my_mouse_x - 12, my_mouse_y + 12 + 16, 16777215, 0, 1, -1, 200, 1, 1, 0);
	}
	draw_text_reset();
	
	if (OnCustomDraw != noone)
	{
		OnCustomDraw();
	}
}

////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////
//MenuToggleButton//

OnMenuLabelCreate = function()
{
	OnLabelClick = noone;
	OnLabelHoldTick = noone;
	
	text = "";
	font = fnt_freddy; 
	halign = fa_left;
	valign = fa_top;

	color_idle = c_lime;
	color_hover = c_yellow;
	color_click = c_red;

	hold_timer = 30;
	is_held = false;

	is_clickable = true;
	is_holdable = false;
	
	is_lazy_update = true;
	lazy_update_interval = 15;
	update_timer = 0;
	
	hold_repeate_rate = 5;
	initial_repeat_delay = 30;

	cached_x1 = 0;
	cached_y1 = 0;
	cached_x2 = 0;
	cached_y2 = 0;

	is_hovered = false;
	is_clicked = false;
	is_rainbow = false;
	is_visible = true;

	update_bounds = function() {
		if (font != -1) draw_set_font(font);
		
		var _display_text = is_callable(text) ? text() : text; 
		
		var _w = string_width(_display_text) * image_xscale;
		var _h = string_height(_display_text) * image_yscale;

		cached_x1 = x;
		cached_y1 = y;

		if (halign == fa_center) { cached_x1 -= _w / 2; }
		else if (halign == fa_right) { cached_x1 -= _w; }

		if (valign == fa_middle) { cached_y1 -= _h / 2; }
		else if (valign == fa_bottom) { cached_y1 -= _h; }

		cached_x2 = cached_x1 + _w;
		cached_y2 = cached_y1 + _h;
	};

	OnCustomStep = noone;
	OnCustomDraw = noone;

	update_bounds();
}

OnMenuLabelStep = function()
{
	if (!is_clickable) { return; }
	if (is_lazy_update)
	{
		update_timer--;

		if (update_timer <= 0)
		{
			update_bounds();
			update_timer = lazy_update_interval;
		}
	}
	else
	{
		update_bounds();
	}

	is_hovered = point_in_rectangle(mouse_x, mouse_y, cached_x1, cached_y1, cached_x2, cached_y2);
	
	if (is_hovered && is_visible)
	{
		if (mouse_check_button_pressed(mb_left) || global.gp_accept_pressed))
		{
			is_clicked = true;
			audio_play_sound(snd_crit, 999 , false);
			if (OnLabelClick != noone)
			{
				OnLabelClick();
			}			
			self.hold_timer = 0;
			self.is_held = true;
		}
		else if (is_holdable && (mouse_check_button(mb_left) || global.gp_accept))
		{
			if (!self.is_held)
			{
				self.is_held = true;
				self.hold_timer = 0;
			}
			else
			{
				self.hold_timer+=1;						
				if (self.hold_timer >= initial_repeat_delay && (self.hold_timer - initial_repeat_delay) mod hold_repeate_rate == 0)
				{
					audio_play_sound(snd_crit, 999, false);
					if (OnLabelHoldTick != noone)
					{
						OnLabelHoldTick();
					}
				}
			}
		}
		else
		{
			self.is_clicked = false;
			self.is_held = false;
			self.hold_timer = 0;
		}
	}
	else
	{
		self.is_clicked = false;
		self.is_held = false;
		self.hold_timer = 0;
	}
	
	if (OnCustomStep != noone)
	{
		OnCustomStep();
	}
}

OnMenuLabelDraw = function()
{
	if (!is_visible) { return; }
	if (font != -1)
	{
		draw_set_font(font);
	}
	draw_set_halign(halign);
	draw_set_valign(valign);

	var _current_color = color_idle;
	
	if (is_clickable)
	{
		if (is_clicked)
		{
			_current_color = color_click;
		}
		else if (is_hovered)
		{
			_current_color = color_hover;
		}
	}

	var _display_text = is_callable(text) ? text() : text;
	var draw_col = is_rainbow ? c_rainbow(get_timer() / 10000) : _current_color;
	draw_text_transformed_colour(x, y, _display_text, image_xscale, image_yscale, image_angle, draw_col, draw_col, draw_col, draw_col, image_alpha);
	//draw_text_color(x, y, _display_text, draw_col, draw_col, draw_col, draw_col, 1);

	if (global.GodHome.IS_DRAW_DEBUG_SPRITES)
	{
		draw_rectangle(cached_x1, cached_y1, cached_x2, cached_y2, true);
	}
	
	if (OnCustomDraw != noone)
	{
		OnCustomDraw();
	}
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////
//MenuSocialButton//

OnMenuSocialButtonCreate = function()
{
	OnCustomStep = noone;
	OnCustomDraw = noone;
	OnSocialButtonClick = noone;
	sprite_index = noone;
	hoversnd = false;
	social_url = "";
	text = "";
	text_color = c_white;
	is_rainbow_text = false;
	is_rainbow_sprite = false;
	image_index = 0;
}

OnMenuSocialButtonStep = function()
{
	if (OnCustomStep != noone)
	{
		OnCustomStep();
	}
}

OnMenuSocialButtonDraw = function()
{
	var hover_alph = 1;

	self.my_mouse = noone;
	with (obj_mouse)
	{
		other.my_mouse = self;
	}
	if (instance_place(x, y, my_mouse))
	{
		if (text != "")
		{
			var text_draw_col = is_rainbow_text ? c_rainbow(get_timer() / 10000) : text_color;
			outline_text_ext(text, my_mouse.x + 10, my_mouse.y - 10, text_draw_col, 0, 1, -1, 200, 1, 1, 0);
		}
		if (hoversnd == false)
		{
			playsnd_at(global.sounds.snd_menu_hover, 1, false, 1, my_mouse.x, my_mouse.y);
			hoversnd = true;
		}
		
		hover_alph = 0.6;
		
		if (mouse_check_button(mb_left) || global.gp_accept)
		{
			hover_alph = 0.3;
		}
		
		if (mouse_check_button_released(mb_left) || global.gp_accept_pressed)
		{
			playsnd_at(global.sounds.snd_menu_click, 1, 0, 1, my_mouse.x, my_mouse.y);
			if (OnSocialButtonClick != noone)
			{
				OnSocialButtonClick();
			}			
			if (social_url != "")
			{
				url_open_ext(social_url, "_blank");
			}
		}
	}
	else if (hoversnd == true)
	{
		hoversnd = false;
	}

	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, hover_alph);

	if (is_rainbow_sprite)
	{
		var sprite_col = c_rainbow(get_timer() / 10000);
		gpu_set_fog(true, sprite_col, 0, 0);
		draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, hover_alph * 0.5); 
		gpu_set_fog(false, c_white, 0, 0);
	}

	
	if (OnCustomDraw != noone)
	{
		OnCustomDraw();
	}
}	

////////////////////////////////////////////////////////////////////
