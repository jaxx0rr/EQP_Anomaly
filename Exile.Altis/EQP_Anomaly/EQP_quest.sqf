/* Attention particle animation and this code is copyrighted , it can be used freely only with the mod Exile. Do not modify! No modifications in their use!
Author animation olke 2014-2015 , script code the SteelRat & olke 2016 */

params["_target", "_caller", "_ID", "_arguments"];
private ["_debug", "_title", "_questItem", "_htext", "_inventoryItems", "_questman", "_notification", "_detector", "_quests"];

_debug = true;

_questman = _target getVariable ["questman", ""];
if (_questman == "") exitWith {
	diag_log "PTM: ERROR: script EQP_quest.sqf: _questman empty variable";
	if (_debug) then {hintSilent "PTM: ERROR: script EQP_quest.sqf: _questman empty variable";};
};

_quests = player getVariable ["quests", []];
if (
	("Basil_Obukhov" in _quests)&&
	{"Ivan_Demidov" in _quests}&&
	{"Boris_Britva" in _quests}
) exitWith {
	/* Quests complited */
	['Success',["Заданий нет."]] call ExileClient_gui_notification_event_addNotification;
};

// Блок конфигурации
_detector		= 'MineDetector';
_questItem		= 'Exile_Magazine_Battery';
_title			= "<t color='#7FFF00' size='1.2' shadow='1' shadowColor='#000000' align='center'>ANOMALY ACTIVITY TASK:</t><br/><t color='#ffffff'>¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯<br/>";
_htext			= "";
_notification		= "";


_inventoryItems = (uniformItems player) + (vestItems player) + (backpackItems player);

_fnc_taskComplited = {
	player removeItem _questItem;
	_quests pushBack (player getVariable ["questCurrent", ""]);
	player setVariable ["quests", _quests];
	player setVariable ["questCurrent", ""];
};

switch (_questman) do {
	case ('Basil_Obukhov'): {
		if (player getVariable ["questCurrent", ""] == "" && {!("Basil_Obukhov" in _quests)}) then {
			player setVariable ["questCurrent", "Basil_Obukhov"];
			_htext	= "Hi man. My name is Basil Obukhov. It is a strange place dude but here, too, we need the money. Do you want to earn a few coins? Here nearby there is a strange place. Where land and grass is flying up. I'll give you anomaly detector, go there and apply your location."; 
			_notification = "Find Anomaly Gravi";
			player addItem _detector;
			player setVariable ["questAnomalyType", "gravi", true];
		} else {
			if (player getVariable ["questCurrent", ""] == "Basil_Obukhov") then {
				switch (true) do {
					case (_questItem in _inventoryItems): {
						call _fnc_taskComplited;
						_htext	= "Wow. You found the anomaly, now we have to carry this map to Ivan Demidov. You will find it in the eastern trade area.";
						_notification = "Find Ivan Demidov";
						player addItem 'H_PilotHelmetFighter_O';
						player addItem 'Exile_Item_CodeLock';
					};
					case (_detector in _inventoryItems): {
						_notification = "You are already in a quest";
					};
					default {
						_htext	= "You are already in a quest";
						player setVariable ["questCurrent", ""];
					};
				};
			};
		};
	};
	
	case ('Ivan_Demidov'): {
		if (player getVariable ["questCurrent", ""] == "" && {"Basil_Obukhov" in _quests} && {!("Ivan_Demidov" in _quests)}) then {
			player setVariable ["questCurrent", "Ivan_Demidov"];
			_htext	= "Well, the day today. Where are you bro? Ur breaking up..!??? Basil's not calm down. Hi there! You brought the Map? Excellent. Now you must find this anomaly, just follow the smell, rotten flesh, yuk. Learn it and mark on the map. Be careful. Do not come too close to it!"; 
			_notification = "Find Anomaly Meatgrinder";
			player addItem _detector;
			player setVariable ["questAnomalyType", "meat", true];
		} else {
			if (player getVariable ["questCurrent", ""] == "Ivan_Demidov") then {
				switch (true) do {
					case (_questItem in _inventoryItems): {
						call _fnc_taskComplited;
						_htext	= "What? Detector is fail?! Hold on, i'll phone Boris.. - Boris? Bad news. We are ditching the Japanese unit... The Device is exhausted. Yes I'll send you the guy. - Go to Boris Britva, he's waiting for you on the west side of the island.";
						_notification = "Find Boris Britva";
						player addItem 'Exile_Item_CodeLock';
						player addItem 'Exile_Item_CodeLock';
					};
					case (_detector in _inventoryItems): {
						_notification = "Please activate quest in Aero.";
					};
					default {
						_htext	= "You are already in a quest";
						player setVariable ["questCurrent", ""];
					};
				};
			} else {
				if ("Basil_Obukhov" in _quests) then {
					_notification = "Find Boris Britva";
				} else {
					_notification = "Find Basil Obuhov";
				};
			};
		};		
	};
	
	case ('Boris_Britva'): {
		if (player getVariable ["questCurrent", ""] == "" && {"Ivan_Demidov" in _quests} && {!("Boris_Britva" in _quests)}) then {
			player setVariable ["questCurrent", "Boris_Britva"];
			_htext	= "Hi there. We have to get another anomaly but the reward is great! You must find the Fire Fluff!"; 
			_notification = "Find Anomaly Fire Fluff";
			player addItem _detector;
			player setVariable ["questAnomalyType", "fluff", true];
		} else {
			if (player getVariable ["questCurrent", ""] == "Boris_Britva") then {
				switch (true) do {
					case (_questItem in _inventoryItems): {
						call _fnc_taskComplited;
						_htext	= "You have fulfilled the task ?! Good job... Good quest... Take prize!!";
						_notification = "Quest complite";
						player addItem 'U_O_CombatUniform_ocamo';
						player addItem 'Exile_Item_CodeLock';
						player addItem 'Exile_Item_CodeLock';
						player addItem 'Exile_Item_CodeLock';
						player addItem 'Exile_Item_CodeLock';
					};
					case (_detector in _inventoryItems): {
						_notification = "You are already in a quest";
					};
					default {
						_htext	= "You are already in a quest";
						player setVariable ["questCurrent", ""];
					};
				};
			} else {
				// квест завершён
			};
		};		
	};
};

if (_htext != "") then {
	hint parseText ( _title + _htext);
};

if (_notification != "") then {
	['Success',[_notification]] call ExileClient_gui_notification_event_addNotification;
};