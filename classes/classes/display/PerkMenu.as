/**
 * Created by aimozg on 22.05.2017.
 */
package classes.display {
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.GlobalFlags.kGAMECLASS;
import classes.PerkClass;
import classes.PerkLib;
import classes.PerkTree;
import classes.PerkType;
import classes.StatusAffects;

import flash.events.MouseEvent;

public class PerkMenu extends BaseContent {
	public function PerkMenu() {
	}
	public function displayPerks(e:MouseEvent = null):void {
		var temp:int = 0;
		clearOutput();
		displayHeader("Perks");
		while(temp < player.perks.length) {
			outputText("<b>" + player.perk(temp).perkName + "</b> - " + player.perk(temp).perkDesc + "\n", false);
			temp++;
		}
		menu();
		var button:int = 0;
		addButton(button++, "Next", playerMenu);
		if(player.perkPoints > 0) {
			outputText("\n<b>You have " + num2Text(player.perkPoints) + " perk point", false);
			if(player.perkPoints > 1) outputText("s", false);
			outputText(" to spend.</b>", false);
			addButton(button++, "Perk Up", kGAMECLASS.perkBuyMenu);
		}
		if(player.findPerk(PerkLib.DoubleAttack) >= 0 || player.findPerk(PerkLib.DoubleAttackLarge) >= 0 || player.findPerk(PerkLib.Combo) >= 0) {
			outputText("\n<b>You can adjust your melee attack settings.</b>");
			addButton(button++,"Melee Opt",doubleAttackOptions);
		}
		if(player.findPerk(PerkLib.DoubleStrike) >= 0 || player.findPerk(PerkLib.ElementalArrows) >= 0 || player.findPerk(PerkLib.Cupid) >= 0 || player.findPerk(PerkLib.EnvenomedBolt) >= 0) {
			outputText("\n<b>You can adjust your range strike settings.</b>");
			addButton(button++,"Range Opt",doubleStrikeOptions);
		}
		if(player.findPerk(PerkLib.Spellsword) >= 0 || player.findPerk(PerkLib.Spellarmor) >= 0 || player.findPerk(PerkLib.Battleflash) >= 0 || player.findPerk(PerkLib.Battlemage) >= 0) {
			outputText("\n<b>You can adjust your spell autocast settings.</b>");
			addButton(button++,"Spells Opt",spellautocastOptions);
		}
		addButton(9, "Database", perkDatabase);
		addButton(10, "Number of", kGAMECLASS.doNothing);
		addButton(11, "perks: " + player.perks.length, kGAMECLASS.doNothing);
	}

	public function doubleAttackOptions():void {
		clearOutput();
		menu();
		outputText("You will always attack ");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) outputText("six times");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) outputText("five times");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) outputText("four times");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) outputText("three times");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) outputText("twice");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] < 1) outputText("once");
		outputText(" in combat turn");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) outputText(" using 75% of your current strength");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) outputText(" using 80% of your current strength");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) outputText(" using 85% of your current strength");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) outputText(" using 90% of your current strength");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) outputText(" using 95% of your current strength");
		outputText(".");
		outputText("\n\nYou can change it to different amount of attacks.");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 0) addButton(0, "All Single", singleAttack);
		if ((player.findPerk(PerkLib.DoubleAttack) >= 0 || player.findPerk(PerkLib.DoubleAttackLarge) >= 0 || player.findPerk(PerkLib.Combo) >= 0) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 1) {
			if ((player.weaponPerk == "Large" && player.findPerk(PerkLib.DoubleAttackLarge) < 0) || player.weaponPerk == "Dual Large" || player.weaponPerk == "Dual" || player.weaponPerk == "Staff" || (player.isFistOrFistWeapon() && player.findPerk(PerkLib.Combo) < 0)) addButtonDisabled(1, "All Double", "You current melee weapon not allow to use this option");
			else addButton(1, "All Double", doubleAttack);
		}
		if ((player.findPerk(PerkLib.TripleAttack) >= 0 || player.findPerk(PerkLib.TripleAttackLarge) >= 0) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 2) {
			if ((player.weaponPerk == "Large" && player.findPerk(PerkLib.TripleAttackLarge) < 0) || player.weaponPerk == "Dual Large" || player.weaponPerk == "Dual" || player.weaponPerk == "Staff" || (player.isFistOrFistWeapon() && player.findPerk(PerkLib.ComboMaster) < 0)) addButtonDisabled(5, "All Triple", "You current melee weapon not allow to use this option");
			else addButton(5, "All Triple", tripleAttack);
		}
		if (player.findPerk(PerkLib.QuadrupleAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 3) {
			if (player.weaponPerk == "Large" || player.weaponPerk == "Dual Large" || player.weaponPerk == "Dual" || player.weaponPerk == "Staff" || player.isFistOrFistWeapon()) addButtonDisabled(6, "All Quadruple", "You current melee weapon not allow to use this option");
			else addButton(6, "All Quadruple", quadrupleAttack);
		}
		if (player.findPerk(PerkLib.PentaAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 4) {
			if (player.weaponPerk == "Large" || player.weaponPerk == "Dual Large" || player.weaponPerk == "Dual" || player.weaponPerk == "Staff" || player.isFistOrFistWeapon()) addButtonDisabled(10, "All Penta", "You current melee weapon not allow to use this option");
			else addButton(10, "All Penta", pentaAttack);
		}
		if (player.findPerk(PerkLib.HexaAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 5) {
			if (player.weaponPerk == "Large" || player.weaponPerk == "Dual Large" || player.weaponPerk == "Dual" || player.weaponPerk == "Staff" || player.isFistOrFistWeapon()) addButtonDisabled(11, "All Hexe", "You current melee weapon not allow to use this option");
			else addButton(11, "All Hexe", hexaAttack);
		}

		var e:MouseEvent;
		if (getGame().inCombat) addButton(14, "Back", combat.combatMenu);
		else addButton(14, "Back", displayPerks);
	}

	public function hexaAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 5;
		doubleAttackOptions();
	}
	public function pentaAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 4;
		doubleAttackOptions();
	}
	public function quadrupleAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 3;
		doubleAttackOptions();
	}
	public function tripleAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 2;
		doubleAttackOptions();
	}
	public function doubleAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 1;
		doubleAttackOptions();
	}
	public function singleAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 0;
		doubleAttackOptions();
	}

	public function doubleStrikeOptions():void {
		clearOutput();
		menu();
		outputText("You will always shoot ");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 5) outputText("six");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 4) outputText("five");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 3) outputText("four");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 2) outputText("three");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 1) outputText("two");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] < 1) outputText("single");
		outputText(" projectile");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] > 0) outputText("s");
		outputText(" in combat.");
		outputText("\n\nYou can change it to different amount of projectiles.");
		if (player.findPerk(PerkLib.ElementalArrows) >= 0) {
			outputText("\n\nIf you learned specific techniques you could even add some magical effects to the projectiles. (Working only with bows and crosbows)");
			if (flags[kFLAGS.ELEMENTAL_ARROWS] == 0) outputText("\n\nElemental effect added: <b>None</b>");
			if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) outputText("\n\nElemental effect added: <b>Fire</b>");
			if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) outputText("\n\nElemental effect added: <b>Ice</b>");
			if (flags[kFLAGS.ELEMENTAL_ARROWS] == 3) outputText("\n\nElemental effect added: <b>Lightning</b>");
			if (flags[kFLAGS.ELEMENTAL_ARROWS] == 4) outputText("\n\nElemental effect added: <b>Dakness</b>");
		}
		if (player.findPerk(PerkLib.Cupid) >= 0) {
			outputText("\n\nIf you learned specific black magical you could add it effects to the projectiles. (Working only with bows and crosbows)");
			if (flags[kFLAGS.CUPID_ARROWS] == 0) outputText("\n\nBlack Magic effect added: <b>None</b>");
			if (flags[kFLAGS.CUPID_ARROWS] == 1) outputText("\n\nBlack Magic effect added: <b>Arouse</b>");
		}
		if (player.findPerk(PerkLib.EnvenomedBolt) >= 0) {
			outputText("\n\nIf you can naturaly produce venom then you could add it effects to the projectiles. (Working only with bows and crosbows)");
			if (flags[kFLAGS.ENVENOMED_BOLTS] == 0) outputText("\n\nVenom effect added: <b>No</b>");
			if (flags[kFLAGS.ENVENOMED_BOLTS] == 1) outputText("\n\nVenom effect added: <b>Yes</b>");
		}
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 0) addButton(0, "All Single", singleStrike);
		if (player.findPerk(PerkLib.DoubleStrike) >= 0 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 1) {
			if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow" || player.weaponRangePerk == "Throwing") addButton(1, "All Double", doubleStrike);
			else addButtonDisabled(1, "All Double", "You current range weapon not allow to use this option");
		}
		if (player.findPerk(PerkLib.TripleStrike) >= 0 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 2) {
			if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow" || player.weaponRangePerk == "Throwing") addButton(2, "All Triple", tripleStrike);
			else addButtonDisabled(2, "All Triple", "You current range weapon not allow to use this option");
		}
		if (player.findPerk(PerkLib.Manyshot) >= 0 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 3) {
			if (player.weaponRangePerk == "Bow") addButton(5, "All Quad", quadrupleStrike);
			else addButtonDisabled(5, "All Quad", "You current range weapon not allow to use this option");
		}
		if (player.findPerk(PerkLib.WildQuiver) >= 0 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 4) {
			if (player.weaponRangePerk == "Bow") addButton(6, "All Penta", pentaStrike);
			else addButtonDisabled(6, "All Penta", "You current range weapon not allow to use this option");
		}
		if (player.findPerk(PerkLib.Multishot) >= 0 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 5) {
			if (player.weaponRangePerk == "Bow") addButton(7, "All Hexa", hexaStrike);
			else addButtonDisabled(7, "All Hexa", "You current range weapon not allow to use this option");
		}
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && flags[kFLAGS.ELEMENTAL_ARROWS] != 0) addButton(3, "None", normalArrows);
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && player.hasStatusAffect(StatusAffects.KnowsWhitefire) && flags[kFLAGS.ELEMENTAL_ARROWS] != 1) addButton(8, "Fire", fireArrows);
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && player.hasStatusAffect(StatusAffects.KnowsIceSpike) && flags[kFLAGS.ELEMENTAL_ARROWS] != 2) addButton(9, "Ice", iceArrows);
		if (player.findPerk(PerkLib.Cupid) >= 0 && flags[kFLAGS.CUPID_ARROWS] != 0) addButton(10, "None", normalArrows2);
		if (player.findPerk(PerkLib.Cupid) >= 0 && player.hasStatusAffect(StatusAffects.KnowsArouse) && flags[kFLAGS.CUPID_ARROWS] != 1) addButton(11, "Arouse", arouseArrows);
		if (player.findPerk(PerkLib.EnvenomedBolt) >= 0 && flags[kFLAGS.ENVENOMED_BOLTS] != 0) addButton(12, "None", normalArrows3);
		if (player.findPerk(PerkLib.EnvenomedBolt) >= 0 && (player.tailType == TAIL_TYPE_BEE_ABDOMEN || player.tailType == TAIL_TYPE_SCORPION || player.tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL || player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS) && flags[kFLAGS.ENVENOMED_BOLTS] != 1) addButton(13, "Venom", venomArrows);

		var e:MouseEvent;
		if (getGame().inCombat) addButton(14, "Back", combat.combatMenu);
		else addButton(14, "Back", displayPerks);
	}

	public function darknessArrows():void {
		flags[kFLAGS.ELEMENTAL_ARROWS] = 4;
		doubleStrikeOptions();
	}
	public function lightningArrows():void {
		flags[kFLAGS.ELEMENTAL_ARROWS] = 3;
		doubleStrikeOptions();
	}
	public function iceArrows():void {
		flags[kFLAGS.ELEMENTAL_ARROWS] = 2;
		doubleStrikeOptions();
	}
	public function fireArrows():void {
		flags[kFLAGS.ELEMENTAL_ARROWS] = 1;
		doubleStrikeOptions();
	}
	public function normalArrows():void {
		flags[kFLAGS.ELEMENTAL_ARROWS] = 0;
		doubleStrikeOptions();
	}
	public function arouseArrows():void {
		flags[kFLAGS.CUPID_ARROWS] = 1;
		doubleStrikeOptions();
	}
	public function normalArrows2():void {
		flags[kFLAGS.CUPID_ARROWS] = 0;
		doubleStrikeOptions();
	}
	public function venomArrows():void {
		flags[kFLAGS.ENVENOMED_BOLTS] = 1;
		doubleStrikeOptions();
	}
	public function normalArrows3():void {
		flags[kFLAGS.ENVENOMED_BOLTS] = 0;
		doubleStrikeOptions();
	}
	public function hexaStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 5;
		doubleStrikeOptions();
	}
	public function pentaStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 4;
		doubleStrikeOptions();
	}
	public function quadrupleStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 3;
		doubleStrikeOptions();
	}
	public function tripleStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 2;
		doubleStrikeOptions();
	}
	public function doubleStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 1;
		doubleStrikeOptions();
	}
	public function singleStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 0;
		doubleStrikeOptions();
	}

	public function spellautocastOptions():void {
		clearOutput();
		menu();
		outputText("You can choose to autocast or not specific buff spells at the start of each combat.\n");
		if (player.findPerk(PerkLib.Spellsword) >= 0) {
			outputText("\n<b>Charge Weapon:</b> ");
			if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.findPerk(PerkLib.Spellarmor) >= 0) {
			outputText("\n<b>Charge Armor:</b> ");
			if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.findPerk(PerkLib.Battlemage) >= 0) {
			outputText("\n<b>Might:</b> ");
			if (flags[kFLAGS.AUTO_CAST_MIGHT] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.findPerk(PerkLib.Battleflash) >= 0) {
			outputText("\n<b>Blink:</b> ");
			if (flags[kFLAGS.AUTO_CAST_BLINK] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 0) addButton(0, "Autocast", autoChargeWeapon);
		if (player.findPerk(PerkLib.Spellsword) >= 0 && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 1) addButton(5, "Manual", manualChargeWeapon);
		if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 0) addButton(1, "Autocast", autoChargeArmor);
		if (player.findPerk(PerkLib.Spellarmor) >= 0 && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 1) addButton(6, "Manual", manualChargeArmor);
		if (flags[kFLAGS.AUTO_CAST_MIGHT] != 0) addButton(2, "Autocast", autoMight);
		if (player.findPerk(PerkLib.Battlemage) >= 0 && flags[kFLAGS.AUTO_CAST_MIGHT] != 1) addButton(7, "Manual", manualMight);
		if (flags[kFLAGS.AUTO_CAST_BLINK] != 0) addButton(3, "Autocast", autoBlink);
		if (player.findPerk(PerkLib.Battleflash) >= 0 && flags[kFLAGS.AUTO_CAST_BLINK] != 1) addButton(8, "Manual", manualBlink);

		var e:MouseEvent;
		addButton(14, "Back", displayPerks);
	}

	public function manualBlink():void {
		flags[kFLAGS.AUTO_CAST_BLINK] = 1;
		spellautocastOptions();
	}
	public function autoBlink():void {
		flags[kFLAGS.AUTO_CAST_BLINK] = 0;
		spellautocastOptions();
	}
	public function manualMight():void {
		flags[kFLAGS.AUTO_CAST_MIGHT] = 1;
		spellautocastOptions();
	}
	public function autoMight():void {
		flags[kFLAGS.AUTO_CAST_MIGHT] = 0;
		spellautocastOptions();
	}
	public function manualChargeArmor():void {
		flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] = 1;
		spellautocastOptions();
	}
	public function autoChargeArmor():void {
		flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] = 0;
		spellautocastOptions();
	}
	public function manualChargeWeapon():void {
		flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] = 1;
		spellautocastOptions();
	}
	public function autoChargeWeapon():void {
		flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] = 0;
		spellautocastOptions();
	}

	public function perkDatabase(page:int=0, count:int=20):void {
		var allPerks:Array = PerkTree.obtainablePerks();
		clearOutput();
		var perks:Array = allPerks.slice(page*count,(page+1)*count);
		displayHeader("All Perks ("+(1+page*count)+"-"+(page*count+perks.length)+
					  "/"+allPerks.length+")");
		for each (var ptype:PerkType in perks) {
			var pclass:PerkClass = player.perk(player.findPerk(ptype));

			var color:String;
			if (pclass) color='#000000'; // has perk
			else if (ptype.available(player)) color='#228822'; // can take on next lvl
			else color='#aa8822'; // requirements not met

			outputText("<font color='" +color +"'><b>"+ptype.name+"</b></font>: ");
			outputText(pclass?ptype.desc(pclass):ptype.longDesc);
			if (!pclass && ptype.requirements.length>0) {
				var reqs:Array = [];
				for each (var cond:Object in ptype.requirements) {
					if (cond.fn(player)) color='#000000';
					else color='#aa2222';
					reqs.push("<font color='"+color+"'>"+cond.text+"</font>");
				}
				outputText("<ul><li><b>Requires:</b> " + reqs.join(", ")+".</li></ul>");
			} else {
				outputText("\n");
			}
		}
		if (page>0) addButton(0,"Prev",perkDatabase,page-1);
		else addButtonDisabled(0,"Prev");
		if (page*count<allPerks.length) addButton(1,"Next",perkDatabase,page+1);
		else addButtonDisabled(1,"Next");
		addButton(9, "Back", playerMenu);
	}
}
}
