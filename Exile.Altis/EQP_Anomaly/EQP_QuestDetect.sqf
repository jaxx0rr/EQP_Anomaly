// vitacite aka olke detector anomaly and send money prize (tnx to bombajack for betatesting and Dizzturbed for his knowledge
// for saving prize to database need use https://github.com/happydayz-enigma/Enigma_Exile_Custom  Enigma addon for Exile.
// just copy Enigma_Exile_Custom.pbo in you @ExileServer/addons/ 
/* Attention particle animation and this code is copyrighted , it can be used freely only with the mod Exile. Do not modify! No modifications in their use!
Author animation olke 2014-2015 , script code the SteelRat & olke 2016 */

params["_anomalyType"];
private ["_title", "_htext", "_cost", "_addrespect", "_addpoptabs"];

// Блок конфигурации

switch (_anomalyType) do {
	case "electra": {
	};
	case "gravi": {
		_addrespect = 1250;
		_addpoptabs = 2500;
		_title	= "<t color='#7FFF00' size='1.2' shadow='1' shadowColor='#000000' align='center'>ANOMALY ACTIVITY TASK:</t><br/><t color='#ffffff'>¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯<br/>";
		_htext  = "You have successfully studied the anomaly GRAVI. Go back to Basil.";
	};
	case "jarka": {
	};
	case "meat": {
		_addrespect = 2500;
		_addpoptabs = 5000;
		_title	= "<t color='#7FFF00' size='1.2' shadow='1' shadowColor='#000000' align='center'>ANOMALY ACTIVITY TASK:</t><br/><t color='#ffffff'>¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯<br/>";
		_htext  = "You found an anomaly MEATGRINDER. But the detector seems broken. You need to find Ivan Demidov and tell him about the problem.";	
	};
	case "fluff": {
		_addrespect = 5000;
		_addpoptabs = 10000;
		_title	= "<t color='#7FFF00' size='1.2' shadow='1' shadowColor='#000000' align='center'>ANOMALY ACTIVITY TASK:</t><br/><t color='#ffffff'>¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯<br/>";
		_htext  = "You have successfully studied the anomaly BURNING FLUFF and struck her on the map . Find Boris Razor, and talk to him.";
	};
};

hint parseText ( _title + _htext);
_newScore = ExileClientPlayerScore + _addrespect;
ENIGMA_UpdateStats = [player,0,_newScore];
publicVariableServer "ENIGMA_UpdateStats";
uisleep 1;
_newPoptabs = ExileClientPlayerMoney + _addpoptabs;
ENIGMA_UpdateStats = [player,_newPoptabs];
publicVariableServer "ENIGMA_UpdateStats";
['Success',[format['+%1 Pop Tabs', _addpoptabs]]] call ExileClient_gui_notification_event_addNotification;
uisleep 1;			
['Success',[format['+%1 Rep', _addrespect]]] call ExileClient_gui_notification_event_addNotification;