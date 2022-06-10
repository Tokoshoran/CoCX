﻿package classes
{
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.ISexyPart;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Items.Armor;
import classes.Items.ArmorLib;
import classes.Items.FlyingSwords;
import classes.Items.FlyingSwordsLib;
import classes.Items.HeadJewelry;
import classes.Items.HeadJewelryLib;
import classes.Items.ItemTags;
import classes.Items.Jewelry;
import classes.Items.JewelryLib;
import classes.Items.MiscJewelry;
import classes.Items.MiscJewelryLib;
import classes.Items.Necklace;
import classes.Items.NecklaceLib;
import classes.Items.Shield;
import classes.Items.ShieldLib;
import classes.Items.Undergarment;
import classes.Items.UndergarmentLib;
import classes.Items.Vehicles;
import classes.Items.VehiclesLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.WeaponRange;
import classes.Items.WeaponRangeLib;
import classes.Races.ElementalRace;
import classes.Races.HumanRace;
import classes.Scenes.Combat.CombatAbilities;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.NPCs.AetherTwinsFollowers;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.Places.Mindbreaker;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Pregnancy;
import classes.Scenes.SceneLib;
import classes.Stats.StatUtils;
import classes.StatusEffects.HeatEffect;
import classes.StatusEffects.RutEffect;
import classes.internals.Utils;
import classes.lists.BreastCup;

use namespace CoC;

	/**
	 * ...
	 * @author Yoffy
	 */
	public class Player extends Character {

		public function Player() {
			for (var i:int = 0; i < CombatAbility.Registry.length; i++) {
				cooldowns[i] = 0;
			}
			//Item things
			itemSlot1 = new ItemSlotClass();
			itemSlot2 = new ItemSlotClass();
			itemSlot3 = new ItemSlotClass();
			itemSlot4 = new ItemSlotClass();
			itemSlot5 = new ItemSlotClass();
			itemSlot6 = new ItemSlotClass();
			itemSlot7 = new ItemSlotClass();
			itemSlot8 = new ItemSlotClass();
			itemSlot9 = new ItemSlotClass();
			itemSlot10 = new ItemSlotClass();
			itemSlot11 = new ItemSlotClass();
			itemSlot12 = new ItemSlotClass();
			itemSlot13 = new ItemSlotClass();
			itemSlot14 = new ItemSlotClass();
			itemSlot15 = new ItemSlotClass();
			itemSlot16 = new ItemSlotClass();
			itemSlot17 = new ItemSlotClass();
			itemSlot18 = new ItemSlotClass();
			itemSlot19 = new ItemSlotClass();
			itemSlot20 = new ItemSlotClass();
			itemSlots = [itemSlot1, itemSlot2, itemSlot3, itemSlot4, itemSlot5, itemSlot6, itemSlot7, itemSlot8, itemSlot9, itemSlot10, itemSlot11, itemSlot12, itemSlot13, itemSlot14, itemSlot15, itemSlot16, itemSlot17, itemSlot18, itemSlot19, itemSlot20];
		}

		protected final function outputText(text:String, clear:Boolean = false):void
		{
			if (clear) EngineCore.clearOutputTextOnly();
			EngineCore.outputText(text);
		}

		public var startingRace:String = "human";

		//Autosave
		public var slotName:String = "VOID";
		public var autoSave:Boolean = false;

		//Lust vulnerability
		public var lustVuln:Number = 1;

		//Mastery attributes
		public var masteryFeralCombatLevel:Number = 0;
		public var masteryFeralCombatXP:Number = 0;
		public var masteryGauntletLevel:Number = 0;
		public var masteryGauntletXP:Number = 0;
		public var masterySwordLevel:Number = 0;
		public var masterySwordXP:Number = 0;
		public var masteryAxeLevel:Number = 0;
		public var masteryAxeXP:Number = 0;
		public var masteryMaceHammerLevel:Number = 0;
		public var masteryMaceHammerXP:Number = 0;
		public var masteryDuelingSwordLevel:Number = 0;
		public var masteryDuelingSwordXP:Number = 0;
		public var masteryPolearmLevel:Number = 0;
		public var masteryPolearmXP:Number = 0;
		public var masterySpearLevel:Number = 0;
		public var masterySpearXP:Number = 0;
		public var masteryDaggerLevel:Number = 0;
		public var masteryDaggerXP:Number = 0;
		public var masteryWhipLevel:Number = 0;
		public var masteryWhipXP:Number = 0;
		public var masteryExoticLevel:Number = 0;
		public var masteryExoticXP:Number = 0;
		public var masteryArcheryLevel:Number = 0;
		public var masteryArcheryXP:Number = 0;
		public var masteryThrowingLevel:Number = 0;
		public var masteryThrowingXP:Number = 0;
		public var masteryFirearmsLevel:Number = 0;
		public var masteryFirearmsXP:Number = 0;
		public var dualWSLevel:Number = 0;
		public var dualWSXP:Number = 0;
		public var dualWNLevel:Number = 0;
		public var dualWNXP:Number = 0;
		public var dualWLLevel:Number = 0;
		public var dualWLXP:Number = 0;
		public var dualWFLevel:Number = 0;
		public var dualWFXP:Number = 0;

		//Combat ability cooldowns. Index is ability id.
		public var cooldowns:/*int*/Array = [];
		
		//Mining attributes
		public var miningLevel:Number = 0;
		public var miningXP:Number = 0;
		
		//Herbalism attributes
		public var herbalismLevel:Number = 0;
		public var herbalismXP:Number = 0;

		//Teasing attributes
		public var teaseLevel:Number = 0;
		public var teaseXP:Number = 0;

		//Prison stats
		public var hunger:Number = 0; //Also used in survival and realistic mode
		public var obey:Number = 0;
		public var esteem:Number = 0;
		public var will:Number = 0;

		public var obeySoftCap:Boolean = true;

		//Perks used to store 'queued' perk buys
		public var perkPoints:Number = 0;
		public var statPoints:Number = 0;
		public var superPerkPoints:Number = 0;
		public var ascensionPerkPoints:Number = 0;

		public var tempStr:Number = 0;
		public var tempTou:Number = 0;
		public var tempSpe:Number = 0;
		public var tempInt:Number = 0;
		public var tempWis:Number = 0;
		public var tempLib:Number = 0;
		//Number of times explored for new areas
		public var explored:Number = 0;
		public var exploredForest:Number = 0;
		public var exploredDesert:Number = 0;
		public var exploredMountain:Number = 0;
		public var exploredLake:Number = 0;

		//Player pregnancy variables and functions
		private var pregnancy:Pregnancy = new Pregnancy();
		override public function pregnancyUpdate():Boolean {
			return pregnancy.updatePregnancy(); //Returns true if we need to make sure pregnancy texts aren't hidden
		}

		// Inventory
		public var itemSlot1:ItemSlotClass;
		public var itemSlot2:ItemSlotClass;
		public var itemSlot3:ItemSlotClass;
		public var itemSlot4:ItemSlotClass;
		public var itemSlot5:ItemSlotClass;
		public var itemSlot6:ItemSlotClass;
		public var itemSlot7:ItemSlotClass;
		public var itemSlot8:ItemSlotClass;
		public var itemSlot9:ItemSlotClass;
		public var itemSlot10:ItemSlotClass;
		public var itemSlot11:ItemSlotClass;
		public var itemSlot12:ItemSlotClass;
		public var itemSlot13:ItemSlotClass;
		public var itemSlot14:ItemSlotClass;
		public var itemSlot15:ItemSlotClass;
		public var itemSlot16:ItemSlotClass;
		public var itemSlot17:ItemSlotClass;
		public var itemSlot18:ItemSlotClass;
		public var itemSlot19:ItemSlotClass;
		public var itemSlot20:ItemSlotClass;
		public var itemSlots:Array;

		public var prisonItemSlots:Array = [];
		public var previouslyWornClothes:Array = []; //For tracking achievement.

		private var _weapon:Weapon = WeaponLib.FISTS;
		private var _weaponRange:WeaponRange = WeaponRangeLib.NOTHING;
		private var _weaponFlyingSwords:FlyingSwords = FlyingSwordsLib.NOTHING;
		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _miscjewelry:MiscJewelry = MiscJewelryLib.NOTHING;
		private var _miscjewelry2:MiscJewelry = MiscJewelryLib.NOTHING;
		private var _headjewelry:HeadJewelry = HeadJewelryLib.NOTHING;
		private var _necklace:Necklace = NecklaceLib.NOTHING;
		private var _jewelry:Jewelry = JewelryLib.NOTHING;
		private var _jewelry2:Jewelry = JewelryLib.NOTHING;
		private var _jewelry3:Jewelry = JewelryLib.NOTHING;
		private var _jewelry4:Jewelry = JewelryLib.NOTHING;
		private var _shield:Shield = ShieldLib.NOTHING;
		private var _upperGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _lowerGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _vehicle:Vehicles = VehiclesLib.NOTHING;
		private var _modArmorName:String = "";

		//override public function set armors
		override public function set armorValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorValue.");
		}

		override public function set armorName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorName.");
		}

		override public function set armorDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorDef.");
		}

		override public function set armorMDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorMDef.");
		}

		override public function set armorPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorPerk.");
		}

		//override public function set weapons
		override public function set weaponName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponName.");
		}

		override public function set weaponVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponVerb.");
		}

		override public function set weaponAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponAttack.");
		}

		override public function set weaponPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponPerk.");
		}

		override public function set weaponValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponValue.");
		}

		//override public function set weapons range
		override public function set weaponRangeName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeName.");
		}

		override public function set weaponRangeVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeVerb.");
		}

		override public function set weaponRangeAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeAttack.");
		}

		override public function set weaponRangePerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangePerk.");
		}

		override public function set weaponRangeValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeValue.");
		}

		//override public function set misc jewelries
		override public function set miscjewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryName.");
		}

		override public function set miscjewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryEffectId.");
		}

		override public function set miscjewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryEffectMagnitude.");
		}

		override public function set miscjewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryPerk.");
		}

		override public function set miscjewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryValue.");
		}
		override public function set miscjewelryName2(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryName2.");
		}

		override public function set miscjewelryEffectId2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryEffectId2.");
		}

		override public function set miscjewelryEffectMagnitude2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryEffectMagnitude2.");
		}

		override public function set miscjewelryPerk2(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryPerk2.");
		}

		override public function set miscjewelryValue2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.miscjewelryValue2.");
		}

		//override public function set head jewelries
		override public function set headjewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryName.");
		}

		override public function set headjewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryEffectId.");
		}

		override public function set headjewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryEffectMagnitude.");
		}

		override public function set headjewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryPerk.");
		}

		override public function set headjewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryValue.");
		}

		//override public function set necklaces
		override public function set necklaceName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceName.");
		}

		override public function set necklaceEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceEffectId.");
		}

		override public function set necklaceEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceEffectMagnitude.");
		}

		override public function set necklacePerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklacePerk.");
		}

		override public function set necklaceValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceValue.");
		}

		//override public function set jewelries
		override public function set jewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryName.");
		}

		override public function set jewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectId.");
		}

		override public function set jewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectMagnitude.");
		}

		override public function set jewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryPerk.");
		}

		override public function set jewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryValue.");
		}
		override public function set jewelryName2(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryName2.");
		}

		override public function set jewelryEffectId2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectId2.");
		}

		override public function set jewelryEffectMagnitude2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectMagnitude2.");
		}

		override public function set jewelryPerk2(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryPerk2.");
		}

		override public function set jewelryValue2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryValue2.");
		}

		//override public function set shields
		override public function set shieldName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldName.");
		}

		override public function set shieldBlock(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldBlock.");
		}

		override public function set shieldPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldPerk.");
		}

		override public function set shieldValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldValue.");
		}

		//override public function set undergarments
		override public function set upperGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentName.");
		}

		override public function set upperGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentPerk.");
		}

		override public function set upperGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentValue.");
		}

		override public function set lowerGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentName.");
		}

		override public function set lowerGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentPerk.");
		}

		override public function set lowerGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentValue.");
		}

		//override public function set vehicles
		override public function set vehiclesName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesName.");
		}

		override public function set vehiclesEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesEffectId.");
		}

		override public function set vehiclesEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesEffectMagnitude.");
		}

		override public function set vehiclesPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesPerk.");
		}

		override public function set vehiclesValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesValue.");
		}


		public function get modArmorName():String
		{
			if (_modArmorName == null) _modArmorName = "";
			return _modArmorName;
		}

		public function set modArmorName(value:String):void {
			if (value == null) value = "";
			_modArmorName = value;
		}
		public function isWearingArmor():Boolean {
			return armor != ArmorLib.COMFORTABLE_UNDERCLOTHES && armor != ArmorLib.NOTHING;
		}
		public function isStancing():Boolean {
			return (lowerBody == LowerBody.DRAGON && arms.type == Arms.DRACONIC) || (lowerBody == LowerBody.HINEZUMI && arms.type == Arms.HINEZUMI) || isFeralStancing() || isSitStancing();
		}
		public function isSitStancing():Boolean {
			return (lowerBody == LowerBody.LION && arms.type == Arms.LION);
		}
		public function isFeralStancing():Boolean {
			return (lowerBody == LowerBody.WOLF && arms.type == Arms.WOLF) || (lowerBody == LowerBody.LION && arms.type == Arms.DISPLACER);
		}
		public function isGargoyleStancing():Boolean {
			return (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2) && (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2);
		}
		//Natural Armor (need at least to partialy covering whole body)
		public function haveNaturalArmor():Boolean
		{
			return hasPerk(PerkLib.ThickSkin) || skin.hasFur() || skin.hasChitin() || skin.hasScales() || skin.hasBark() || skin.hasDragonScales() || skin.hasBaseOnly(Skin.STONE);
		}
		//Unhindered related acceptable armor types
		public function meetUnhinderedReq():Boolean
		{
			return armor.hasTag(ItemTags.AGILE);
		}
		//override public function get armors
		override public function get armorName():String {
			if (_modArmorName.length > 0) return modArmorName;
			else if (_armor.name == "nothing" && lowerGarmentName != "nothing") return lowerGarmentName;
			else if (_armor.name == "nothing" && lowerGarmentName == "nothing") return "gear";
			return _armor.name;
		}
		override public function get armorDef():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var armorDef:Number = super.armorDef;
			armorDef += _armor.def;
			armorDef += upperGarment.armorDef;
			armorDef += lowerGarment.armorDef;
			var tier:int;
			//Blacksmith history!
			if (armorDef > 0 && (hasPerk(PerkLib.HistorySmith) || hasPerk(PerkLib.PastLifeSmith))) {
				var smithPBonus:Number = 1.05;
				if (hasPerk(PerkLib.Tongs)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Bellows)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Furnace)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Hammer)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Anvil)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Weap0n)) smithPBonus += 0.05;
				if (hasPerk(PerkLib.Arm0r)) smithPBonus += 0.05;
				armorDef = Math.round(armorDef * smithPBonus);
				armorDef += 1;
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) {
				armorDef = Math.round(armorDef * (1 + (statusEffectv2(StatusEffects.KonstantinArmorPolishing) / 100)));
				armorDef += 1;
			}
			//Skin armor perk
			if (hasPerk(PerkLib.ThickSkin)) {
				armorDef += (2 * newGamePlusMod);
			}
			//Stacks on top of Thick Skin perk.
			var p:Boolean = skin.isCoverLowMid();
			if (skin.hasFur()) armorDef += (p?1:2) * newGamePlusMod;
			if (hasGooSkin() && skinAdj == "slimy") armorDef += (2 * newGamePlusMod);
			if (skin.hasChitin()) armorDef += (p?2:4)*newGamePlusMod;
			if (skin.hasScales()) armorDef += (p?3:6)*newGamePlusMod; //bee-morph (), mantis-morph (), scorpion-morph (wpisane), spider-morph (wpisane)
			if (skin.hasBark() || skin.hasDragonScales()) armorDef += (p?4:8)*newGamePlusMod;
			if (skin.hasBaseOnly(Skin.STONE)) armorDef += (10 * newGamePlusMod);
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorDef += (1 * newGamePlusMod);
			//Bonus defense
			if (arms.type == Arms.YETI) armorDef += (1 * newGamePlusMod);
			if (arms.type == Arms.SPIDER || arms.type == Arms.MANTIS || arms.type == Arms.BEE || arms.type == Arms.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (arms.type == Arms.DRACONIC || arms.type == Arms.JABBERWOCKY || arms.type == Arms.FROSTWYRM || arms.type == Arms.SEA_DRAGON) armorDef += (3 * newGamePlusMod);
			if (arms.type == Arms.HYDRA) armorDef += (4 * newGamePlusMod);
			if (tailType == Tail.SPIDER_ADBOMEN || tailType == Tail.MANTIS_ABDOMEN || tailType == Tail.BEE_ABDOMEN) armorDef += (2 * newGamePlusMod);
			if (tailType == Tail.DRACONIC) armorDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.FROSTWYRM) armorDef += (6 * newGamePlusMod);
			if (lowerBody == LowerBody.YETI) armorDef += (1 * newGamePlusMod);
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || lowerBody == LowerBody.BEE || lowerBody == LowerBody.MANTIS || lowerBody == LowerBody.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.DRAGON || lowerBody == LowerBody.JABBERWOCKY || lowerBody == LowerBody.SEA_DRAGON) armorDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.DRIDER || lowerBody == LowerBody.HYDRA) armorDef += (4 * newGamePlusMod);
			if (rearBody.type == RearBody.YETI_FUR) armorDef += (4 * newGamePlusMod);
			if (hasPerk(PerkLib.Lycanthropy)) armorDef += 10 * newGamePlusMod;
			if (isGargoyle() && Forgefather.material == "granite")
			{
				if (Forgefather.refinement == 1) armorDef *= (1.15);
				if (Forgefather.refinement == 2) armorDef *= (1.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) armorDef *= (1.5);
				if (Forgefather.refinement == 5) armorDef *= (2);
			}
			//if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
				//if (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2) armorDef += (30 * newGamePlusMod);
				//if (tailType == Tail.GARGOYLE || tailType == Tail.GARGOYLE_2) armorDef += (30 * newGamePlusMod);
				//if (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2) armorDef += (30 * newGamePlusMod);
				//if (wings.type == Wings.GARGOYLE_LIKE_LARGE) armorDef += (30 * newGamePlusMod);
				//if (faceType == Face.DEVIL_FANGS) armorDef += (30 * newGamePlusMod);
			//}
			//if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) armorDef += (25 * newGamePlusMod);
			//Soul Cultivators bonuses
			if (hasPerk(PerkLib.BodyCultivator)) {
				armorDef += (1 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.FleshBodyApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) armorDef += 2 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulPersonage)) armorDef += 2 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulWarrior)) armorDef += 2 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) armorDef += 4 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulScholar)) armorDef += 4 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulElder)) armorDef += 4 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) armorDef += 6 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulOverlord)) armorDef += 6 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulTyrant)) armorDef += 6 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulKing)) armorDef += 8 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulEmperor)) armorDef += 8 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulAncestor)) armorDef += 8 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) armorDef += 6 * newGamePlusMod;
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) armorDef += 9 * newGamePlusMod;
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) armorDef += 12 * newGamePlusMod;
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) armorDef += 15 * newGamePlusMod;
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if (hasPerk(PerkLib.Agility)) {
				if (armorPerk == "Light" || _armor.name == "nothing" || _armor.name == "some taur paladin armor" || _armor.name == "some taur blackguard armor") {
					speedBonus += Math.round(spe / 10);
				}
				else if (armorPerk == "Medium") {
					speedBonus += Math.round(spe / 25);
				}
			}
			if (hasPerk(PerkLib.ArmorMaster)) {
				if (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor") speedBonus += Math.round(spe / 50);
			}
			armorDef += speedBonus;
			//Feral armor boosts armor ratings!
			var toughnessBonus:int = 0;
			if (hasPerk(PerkLib.FeralArmor) && haveNaturalArmor() && armor.hasTag(ItemTags.AGILE)) {
				toughnessBonus += Math.round(tou / 20);
			}
			if (perkv1(IMutationsLib.NukiNutsIM) >= 1) {
				toughnessBonus += Math.round(ballSize);
			}
			if (perkv1(IMutationsLib.NukiNutsIM) >= 2) {
				toughnessBonus += Math.round(ballSize);
			}
			if (perkv1(IMutationsLib.NukiNutsIM) >= 3) {
				toughnessBonus += Math.round(ballSize);
			}
			armorDef += toughnessBonus;
			if (hasPerk(PerkLib.PrestigeJobSentinel) && (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor")) armorDef += _armor.def;
			if (hasPerk(PerkLib.ShieldExpertise) && shieldName != "nothing" && isShieldsForShieldBash()) {
				if (shieldBlock >= 4) armorDef += Math.round(shieldBlock * 0.25);
				else armorDef += 1;
			}
			//Acupuncture effect
			if (hasPerk(PerkLib.ChiReflowDefense)) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (hasPerk(PerkLib.ChiReflowAttack)) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;
			//Other bonuses
			if (hasPerk(PerkLib.ToughHide) && haveNaturalArmor()) armorDef += (2 * newGamePlusMod);
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 1) armorDef += (1 * newGamePlusMod);
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 2) armorDef += (2 * newGamePlusMod);
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 3) armorDef += (12 * newGamePlusMod);
			if (hasPerk(PerkLib.GoblinoidBlood)) {
				var goblinbracerBonus:int = 0;
				if (hasKeyItem("Powboy") >= 0) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (10 * newGamePlusMod)) goblinbracerBonus = (10 * newGamePlusMod);
				}
				if (hasKeyItem("M.G.S. bracer") >= 0) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (20 * newGamePlusMod)) goblinbracerBonus = (20 * newGamePlusMod);
				}
				armorDef += goblinbracerBonus;
			}
			if (headjewelryName == "Kabuto & Mempo set") {
				armorDef += 3;
				if (armorName == "samurai armor") armorDef += 4;
			}
			if (headjewelryName == "HB helmet") armorDef += 5;
			if (vehiclesName == "Goblin Mech Alpha") {
				armorDef += 10;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorDef += 5;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorDef += 10;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorDef += 15;
			}
			if (vehiclesName == "Goblin Mech Prime") {
				armorDef += 20;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorDef += 10;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorDef += 20;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorDef += 30;
			}
			if (vehiclesName == "Giant Slayer Mech") {
				armorDef += 20;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorDef += 40;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorDef += 60;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorDef += 80;
			}
			if (vehiclesName == "Howling Banshee Mech") {
				armorDef += 15;
				if (hasKeyItem("HB Armor Plating") >= 0) {
					if (keyItemvX("HB Armor Plating", 1) == 1) armorDef += 15;
					if (keyItemvX("HB Armor Plating", 1) == 2) armorDef += 25;
					if (keyItemvX("HB Armor Plating", 1) == 3) armorDef += 35;
					if (keyItemvX("HB Armor Plating", 1) == 4) armorDef += 45;
				}
			}
			armorDef = Math.round(armorDef);
			//Berzerking removes armor
			if (hasStatusEffect(StatusEffects.Berzerking) && !hasPerk(PerkLib.ColdFury)) armorDef = 0;
			if (hasStatusEffect(StatusEffects.ChargeArmor) && (!isNaked() || (isNaked() && haveNaturalArmor() && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)))) armorDef += Math.round(statusEffectv1(StatusEffects.ChargeArmor));
			if (hasStatusEffect(StatusEffects.CompBoostingPCArmorValue)) armorDef += (level * newGamePlusMod);
			if (hasStatusEffect(StatusEffects.StoneSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.StoneSkin));
			if (hasStatusEffect(StatusEffects.BarkSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.BarkSkin));
			if (hasStatusEffect(StatusEffects.MetalSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.MetalSkin));
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				armorDef -= CoC.instance.monster.statusEffectv1(StatusEffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				if (jewelryName == "Flame Lizard ring" || jewelryName2 == "Flame Lizard ring" || jewelryName3 == "Flame Lizard ring" || jewelryName4 == "Flame Lizard ring") armorDef = Math.round(armorDef * 1.15);
				else armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			if (statStore.hasBuff("CrinosShape") && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			armorDef = Math.round(armorDef);
			return armorDef;
		}
		override public function get armorMDef():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var armorMDef:Number = super.armorMDef;
			armorMDef = _armor.mdef;
			armorMDef += upperGarment.armorMDef;
			armorMDef += lowerGarment.armorMDef;
			//Blacksmith history!
			if (armorDef > 0 && (hasPerk(PerkLib.HistorySmith) || hasPerk(PerkLib.PastLifeSmith))) {
				var smithMBonus:Number = 1.05;
				if (hasPerk(PerkLib.Tongs)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Bellows)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Furnace)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Hammer)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Anvil)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Weap0n)) smithMBonus += 0.05;
				if (hasPerk(PerkLib.Arm0r)) smithMBonus += 0.05;
				armorMDef = Math.round(armorMDef * smithMBonus);
				armorMDef += 1;
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) {
				armorMDef = Math.round(armorMDef * (1 + (statusEffectv2(StatusEffects.KonstantinArmorPolishing) / 100)));
				armorMDef += 1;
			}
			//Skin armor perk
			if (hasPerk(PerkLib.ThickSkin)) {
				armorMDef += (1 * newGamePlusMod);
			}
			//Stacks on top of Thick Skin perk.
			var p:Boolean = skin.isCoverLowMid();
			if (skin.hasFur()) armorMDef += (p?1:2)*newGamePlusMod;
			if (hasGooSkin() && skinAdj == "slimy") armorMDef += (2 * newGamePlusMod);
			if (skin.hasChitin()) armorMDef += (p?2:4)*newGamePlusMod;
			if (skin.hasScales()) armorMDef += (p?3:6)*newGamePlusMod; //bee-morph (), mantis-morph (), scorpion-morph (wpisane), spider-morph (wpisane)
			if (skin.hasBark() || skin.hasDragonScales()) armorMDef += (p?4:8)*newGamePlusMod;
			if (skin.hasBaseOnly(Skin.STONE)) armorMDef += (10 * newGamePlusMod);/*
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorMDef += (1 * newGamePlusMod);/*
			*/
			
			//Bonus defense
			if (arms.type == Arms.YETI) armorMDef += (1 * newGamePlusMod);
			if (arms.type == Arms.SPIDER || arms.type == Arms.MANTIS || arms.type == Arms.BEE || arms.type == Arms.SALAMANDER) armorMDef += (2 * newGamePlusMod);
			if (arms.type == Arms.DRACONIC || arms.type == Arms.FROSTWYRM) armorMDef += (3 * newGamePlusMod);
			if (arms.type == Arms.HYDRA) armorMDef += (4 * newGamePlusMod);
			if (tailType == Tail.SPIDER_ADBOMEN || tailType == Tail.MANTIS_ABDOMEN || tailType == Tail.BEE_ABDOMEN) armorMDef += (2 * newGamePlusMod);
			if (tailType == Tail.DRACONIC) armorMDef += (3 * newGamePlusMod);
			if (tailType == LowerBody.FROSTWYRM) armorMDef += (6 * newGamePlusMod);
			if (lowerBody == LowerBody.YETI) armorMDef += (1 * newGamePlusMod);
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || lowerBody == LowerBody.BEE || lowerBody == LowerBody.MANTIS || lowerBody == LowerBody.SALAMANDER) armorMDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.DRAGON) armorMDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.DRIDER) armorMDef += (4 * newGamePlusMod);
			//if (hasPerk(PerkLib.Vulpesthropy)) armorMDef += 10 * newGamePlusMod;
			if (isGargoyle() && Forgefather.material == "alabaster")
			{
				if (Forgefather.refinement == 1) armorMDef *= (1.15);
				if (Forgefather.refinement == 2) armorMDef *= (1.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) armorMDef *= (1.5);
				if (Forgefather.refinement == 5) armorMDef *= (2);
			}
			//if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) armorMDef += (25 * newGamePlusMod);
			//if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
				//if (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2) armorMDef += (30 * newGamePlusMod);
				//if (tailType == Tail.GARGOYLE || tailType == Tail.GARGOYLE_2) armorMDef += (30 * newGamePlusMod);
				//if (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2) armorMDef += (30 * newGamePlusMod);
				//if (wings.type == Wings.GARGOYLE_LIKE_LARGE) armorMDef += (30 * newGamePlusMod);
				//if (faceType == Face.DEVIL_FANGS) armorMDef += (30 * newGamePlusMod);
			//}
			//Soul Cultivators bonuses
			if (hasPerk(PerkLib.FleshBodyApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) armorMDef += 1 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulPersonage)) armorMDef += 1 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulWarrior)) armorMDef += 1 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) armorMDef += 3 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulScholar)) armorMDef += 3 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulElder)) armorMDef += 3 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) armorMDef += 5 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulOverlord)) armorMDef += 5 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulTyrant)) armorMDef += 5 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulKing)) armorMDef += 7 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulEmperor)) armorMDef += 7 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulAncestor)) armorMDef += 7 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) armorMDef += 4 * newGamePlusMod;
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) armorMDef += 6 * newGamePlusMod;
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) armorMDef += 8 * newGamePlusMod;
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) armorMDef += 10 * newGamePlusMod;/*
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if (hasPerk(PerkLib.Agility)) {
				if (armorPerk == "Light" || _armor.name == "nothing") {
					speedBonus += Math.round(spe / 10);
				}
				else if (armorPerk == "Medium") {
					speedBonus += Math.round(spe / 25);
				}
			}
			if (hasPerk(PerkLib.ArmorMaster)) {
				if (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor") speedBonus += Math.round(spe / 50);
			}
			armorDef += speedBonus;
			//Feral armor boosts armor ratings!
			var toughnessBonus:int = 0;
			if (hasPerk(PerkLib.FeralArmor) && haveNaturalArmor() && meetUnhinderedReq()) {
				toughnessBonus += Math.round(tou / 20);
			}
			armorDef += toughnessBonus;
			if (hasPerk(PerkLib.PrestigeJobSentinel) && (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor")) armorDef += _armor.def;
			if (hasPerk(PerkLib.ShieldExpertise) && shieldName != "nothing") {
				if (shieldBlock >= 4) armorDef += Math.round(shieldBlock);
				else armorDef += 1;
			}
			//Acupuncture effect
			if (hasPerk(PerkLib.ChiReflowDefense)) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (hasPerk(PerkLib.ChiReflowAttack)) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;*/
			//Other bonuses
			if (hasPerk(PerkLib.ToughHide) && haveNaturalArmor()) armorMDef += (1 * newGamePlusMod);
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 1) armorMDef += (1 * newGamePlusMod);
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 2) armorMDef += (2 * newGamePlusMod);
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 3) armorMDef += (12 * newGamePlusMod);
			if (hasPerk(PerkLib.GoblinoidBlood)) {
				var goblinbracerBonus:int = 0;
				if (hasKeyItem("Powboy") >= 0) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (10 * newGamePlusMod)) goblinbracerBonus = (10 * newGamePlusMod);
				}
				if (hasKeyItem("M.G.S. bracer") >= 0) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (20 * newGamePlusMod)) goblinbracerBonus = (20 * newGamePlusMod);
				}
				armorMDef += goblinbracerBonus;
			}
			if (headjewelryName == "HB helmet") armorMDef += 4;
			if (vehiclesName == "Goblin Mech Alpha") {
				armorMDef += 10;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorMDef += 5;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorMDef += 10;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorMDef += 15;
			}
			if (vehiclesName == "Goblin Mech Prime") {
				armorMDef += 20;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorMDef += 10;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorMDef += 20;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorMDef += 30;
			}
			if (vehiclesName == "Giant Slayer Mech") {
				armorMDef += 20;
				if (hasKeyItem("Upgraded Leather Insulation 1.0") >= 0) armorMDef += 40;
				if (hasKeyItem("Upgraded Leather Insulation 2.0") >= 0) armorMDef += 60;
				if (hasKeyItem("Upgraded Leather Insulation 3.0") >= 0) armorMDef += 80;
			}
			if (vehiclesName == "Howling Banshee Mech") {
				armorMDef += 15;
				if (hasKeyItem("HB Leather Insulation") >= 0) {
					if (keyItemvX("HB Leather Insulation", 2) == 1) armorMDef += 15;
					if (keyItemvX("HB Leather Insulation", 2) == 2) armorMDef += 25;
					if (keyItemvX("HB Leather Insulation", 2) == 3) armorMDef += 35;
					if (keyItemvX("HB Leather Insulation", 2) == 4) armorMDef += 45;
				}
			}
			armorMDef = Math.round(armorMDef);
			//Berzerking/Lustzerking removes magic resistance
			if (hasStatusEffect(StatusEffects.Berzerking) && !hasPerk(PerkLib.ColderFury)) armorMDef = 0;
			if (hasStatusEffect(StatusEffects.Lustzerking) && !hasPerk(PerkLib.ColderLust)) armorMDef = 0;
			//if (hasStatusEffect(StatusEffects.ChargeArmor) && (!isNaked() || (isNaked() && haveNaturalArmor() && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)))) armorDef += Math.round(statusEffectv1(StatusEffects.ChargeArmor));
			if (hasStatusEffect(StatusEffects.StoneSkin)) armorMDef += Math.round(statusEffectv1(StatusEffects.StoneSkin));
			if (hasStatusEffect(StatusEffects.BarkSkin)) armorMDef += Math.round(statusEffectv1(StatusEffects.BarkSkin));
			if (hasStatusEffect(StatusEffects.MetalSkin)) armorMDef += Math.round(statusEffectv1(StatusEffects.MetalSkin));/*
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				armorDef -= CoC.instance.monster.statusEffectv1(StatusEffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.CrinosShape) && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}*/
			armorMDef = Math.round(armorMDef);
			return armorMDef;
		}
		public function get armorBaseDef():Number {
			return _armor.def;
		}
		override public function get armorPerk():String {
			return _armor.perk;
		}
		override public function get armorValue():Number {
			return _armor.value;
		}
		//Wing Slap compatibile wings + tiers of wings for dmg multi
		public function haveWingsForWingSlap():Boolean
		{
			return Arms.Types[arms.type].wingSlap || Wings.Types[wings.type].wingSlap;
		}
		public function thirdtierWingsForWingSlap():Boolean
		{
			return wings.type == Wings.BAT_LIKE_LARGE_2 || wings.type == Wings.DRACONIC_HUGE;
		}
		//Natural Claws (arm types and weapons that can substitude them)
		public function haveNaturalClaws():Boolean { return Arms.Types[arms.type].claw || Arms.Types[arms.type].armSlam || Arms.Types[arms.type].scythe || LowerBody.hasClaws(this);}
		public function haveNaturalClawsTypeWeapon():Boolean {return weaponName == "gauntlet with claws" || weaponName == "gauntlet with an aphrodisiac-coated claws" || weaponName == "Venoclaw" || weaponName == "hooked gauntlets" || (shield == game.shields.AETHERS && weapon == game.weapons.AETHERD && (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Gaunlets" || AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets"));}
		//Other natural weapon checks
		public function hasABiteAttack():Boolean { return (lowerBody == LowerBody.HYDRA || Face.Types[faceType].bite);}
		public function hasAWingAttack():Boolean { return (Wings.Types[wings.type].wingSlap || wings.type == Wings.THUNDEROUS_AURA || wings.type == Wings.WINDY_AURA);}
		public function hasAGoreAttack():Boolean { return (Horns.Types[horns.type].gore);}
		public function hasATailSlapAttack():Boolean { return (Tail.Types[tail.type].tailSlam || Tail.Types[tail.type].stinger || Tail.Types[tail.type].Energy || LowerBody.canTailSlam(this));}
		public function hasTalonsAttack():Boolean{return LowerBody.hasTalons(this);}
		public function hasTentacleAttacks():Boolean{return LowerBody.hasTentacles(this) || hasPerk(PerkLib.MorphicWeaponry);}
		public function hasNaturalWeapons():Boolean { return (haveNaturalClaws() || hasABiteAttack() || hasAWingAttack() || hasAGoreAttack() || hasATailSlapAttack() || hasTalonsAttack || hasTentacleAttacks || isAlraune() || isTaur());}
		//Some other checks
		public function isGoblinoid():Boolean { return (isRace(Races.GOBLIN) || isRace(Races.GREMLIN)); }
		public function isSlime():Boolean { return (hasPerk(PerkLib.DarkSlimeCore) || hasPerk(PerkLib.SlimeCore)); }
		public function isHarpy():Boolean { return (isRace(Races.HARPY) || isRace(Races.THUNDERBIRD) || isRace(Races.PHOENIX)); }
		public function isWerewolf():Boolean { return isRace(Races.WEREWOLF); }
		public function isNightCreature():Boolean { return (isRace(Races.VAMPIRE) || isRace(Races.BAT) || isRace(Races.JIANGSHI)); }
		public function hasDarkVision():Boolean { return (Eyes.Types[eyes.type].Darkvision); }
		public function isHavingEnhancedHearing():Boolean { return (ears.type == Ears.ELVEN); }
		//Weapons for Whirlwind
		public function isWeaponForWhirlwind():Boolean
		{
			return isSwordTypeWeapon() || isAxeTypeWeapon() || weaponSpecials("Whirlwind");// || weapon == game.weapons.
		}
		//Weapons for Whipping
		public function isWeaponsForWhipping():Boolean
		{
			return weaponSpecials("Whipping");
		}
		//1H Weapons
		public function isOneHandedWeapons():Boolean
		{
			return (!weaponSpecials("Dual Large") && !weaponSpecials("Dual") && !weaponSpecials("Dual Small") &&!weaponSpecials("Staff") && !weaponSpecials("Large") && !weaponSpecials("Massive") && weapon != game.weapons.DAISHO);
		}
		//Non Large/Massive weapons
		public function isNoLargeNoStaffWeapon():Boolean
		{
			return (!weaponSpecials("Dual Large") && !weaponSpecials("Large") && !weaponSpecials("Massive") && !isStaffTypeWeapon());
		}
		//Wrath Weapons
		public function isLowGradeWrathWeapon():Boolean
		{
			return weaponSpecials("LGWrath") || weaponRange == game.weaponsrange.B_F_BOW || AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets";
		}
		public function isDualLowGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.DBFSWO || weapon == game.weapons.ANGSTD || weapon == game.weapons.DBFWHIP;
		}/*
		public function isMidGradeWrathWeapon():Boolean
		{
			return weaponSpecials("MGWrath") || weapon == game.weapons.NTWHIP;
		}*/
		public function isDualMidGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.ASTERIUS;
		}/*
		public function isHighGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.CNTWHIP;
		}
		public function isDualHighGradeWrathWeapon():Boolean
		{
			return ;
		}*/
		//Free off-hand for spellcasting and etc.
		public function isHavingFreeOffHand():Boolean
		{
			return !isShieldsForShieldBash() && shield != game.shields.BATTNET && shield != game.shields.Y_U_PAN;
		}
		public function isNotHavingShieldCuzPerksNotWorkingOtherwise():Boolean
		{
			return shield == ShieldLib.NOTHING || shield == game.shields.AETHERS;
		}

		//weaponType check. Make sure weapon has the type filled in. Currently, Type is the last parameter in Weapon().
		//Fists and fist weapons
		public function isFistOrFistWeapon():Boolean {
			return weaponName == "fists" || isGauntletWeapon();
		}
		public function isGauntletWeapon():Boolean {
			return (weaponClass("Gauntlet")) || (shield == game.shields.AETHERS && weapon == game.weapons.AETHERD && (AetherTwinsFollowers.AetherTwinsShape == "" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Gaunlets" || AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets"));
		}
		//Sword-type weapons
		public function isSwordTypeWeapon():Boolean {
			return (weaponClass("Sword"));
		}
		//Axe-type weapons
		public function isAxeTypeWeapon():Boolean {
			return (weaponClass("Axe"));
		}
		//Mace/Hammer-type weapons
		public function isMaceHammerTypeWeapon():Boolean {
			return (weaponClass("Mace/Hammer"));
		}
		public function isTetsubo():Boolean {
			return (weaponClass("Tetsubo"));
		}
		//Dueling sword-type weapons (rapier & katana)
		public function isDuelingTypeWeapon():Boolean {
			return (weaponClass("Dueling"));
		}
		//Polearm-type
		public function isPolearmTypeWeapon():Boolean {
			return (weaponClass("Polearm"));
		}
		//Spear-type
		public function isSpearTypeWeapon():Boolean {
			return (weaponClass("Spear")) || weapon == game.weapons.SKYPIER;
		}
		//Scythe-type
		public function isScytheTypeWeapon():Boolean {
			return (weaponClass("Scythe"));
		}
		//Dagger-type weapons
		public function isDaggerTypeWeapon():Boolean {
			return (weaponClass("Dagger"));
		}
		//Staff <<SCECOMM(scepter not staff)>>
		public function isStaffTypeWeapon():Boolean {
			return (weaponClass("Staff")) || weapon == game.weapons.ASCENSU || weapon == game.weapons.B_STAFF || weapon == game.weapons.DEPRAVA || weapon == game.weapons.PURITAS || weapon == game.weapons.WDSTAFF;
		}
		//Whip-type weapons
		public function isWhipTypeWeapon():Boolean {
			return (weaponClass("Whip"));
		}
		//Ribbon-type weapons
		public function isRibbonTypeWeapon():Boolean {
			return (weaponClass("Ribbon"));
		}
		//Exotic-type weapons
		public function isExoticTypeWeapon():Boolean {
			return isRibbonTypeWeapon() || (weaponClass("Exotic"));
		}
		//Partial staff type weapons
		public function isPartiallyStaffTypeWeapon():Boolean {
			return (weaponClass("StaffPart")) || weapon == game.weapons.DEMSCYT || weapon == game.weapons.LHSCYTH;// || weapon == game.weapons.E_STAFF || weapon == game.weapons.L_STAFF || weapon == game.weapons.N_STAFF || weapon == game.weapons.U_STAFF || weapon == game.weapons.W_STAFF || weapon == game.weapons.WDSTAFF
		}
		//Weapons for Sneak Attack (Meele and Range)
		public function haveWeaponForSneakAttack():Boolean
		{
			return weaponSpecials("Small") || weaponSpecials("Dual Small");
		}
		public function haveWeaponForSneakAttackRange():Boolean
		{
			return weaponRangePerk == "Bow" || weaponRange == game.weaponsrange.M1CERBE || weaponRange == game.weaponsrange.SNIPPLE;
		}
		//(dla Sword Immortal gra musi sprawdzić czy używa Sword type lub Dueling sword type weapons bo tak)
		//Throwable melee weapons
		public function haveThrowableMeleeWeapon():Boolean
		{
			return (weaponClass("Thrown"));//wrath large weapon that can be throwed or used in melee xD
		}
		//Cleave compatibile weapons
		public function haveWeaponForCleave():Boolean
		{
			return isAxeTypeWeapon() || isSwordTypeWeapon() || isDuelingTypeWeapon();
		}
		//No multishoot firearms
		public function noMultishootFirearms():Boolean
		{
			return weaponRange == game.weaponsrange.TRFATBI;//weaponRange == game.weaponsrange.TRFATBI ||
		}
		//Is in Ayo armor
		public function isInAyoArmor():Boolean
		{
			return armorPerk == "Light Ayo" || armorPerk == "Heavy Ayo" || armorPerk == "Ultra Heavy Ayo";
		}
		//Is in goblin mech
		public function isInGoblinMech():Boolean
		{
			return vehicles == game.vehicles.GOBMALP || vehicles == game.vehicles.GOBMPRI || vehicles == game.vehicles.GS_MECH;
		}
		//Is using goblin mech friendly firearms
		public function isUsingGoblinMechFriendlyFirearms():Boolean
		{
			return weaponRange == game.weaponsrange.ADBSCAT || weaponRange == game.weaponsrange.ADBSHOT || weaponRange == game.weaponsrange.BLUNDER || weaponRange == game.weaponsrange.DESEAGL || weaponRange == game.weaponsrange.DUEL_P_ || weaponRange == game.weaponsrange.FLINTLK || weaponRange == game.weaponsrange.HARPGUN || weaponRange == game.weaponsrange.IVIARG_
			 || weaponRange == game.weaponsrange.M1CERBE || weaponRange == game.weaponsrange.TOUHOM3 || weaponRange == game.weaponsrange.TWINGRA || weaponRange == game.weaponsrange.TDPISTO || weaponRange == game.weaponsrange.DPISTOL;
		}
		//Is in medium sized mech (med sized races mech)(have upgrade option to allow smaller than medium races pilot it)
		public function isInNonGoblinMech():Boolean
		{
			return vehicles == game.vehicles.HB_MECH;// || vehicles == game.vehicles.GOBMPRI
		}
		//Is using howling banshee mech friendly range weapons
		public function isUsingHowlingBansheeMechFriendlyRangeWeapons():Boolean
		{
			return weaponRangePerk == "Bow" || weaponRangePerk == "Crossbow";
		}
		//Is in ... mech (large sized races mech)(have upgrade option to allow smaller than large races pilot it)
		//Player have any party member with them
		public function companionsInPCParty():Boolean
		{
			return flags[kFLAGS.PLAYER_COMPANION_0] != "" || flags[kFLAGS.PLAYER_COMPANION_1] != "" || flags[kFLAGS.PLAYER_COMPANION_2] != "" || flags[kFLAGS.PLAYER_COMPANION_3] != "";
		}
		//PC can fly without natural wings
		public function canFlyNoWings():Boolean
		{
			return weaponFlyingSwordsName != "nothing" || hasPerk(PerkLib.GclassHeavenTribulationSurvivor);
		}
		//Flying swords related checks
		public function canFlyOnFlyingSwords():Boolean
		{
			return weaponFlyingSwordsPerk == "Large" || weaponFlyingSwordsPerk == "Large Two" || weaponFlyingSwordsPerk == "Massive";
		}
		public function usingSingleFlyingSword():Boolean
		{
			return weaponFlyingSwordsPerk == "Small" || weaponFlyingSwordsPerk == "Large" || weaponFlyingSwordsPerk == "Massive";
		}
		//Natural Jouster perks req check
		public function isMeetingNaturalJousterReq():Boolean
		{
			return (((isTaur() || isDrider() || canFly()) && spe >= 60) && hasPerk(PerkLib.Naturaljouster) && (!(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)))
             || (spe >= 150 && hasPerk(PerkLib.Naturaljouster) && hasPerk(PerkLib.DoubleAttack) && (!hasPerk(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)));
		}
		public function isMeetingNaturalJousterMasterGradeReq():Boolean
		{
			return (((isTaur() || isDrider() || canFly()) && spe >= 180) && hasPerk(PerkLib.NaturaljousterMastergrade) && (!hasPerk(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)))
             || (spe >= 450 && hasPerk(PerkLib.NaturaljousterMastergrade) && hasPerk(PerkLib.DoubleAttack) && (!hasPerk(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)));
		}
		public function haveWeaponForJouster():Boolean
		{
			return isSpearTypeWeapon();
		}
		public function playerIsBlinded():Boolean
		{
			return hasStatusEffect(StatusEffects.Blind) || hasStatusEffect(StatusEffects.Snowstorms);
		}
		public function playerHasFourArms():Boolean
		{
			return arms.type == Arms.DISPLACER;
		}
		//override public function get weapons
		override public function get weaponName():String {
			return _weapon.name;
		}
		override public function get weaponVerb():String {
			return _weapon.verb;
		}
		override public function get weaponAttack():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var attack:Number = _weapon.attack;
			if (hasPerk(PerkLib.JobSwordsman) && weaponSpecials("Large")) {
				if (hasPerk(PerkLib.WeaponMastery) && str >= 100) {
					if (hasPerk(PerkLib.WeaponGrandMastery) && str >= 140) attack *= 2;
					else attack *= 1.5;
				}
				else attack *= 1.25;
			}
			if (hasPerk(PerkLib.WeaponGrandMastery) && weaponSpecials("Dual Large") && str >= 140) {
				attack *= 2;
			}
			if (hasPerk(PerkLib.GigantGripEx) && weaponSpecials("Massive")) {
				if (hasPerk(PerkLib.WeaponMastery) && str >= 100) {
					if (hasPerk(PerkLib.WeaponGrandMastery) && str >= 140) attack *= 2;
					else attack *= 1.5;
				}
				else attack *= 1.25;
			}
			if (hasPerk(PerkLib.HiddenMomentum) && (weaponSpecials("Large") || (hasPerk(PerkLib.GigantGripEx) && weaponSpecials("Massive"))) && str >= 75 && spe >= 50) {
				attack += (((str + spe) - 100) * 0.2);
			}//30-70-110
			if (hasPerk(PerkLib.HiddenDualMomentum) && weaponSpecials("Dual Large") && str >= 150 && spe >= 100) {
				attack += (((str + spe) - 200) * 0.2);
			}//20-60-100
			if (hasPerk(PerkLib.LightningStrikes) && spe >= 60 && (!weaponSpecials("Massive") || !weaponSpecials("Large") || !weaponSpecials("Dual Large") || !weaponSpecials("Small") || !weaponSpecials("Dual Small") || !isFistOrFistWeapon())) {
				attack += ((spe - 50) * 0.3);
			}//45-105-165
			if (weaponSpecials("Hybrid") && shieldName == "nothing"){
				attack *= 1.5;
			}
			if (hasPerk(PerkLib.StarlightStrikes) && spe >= 60 && (weaponSpecials("Small") || weaponSpecials("Dual Small"))) {
				attack += ((spe - 50) * 0.2);
			}
			if (hasPerk(PerkLib.SteelImpact)) {
				attack += ((tou - 50) * 0.3);
			}
			if (isFistOrFistWeapon()) {
				if (hasPerk(PerkLib.IronFistsI) && str >= 50) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsII) && str >= 65) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsIII) && str >= 80) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsIV) && str >= 95) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsV) && str >= 110) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsVI) && str >= 125) {
					attack += 10;
				}
				if (hasPerk(PerkLib.JobBrawler) && str >= 60) {
					attack += (5 * newGamePlusMod);
				}
				if (hasPerk(PerkLib.MightyFist) && isFistOrFistWeapon()) {
					attack += (5 * newGamePlusMod);
				}
				if (SceneLib.combat.unarmedAttack()) {
					attack += SceneLib.combat.unarmedAttack();
				}
			}
			if (hasPerk(PerkLib.PrestigeJobTempest) && (weaponSpecials("Dual Small") || weaponSpecials("Dual") || weaponSpecials("Dual Large") || weapon == game.weapons.DAISHO)) {
				attack += (5 * newGamePlusMod);
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinWeaponSharpening) && weaponName != "fists") {
				attack *= 1 + (statusEffectv2(StatusEffects.KonstantinWeaponSharpening) / 100);
			}
			if (hasStatusEffect(StatusEffects.Berzerking) || hasStatusEffect(StatusEffects.Lustzerking)) {
				var zerkersboost:Number = 0;
				zerkersboost += (15 + (15 * newGamePlusMod));
				if (hasPerk(PerkLib.ColdFury) || hasPerk(PerkLib.ColdLust)) zerkersboost += (5 + (5 * newGamePlusMod));
				if (hasPerk(PerkLib.ColderFury) || hasPerk(PerkLib.ColderLust)) zerkersboost += (10 + (10 * newGamePlusMod));
				if (perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3) zerkersboost += (30 + (30 * newGamePlusMod));
				if (hasPerk(PerkLib.Lustzerker) && (jewelryName == "Flame Lizard ring" || jewelryName2 == "Flame Lizard ring" || jewelryName3 == "Flame Lizard ring" || jewelryName4 == "Flame Lizard ring")) zerkersboost += (5 + (5 * newGamePlusMod));
				if (hasPerk(PerkLib.BerserkerArmor)) zerkersboost += (5 + (5 * newGamePlusMod));
				if (hasStatusEffect(StatusEffects.Berzerking) && hasStatusEffect(StatusEffects.Lustzerking)) {
					if (hasPerk(PerkLib.ColderFury) || hasPerk(PerkLib.ColderLust)) zerkersboost *= 4;
					else if (hasPerk(PerkLib.ColderFury) || hasPerk(PerkLib.ColderLust)) zerkersboost *= 3;
					else zerkersboost *= 2.5;
				}
				attack += zerkersboost;
			}
			if (isGargoyle() && Forgefather.material == "ebony")
			{
				if (Forgefather.refinement == 1) attack *= (1.15);
				if (Forgefather.refinement == 2) attack *= (1.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) attack *= (1.5);
				if (Forgefather.refinement == 5) attack *= (2);
			}
			if (hasStatusEffect(StatusEffects.ChargeWeapon)) {
				if (weaponName == "fists" && !hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalWeapons)) attack += 0;
				else attack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
			}
			attack = Math.round(attack);
			return attack;
		}
		public function get weaponBaseAttack():Number {
			return _weapon.attack;
		}
		override public function get weaponPerk():String {
			return _weapon.perk || "";
		}
		override public function get weaponType():String {
			return _weapon.type || "";
		}
		override public function get weaponValue():Number {
			return _weapon.value;
		}
		//First arg is weapon type. Second is override, in case you want to check specific weapon.
		public function weaponClass(pWeaponClass:String = "", orWeaponCheck:* = null):Boolean {
			var temp:Array;
			if (orWeaponCheck != null){
				temp = orWeaponCheck.type.split(", ");
			}
			else{
				temp = weapon.type.split(", ");
			}
			return (temp.indexOf(pWeaponClass) >= 0);
		}
		public function weaponSpecials(pWeaponSpecials:String = "", orWeaponCheck:* = null):Boolean {
			var temp:Array;
			if (orWeaponCheck != null){
				temp = orWeaponCheck.perk.split(", ");
			}
			else{
				temp = weapon.perk.split(", ");
			}
			return (temp.indexOf(pWeaponSpecials) >= 0);
		}
		//Is DualWield
		public function isDualWield():Boolean
		{
			return weaponRangePerk == "Dual Firearms" || weaponSpecials("Dual Large") || weaponSpecials("Dual Small") || weaponSpecials("Dual");
		}
		//Artifacts Bows
		public function isArtifactBow():Boolean
		{
			return weaponRange == game.weaponsrange.BOWGUID || weaponRange == game.weaponsrange.BOWHODR;
		}
		//Is Bows
		public function isBowTypeWeapon():Boolean
		{
			return weaponRangePerk == "Bow";
		}
		//Is Thrown
		public function isThrownTypeWeapon():Boolean
		{
			return weaponRangePerk == "Throwing";
		}
		//Using Tome
		public function isUsingTome():Boolean
		{
			return weaponRangeName == "nothing" || weaponRangeName == "Inquisitor’s Tome" || weaponRangeName == "Sage’s Sketchbook";
		}
		//Using a spear DEPRECATED
		public function isUsingSpear():Boolean
		{
			return (weaponClass("Spear"));
		}
		//Using Staff
		public function isUsingStaff():Boolean
		{
			return isStaffTypeWeapon();
		}
		//Using Wand
		public function isUsingWand():Boolean
		{
			return weaponSpecials("Wand");
		}
		//override public function get weapons
		override public function get weaponRangeName():String {
			return _weaponRange.name;
		}
		override public function get weaponRangeVerb():String {
			return _weaponRange.verb;
		}
		override public function get weaponRangeAttack():Number {
			//var newGamePlusMod:int = this.newGamePlusMod()+1;
			var rangeattack:Number = _weaponRange.attack;
			if (hasPerk(PerkLib.PracticedShot) && str >= 60 && (weaponRangePerk == "Bow" || weaponRangePerk == "Crossbow" || weaponRangePerk == "Throwing")) {
				if (hasPerk(PerkLib.EagleEye)) rangeattack *= 2;
				else rangeattack *= 1.5;
			}
			if (hasPerk(PerkLib.Sharpshooter) && weaponRangePerk != "Bow") {
				if (inte < 201) rangeattack *= (1 + (inte / 200));
				else rangeattack *= 2;
			}
			if (isGargoyle() && Forgefather.material == "sandstone")
			{
				if (Forgefather.refinement == 1) rangeattack *= (1.15);
				if (Forgefather.refinement == 2) rangeattack *= (1.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) rangeattack *= (1.5);
				if (Forgefather.refinement == 5) rangeattack *= (2);
			}
		/*	if(hasPerk(PerkLib.LightningStrikes) && spe >= 60 && weaponRangePerk != "Large") {
				rangeattack += Math.round((spe - 50) / 3);
			}
			if(hasPerk(PerkLib.IronFistsI) && str >= 50 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.IronFistsII) && str >= 65 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.IronFistsIII) && str >= 80 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.IronFistsIV) && str >= 95 && weaponRangeName == "fists") {
			}
			if(arms.type == MANTIS && weaponRangeName == "fists") {
				rangeattack += (15 * newGamePlusMod);
			}
			if(hasStatusEffect(StatusEffects.Berzerking)) rangeattack += (30 + (15 * newGamePlusMod));
			if(hasStatusEffect(StatusEffects.Lustzerking)) rangeattack += (30 + (15 * newGamePlusMod));
			if(hasPerk(PerkLib.)) rangeattack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
		*/	if (hasStatusEffect(StatusEffects.ChargeWeapon) && !isUsingTome()) {
				rangeattack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
			}
			rangeattack = Math.round(rangeattack);
			return rangeattack;
		}
		public function get weaponRangeBaseAttack():Number {
			return _weaponRange.attack;
		}
		override public function get weaponRangePerk():String {
			return _weaponRange.perk || "";
		}
		override public function get weaponRangeValue():Number {
			return _weaponRange.value;
		}
		public function get ammo():int {
			return flags[kFLAGS.FLINTLOCK_PISTOL_AMMO];
		}
		public function set ammo(value:int):void {
			flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = value;
		}

		//override public function get weapons
		override public function get weaponFlyingSwordsName():String {
			return _weaponFlyingSwords.name;
		}
		override public function get weaponFlyingSwordsVerb():String {
			return _weaponFlyingSwords.verb;
		}
		override public function get weaponFlyingSwordsAttack():Number {
			//var newGamePlusMod:int = this.newGamePlusMod()+1;
			var flyingswordsattack:Number = _weaponFlyingSwords.attack;
			//flyingswordsattack = Math.round(flyingswordsattack);
			return flyingswordsattack;
		}
		public function get weaponFlyingSwordsBaseAttack():Number {
			return _weaponFlyingSwords.attack;
		}
		override public function get weaponFlyingSwordsPerk():String {
			return _weaponFlyingSwords.perk || "";
		}
		override public function get weaponFlyingSwordsValue():Number {
			return _weaponFlyingSwords.value;
		}

		//override public function get miscjewelries.
		override public function get miscjewelryName():String {
			return _miscjewelry.name;
		}
		override public function get miscjewelryEffectId():Number {
			return _miscjewelry.effectId;
		}
		override public function get miscjewelryEffectMagnitude():Number {
			return _miscjewelry.effectMagnitude;
		}
		override public function get miscjewelryPerk():String {
			return _miscjewelry.perk;
		}
		override public function get miscjewelryValue():Number {
			return _miscjewelry.value;
		}
		override public function get miscjewelryName2():String {
			return _miscjewelry2.name;
		}
		override public function get miscjewelryEffectId2():Number {
			return _miscjewelry2.effectId;
		}
		override public function get miscjewelryEffectMagnitude2():Number {
			return _miscjewelry2.effectMagnitude;
		}
		override public function get miscjewelryPerk2():String {
			return _miscjewelry2.perk;
		}
		override public function get miscjewelryValue2():Number {
			return _miscjewelry2.value;
		}

		//override public function get headjewelries.
		override public function get headjewelryName():String {
			return _headjewelry.name;
		}
		override public function get headjewelryEffectId():Number {
			return _headjewelry.effectId;
		}
		override public function get headjewelryEffectMagnitude():Number {
			return _headjewelry.effectMagnitude;
		}
		override public function get headjewelryPerk():String {
			return _headjewelry.perk;
		}
		override public function get headjewelryValue():Number {
			return _headjewelry.value;
		}

		//override public function get necklaces.
		override public function get necklaceName():String {
			return _necklace.name;
		}
		override public function get necklaceEffectId():Number {
			return _necklace.effectId;
		}
		override public function get necklaceEffectMagnitude():Number {
			return _necklace.effectMagnitude;
		}
		override public function get necklacePerk():String {
			return _necklace.perk;
		}
		override public function get necklaceValue():Number {
			return _necklace.value;
		}

		//override public function get jewelries.
		override public function get jewelryName():String {
			return _jewelry.name;
		}
		override public function get jewelryEffectId():Number {
			return _jewelry.effectId;
		}
		override public function get jewelryEffectMagnitude():Number {
			return _jewelry.effectMagnitude;
		}
		override public function get jewelryPerk():String {
			return _jewelry.perk;
		}
		override public function get jewelryValue():Number {
			return _jewelry.value;
		}
		override public function get jewelryName2():String {
			return _jewelry2.name;
		}
		override public function get jewelryEffectId2():Number {
			return _jewelry2.effectId;
		}
		override public function get jewelryEffectMagnitude2():Number {
			return _jewelry2.effectMagnitude;
		}
		override public function get jewelryPerk2():String {
			return _jewelry2.perk;
		}
		override public function get jewelryValue2():Number {
			return _jewelry2.value;
		}
		override public function get jewelryName3():String {
			return _jewelry3.name;
		}
		override public function get jewelryEffectId3():Number {
			return _jewelry3.effectId;
		}
		override public function get jewelryEffectMagnitude3():Number {
			return _jewelry3.effectMagnitude;
		}
		override public function get jewelryPerk3():String {
			return _jewelry3.perk;
		}
		override public function get jewelryValue3():Number {
			return _jewelry3.value;
		}
		override public function get jewelryName4():String {
			return _jewelry4.name;
		}
		override public function get jewelryEffectId4():Number {
			return _jewelry4.effectId;
		}
		override public function get jewelryEffectMagnitude4():Number {
			return _jewelry4.effectMagnitude;
		}
		override public function get jewelryPerk4():String {
			return _jewelry4.perk;
		}
		override public function get jewelryValue4():Number {
			return _jewelry4.value;
		}

		//override public function get vehicle.
		override public function get vehiclesName():String {
			return _vehicle.name;
		}
		override public function get vehiclesEffectId():Number {
			return _vehicle.effectId;
		}
		override public function get vehiclesEffectMagnitude():Number {
			return _vehicle.effectMagnitude;
		}
		override public function get vehiclesPerk():String {
			return _vehicle.perk;
		}
		override public function get vehiclesValue():Number {
			return _vehicle.value;
		}

		//Shields for Bash
		public function isShieldsForShieldBash():Boolean
		{
			return shield == game.shields.BSHIELD || shield == game.shields.BUCKLER || shield == game.shields.DRGNSHL || shield == game.shields.KITE_SH || shield == game.shields.TRASBUC || shield == game.shields.SPIL_SH || shield == game.shields.SANCTYN || shield == game.shields.SANCTYL || shield == game.shields.SANCTYD
			 || shieldPerk == "Large" || shieldPerk == "Massive" || (shield == game.shields.AETHERS && weapon == game.weapons.AETHERD && (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Gaunlets" || AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets"));
		}
		//override public function get shields
		override public function get shieldName():String {
			return _shield.name;
		}
		override public function get shieldBlock():Number {
			var block:Number = _shield.block;
			if (hasPerk(PerkLib.JobKnight)) {
				if (shieldPerk == "Massive") block += 3;
				else if (shieldPerk == "Large") block += 2;
				else block += 1;
			}
			if (shield == game.shields.AETHERS && weapon == game.weapons.AETHERD) {
				if (AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets") block += 4;
				else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Gaunlets") block += 2;
				block += 1;
			}
			if (hasPerk(PerkLib.PrestigeJobSentinel)) {
				if (shieldPerk == "Massive") block += 3;
				else if (shieldPerk == "Large") block += 2;
				else block += 1;
			}
			if (hasPerk(PerkLib.ShieldCombat)) {
				if (shieldPerk == "Massive") block += 6;
				else if (shieldPerk == "Large") block += 4;
				else block += 2;
			}
			block = Math.round(block);
			return block;
		}
		override public function get shieldPerk():String {
			return _shield.perk;
		}
		override public function get shieldValue():Number {
			return _shield.value;
		}
		public function get shield():Shield
		{
			return _shield;
		}

		//override public function get undergarment
		override public function get upperGarmentName():String {
			return _upperGarment.name;
		}
		override public function get upperGarmentPerk():String {
			return _upperGarment.perk;
		}
		override public function get upperGarmentValue():Number {
			return _upperGarment.value;
		}
		public function get upperGarment():Undergarment
		{
			return _upperGarment;
		}

		override public function get lowerGarmentName():String {
			return _lowerGarment.name;
		}
		override public function get lowerGarmentPerk():String {
			return _lowerGarment.perk;
		}
		override public function get lowerGarmentValue():Number {
			return _lowerGarment.value;
		}
		public function get lowerGarment():Undergarment
		{
			return _lowerGarment;
		}

		public function get armor():Armor
		{
			return _armor;
		}

		public function setArmor(newArmor:Armor):Armor {
			//Returns the old armor, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldArmor:Armor = _armor.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newArmor == null) {
				CoC_Settings.error(short + ".armor is set to null");
				newArmor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			_armor = newArmor.playerEquip(); //The armor can also choose to equip something else - useful for Ceraph's trap armor
			return oldArmor;
		}

		/*
		public function set armor(value:Armor):void
		{
			if (value == null){
				CoC_Settings.error(short+".armor is set to null");
				value = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setArmorHiddenField(value:Armor):void
		{
			this._armor = value;
		}

		public function get weapon():Weapon
		{
			return _weapon;
		}

		public function setWeapon(newWeapon:Weapon):Weapon {
			//Returns the old weapon, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeapon:Weapon = _weapon.playerRemove(); //The weapon is responsible for removing any bonuses, perks, etc.
			if (newWeapon == null) {
				CoC_Settings.error(short + ".weapon (melee) is set to null");
				newWeapon = WeaponLib.FISTS;
			}
			_weapon = newWeapon.playerEquip(); //The weapon can also choose to equip something else
			return oldWeapon;
		}

		/*
		public function set weapon(value:Weapon):void
		{
			if (value == null){
				CoC_Settings.error(short+".weapon is set to null");
				value = WeaponLib.FISTS;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setWeaponHiddenField(value:Weapon):void
		{
			this._weapon = value;
		}

		//Range Weapon, added by Ormael
		public function get weaponRange():WeaponRange
		{
			return _weaponRange;
		}

		public function setWeaponRange(newWeaponRange:WeaponRange):WeaponRange {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeaponRange:WeaponRange = _weaponRange.playerRemove();
			if (newWeaponRange == null) {
				CoC_Settings.error(short + ".weapon (range) is set to null");
				newWeaponRange = WeaponRangeLib.NOTHING;
			}
			_weaponRange = newWeaponRange.playerEquip();
			return oldWeaponRange;
		}

		// in case you don't want to call the value.equip
		public function setWeaponRangeHiddenField(value:WeaponRange):void
		{
			this._weaponRange = value;
		}

		//Flying Swords, added by Ormael
		public function get weaponFlyingSwords():FlyingSwords
		{
			return _weaponFlyingSwords;
		}

		public function setWeaponFlyingSwords(newWeaponFlyingSwords:FlyingSwords):FlyingSwords {
			//Returns the old flying Swords, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeaponFlyingSwords:FlyingSwords = _weaponFlyingSwords.playerRemove();
			if (newWeaponFlyingSwords == null) {
				CoC_Settings.error(short + ".weapon (flying swords) is set to null");
				newWeaponFlyingSwords = FlyingSwordsLib.NOTHING;
			}
			_weaponFlyingSwords = newWeaponFlyingSwords.playerEquip();
			return oldWeaponFlyingSwords;
		}

		// in case you don't want to call the value.equip
		public function setWeaponFlyingSwordsHiddenField(value:FlyingSwords):void
		{
			this._weaponFlyingSwords = value;
		}

		//Misc Jewelry, added by Ormael
		public function get miscJewelry():MiscJewelry
		{
			return _miscjewelry;
		}

		public function setMiscJewelry(newMiscJewelry:MiscJewelry):MiscJewelry {
			//Returns the old misc jewelery, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldMiscJewelry:MiscJewelry = _miscjewelry.playerRemove();
			if (newMiscJewelry == null) {
				CoC_Settings.error(short + ".miscjewelry is set to null");
				newMiscJewelry = MiscJewelryLib.NOTHING;
			}
			_miscjewelry = newMiscJewelry.playerEquip(); //The head jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldMiscJewelry;
		}
		// in case you don't want to call the value.equip
		public function setMiscJewelryHiddenField(value:MiscJewelry):void
		{
			this._miscjewelry = value;
		}

		public function get miscJewelry2():MiscJewelry
		{
			return _miscjewelry2;
		}

		public function setMiscJewelry2(newMiscJewelry:MiscJewelry):MiscJewelry {
			//Returns the old misc jewelery, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldMiscJewelry:MiscJewelry = _miscjewelry2.playerRemove();
			if (newMiscJewelry == null) {
				CoC_Settings.error(short + ".miscjewelry2 is set to null");
				newMiscJewelry = MiscJewelryLib.NOTHING;
			}
			_miscjewelry2 = newMiscJewelry.playerEquip(); //The head jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldMiscJewelry;
		}
		// in case you don't want to call the value.equip
		public function setMiscJewelryHiddenField2(value:MiscJewelry):void
		{
			this._miscjewelry2 = value;
		}

		//Head Jewelry, added by Ormael
		public function get headJewelry():HeadJewelry
		{
			return _headjewelry;
		}

		public function setHeadJewelry(newHeadJewelry:HeadJewelry):HeadJewelry {
			//Returns the old head jewelery, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldHeadJewelry:HeadJewelry = _headjewelry.playerRemove();
			if (newHeadJewelry == null) {
				CoC_Settings.error(short + ".headjewelry is set to null");
				newHeadJewelry = HeadJewelryLib.NOTHING;
			}
			_headjewelry = newHeadJewelry.playerEquip(); //The head jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldHeadJewelry;
		}
		// in case you don't want to call the value.equip
		public function setHeadJewelryHiddenField(value:HeadJewelry):void
		{
			this._headjewelry = value;
		}

		//Necklace, added by Ormael
		public function get necklace():Necklace
		{
			return _necklace;
		}

		public function setNecklace(newNecklace:Necklace):Necklace {
			//Returns the old necklace, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldNecklace:Necklace = _necklace.playerRemove();
			if (newNecklace == null) {
				CoC_Settings.error(short + ".necklace is set to null");
				newNecklace = NecklaceLib.NOTHING;
			}
			_necklace = newNecklace.playerEquip(); //The necklace can also choose to equip something else - useful for Ceraph's trap armor
			return oldNecklace;
		}
		// in case you don't want to call the value.equip
		public function setNecklaceHiddenField(value:Necklace):void
		{
			this._necklace = value;
		}

		//Jewelry, added by Kitteh6660
		public function get jewelry():Jewelry
		{
			return _jewelry;
		}

		public function setJewelry(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField(value:Jewelry):void
		{
			this._jewelry = value;
		}

		public function get jewelry2():Jewelry
		{
			return _jewelry2;
		}

		public function setJewelry2(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry2.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry2 is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry2 = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField2(value:Jewelry):void
		{
			this._jewelry2 = value;
		}

		public function get jewelry3():Jewelry
		{
			return _jewelry3;
		}

		public function setJewelry3(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry3.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry2 is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry3 = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField3(value:Jewelry):void
		{
			this._jewelry3 = value;
		}

		public function get jewelry4():Jewelry
		{
			return _jewelry4;
		}

		public function setJewelry4(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry4.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry2 is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry4 = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField4(value:Jewelry):void
		{
			this._jewelry4 = value;
		}

		public function setShield(newShield:Shield):Shield {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldShield:Shield = _shield.playerRemove(); //The shield is responsible for removing any bonuses, perks, etc.
			if (newShield == null) {
				CoC_Settings.error(short + ".shield is set to null");
				newShield = ShieldLib.NOTHING;
			}
			_shield = newShield.playerEquip(); //The shield can also choose to equip something else.
			return oldShield;
		}

		// in case you don't want to call the value.equip
		public function setShieldHiddenField(value:Shield):void
		{
			this._shield = value;
		}

		public function setUndergarment(newUndergarment:Undergarment, typeOverride:int = -1):Undergarment {
			//Returns the old undergarment, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldUndergarment:Undergarment = UndergarmentLib.NOTHING;
			if (newUndergarment.type == UndergarmentLib.TYPE_UPPERWEAR || typeOverride == 0) {
				oldUndergarment = _upperGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".upperGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_upperGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			else if (newUndergarment.type == UndergarmentLib.TYPE_LOWERWEAR || typeOverride == 1) {
				oldUndergarment = _lowerGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".lowerGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_lowerGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			return oldUndergarment;
		}

		// in case you don't want to call the value.equip
		public function setUndergarmentHiddenField(value:Undergarment, type:int):void
		{
			if (type == UndergarmentLib.TYPE_UPPERWEAR) this._upperGarment = value;
			else this._lowerGarment = value;
		}

		//Vehicles, added by Ormael
		public function get vehicles():Vehicles
		{
			return _vehicle;
		}

		public function setVehicle(newVehicle:Vehicles):Vehicles {
			//Returns the old vehicle, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldVehicle:Vehicles = _vehicle.playerRemove();
			if (newVehicle == null) {
				CoC_Settings.error(short + ".vehicle is set to null");
				newVehicle = VehiclesLib.NOTHING;
			}
			_vehicle = newVehicle.playerEquip(); //The vehicle can also choose to equip something else
			return oldVehicle;
		}
		// in case you don't want to call the value.equip
		public function setVehicleHiddenField(value:Vehicles):void
		{
			this._vehicle = value;
		}

		// Potions
		/**
		 * Array of objects { type: PotionType, count: Number }
		 */
		public var potions:Array = [];
		public function numberOfPotions(pt: PotionType): Number {
			for (var i:int = 0; i < potions.length; i++){
				if (potions[i].type == pt) {
					return potions[i].count;
				}
			}
			return 0;
		}
		public function setNumberOfPotions(pt: PotionType, count: Number): void {
			for (var i:int = 0; i < potions.length; i++) {
				if (potions[i].type == pt) {
					if (count <= 0) { // remove the potion
						potions.splice(i, 1);
					} else {
						potions[i].count = count;
					}
					return;
				}
			}
			// did not find a potion entry, create new
			if (count > 0) {
				potions.push( { type: pt, count: count });
			}
		}
		public function changeNumberOfPotions(pt: PotionType, change: Number): void {
			setNumberOfPotions(pt, numberOfPotions(pt) + change);
		}

		public override function lustPercent():Number {
			var lust:Number = 100;
			var minLustCap:Number = 25;

			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//ADDITIVE REDUCTIONS
			//THESE ARE FLAT BONUSES WITH LITTLE TO NO DOWNSIDE
			//TOTAL IS LIMITED TO 75%!
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Corrupted Libido reduces lust gain by 10%!
			if(hasPerk(PerkLib.CorruptedLibido)) lust -= 10;
			//Acclimation reduces by 15%
			if(hasPerk(PerkLib.Acclimation)) lust -= 15;
			//Purity blessing reduces lust gain
			if(hasPerk(PerkLib.PurityBlessing)) lust -= 5;
			//Resistance = 10%
			if(hasPerk(PerkLib.ResistanceI)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceII)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceIII)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceIV)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceV)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceVI)) lust -= 5;
			if(hasPerk(PerkLib.PewWarmer)) lust -= 5;
			if(hasPerk(PerkLib.Acolyte)) lust -= 5;
			if(hasPerk(PerkLib.Priest)) lust -= 5;
			if(hasPerk(PerkLib.Pastor)) lust -= 5;
			if(hasPerk(PerkLib.Saint)) lust -= 5;
			if(hasPerk(PerkLib.Cardinal)) lust -= 5;
			if(hasPerk(PerkLib.Pope)) lust -= 5;
			if(perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 2) lust -= 5;
			if(perkv1(IMutationsLib.MinotaurTesticlesIM) >= 2) lust -= 5;
			if((hasPerk(PerkLib.UnicornBlessing) && cor <= 20) || (hasPerk(PerkLib.BicornBlessing) && cor >= 80)) lust -= 10;
			if(hasPerk(PerkLib.ChiReflowLust)) lust -= UmasShop.NEEDLEWORK_LUST_LUST_RESIST;
			if(jewelryEffectId == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude;
			if(jewelryEffectId2 == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude2;
			if(jewelryEffectId3 == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude3;
			if(jewelryEffectId4 == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude4;
			if(headjewelryEffectId == HeadJewelryLib.MODIFIER_LUST_R) lust -= headjewelryEffectMagnitude;
			if(necklaceEffectId == NecklaceLib.MODIFIER_LUST_R) lust -= necklaceEffectMagnitude;
			if(jewelryEffectId == JewelryLib.MODIFIER_LUST_R && jewelryEffectId2 == JewelryLib.MODIFIER_LUST_R && jewelryEffectId3 == JewelryLib.MODIFIER_LUST_R && jewelryEffectId4 == JewelryLib.MODIFIER_LUST_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_LUST_R && necklaceEffectId == NecklaceLib.MODIFIER_LUST_R) lust -= 15;
			if(BelisaFollower.HolyBand2 > 0) lust -= 10 * BelisaFollower.HolyBand2;
			if(lust < minLustCap) lust = minLustCap;
			if(statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				if(lust >= 80) lust = 100;
				else lust += 20;
			}
			lust += Math.round(perkv1(PerkLib.PentUp)/2);
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//MULTIPLICATIVE REDUCTIONS
			//THESE PERKS ALSO RAISE MINIMUM LUST OR HAVE OTHER
			//DRAWBACKS TO JUSTIFY IT.
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Bimbo body slows lust gains!
			if((hasStatusEffect(StatusEffects.BimboChampagne) || hasPerk(PerkLib.BimboBody)) && lust > 0) lust *= .75;
			if(hasPerk(PerkLib.BroBody) && lust > 0) lust *= .75;
			if(hasPerk(PerkLib.FutaForm) && lust > 0) lust *= .75;
			//Omnibus' Gift reduces lust gain by 15%
			if(hasPerk(PerkLib.OmnibusGift)) lust *= .85;
			//Fera Blessing reduces lust gain by 15%
			if(hasStatusEffect(StatusEffects.BlessingOfDivineFera)) lust *= .85;
			//Luststick reduces lust gain by 10% to match increased min lust
			if(hasPerk(PerkLib.LuststickAdapted)) lust *= 0.9;
			if (hasPerk(PerkLib.PureAndLoving)) lust *= 0.95;
			//Berseking reduces lust gains by 10%
			if (hasStatusEffect(StatusEffects.Berzerking)) lust *= 0.9;
			if (hasStatusEffect(StatusEffects.Overlimit) || hasStatusEffect(StatusEffects.FieryRage)) lust *= 0.9;
			if (TyrantiaFollower.TyrantiaTrainingSessions >= 25 && lust100 >= 50) {
				if (lust100 >= 100) lust *= 0.3;
				else if (lust100 >= 51) lust *= (1 - ((lust100 - 30) * 0.01));
				else lust *= 0.8;
			}
			//Items
			if (jewelryEffectId == JewelryLib.PURITY) lust *= 1 - (jewelryEffectMagnitude / 100);
			if (armor == game.armors.DBARMOR) lust *= 0.9;
			if (weapon == game.weapons.HNTCANE) lust *= 0.75;
			if ((weapon == game.weapons.PURITAS) || (weapon == game.weapons.ASCENSU)) lust *= 0.9;
			if (vehiclesName == "Giant Slayer Mech") lust *= 0.25;
			// Lust mods from Uma's content -- Given the short duration and the gem cost, I think them being multiplicative is justified.
			// Changing them to an additive bonus should be pretty simple (check the static values in UmasShop.as)
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac)
			{
				if (sac.value1 == UmasShop.MASSAGE_RELIEF || sac.value1 == UmasShop.MASSAGE_LUST)
				{
					lust *= sac.value2;
				}
			}
			if(statusEffectv1(StatusEffects.Maleficium) > 0) {
				if (perkv1(IMutationsLib.ObsidianHeartIM) >= 3) {
					if (lust >= 70) lust = 100;
					else lust += 30;
				}
				else {
					if (lust >= 50) lust = 100;
					else lust += 50;
				}
			}
			if (hasStatusEffect(StatusEffects.Aegis)) lust *= 0.5;
			lust = Math.round(lust);
			if (hasStatusEffect(StatusEffects.Lustzerking) && !hasPerk(PerkLib.ColdLust)) lust = 100;
			if (hasStatusEffect(StatusEffects.BlazingBattleSpirit) || hasStatusEffect(StatusEffects.MomentOfClarity)) lust = 0;
			return lust;
		}

		public function effectiveLibido():Number {
			var mins:Object = getAllMinStats();
			var baseLib:Number = lib;
			var finalLib:Number = 1;
			if (finalLib < 0.05) finalLib = 0.05;
			baseLib = Math.round(baseLib * finalLib);
			if (baseLib < mins.lib) baseLib = mins.lib;
			return baseLib;
		}

		public function effectiveSensitivity():Number {
			var mins:Object = getAllMinStats();
			var baseSens:Number = sens;
			var finalSens:Number = 1;
			if (hasPerk(PerkLib.Desensitization)) finalSens -= 0.05;
			if (hasPerk(PerkLib.GreaterDesensitization)) finalSens -= 0.1;
			if (hasPerk(PerkLib.EpicDesensitization)) finalSens -= 0.15;
			if (hasPerk(PerkLib.LegendaryDesensitization)) finalSens -= 0.2;
			if (hasPerk(PerkLib.MythicalDesensitization)) finalSens -= 0.25;
			if (finalSens < 0.05) finalSens = 0.05;
			baseSens = Math.round(baseSens * finalSens);
			if (baseSens < mins.sens) baseSens = mins.sens;
			return baseSens;
		}

		public function bouncybodyDR():Number {
			var bbDR:Number = 0.25;
			if (perkv1(IMutationsLib.NaturalPunchingBagIM) >= 1) bbDR += 0.05;
			if (perkv1(IMutationsLib.NaturalPunchingBagIM) >= 2) bbDR += 0.1;
			if (perkv1(IMutationsLib.NaturalPunchingBagIM) >= 3) bbDR += 0.2;
			return bbDR;
		}
		public function wrathFromHPmulti():Number {
			var WHmulti:Number = 1;
			WHmulti *= (effectiveSensitivity() * (1 / 100));
			if (hasPerk(PerkLib.FuelForTheFire)) WHmulti *= 2;
			return WHmulti;
		}
		public function wrathFromBeenPunchingBag(damage:Number):void {
			if (damage > 0) {
				var gainedWrath:Number = 0;
				gainedWrath += Math.sqrt(damage / 10);
				gainedWrath = Math.round(gainedWrath * wrathFromHPmulti());
				if (gainedWrath > 0) EngineCore.WrathChange(gainedWrath, false);
			}
		}

		public function manaShieldAbsorbMagic(damage:Number, display:Boolean = false):Number {
			return manaShieldAbsorb(damage, display, true);
		}
		public function manaShieldAbsorb(damage:Number, display:Boolean = false, magic:Boolean = false):Number{
			var magicmult:Number = 1;
			if (hasPerk(PerkLib.ImprovedManaShield)) magicmult *= 0.25;
			// if magical damage, double efficiency
			if (magic == true) magicmult *= 0.2;
			// defensive staff channeling
			if (hasPerk(PerkLib.DefensiveStaffChanneling) && (isStaffTypeWeapon() || isPartiallyStaffTypeWeapon())) magicmult *= 0.5;
			if (damage * magicmult <= mana) {
				mana -= (damage * magicmult);
				if (display) {
					if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
					else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
				}
				game.mainView.statsView.showStatDown('mana');
				dynStats("lus", 0); //Force display arrow.
				return 0;
			}
			else {
				var partial:Number = Math.round(mana / magicmult);
				damage -= partial;
				if (display) {
					if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + partial + "</font>)</b>");
					else outputText("<b>(<font color=\"#000080\">Absorbed " + partial + "</font>)</b>");
				}
				mana = 0;
				game.mainView.statsView.showStatDown('mana');
				dynStats("lus", 0); //Force display arrow.
				return damage;
			}
		}
		public function bloodShieldAbsorb(damage:Number, display:Boolean = false):Number{
			if (damage <= statusEffectv1(StatusEffects.BloodShield)) {
				addStatusValue(StatusEffects.BloodShield,1,-damage);
				if (display) {
					if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
					else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
				}
				return 0;
			}
			else {
				var partial:Number = statusEffectv1(StatusEffects.BloodShield);
				damage -= partial;
				if (display) {
					if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + partial + "</font>)</b>");
					else outputText("<b>(<font color=\"#000080\">Absorbed " + partial + "</font>)</b>");
				}
				removeStatusEffect(StatusEffects.BloodShield);
				return damage;
			}
		}
		public function difficultyDamageMultiplier(damage:Number):Number{
			var damageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) damageMultiplier *= 0.1;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damageMultiplier *= 1.2;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) damageMultiplier *= 2;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) damageMultiplier *= 3.5;
			return damage * damageMultiplier;
		}
		public function takeDamage(damage:Number, damagetype:Number = 0, display:Boolean = false):Number{
			// Damage types:
			// 0: phys, 1: null, 2: null, 3: null
			// 4: magical, 5: fire, 6: ice
			// 7: lightning, 8: darkness, 9: poison
			// 10: wind, 11: water, 12: earth
			damage = difficultyDamageMultiplier(damage);
			//all dmg reduction effect(s)
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.EnergyDrain)) damage *= 0.8;
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (henchmanBasedInvulnerabilityFrame() || hasStatusEffect(StatusEffects.TurquoiseBandProtection)) {
					if (henchmanBasedInvulnerabilityFrame()) henchmanBasedInvulnerabilityFrameTexts();
					else SceneLib.combat.triggeredTurquoiseBandProtectionTexts();
					damage = 0;
				}
				else if (hasStatusEffect(StatusEffects.ManaShield)) {
					if (hasPerk(PerkLib.ArcaneShielding)) {
						if (damagetype < 4) damage = manaShieldAbsorb(damage, display);
						else damage = manaShieldAbsorbMagic(damage, display);
					}
					else damage = manaShieldAbsorb(damage, display);
				}
				else if (damage > 0 && hasStatusEffect(StatusEffects.BloodShield)) {
					damage = bloodShieldAbsorb(damage, display);
				}
				if (hasStatusEffect(StatusEffects.AdamantineShell)) damage *= 0.25;
				if (hasStatusEffect(StatusEffects.TrueEvasion)) damage = 0;
				if (damage > 0) {
					switch (damagetype) {
						case 0: // physical
							damage = reducePhysDamage(damage);
							break;
						case 1: // physical
							damage = reducePhysDamage(damage);
							break;
						case 2: // physical
							damage = reducePhysDamage(damage);
							break;
						case 3: // physical
							damage = reducePhysDamage(damage);
							break;
						case 4: // magical
							damage = reduceMagicDamage(damage);
							break;
						case 5: // fire
							if (hasPerk(PerkLib.WalpurgisIzaliaRobe)) damage = damage/4*3;
							damage = reduceFireDamage(damage);
							break;
						case 6: // ice
							damage = reduceIceDamage(damage);
							break;
						case 7: // lightning
							damage = reduceLightningDamage(damage);
							break;
						case 8: // darkness
							damage = reduceDarknessDamage(damage);
							break;
						case 9: // poison
							damage = reducePoisonDamage(damage);
							break;
						case 10: // wind
							damage = reduceWindDamage(damage);
							break;
						case 11: // water
							damage = reduceWaterDamage(damage);
							break;
						case 12: // earth
							damage = reduceEarthDamage(damage);
							break;
						case 13: // acid
							damage = reducePoisonDamage(damage);
							break;
						default:
							damage = reducePhysDamage(damage);
					}
					//Wrath
					wrathFromBeenPunchingBag(damage);
					if (hasStatusEffect(StatusEffects.BoneArmor)) damage = Math.round(damage * 0.5);
					//game.HPChange(-damage, display);
					damage = Math.round(damage);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				if (damagetype == 0 && flags[kFLAGS.YAMATA_MASOCHIST] > 1 && flags[kFLAGS.AIKO_BOSS_COMPLETE] < 1) {
					dynStats("lus", int(damage / 8));
				}
				//Prevent negatives
				if (HP < minHP()){
					HP = minHP();
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public override function damagePercent():Number {
			var mult:Number = 100;
			var armorMod:Number = armorDef;
			//--BASE--
			mult -= armorMod;
			if (mult < 20) mult = 20;
			//--PERKS--
			//Take damage you masochist!
			if (hasPerk(PerkLib.Masochist) && lib >= 60) {
				mult -= 20;
				if(armorName == "Scandalous Succubus Clothing"){
					mult -= 20;
					dynStats("lus", (2 * (1 + game.player.newGamePlusMod())));
				}
				dynStats("lus", (2 * (1 + game.player.newGamePlusMod())));
			}
			if (perkv1(IMutationsLib.DraconicBonesIM) >= 2) {
				mult -= 5;
			}
			if (perkv1(IMutationsLib.DraconicBonesIM) >= 3) {
				mult -= 5;
			}
			if (perkv1(IMutationsLib.WhaleFatIM) >= 1) {
				mult -= 5;
			}
			if (perkv1(IMutationsLib.WhaleFatIM) >= 2) {
				mult -= 10;
			}
			if (perkv1(IMutationsLib.WhaleFatIM) >= 3) {
				mult -= 20;
			}
			if (perkv1(IMutationsLib.YetiFatIM) >= 1) {
				mult -= 5;
			}
			if (perkv1(IMutationsLib.YetiFatIM) >= 2) {
				mult -= 10;
			}
			if (perkv1(IMutationsLib.YetiFatIM) >= 3) {
				mult -= 20;
			}
			if (hasPerk(PerkLib.FenrirSpikedCollar)) {
				mult -= 15;
			}
			if (hasPerk(PerkLib.Juggernaut) && tou >= 100 && (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor")) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.ImmovableObject) && tou >= 75) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.AyoArmorProficiency) && tou >= 100 && (armorPerk == "Light Ayo" || armorPerk == "Heavy Ayo" || armorPerk == "Ultra Heavy Ayo")) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.HeavyArmorProficiency) && tou >= 75 && (armorPerk == "Heavy" || _armor.name == "Drider-weave Armor")) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.ShieldHarmony) && tou >= 100 && isShieldsForShieldBash() && shieldName != "nothing" && !hasStatusEffect(StatusEffects.Stunned)) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.KnightlySword) && isSwordTypeWeapon() && isShieldsForShieldBash()) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.NakedTruth) && spe >= 75 && lib >= 60 && armor.hasTag(ItemTags.REVEALING)) {
				mult -= 10;
			}
			if (hasPerk(PerkLib.FluidBody) && meetUnhinderedReq()) {
				mult -= 50;
				dynStats("lus", (5 * (1 + game.player.newGamePlusMod())));
			}
			if (hasPerk(PerkLib.HaltedVitals)) {
				if (hasStatusEffect(StatusEffects.AlterBindScroll1)) mult -= 40;
				else mult -= 20;
			}
			//--STATUS AFFECTS--
			//Black cat beer = 25% reduction!
			if (statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				mult -= 25;
			}
			if (statusEffectv1(StatusEffects.OniRampage) > 0) {
				mult -= 20;
			}
			if (statusEffectv1(StatusEffects.EarthStance) > 0) {
				mult -= 30;
			}
			if (statusEffectv1(StatusEffects.AcidDoT) > 0) {
				mult += statusEffectv2(StatusEffects.AcidDoT);
			}
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			if (hasStatusEffect(StatusEffects.TyrantState)) mult += 20;
			if (TyrantiaFollower.TyrantiaTrainingSessions >= 25 && lust100 >= 50) {
				mult -= 20;
				if (lust100 >= 51) {
					if (lust100 >= 100) mult -= 50;
					else mult -= (lust100 - 50);
				}
			}
			if (jewelryEffectId == JewelryLib.MODIFIER_PHYS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_PHYS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_PHYS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_PHYS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_PHYS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_PHYS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_PHYS_R && jewelryEffectId2 == JewelryLib.MODIFIER_PHYS_R && jewelryEffectId3 == JewelryLib.MODIFIER_PHYS_R && jewelryEffectId4 == JewelryLib.MODIFIER_PHYS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_PHYS_R && necklaceEffectId == NecklaceLib.MODIFIER_PHYS_R) mult -= 9;
			//Defend = 35-95% reduction
			if (hasStatusEffect(StatusEffects.Defend)) {
				if (hasPerk(PerkLib.DefenceStance) && tou >= 80) {
					if (hasPerk(PerkLib.MasteredDefenceStance) && tou >= 120) {
						if (hasPerk(PerkLib.PerfectDefenceStance) && tou >= 160) mult -= 95;
						else mult -= 70;
					}
					else mult -= 50;
				}
				else mult -= 35;
			}
			// Uma's Massage bonuses
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac && sac.value1 == UmasShop.MASSAGE_RELAXATION) {
				mult -= 100 * sac.value2;
			}
			//Caps damage reduction at 80/99%
			if (hasStatusEffect(StatusEffects.Defend) && hasPerk(PerkLib.PerfectDefenceStance) && tou >= 160 && mult < 1) mult = 1;
			if (!hasStatusEffect(StatusEffects.Defend) && mult < 20) mult = 20;
			return mult;
		}
		public override function takePhysDamage(damage:Number, display:Boolean = false):Number{
			return takeDamage(damage, 0, display);
		}
		public function reducePhysDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.Tactician) && CoC.instance.monster.inte >= 50) {
				if (CoC.instance.monster.inte <= 100) critChanceMonster += (CoC.instance.monster.inte - 50) / 5;
				if (CoC.instance.monster.inte > 100) critChanceMonster += 10;
			}
			if (CoC.instance.monster.hasPerk(PerkLib.VitalShot) && CoC.instance.monster.inte >= 50) critChanceMonster += 10;
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			if (BelisaFollower.HolyBand1 > 0) {
				var hdr:Number = damage * (1 - (0.1 * BelisaFollower.HolyBand1));
				damage -= hdr;
				damage = Math.round(damage);
			}
			//Apply damage resistance percentage.
			damage *= damagePercent() / 100;
			return damage;
		}

		public override function damageMagicalPercent():Number {
			var mult:Number = 100;
			var armorMMod:Number = armorMDef;
			//--BASE--
			mult -= armorMMod;
			if (mult < 20) mult = 20;
			//--PERKS--
			if (hasPerk(PerkLib.NakedTruth) && spe >= 75 && lib >= 60 && armor.hasTag(ItemTags.REVEALING)) {
				mult -= 10;
			}
			if (perkv1(IMutationsLib.DraconicBonesIM) >= 2) {
				mult -= 5;
			}
			if (perkv1(IMutationsLib.DraconicBonesIM) >= 3) {
				mult -= 5;
			}
			if (perkv1(IMutationsLib.MelkieLungIM) >= 1) {
				mult -= 5;
			}
			if (perkv1(IMutationsLib.MelkieLungIM) >= 2) {
				mult -= 10;
			}
			if (perkv1(IMutationsLib.MelkieLungIM) >= 3) {
				mult -= 15;
			}
			//--STATUS AFFECTS--
			if (statusEffectv1(StatusEffects.OniRampage) > 0) {
				mult -= 20;
			}
			if (statusEffectv4(StatusEffects.ZenjiZList) == 2) {
				mult -= 10;
			}
			if (hasStatusEffect(StatusEffects.DivineShield)) {
				mult -= 40;
			}
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			if (jewelryEffectId == JewelryLib.MODIFIER_MAGIC_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_MAGIC_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_MAGIC_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_MAGIC_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_MAGIC_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_MAGIC_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_MAGIC_R && jewelryEffectId2 == JewelryLib.MODIFIER_MAGIC_R && jewelryEffectId3 == JewelryLib.MODIFIER_MAGIC_R && jewelryEffectId4 == JewelryLib.MODIFIER_MAGIC_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_MAGIC_R && necklaceEffectId == NecklaceLib.MODIFIER_MAGIC_R) mult -= 6;
			//Defend = 35-95% reduction
			if (hasStatusEffect(StatusEffects.Defend)) {
				if (hasPerk(PerkLib.DefenceStance) && tou >= 80) {
					if (hasPerk(PerkLib.MasteredDefenceStance) && tou >= 120) {
						if (hasPerk(PerkLib.PerfectDefenceStance) && tou >= 160) mult -= 95;
						else mult -= 70;
					}
					else mult -= 50;
				}
				else mult -= 35;
			}
			// Uma's Massage bonuses
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac && sac.value1 == UmasShop.MASSAGE_RELAXATION) {
				mult -= 100 * sac.value2;
			}
			//Caps damage reduction at 80/99%
			if (hasStatusEffect(StatusEffects.Defend) && hasPerk(PerkLib.PerfectDefenceStance) && tou >= 160 && mult < 1) mult = 1;
			if (!hasStatusEffect(StatusEffects.Defend) && mult < 20) mult = 20;
			return mult;
		}
		public override function takeMagicDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 4, display);
		}
		public function reduceMagicDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			if (BelisaFollower.HolyBand7 > 0) {
				var hdr:Number = damage * (1 - (0.05 * BelisaFollower.HolyBand7));
				damage -= hdr;
				damage = Math.round(damage);
			}
			//Apply magic damage resistance percentage.
			damage *= damageMagicalPercent() / 100;
			return damage;
		}

		public override function damageFirePercent():Number {
			var mult:Number = damageMagicalPercent();
			if (upperGarmentName == "HB shirt") mult -= 10;
			if (lowerGarmentName == "HB shorts") mult -= 10;
			if (hasPerk(PerkLib.FromTheFrozenWaste) || hasPerk(PerkLib.ColdAffinity)) mult += 100;
			if (hasPerk(PerkLib.FireAffinity)) mult -= 50;
			if (hasStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff1) && (statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff1) > 0)) mult -= statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff1);
			if (hasStatusEffect(StatusEffects.DaoOfFire) && (statusEffectv2(StatusEffects.DaoOfFire) > 2)) mult -= 10;
			if (jewelryEffectId == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_FIRE_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_FIRE_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_FIRE_R && jewelryEffectId2 == JewelryLib.MODIFIER_FIRE_R && jewelryEffectId3 == JewelryLib.MODIFIER_FIRE_R && jewelryEffectId4 == JewelryLib.MODIFIER_FIRE_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_FIRE_R && necklaceEffectId == NecklaceLib.MODIFIER_FIRE_R) mult -= 15;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			if (hasStatusEffect(StatusEffects.WinterClaw)) {
				mult += 100;
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeFireDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 5, display);
		}
		public function reduceFireDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply fire damage resistance percentage.
			damage *= damageFirePercent() / 100;
			return damage;
		}

		public override function damageIcePercent():Number {
			var mult:Number = damageMagicalPercent();
			if (upperGarmentName == "Fur bikini top") mult -= 10;
			if (lowerGarmentName == "Fur loincloth" || lowerGarmentName == "Fur panty") mult -= 10;
			if (upperGarmentName == "HB shirt") mult -= 10;
			if (lowerGarmentName == "HB shorts") mult -= 10;
			if (necklaceName == "Blue Winter scarf" || necklaceName == "Green Winter scarf" || necklaceName == "Purple Winter scarf" || necklaceName == "Red Winter scarf" || necklaceName == "Yellow Winter scarf") mult -= 20;
			if (hasPerk(PerkLib.FromTheFrozenWaste) || hasPerk(PerkLib.ColdAffinity)) mult -= 50;
			if (hasPerk(PerkLib.IcyFlesh)) mult -= 40;
			if (hasPerk(PerkLib.FireAffinity) || hasPerk(PerkLib.AffinityIgnis)) mult += 100;
			if (jewelryEffectId == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_ICE_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_ICE_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_ICE_R && jewelryEffectId2 == JewelryLib.MODIFIER_ICE_R && jewelryEffectId3 == JewelryLib.MODIFIER_ICE_R && jewelryEffectId4 == JewelryLib.MODIFIER_ICE_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_ICE_R && necklaceEffectId == NecklaceLib.MODIFIER_ICE_R) mult -= 15;
			if (hasStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff1) && (statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff1) > 0)) mult -= statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff1);
			if (hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				if (isRace(Races.MOUSE, 2) && (jewelryName == "Infernal Mouse ring" || jewelryName2 == "Infernal Mouse ring" || jewelryName3 == "Infernal Mouse ring" || jewelryName4 == "Infernal Mouse ring")) mult += 90;
				else mult += 100;
			}
			if (hasStatusEffect(StatusEffects.DaoOfIce) && (statusEffectv2(StatusEffects.DaoOfIce) > 2)) mult -= 10;
			if (rearBody.type == RearBody.YETI_FUR) mult -= 20;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			if (hasStatusEffect(StatusEffects.AlterBindScroll3)) mult = 0;
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeIceDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 6, display);
		}
		public function reduceIceDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply ice damage resistance percentage.
			damage *= damageIcePercent() / 100;
			return damage;
		}

		public override function damageLightningPercent():Number {
			var mult:Number = damageMagicalPercent();
			if (armorName == "Goblin Technomancer clothes") mult -= 25;
			if (upperGarmentName == "Technomancer bra") mult -= 15;
			if (lowerGarmentName == "Technomancer panties") mult -= 15;
			if (upperGarmentName == "HB shirt") mult -= 10;
			if (lowerGarmentName == "HB shorts") mult -= 10;
			if (hasPerk(PerkLib.LightningAffinity)) mult -= 50;
			if (perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) mult -= 10;
			if (perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) mult -= 30;
			if (hasPerk(PerkLib.AquaticAffinity) || hasPerk(PerkLib.AffinityUndine)) mult += 100;
			if (jewelryEffectId == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_LIGH_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_LIGH_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_LIGH_R && jewelryEffectId2 == JewelryLib.MODIFIER_LIGH_R && jewelryEffectId3 == JewelryLib.MODIFIER_LIGH_R && jewelryEffectId4 == JewelryLib.MODIFIER_LIGH_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_LIGH_R && necklaceEffectId == NecklaceLib.MODIFIER_LIGH_R) mult -= 15;
			if (hasStatusEffect(StatusEffects.DaoOfLightning) && (statusEffectv2(StatusEffects.DaoOfLightning) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeLightningDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 7, display);
		}
		public function reduceLightningDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply lightning damage resistance percentage.
			damage *= damageLightningPercent() / 100;
			return damage;
		}

		public override function damageDarknessPercent():Number {
			var mult:Number = damageMagicalPercent();
			if (upperGarmentName == "HB shirt") mult -= 10;
			if (lowerGarmentName == "HB shorts") mult -= 10;
			if (hasPerk(PerkLib.DarknessAffinity)) mult -= 50;
			if (jewelryEffectId == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_DARK_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_DARK_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_DARK_R && jewelryEffectId2 == JewelryLib.MODIFIER_DARK_R && jewelryEffectId3 == JewelryLib.MODIFIER_DARK_R && jewelryEffectId4 == JewelryLib.MODIFIER_DARK_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_DARK_R && necklaceEffectId == NecklaceLib.MODIFIER_DARK_R) mult -= 15;
			if (hasStatusEffect(StatusEffects.DaoOfDarkness) && (statusEffectv2(StatusEffects.DaoOfDarkness) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeDarknessDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 8, display);
		}
		public function reduceDarknessDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply darkness damage resistance percentage.
			damage *= damageDarknessPercent() / 100;
			return damage;
		}

		public override function damagePoisonPercent():Number {
			var mult:Number = damageMagicalPercent();
			if (perkv1(IMutationsLib.VenomGlandsIM) >= 2) mult -= 5;
			if (perkv1(IMutationsLib.VenomGlandsIM) >= 3) mult -= 10;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R && necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= 15;
			if (hasStatusEffect(StatusEffects.DaoOfPoison) && (statusEffectv2(StatusEffects.DaoOfPoison) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			if (hasStatusEffect(StatusEffects.AlterBindScroll3)) mult = 0;
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takePoisonDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 9, display);
		}
		public function reducePoisonDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damagePoisonPercent() / 100;
			return damage;
		}

		public override function damageWindPercent():Number {
			var mult:Number = damageMagicalPercent();/*
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R && necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= 15;*/
			if (hasStatusEffect(StatusEffects.DaoOfWind) && (statusEffectv2(StatusEffects.DaoOfWind) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeWindDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 10, display);
		}
		public function reduceWindDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damageWindPercent() / 100;
			return damage;
		}

		public override function damageWaterPercent():Number {
			var mult:Number = damageMagicalPercent();/*
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R && necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= 15;*/
			if (hasStatusEffect(StatusEffects.DaoOfWater) && (statusEffectv2(StatusEffects.DaoOfWater) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeWaterDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 11, display);
		}
		public function reduceWaterDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damagePoisonPercent() / 100;
			return damage;
		}

		public override function damageEarthPercent():Number {
			var mult:Number = damageMagicalPercent();/*
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R && necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= 15;*/
			if (hasStatusEffect(StatusEffects.DaoOfEarth) && (statusEffectv2(StatusEffects.DaoOfEarth) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeEarthDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 12, display);
		}
		public function reduceEarthDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damagePoisonPercent() / 100;
			return damage;
		}

		public override function damageAcidPercent():Number {
			var mult:Number = damageMagicalPercent();/*
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == HeadJewelryLib.MODIFIER_POIS_R && necklaceEffectId == NecklaceLib.MODIFIER_POIS_R) mult -= 15;*/
			if (hasStatusEffect(StatusEffects.DaoOfAcid) && (statusEffectv2(StatusEffects.DaoOfAcid) > 2)) mult -= 10;
			if (CoC.instance.monster.statusEffectv1(StatusEffects.EnemyLoweredDamageH) > 0) {
				mult -= CoC.instance.monster.statusEffectv2(StatusEffects.EnemyLoweredDamageH);
			}
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeAcidDamage(damage:Number, display:Boolean = false):Number {
			return takeDamage(damage, 13, display);
		}
		public function reduceAcidDamage(damage:Number):Number {
			//Opponents can critical too!
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.MagiculesTheory) && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (hasPerk(PerkLib.BouncyBody) && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damagePoisonPercent() / 100;
			return damage;
		}

		public function eyesOfTheHunterAdeptBoost():Boolean {
			return CoC.instance.monster.hasPerk(PerkLib.EnemyHugeType) || CoC.instance.monster.hasPerk(PerkLib.EnemyGroupType) || CoC.instance.monster.hasPerk(PerkLib.EnemyBeastOrAnimalMorphType) || CoC.instance.monster.hasPerk(PerkLib.EnemyConstructType) || CoC.instance.monster.hasPerk(PerkLib.EnemyFeralType) || CoC.instance.monster.hasPerk(PerkLib.EnemyGooType)
			|| CoC.instance.monster.hasPerk(PerkLib.EnemyTrueDemon) || CoC.instance.monster.hasPerk(PerkLib.EnemyEliteType);
		}
		public function eyesOfTheHunterExpertBoost():Boolean {
			return CoC.instance.monster.hasPerk(PerkLib.EnemyGigantType) || CoC.instance.monster.hasPerk(PerkLib.EnemyLargeGroupType) || CoC.instance.monster.hasPerk(PerkLib.EnemyElementalType) || CoC.instance.monster.hasPerk(PerkLib.EnemyGhostType) || CoC.instance.monster.hasPerk(PerkLib.EnemyPlantType) || CoC.instance.monster.hasPerk(PerkLib.EnemyChampionType)
			|| CoC.instance.monster.hasPerk(PerkLib.FireVulnerability) || CoC.instance.monster.hasPerk(PerkLib.IceVulnerability) || CoC.instance.monster.hasPerk(PerkLib.LightningVulnerability) || CoC.instance.monster.hasPerk(PerkLib.DarknessVulnerability);
		}
		public function eyesOfTheHunterMasterBoost():Boolean {
			return CoC.instance.monster.hasPerk(PerkLib.EnemyColossalType) || CoC.instance.monster.hasPerk(PerkLib.EnemyFleshConstructType) || CoC.instance.monster.hasPerk(PerkLib.FireNature) || CoC.instance.monster.hasPerk(PerkLib.IceNature) || CoC.instance.monster.hasPerk(PerkLib.LightningNature) || CoC.instance.monster.hasPerk(PerkLib.DarknessNature);
		}
		public function eyesOfTheHunterGrandMasterBoost():Boolean {
			return CoC.instance.monster.hasPerk(PerkLib.EnemyGodType) || CoC.instance.monster.hasPerk(PerkLib.EnemyBossType);
		}

		public function henchmanBasedInvulnerabilityFrame():Boolean {
			if (statusEffectv3(StatusEffects.CombatFollowerZenji) == 1 || statusEffectv3(StatusEffects.CombatFollowerZenji) == 3) return true;
			else return false;
		}
		public function henchmanBasedInvulnerabilityFrameTexts():void {
			if (statusEffectv3(StatusEffects.CombatFollowerZenji) == 1 || statusEffectv3(StatusEffects.CombatFollowerZenji) == 3) {
				outputText(" Zenji grits his teeth as he shields you, enduring several strikes from your opponent.");
				addStatusValue(StatusEffects.CombatFollowerZenji, 3, 1);
			}
		}

		/**
		 * @return 0: did not avoid; 1-3: avoid with varying difference between
		 * speeds (1: narrowly avoid, 3: deftly avoid)
		 */
		public function speedDodge(monster:Monster):int{
			var diff:Number = spe - monster.spe;
			var rnd:int = int(Math.random() * ((diff / 4) + 80));
			if (rnd<=80) return 0;
			else if (diff<8) return 1;
			else if (diff<20) return 2;
			else return 3;
		}

		//Body Type
		public function bodyType():String
		{
			var desc:String = "";
			//OLD STUFF
			//SUPAH THIN
			if (thickness < 10)
			{
				//SUPAH BUFF
				if (tone > 150)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 100)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 90)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 75)
					desc += "an incredibly thin, well-muscled frame";
				else if (tone > 50)
					desc += "a very thin body that has a good bit of muscle definition";
				else if (tone > 25)
					desc += "a lithe body and only a little bit of muscle definition";
				else
					desc += "a waif-thin body, and soft, forgiving flesh";
			}
			//Pretty thin
			else if (thickness < 25)
			{
				if (tone > 150)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 100)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 90)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 75)
					desc += "a narrow frame that shows off your muscles";
				else if (tone > 50)
					desc += "a somewhat lithe body and a fair amount of definition";
				else if (tone > 25)
					desc += "a narrow, soft body that still manages to show off a few muscles";
				else
					desc += "a thin, soft body";
			}
			//Somewhat thin
			else if (thickness < 40)
			{
				if (tone > 150)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 100)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 90)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 75)
					desc += "a thinner-than-average frame and great muscle definition";
				else if (tone > 50)
					desc += "a somewhat narrow body and a decent amount of visible muscle";
				else if (tone > 25)
					desc += "a moderately thin body, soft curves, and only a little bit of muscle";
				else
					desc += "a fairly thin form and soft, cuddle-able flesh";
			}
			//average
			else if (thickness < 60)
			{
				if (tone > 150)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 100)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 90)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 75)
					desc += "an average-sized frame and great musculature";
				else if (tone > 50)
					desc += "a normal waistline and decently visible muscles";
				else if (tone > 25)
					desc += "an average body and soft, unremarkable flesh";
				else
					desc += "an average frame and soft, untoned flesh with a tendency for jiggle";
			}
			else if (thickness < 75)
			{
				if (tone > 150)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 100)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 90)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 75)
					desc += "a body that's a little bit wide and has some highly-visible muscles";
				else if (tone > 50)
					desc += "a solid build that displays a decent amount of muscle";
				else if (tone > 25)
					desc += "a slightly wide frame that displays your curves and has hints of muscle underneath";
				else
					desc += "a soft, plush body with plenty of jiggle";
			}
			else if (thickness < 90)
			{
				if (tone > 150)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 100)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 90)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 75)
					desc += "a burly form and plenty of muscle definition";
				else if (tone > 50)
					desc += "a solid, thick frame and a decent amount of muscles";
				else if (tone > 25)
					desc += "a wide-set body, some soft, forgiving flesh, and a hint of muscle underneath it";
				else
				{
					desc += "a wide, cushiony body";
					if (gender >= 2 || biggestTitSize() > 3 || hips.type > 7 || butt.type > 7)
						desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else
			{
				if (tone > 150)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 100)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 90)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 75)
					desc += "a very wide body and enough muscle to make you look like a tank";
				else if (tone > 50)
					desc += "an extremely substantial frame packing a decent amount of muscle";
				else if (tone > 25)
				{
					desc += "a very wide body";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				}
				else
				{
					desc += "a thick";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += ", voluptuous";
					desc += " body and plush, ";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += " jiggly curves";
					else
						desc += " soft flesh";
				}
			}
			return desc;
		}

		//Camp Development Stage
		public function campDevelopmentStage():String {
			var descC:String;
			if (hasStatusEffect(StatusEffects.AdvancingCamp)) {
				/*if (statusEffectv1(StatusEffects.AdvancingCamp) ) descC = "city";
				else if (statusEffectv1(StatusEffects.AdvancingCamp) =) descC = "town";
				else if (statusEffectv1(StatusEffects.AdvancingCamp) ==) descC = "village";
				else */descC = "hamlet";
			}
			else descC = "camp";
			return descC;
		}

		public function bodyData():BodyData {
			// TODO @aimozg caching?
			return new BodyData(this);
		}
		
		/**
		 * Array of [race:Race, score:int, tier:int], indexed by race id
		 */
		public var racialScores:Array = [];
		public function needToUpdateRacialCache():Boolean {
			// TODO @aimozg caching
			return true;
		}
		public function updateRacialCache():void {
			var body:BodyData = bodyData();
			for each (var race:Race in Races.AllEnabledRaces) {
				var score:int = race.totalScore(body);
				var tier:int = race.getTierNumber(body, score);
				racialScores[race.id] = [race, score, tier];
			}
		}
		public function updateRacialCacheIfNeeded():void {
			if (needToUpdateRacialCache()) {
				updateRacialCache();
			}
		}
		public function racialScoreCached(race:Race):int {
			var entry:Array = racialScores[race.id];
			return entry ? entry[1] : 0;
		}
		public function racialTierCached(race:Race):int {
			var entry:Array = racialScores[race.id];
			return entry ? entry[2] : 0;
		}
		public function isRaceCached(race:Race, minTier:int=1):Boolean {
			return racialTierCached(race) >= minTier;
		}
		
		public function raceObject(useCache:Boolean=false):Race {
			if (!useCache) {
				updateRacialCacheIfNeeded();
			}
			// array of [race,score,tier]
			var scores:Array = racialScores.slice();
			// set human score to 1, so it would be of the lowest priority
			scores[Races.HUMAN.id][1] = 1;
			scores[Races.HUMAN.id][2] = 1;
			// drop races of tier 0
			scores = scores.filter(varargify(function(e:Array):Boolean {
				return e && e[2] > 0;
			}));
			scores.sortOn("1", Array.NUMERIC|Array.DESCENDING);
			return scores[0][0];
		}
		public function race():String {
			updateRacialCache();
			if (grandchimeraScore(true) >= 3) {
				return "grand chimera";
			}
			if (chimeraScore(true) >= 3) {
				return "chimera";
			}
			var topRace:Race = raceObject(true);
			var topScore:Number = racialScoreCached(topRace);
			return topRace.nameFor(bodyData(), topScore);
			/*
			if (TopRace == "alicornkin") {
				if (TopScore >= 12) {
					if (horns.type == Horns.UNICORN) {
						race = "alicornkin";
					} else {
						race = "nightmarekin";
					}
				}
			}
			
			 */
			//if (mutantScore() >= 5 && race == "human")
			//	race = "corrupted mutant";
			//if (humanScore() >= 5 && race == "corrupted mutant")
			//	race = "somewhat human mutant";
			//if (lowerBody == LowerBody.HOOFED && isTaur() && wings.type == Wings.FEATHERED_LARGE) {
			//	race = "pegataur";
			//}
			//if (lowerBody == LowerBody.PONY)
			//	race = "pony-kin";
		}

		public function humanScore():Number {
			return racialScore(Races.HUMAN);
		}
		
		public function isPureHuman():Boolean {
			return humanScore() >= HumanRace.maxScore;
		}
		
		public function racialScore(race:Race):int {
			return race.totalScore(bodyData());
		}
		public function racialTier(race:Race):int {
			return race.getTierNumber(bodyData());
		}
		public function racialTierObject(race:Race):RaceTier {
			return race.getTier(bodyData());
		}
		
		/**
		 * true if player qualifies as specified race and tier (or higher).
		 * DOES NOT mean that this is player's top race!
		 */
		public function isRace(race:Race, minTier:int=1):Boolean {
			return racialTier(race) >= minTier;
		}
		/**
		 * true if player qualifies as any of specified races at least of tier 1.
		 * DOES NOT mean that this is player's top race!
		 */
		public function isAnyRace(...races:/*Race*/Array):Boolean {
			if (races.length == 1 && races[0] is Array) races = flatten(races);
			for each (var race:Race in races) {
				if (isRace(race)) return true;
			}
			return false;
		}
		public function isAnyRaceCached(...races:/*Race*/Array):Boolean {
			if (races.length == 1 && races[0] is Array) races = flatten(races);
			for each (var race:Race in races) {
				if (isRaceCached(race)) return true;
			}
			return false;
		}

		public function racialParagonSelectedRace():Race {
			return Race.byId(flags[kFLAGS.APEX_SELECTED_RACE]);
		}

		//Determine Inner Chimera Rating
		public function internalChimeraRating():Number {
			Begin("Player","racialScore","internalChimeraRating");
			var internalChimeraRatingCounter:Number = 0;
			if (internalChimeraScore() > 0)
				internalChimeraRatingCounter += internalChimeraScore();
			if (hasPerk(PerkLib.ChimericalBodyInitialStage))
				internalChimeraRatingCounter -= 2;//	 2-r2
			if (hasPerk(PerkLib.ChimericalBodySemiBasicStage))
				internalChimeraRatingCounter -= 3;//	 5-r4
			if (hasPerk(PerkLib.ChimericalBodyBasicStage))
				internalChimeraRatingCounter -= 4;//	 9-r8
			if (hasPerk(PerkLib.ChimericalBodySemiImprovedStage))//+1 racials
				internalChimeraRatingCounter -= 5;//	14-r12
			if (hasPerk(PerkLib.ChimericalBodyImprovedStage))
				internalChimeraRatingCounter -= 6;//	20-r18
			if (hasPerk(PerkLib.ChimericalBodySemiAdvancedStage))
				internalChimeraRatingCounter -= 7;//	27-r24
			if (hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				internalChimeraRatingCounter -= 8;//	35-r32
			if (hasPerk(PerkLib.ChimericalBodySemiSuperiorStage))//+1 racials
				internalChimeraRatingCounter -= 9;//	44-r40
			if (hasPerk(PerkLib.ChimericalBodySuperiorStage))
				internalChimeraRatingCounter -= 10;//	54-r50
			if (hasPerk(PerkLib.ChimericalBodySemiPeerlessStage))
				internalChimeraRatingCounter -= 11;//	65-r61
			if (hasPerk(PerkLib.ChimericalBodyPeerlessStage))
				internalChimeraRatingCounter -= 12;//	77-r72
			if (hasPerk(PerkLib.ChimericalBodySemiEpicStage))//+1 racials
				internalChimeraRatingCounter -= 13;//	90-r85
			if (hasPerk(PerkLib.ChimericalBodyEpicStage))
				internalChimeraRatingCounter -= 14;//	104-r99	119	135	152	180	199	219(potem legendary/mythical stages?)
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				internalChimeraRatingCounter -= 20;
			if (jewelryName == "Ezekiel's Signet") internalChimeraRatingCounter -= 1;
			if (jewelryName2 == "Ezekiel's Signet") internalChimeraRatingCounter -= 1;
			if (jewelryName3 == "Ezekiel's Signet") internalChimeraRatingCounter -= 1;
			if (jewelryName4 == "Ezekiel's Signet") internalChimeraRatingCounter -= 1;
			if (headjewelryName == "Ezekiel's Crown") internalChimeraRatingCounter -= 4;
			if (necklaceName == "Ezekiel's Necklace") internalChimeraRatingCounter -= 5;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 0) internalChimeraRatingCounter -= 10;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) internalChimeraRatingCounter -= 5;//tyle ile stopni perków rasowych
			if (internalChimeraRatingCounter < 0 || flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) internalChimeraRatingCounter = 0;
			End("Player","racialScore");
			return internalChimeraRatingCounter;
		}//każdy nowy chimerical body perk wpisywać też do TempleOfTheDivine.as we fragmencie o zostaniu Gargoyle

		//Determine Inner Chimera Score
		public function internalChimeraScore():Number {
			Begin("Player","racialScore","internalChimeraScore");
			var internalChimeraCounter:Number = 0;
			var pMutations:Array = IMutationsLib.mutationsArray("");
			for each (var pPerk:IMutationPerkType in pMutations){
				if (hasMutation(pPerk)) internalChimeraCounter += perkv1(pPerk);
			}
			End("Player","racialScore");
			return internalChimeraCounter;
		}

		public function increaseFromBloodlinePerks():Number {
			var incFBP:Number = 2;
			if (hasPerk(PerkLib.AscensionBloodlineHeritage)) incFBP += 2;
			return incFBP;
		}

		/**
		 * @param useCache true if no need to call `updateRacialCache()`
		 * @return Chimera Race Rating
		 */
		public function chimeraScore(useCache:Boolean=false):Number {
			Begin("Player","racialScore","chimera");
			if (!useCache) updateRacialCache();
			
			var chimeraCounter:Number = 0;
			for each (var race:Race in Races.AllEnabledRaces) {
				if (race.chimeraTier > 0 && isRaceCached(race, race.chimeraTier))
					chimeraCounter++
			}

			End("Player","racialScore");
			return chimeraCounter;
		}

		/**
		 * @param useCache true if no need to call `updateRacialCache()`
		 * @return Grand Chimera Race Rating
		 */
		public function grandchimeraScore(useCache:Boolean = false):Number {
			Begin("Player","racialScore","grandchimera");
			if (!useCache) updateRacialCache();
			
			var grandchimeraCounter:Number = 0;
			for each (var race:Race in Races.AllEnabledRaces) {
				if (race.grandChimeraTier > 0 && isRaceCached(race, race.grandChimeraTier))
					grandchimeraCounter++
			}

			End("Player","racialScore");
			return grandchimeraCounter;
		}
		//Determine Mutant Rating
		public function mutantScore():Number{
			Begin("Player","racialScore","mutant");
			var mutantCounter:Number = 0;
			if (faceType != Face.HUMAN)
				mutantCounter++;
			if (!hasPlainSkinOnly())
				mutantCounter++;
			if (tailType != Tail.NONE)
				mutantCounter++;
			if (cockTotal() > 1)
				mutantCounter++;
			if (hasCock() && hasVagina())
				mutantCounter++;
			if (hasFuckableNipples())
				mutantCounter++;
			if (breastRows.length > 1)
				mutantCounter++;
			if (faceType == Face.HORSE)
			{
				if (hasFur())
					mutantCounter--;
				if (tailType == Tail.HORSE)
					mutantCounter--;
			}
			if (faceType == Face.DOG)
			{
				if (hasFur())
					mutantCounter--;
				if (tailType == Tail.DOG)
					mutantCounter--;
			}
			End("Player","racialScore");
			return mutantCounter;
		}

		public function currentBasicJobs():Number {
			var basicJobs:Number = 0;
			if (hasPerk(PerkLib.JobAllRounder))
				basicJobs++;
			if (hasPerk(PerkLib.JobBeastWarrior))
				basicJobs++;
			if (hasPerk(PerkLib.JobGuardian))
				basicJobs++;
			if (hasPerk(PerkLib.JobLeader))
				basicJobs++;
			if (hasPerk(PerkLib.JobRanger))
				basicJobs++;
			if (hasPerk(PerkLib.JobSeducer))
				basicJobs++;
			if (hasPerk(PerkLib.JobSorcerer))
				basicJobs++;
			if (hasPerk(PerkLib.JobSoulCultivator))
				basicJobs++;
			if (hasPerk(PerkLib.JobWarrior))
				basicJobs++;
			return basicJobs;
		}
		public function currentAdvancedJobs():Number {
			var advancedJobs1:Number = 0;
			if (hasPerk(PerkLib.JobBrawler))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobCourtesan))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobDefender))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobDervish))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobElementalConjurer))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobEnchanter))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobEromancer))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobGolemancer))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobGunslinger))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobHealer))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobHunter))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobKnight))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobMonk))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobRogue))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobSwordsman))
				advancedJobs1++;
			if (hasPerk(PerkLib.JobWarlord))
				advancedJobs1++;
			return advancedJobs1;
		}
		public function maxAdvancedJobs():Number {
			var advancedJobs2:Number = 3;
			if (hasPerk(PerkLib.BasicAllRounderEducation))
				advancedJobs2 += 3;
			if (hasPerk(PerkLib.IntermediateAllRounderEducation))
				advancedJobs2 += 3;
			if (hasPerk(PerkLib.AdvancedAllRounderEducation))
				advancedJobs2 += 3;
			if (hasPerk(PerkLib.ExpertAllRounderEducation))
				advancedJobs2 += 3;
			if (hasPerk(PerkLib.MasterAllRounderEducation))
				advancedJobs2 += 3;
			return advancedJobs2;
		}
		public function freeAdvancedJobsSlots():Number {
			var advancedJobs3:Number = 0;
			advancedJobs3 += maxAdvancedJobs();
			advancedJobs3 -= currentAdvancedJobs();
			return advancedJobs3;
		}
		public function currentPrestigeJobs():Number {
			var prestigeJobs1:Number = 0;
			if (hasPerk(PerkLib.PrestigeJobArcaneArcher))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobArchpriest))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobBerserker))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobBindmaster))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobDruid))
				prestigeJobs1++;
		//	if (hasPerk(PerkLib.PrestigeJobGreySage))
		//		prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobNecromancer))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobSeer))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobSentinel))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobSoulArcher))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobSoulArtMaster))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobSpellKnight))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobStalker))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobTempest))
				prestigeJobs1++;
			if (hasPerk(PerkLib.PrestigeJobWarlock))
				prestigeJobs1++;
			return prestigeJobs1;
		}
		public function maxPrestigeJobs():Number {
			var prestigeJobs2:Number = 2;
			if (hasPerk(PerkLib.MunchkinAtWork))
				prestigeJobs2 += 2;
			if (hasPerk(PerkLib.AscensionBuildingPrestigeX))
				prestigeJobs2 += perkv1(PerkLib.AscensionBuildingPrestigeX);
			return prestigeJobs2;
		}
		public function freePrestigeJobsSlots():Number {
			var prestigeJobs3:Number = 0;
			prestigeJobs3 += maxPrestigeJobs();
			prestigeJobs3 -= currentPrestigeJobs();
			return prestigeJobs3;
		}
		public function currentHiddenJobs():Number {
			var hiddenJobs1:Number = 0;
			if (hasPerk(PerkLib.HiddenJobBloodDemon))
				hiddenJobs1++;
			if (hasPerk(PerkLib.HiddenJobAsura))
				hiddenJobs1++;
			return hiddenJobs1;
		}
		public function maxHiddenJobs():Number {
			var hiddenJobs2:Number = 1;
			if (hasPerk(PerkLib.MunchkinAtWork))
				hiddenJobs2++;
			return hiddenJobs2;
		}
		public function freeHiddenJobsSlots():Number {
			var hiddenJobs3:Number = 0;
			hiddenJobs3 += maxHiddenJobs();
			hiddenJobs3 -= currentHiddenJobs();
			return hiddenJobs3;
		}

		public function maxHeartMutations():Number {
			var heartMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Heart")){
				if (hasMutation(mutation)) heartMutations--;
			}
			return heartMutations;
		}
		public function maxMusclesMutations():Number {
			var musclesMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Muscle")){
				if (hasMutation(mutation)) musclesMutations--;
			}
			return musclesMutations;
		}
		public function maxMouthMutations():Number {
			var mouthMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Mouth")){
				if (hasMutation(mutation)) mouthMutations--;
			}
			return mouthMutations;
		}
		public function maxAdrenalGlandsMutations():Number {
			var adrenalglandsMutations:Number = 1  + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Adrenals")){
				if (hasMutation(mutation)) adrenalglandsMutations--;
			}
			return adrenalglandsMutations;
		}
		public function maxBloodstreamMutations():Number {
			var bloodstreamMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Bloodstream")){
				if (hasMutation(mutation)) bloodstreamMutations--;
			}
			return bloodstreamMutations;
		}
		public function maxFatTissueMutations():Number {
			var fattissueMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("FaT")){
				if (hasMutation(mutation)) fattissueMutations--;
			}
			return fattissueMutations;
		}
		public function maxLungsMutations():Number {
			var lungsMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Lungs")){
				if (hasMutation(mutation)) lungsMutations--;
			}
			return lungsMutations;
		}
		public function maxMetabolismMutations():Number {
			var metabolismMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Metabolism")){
				if (hasMutation(mutation)) metabolismMutations--;
			}
			return metabolismMutations;
		}
		public function maxOvariesMutations():Number {
			var ovariesMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Ovaries")){
				if (hasMutation(mutation)) ovariesMutations--;
			}
			return ovariesMutations;
		}
		public function maxBallsMutations():Number {
			var ballsMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Testicles")){
				if (hasMutation(mutation)) ballsMutations--;
			}
			return ballsMutations;
		}
		public function maxEyesMutations():Number {
			var eyesMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Eyes")){
				if (hasMutation(mutation)) eyesMutations--;
			}
			return eyesMutations;
		}
		public function maxPeripheralNervSysMutations():Number {
			var nervsysMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Nerv/Sys")){
				if (hasMutation(mutation)) nervsysMutations--;
			}
			return nervsysMutations;
		}
		public function maxBonesAndMarrowMutations():Number {
			var bonesandmarrowMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Bone")){
				if (hasMutation(mutation)) bonesandmarrowMutations--;
			}
			return bonesandmarrowMutations;
		}
		public function maxThyroidGlandMutations():Number {
			var thyroidglandMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Thyroid")){
				if (hasMutation(mutation)) thyroidglandMutations--;
			}
			return thyroidglandMutations;
		}
		public function maxParathyroidGlandMutations():Number {
			var parathyroidglandMutations:Number = 1 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("PThyroid")){
				if (hasMutation(mutation)) parathyroidglandMutations--;
			}
			return parathyroidglandMutations;
		}
		public function maxAdaptationsMutations():Number {
			var adaptationsMutations:Number = 2 + maxAscensionBoost();
			for each (var mutation:IMutationPerkType in IMutationsLib.mutationsArray("Adaptations")){
				if (hasMutation(mutation)) adaptationsMutations--;
			}
			return adaptationsMutations;
		}
		public function maxDragonMutations():Number {
			var dragonMutations:Number = 1;
			if (perkv1(IMutationsLib.DraconicBonesIM) >= 1) dragonMutations--;
			if (perkv1(IMutationsLib.DraconicHeartIM) >= 1) dragonMutations--;
			if (perkv1(IMutationsLib.DraconicLungIM) >= 1) dragonMutations--;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) dragonMutations++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2) dragonMutations++;
			return dragonMutations;
		}
		public function maxKitsuneMutations():Number {
			var kitsuneMutations:Number = 1;
			if (perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 1) kitsuneMutations--;
			if (perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 1) kitsuneMutations--;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) kitsuneMutations++;
			return kitsuneMutations;
		}
		public function maxAscensionBoost():Number {
			return perkv1(PerkLib.AscensionAdditionalOrganMutationX);
		}

		public function lactationQ():Number
		{
			if (biggestLactation() < 1)
				return 0;
			//(Milk production TOTAL= breastSize x 10 * lactationMultiplier * breast total * milking-endurance (1- default, maxes at 2.  Builds over time as milking as done)
			//(Small – 0.01 mLs – Size 1 + 1 Multi)
			//(Large – 0.8 - Size 10 + 4 Multi)
			//(HUGE – 2.4 - Size 12 + 5 Multi + 4 tits)
			var total:Number;
			if (!hasStatusEffect(StatusEffects.LactationEndurance))
				createStatusEffect(StatusEffects.LactationEndurance, 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusEffectv1(StatusEffects.LactationEndurance) * totalBreasts();
			if (hasPerk(PerkLib.MilkMaid))
				total += 200 + (perkv1(PerkLib.MilkMaid) * 100);
			if (perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 2)
				total += 200;
			if (hasPerk(PerkLib.ProductivityDrugs))
				total += (perkv3(PerkLib.ProductivityDrugs));
			if (hasPerk(PerkLib.AscensionMilkFaucet))
				total += (perkv1(PerkLib.AscensionMilkFaucet) * 200);
			if (perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3)
				total *= 2.5;
			if (necklaceName == "Cow bell")
				total *= 1.5;
			if (upperGarment == game.undergarments.COW_BRA)
				total *= 1.5;
			if (lowerGarment == game.undergarments.COW_PANTY)
				total *= 1.5;
			if (statusEffectv1(StatusEffects.LactationReduction) >= 48)
				total = total * 1.5;
			if (total > int.MAX_VALUE)
				total = int.MAX_VALUE;
			return total;
		}

		public function isLactating():Boolean
		{
			return lactationQ() > 0;

		}

		public function cuntChange(cArea:Number, display:Boolean, spacingsF:Boolean = false, spacingsB:Boolean = true):Boolean {
			if (vaginas.length==0) return false;
			var wasVirgin:Boolean = vaginas[0].virgin;
			var stretched:Boolean = cuntChangeNoDisplay(cArea);
			var devirgined:Boolean = wasVirgin && !vaginas[0].virgin;
			if (devirgined){
				if(spacingsF) outputText("  ");
				outputText("<b>Your hymen is torn, robbing you of your virginity.</b>");
				if(spacingsB) outputText("  ");
			}
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(display && stretched) {
				//Virgins get different formatting
				if(devirgined) {
					//If no spaces after virgin loss
					if(!spacingsB) outputText("  ");
				}
				//Non virgins as usual
				else if(spacingsF) outputText("  ");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR) outputText("<b>Your " + Appearance.vaginaDescript(this,0)+ " is stretched painfully wide, large enough to accommodate most beasts and demons.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched so wide that it gapes continually.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now very loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now a little loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched out to a more normal size.</b>");
				if(spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function buttChange(cArea:Number, display:Boolean, spacingsF:Boolean = true, spacingsB:Boolean = true):Boolean
		{
			var stretched:Boolean = buttChangeNoDisplay(cArea);
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(stretched && display) {
				if (spacingsF) outputText("  ");
				buttChangeDisplay();
				if (spacingsB) outputText("  ");
			}
			return stretched;
		}

		/**
		 * Refills player's hunger. 'amnt' is how much to refill, 'nl' determines if new line should be added before the notification.
		 * @param	amnt
		 * @param	nl
		 */
		public function refillHunger(amnt:Number = 0, nl:Boolean = true):void {
			var hungerActive:Boolean = false;
			if (flags[kFLAGS.HUNGER_ENABLED] > 0) hungerActive = true;
			if (hungerActive) {
				if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 2 || flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 3) hungerActive = false;
				else if (hasPerk(PerkLib.DeadMetabolism)) hungerActive = false;
				else if (hasPerk(PerkLib.GargoylePure) || hasPerk(PerkLib.GargoyleCorrupted)) hungerActive = false;
			}
			if (flags[kFLAGS.IN_PRISON] > 0) hungerActive = true;
			if (hungerActive) {
				var oldHunger:Number = hunger;
				var weightChange:int = 0;
				var overeatingLimit:int = 0;
				overeatingLimit += 10;
				if (hasPerk(PerkLib.IronStomach)) overeatingLimit += 5;
				if (hasPerk(PerkLib.IronStomachEx)) overeatingLimit += 10;
				if (hasPerk(PerkLib.IronStomachSu)) overeatingLimit += 15;/*(perki muszą dać zwiekszenie limitu przejedzenia sie bez przyrostu wagi powyżej 10 ^^)
				overeatingLimit += 10;overating perk chyba			perki overating dające stałe utrzymywanie hunger powyżej limitu max hunger dopóki hunger naturalnie nie zostanie zużyty xD
				overeatingLimit += 20;overeating ex perk chyba		achiev polegający na przeżyciu x dni bez jedzenie czegokolwiek wiec każde podniesienie hunger resetuje ten timer xD
				overeatingLimit += 40;overeating su perk chyba*/
				hunger += amnt;
				if (hunger > maxHunger()) {
					while (hunger > (maxHunger() + overeatingLimit) && !SceneLib.prison.inPrison) {
						weightChange++;
						hunger -= overeatingLimit;
					}
					modThickness(maxThicknessCap(), weightChange);
					hunger = maxHunger();
				}
				if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
				//game.dynStats("lus", 0, "scale", false);
				if (nl) outputText("\n\n");
				//Messages
				if (hunger < maxHunger() * 0.1) outputText("<b>You still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.1 && hunger < maxHunger() * 0.25) outputText("<b>You are no longer starving but you still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.25 && hunger < maxHunger() * 0.5) outputText("<b>The growling sound in your stomach seems to quiet down. </b>");
				else if (hunger >= maxHunger() * 0.5 && hunger < maxHunger() * 0.75) outputText("<b>Your stomach no longer growls. </b>");
				else if (hunger >= maxHunger() * 0.75 && hunger < maxHunger() * 0.9) outputText("<b>You feel so satisfied. </b>");
				else if (hunger >= maxHunger() * 0.9) outputText("<b>Your stomach feels so full. </b>");
				if (weightChange > 0) outputText("<b>You feel like you've put on some weight. </b>");
				EngineCore.awardAchievement("Tastes Like Chicken ", kACHIEVEMENTS.REALISTIC_TASTES_LIKE_CHICKEN);
				if (oldHunger < 1 && hunger >= 100) EngineCore.awardAchievement("Champion Needs Food Badly (1)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD);
				if (oldHunger < 1 && hunger >= 250) EngineCore.awardAchievement("Champion Needs Food Badly (2)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD_2);
				if (oldHunger < 1 && hunger >= 500) EngineCore.awardAchievement("Champion Needs Food Badly (3)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD_3);
				if (oldHunger < 1 && hunger >= 1000) EngineCore.awardAchievement("Champion Needs Food Badly (4)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD_4);
				if (oldHunger >= 90) EngineCore.awardAchievement("Glutton ", kACHIEVEMENTS.REALISTIC_GLUTTON);
				if (oldHunger >= 240) EngineCore.awardAchievement("Epic Glutton ", kACHIEVEMENTS.REALISTIC_EPIC_GLUTTON);
				if (oldHunger >= 490) EngineCore.awardAchievement("Legendary Glutton ", kACHIEVEMENTS.REALISTIC_LEGENDARY_GLUTTON);
				if (oldHunger >= 990) EngineCore.awardAchievement("Mythical Glutton ", kACHIEVEMENTS.REALISTIC_MYTHICAL_GLUTTON);
				if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
				dynStats("lus", 0, "scale", false);
				EngineCore.statScreenRefresh();
			}
		}
		public function refillGargoyleHunger(amnt:Number = 0, nl:Boolean = true):void {
			var oldHunger:Number = hunger;
			hunger += amnt;
			if (hunger > maxHunger()) hunger = maxHunger();
			if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
			//game.dynStats("lus", 0, "scale", false);
			if (nl) outputText("\n");
			if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
			dynStats("lus", 0, "scale", false);
			EngineCore.statScreenRefresh();
		}

		/**
		 * Damages player's hunger. 'amnt' is how much to deduct.
		 * @param	amnt
		 */
		public function damageHunger(amnt:Number = 0):void {
			var oldHunger:Number = hunger;
			hunger -= amnt;
			if (hunger < 0) hunger = 0;
			if (hunger < oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatDown('hunger');
			dynStats("lus", 0, "scale", false);
		}

		public function get corruptionTolerance():int {
			var temp:int = perkv1(PerkLib.AscensionTolerance) * 5;
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] > 0) temp += 100;
			return temp;
		}
		public function get corAdjustedUp():Number {
			return boundFloat(0, cor + corruptionTolerance, 100);
		}
		public function get corAdjustedDown():Number {
			return boundFloat(0, cor - corruptionTolerance, 100);
		}

		public function playerMinionsCount():Number {
			var minions:Number = 0;
			if (hasStatusEffect(StatusEffects.SummonedElementals)) {
				minions += statusEffectv1(StatusEffects.SummonedElementals);
				minions += statusEffectv2(StatusEffects.SummonedElementals);
				minions += statusEffectv3(StatusEffects.SummonedElementals);
			}
			if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] > 0) minions += flags[kFLAGS.PERMANENT_GOLEMS_BAG];
			if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] > 0) minions += flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG];
			if (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] > 0) minions += flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG];
			if (hasPerk(PerkLib.PrestigeJobNecromancer)) {
				minions += perkv2(PerkLib.PrestigeJobNecromancer);
				minions += perkv1(PerkLib.GreaterHarvest);
				minions += perkv2(PerkLib.GreaterHarvest);
			}
			return minions;
		}

		public static function NewGamePlusMod():int {
			var temp:int = CoC.instance.flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			//Constrains value between 0 and 5.
			if (temp < 0) temp = 0;
			if (temp > 5) temp = 5;
			return temp;
		}
		public function newGamePlusMod():int {
			return NewGamePlusMod();
		}
		
		public static function NewGamePlusFactor():Number {
			return NewGamePlusMod()+1;
		}

		public function buttChangeDisplay():void
		{	//Allows the test for stretching and the text output to be separated
			if (ass.analLooseness == 5) outputText("<b>Your " + Appearance.assholeDescript(this) + " is stretched even wider, capable of taking even the largest of demons and beasts.</b>");
			if (ass.analLooseness == 4) outputText("<b>Your " + Appearance.assholeDescript(this) + " becomes so stretched that it gapes continually.</b>");
			if (ass.analLooseness == 3) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now very loose.</b>");
			if (ass.analLooseness == 2) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now a little loose.</b>");
			if (ass.analLooseness == 1) outputText("<b>You have lost your anal virginity.</b>");
		}

		public function slimeFeed():void{
			if (hasStatusEffect(StatusEffects.SlimeCraving)) {
				//Reset craving value
				changeStatusValue(StatusEffects.SlimeCraving,1,0);
				//Flag to display feed update and restore stats in event parser
				if(!hasStatusEffect(StatusEffects.SlimeCravingFeed)) {
					createStatusEffect(StatusEffects.SlimeCravingFeed,0,0,0,0);
				}
				var Ammount:Number = 30;
				if ((hunger+Ammount)>maxHunger()) Ammount = (maxHunger()-hunger-1);
				refillHunger(Ammount);
				slimeGrowth();
			}
			if (hasPerk(PerkLib.Diapause)) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] += 3 + rand(3);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 1;
			}
			if (isGargoyle() && hasPerk(PerkLib.GargoyleCorrupted)) refillGargoyleHunger(30);
			if (isRace(Races.JIANGSHI) && hasPerk(PerkLib.EnergyDependent)) EnergyDependentRestore();
		}

		public function minoCumAddiction(raw:Number = 10):void {
			//Increment minotaur cum intake count
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340]++;
			//Fix if variables go out of range.
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;

			//Turn off withdrawal
			//if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
			//Reset counter
			flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] = 0;
			//If highly addicted, rises slower
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 60) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 80) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 90) raw /= 2;
			if(hasPerk(PerkLib.MinotaurCumResistance) || hasPerk(PerkLib.ManticoreCumAddict) || hasPerk(PerkLib.HaltedVitals) || hasPerk(PerkLib.LactaBovineImmunity)) raw *= 0;
			//If in withdrawl, readdiction is potent!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) raw += 10;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) raw += 5;
			raw = Math.round(raw * 100)/100;
			//PUT SOME CAPS ON DAT' SHIT
			if(raw > 50) raw = 50;
			if(raw < -50) raw = -50;
			if(!hasPerk(PerkLib.ManticoreCumAddict) || !hasPerk(PerkLib.LactaBovineImmunity) || necklaceName != "Cow bell") flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] += raw;
			//Recheck to make sure shit didn't break
			if(hasPerk(PerkLib.MinotaurCumResistance)) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0; //Never get addicted!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
		}

		public function hasSpells():Boolean
		{
			return spellCount() > 0 || hasPerk(PerkLib.JobSorcerer);
		}

		public function spellCount():Number
		{
			return [StatusEffects.KnowsAcidRain, StatusEffects.KnowsAcidSpray, StatusEffects.KnowsAegis, StatusEffects.KnowsArcticGale, StatusEffects.KnowsArouse, StatusEffects.KnowsBalanceOfLife, StatusEffects.KnowsBlind, StatusEffects.KnowsBlink, StatusEffects.KnowsBlizzard, StatusEffects.KnowsBloodChains, StatusEffects.KnowsBloodExplosion, StatusEffects.KnowsBloodField,
			StatusEffects.KnowsBloodMissiles, StatusEffects.KnowsBloodShield, StatusEffects.KnowsBloodWave, StatusEffects.KnowsBoneArmor, StatusEffects.KnowsBoneshatter, StatusEffects.KnowsBoneSpirit, StatusEffects.KnowsChainLighting, StatusEffects.KnowsCharge, StatusEffects.KnowsChargeA, StatusEffects.KnowsClearMind, StatusEffects.KnowsCorrosiveWave, StatusEffects.KnowsCure,
			StatusEffects.KnowsConsumingDarkness, StatusEffects.KnowsCurseOfDesire, StatusEffects.KnowsCurseOfWeeping, StatusEffects.KnowsDarknessShard, StatusEffects.KnowsDivineShield, StatusEffects.KnowsDuskWave, StatusEffects.KnowsExorcise, StatusEffects.KnowsEnergyDrain, StatusEffects.KnowsFireStorm, StatusEffects.KnowsHeal, StatusEffects.KnowsHydroAcid,
			StatusEffects.KnowsIceRain, StatusEffects.KnowsIceSpike, StatusEffects.KnowsLifeSiphon, StatusEffects.KnowsLifestealEnchantment, StatusEffects.KnowsLifetap, StatusEffects.KnowsLightningBolt, StatusEffects.KnowsManaShield, StatusEffects.KnowsMentalShield, StatusEffects.KnowsMight, StatusEffects.KnowsNosferatu, StatusEffects.KnowsRegenerate, StatusEffects.KnowsRestore,
			StatusEffects.KnowsShatterstone, StatusEffects.KnowsStalagmite, StatusEffects.KnowsTearsOfDenial, StatusEffects.KnowsThunderstorm, StatusEffects.KnowsWaterBall, StatusEffects.KnowsWaterSphere, StatusEffects.KnowsWhitefire, StatusEffects.KnowsWindBlast, StatusEffects.KnowsWindBullet]
					.filter(function(item:StatusEffectType, index:int, array:Array):Boolean{
						return this.hasStatusEffect(item);},this)
					.length;
		}
		public function spellCountWhiteBlack():Number
		{
			return [StatusEffects.KnowsIceSpike, StatusEffects.KnowsDarknessShard, StatusEffects.KnowsMight, StatusEffects.KnowsBlink, StatusEffects.KnowsRegenerate, StatusEffects.KnowsArouse, StatusEffects.KnowsWhitefire, StatusEffects.KnowsLightningBolt, StatusEffects.KnowsCharge, StatusEffects.KnowsChargeA, StatusEffects.KnowsHeal, StatusEffects.KnowsBlind,
			StatusEffects.KnowsPyreBurst, StatusEffects.KnowsChainLighting, StatusEffects.KnowsArcticGale, StatusEffects.KnowsDuskWave, StatusEffects.KnowsBlizzard, StatusEffects.KnowsNosferatu, StatusEffects.KnowsCure, StatusEffects.KnowsMentalShield, StatusEffects.KnowsFireStorm, StatusEffects.KnowsIceRain]
					.filter(function(item:StatusEffectType, index:int, array:Array):Boolean{
						return this.hasStatusEffect(item);},this)
					.length;
		}

		public function armorDescript(nakedText:String = "gear"):String
		{
			var textArray:Array = [];
			var text:String = "";
			//if (armor != ArmorLib.NOTHING) text += armorName;
			//Join text.
			if (armor != ArmorLib.NOTHING) textArray.push(armor.name);
			if (upperGarment != UndergarmentLib.NOTHING) textArray.push(upperGarmentName);
			if (lowerGarment != UndergarmentLib.NOTHING) textArray.push(lowerGarmentName);
			if (textArray.length > 0) text = formatStringArray(textArray);
			//Naked?
			if (upperGarment == UndergarmentLib.NOTHING && lowerGarment == UndergarmentLib.NOTHING && armor == ArmorLib.NOTHING) text = nakedText;
			return text;
		}

		public function clothedOrNaked(clothedText:String, nakedText:String = ""):String
		{
			return (armorDescript() != "gear" ? clothedText : nakedText);
		}

		public function clothedOrNakedLower(clothedText:String, nakedText:String = ""):String
		{
			return (armorName != "gear" && !(armorName == "lethicite armor" && lowerGarmentName == "nothing") && !isTaur() ? clothedText : nakedText);
		}

		public function addToWornClothesArray(armor:Armor):void {
			for (var i:int = 0; i < previouslyWornClothes.length; i++) {
				if (previouslyWornClothes[i] == armor.shortName) return; //Already have?
			}
			previouslyWornClothes.push(armor.shortName);
		}

		public function shrinkTits(ignore_hyper_happy:Boolean=false):void
		{
			if (flags[kFLAGS.HYPER_HAPPY] && !ignore_hyper_happy)
			{
				return;
			}
			if(breastRows.length == 1) {
				if(breastRows[0].breastRating > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number;
					temp = 1;
					breastRows[0].breastRating--;
					//Shrink again 50% chance
					if(breastRows[0].breastRating >= 1 && rand(2) == 0 && !hasPerk(PerkLib.BigTits)) {
						temp++;
						breastRows[0].breastRating--;
					}
					if(breastRows[0].breastRating < 0) breastRows[0].breastRating = 0;
					//Talk about shrinkage
					if(temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
					if(temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
				}
			}
			else if(breastRows.length > 1) {
				//multiple
				outputText("\n");
				//temp2 = amount changed
				//temp3 = counter
				var temp2:Number = 0;
				var temp3:Number = breastRows.length;
				while(temp3 > 0) {
					temp3--;
					if(breastRows[temp3].breastRating > 0) {
						breastRows[temp3].breastRating--;
						if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
						temp2++;
						outputText("\n");
						if(temp3 < breastRows.length - 1) outputText("...and y");
						else outputText("Y");
						outputText("our " + breastDescript(temp3) + " shrink, dropping to " + breastCup(temp3) + "s.");
					}
					if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
				}
				if(temp2 == 2) outputText("\nYou feel so much lighter after the change.");
				if(temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
				if(temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
			}
		}

		public function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number):void
		{
			if(breastRows.length == 0) return;
			//GrowthType 1 = smallest grows
			//GrowthType 2 = Top Row working downward
			//GrowthType 3 = Only top row
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Chance for "big tits" perked characters to grow larger!
			if(hasPerk(PerkLib.BigTits) && rand(3) == 0 && amount < 1) amount=1;

			// Needs to be a number, since uint will round down to 0 prevent growth beyond a certain point
			var temp:Number = breastRows.length;
			if(growthType == 1) {
				//Select smallest breast, grow it, move on
				while(rowsGrown > 0) {
					//Temp = counter
					temp = breastRows.length;
					//Temp2 = smallest tits index
					temp2 = 0;
					//Find smallest row
					while(temp > 0) {
						temp--;
						if(breastRows[temp].breastRating < breastRows[temp2].breastRating) temp2 = temp;
					}
					//Temp 3 tracks total amount grown
					temp3 += amount;
					trace("Breastrow chosen for growth: " + String(temp2) + ".");
					//Reuse temp to store growth amount for diminishing returns.
					temp = amount;
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						//Diminishing returns!
						if(breastRows[temp2].breastRating > 3)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=1.5;
							else
								temp /=1.3;
						}

						// WHy are there three options here. They all have the same result.
						if(breastRows[temp2].breastRating > 7)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 9)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 12)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp  /=1.5;
						}
					}

					//Grow!
					trace("Growing breasts by ", temp);
					breastRows[temp2].breastRating += temp;
					rowsGrown--;
				}
			}

			if (!flags[kFLAGS.HYPER_HAPPY])
			{
				//Diminishing returns!
				if(breastRows[0].breastRating > 3) {
					if(!hasPerk(PerkLib.BigTits)) amount/=1.5;
					else amount/=1.3;
				}
				if(breastRows[0].breastRating > 7) {
					if(!hasPerk(PerkLib.BigTits)) amount/=2;
					else amount /= 1.5;
				}
				if(breastRows[0].breastRating > 12) {
					if(!hasPerk(PerkLib.BigTits)) amount/=2;
					else amount /= 1.5;
				}
			}

			if(growthType == 2) {
				temp = 0;
				//Start at top and keep growing down, back to top if hit bottom before done.
				while(rowsGrown > 0) {
					if(temp+1 > breastRows.length) temp = 0;
					breastRows[temp].breastRating += amount;
					trace("Breasts increased by " + amount + " on row " + temp);
					temp++;
					temp3 += amount;
					rowsGrown--;
				}
			}
			if(growthType == 3) {
				while(rowsGrown > 0) {
					rowsGrown--;
					breastRows[0].breastRating += amount;
					temp3 += amount;
				}
			}
			//Breast Growth Finished...talk about changes.
			trace("Growth amount = ", amount);
			if(display) {
				if(growthType < 3) {
					if(amount <= 2)
					{
						if(breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.");
					}
					else if(amount <= 4)
					{
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					else
					{
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
				else
				{
					if(amount <= 2) {
						if(breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
					}
					if(amount > 2 && amount <= 4) {
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					if(amount > 4) {
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
			}
		}

		public override function getAllMinStats():Object {
			var minStr:int = 1;
			var minTou:int = 1;
			var minSpe:int = 1;
			var minInt:int = 1;
			var minWis:int = 1;
			var minLib:int = 0;
			var minSen:int = 10;
			var minCor:int = 0;
			//Minimum Libido
			if (this.gender > 0) minLib += 5;

			if (this.armorName == "lusty maiden's armor") {
				if (minLib < 50) minLib = 50;
			}
			if (minLib < (minLust() * 2 / 3) && this.hasPerk(PerkLib.GargoylePure))
			{
				minLib = (minLust() * 2 / 3);
			}
			if (this.jewelryEffectId == JewelryLib.PURITY)
			{
				minLib -= this.jewelryEffectMagnitude;
			}
			if (this.hasPerk(PerkLib.PurityBlessing)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.HistoryReligious) || this.hasPerk(PerkLib.PastLifeReligious)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.PewWarmer)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Acolyte)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Priest)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Pastor)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Saint)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Cardinal)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.Pope)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.GargoylePure)) {
				minLib = 5;
				minSen = 5;
			}
			if (this.hasPerk(PerkLib.GargoyleCorrupted)) {
				minSen += 15;
			}
			if (isRace(Races.BEE)) minLib += 20;
			//Factory Perks
			if (this.hasPerk(PerkLib.DemonicLethicite)) {minCor+=10;minLib+=10;}
			if (this.hasPerk(PerkLib.ProductivityDrugs)) {minLib+=this.perkv1(PerkLib.ProductivityDrugs);minCor+=10;}
			//Minimum Sensitivity
			//Rings
			if (this.jewelryName == "Ring of Libido") minLib += 5;
			if (this.jewelryName2 == "Ring of Libido") minLib += 5;
			if (this.jewelryName3 == "Ring of Libido") minLib += 5;
			if (this.jewelryName4 == "Ring of Libido") minLib += 5;
			if (this.jewelryName == "Ring of Sensitivity") minSen += 5;
			if (this.jewelryName2 == "Ring of Sensitivity") minSen += 5;
			if (this.jewelryName3 == "Ring of Sensitivity") minSen += 5;
			if (this.jewelryName4 == "Ring of Sensitivity") minSen += 5;
			//Other
			if (this.hasPerk(PerkLib.GoblinoidBlood)) {
				if (this.hasKeyItem("Drug injectors") >= 0) {
					minLib += 25;
					minSen += 5;
				}
				if (this.hasKeyItem("Improved Drug injectors") >= 0) {
					minLib += 50;
					minSen += 10;
				}
				if (this.hasKeyItem("Potent Drug injectors") >= 0) {
					minLib += 75;
					minSen += 15;
				}
				if (this.hasKeyItem("Power bracer") >= 0) minSen += 5;
				if (this.hasKeyItem("Powboy") >= 0) minSen += 10;
				if (this.hasKeyItem("M.G.S. bracer") >= 0) minSen += 15;
			}
			if (hasPerk(PerkLib.Soulless)) minCor += 50;
			if (hasPerk(PerkLib.Phylactery)) minCor = 100;
			if (hasPerk(PerkLib.BlessingOfTheAncestorTree)) minCor = 50;
			if (this.hasPerk(PerkLib.PurityElixir)) minCor -= (this.perkv1(PerkLib.PurityElixir) * 20);
			if (minLib < 1) minLib = 1;
			if (minCor < 0) minCor = 0;
			if (minCor > 100) minCor = 100;
			return {
				str:minStr,
				tou:minTou,
				spe:minSpe,
				inte:minInt,
				wis:minWis,
				lib:minLib,
				sens:minSen,
				cor:minCor
			};
		}

		//Determine minimum lust
		public override function minLust():Number
		{
			var min:Number = 0;
			var minCap:Number = maxLust();
			//Bimbo body boosts minimum lust by 40
			if (hasPerk(PerkLib.BimboBody) || hasPerk(PerkLib.BroBody) || hasPerk(PerkLib.FutaForm)) min += Math.round(minCap * 0.2);
			if (hasStatusEffect(StatusEffects.BimboChampagne)) min += Math.round(minCap * 0.1);
			//Omnibus' Gift
			if (hasPerk(PerkLib.OmnibusGift)) min += Math.round(minCap * 0.35);
			//Easter bunny eggballs
			if (hasPerk(PerkLib.EasterBunnyBalls)) min += 10*ballSize;
			//Fera Blessing
			if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) min += Math.round(minCap * 0.15);
			//Nymph perk raises to 30
			if (hasPerk(PerkLib.Nymphomania)) min += Math.round(minCap * 0.15);
			//Oh noes anemone!
			if (hasStatusEffect(StatusEffects.AnemoneArousal)) min += Math.round(minCap * 0.3);
			//Hot blooded perk raises min lust!
			if (hasPerk(PerkLib.HotBlooded)) min += Math.round(minCap * 0.2);
			if (hasPerk(PerkLib.LuststickAdapted)) min += Math.round(minCap * 0.1);
			if (hasStatusEffect(StatusEffects.Infested)) min += Math.round(minCap * 0.5);
			//Add points for Crimstone
			min += Math.round(minCap * perkv1(PerkLib.PiercedCrimstone) * 0.01);
			//Subtract points for Icestone!
			min -= Math.round(minCap * perkv1(PerkLib.PiercedIcestone) * 0.01);
			min += Math.round(minCap * perkv1(PerkLib.PentUp) * 0.01);
			//Cold blooded perk reduces min lust, to a minimum of 20! Takes effect after piercings.
			if (hasPerk(PerkLib.ColdBlooded)) {
				if (min >= Math.round(minCap * 0.2)) min -= Math.round(minCap * 0.2);
				else min = 0;
			}
			//Purity Blessing perk reduce min lust, to a minimum of 10! Takes effect after piercings.
			if (hasPerk(PerkLib.PurityBlessing)) {
				if (min >= Math.round(minCap * 0.1)) min -= Math.round(minCap * 0.1);
				else min = 0;
			}
			//Harpy Lipstick and Drunken Power statuses rise minimum lust by 50.
			if(hasStatusEffect(StatusEffects.Luststick)) min += Math.round(minCap * 0.5);
			if(hasStatusEffect(StatusEffects.DrunkenPower)) min += Math.round(minCap * 0.5);
			//SHOULDRA BOOSTS
			//+20
			if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -168 && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75) {
				min += Math.round(minCap * 0.1);
				if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -216)
					min += Math.round(minCap * 0.15);
			}
			//cumOmeter
			if (tailType == Tail.MANTICORE_PUSSYTAIL && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25) {
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 20) min += Math.round(minCap * 0.05);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 20 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 15) min += Math.round(minCap * 0.1);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 15 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 10) min += Math.round(minCap * 0.15);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 10 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 5) min += Math.round(minCap * 0.2);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 5) min += Math.round(minCap * 0.25);
			}
			//MilkOMeter
			if (rearBody.type == RearBody.DISPLACER_TENTACLES && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25) {
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 20) min += Math.round(minCap * 0.05);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 20 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 15) min += Math.round(minCap * 0.1);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 15 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 10) min += Math.round(minCap * 0.15);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 10 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 5) min += Math.round(minCap * 0.2);
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 5) min += Math.round(minCap * 0.25);
			}
			//SPOIDAH BOOSTS
			if(eggs() >= 20) {
				min += Math.round(minCap * 0.1);
				if(eggs() >= 40) min += Math.round(minCap * 0.1);
			}
			//Werebeast
			if (hasPerk(PerkLib.Lycanthropy)) min += Math.round(minCap * perkv1(PerkLib.Lycanthropy) * 0.01);
			//Jewelry effects
			if (jewelryEffectId == JewelryLib.MODIFIER_MINIMUM_LUST)
			{
				min += jewelryEffectMagnitude;
				if (min > (minCap - jewelryEffectMagnitude) && jewelryEffectMagnitude < 0)
				{
					minCap += jewelryEffectMagnitude;
				}
			}
			if (armorName == "lusty maiden's armor" || armorName == "Succubus armor") min += Math.round(minCap * 0.3);
			if (armorName == "tentacled bark armor") min += Math.round(minCap * 0.2);
			if (hasPerk(PerkLib.HotNCold) && min > Math.round(minCap * 0.75)) min = Math.round(minCap * 0.75); 
			//Constrain values
			if (min < 0) min = 0;
			if (min > minCap) min = minCap;
			return min;
		}

		public function maxToneCap():Number {
			var maxToneCap:Number = 100;
			if (perkv1(IMutationsLib.OniMusculatureIM) >= 1) maxToneCap += 10;
			if (perkv1(IMutationsLib.OniMusculatureIM) >= 2) maxToneCap += 20;
			if (perkv1(IMutationsLib.OniMusculatureIM) >= 3) maxToneCap += 30;
			if (perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 2) maxToneCap += 10;
			return maxToneCap;
		}
		public function maxThicknessCap():Number {
			var maxThicknessCap:Number = 100;
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 1) maxThicknessCap += 10;
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 2) maxThicknessCap += 20;
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 3) maxThicknessCap += 30;
			if (perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 2) maxThicknessCap += 10;
			return maxThicknessCap;
		}

		public function calcRacialBuffs(useCache:Boolean=false):Object {
			var score:Number;
			var body:BodyData = bodyData();
			var buffStr:Number = 0;
			var buffTou:Number = 0;
			var buffSpe:Number = 0;
			var buffInt:Number = 0;
			var buffWis:Number = 0;
			var buffLib:Number = 0;
			var buffAll:Number = 0;
			var currentSen:Number = 0;
			var buffs:Object = {};
			//Alter max stats depending on race (+15 za pkt)
			if (!useCache) {
				updateRacialCache();
			}
			for each (var race:Race in Races.AllEnabledRaces) {
				var tier:RaceTier = race.tier(racialTierCached(race));
				if (tier && tier.hasBuffs()) {
					StatUtils.mergeBuffObjects(buffs, tier.buffs(body));
				}
			}
			
			// These buffs below should be documented in PlayerAppearance.RacialScores section!
			
			var factor:Number = 0;
			if (hasCoatOfType(Skin.CHITIN)) factor += 2;
			else if (hasCoatOfType(Skin.SCALES)) factor += 1;
			if (hasPerk(PerkLib.ThickSkin)) factor += 1;
			score = perkv1(IMutationsLib.MantislikeAgilityIM);
			if (score >= 3) {
				buffSpe += 30*factor;
			} else if (score >= 2) {
				buffSpe += 15*factor;
			} else if (score >= 1) {
				buffSpe += 5*factor;
			}
			
			if (hasPerk(PerkLib.Flexibility) && isAnyRaceCached(Races.CatlikeRaces)) {
				buffSpe += 10;
			}
			if (isNaga()) {
				if (lowerBody == LowerBody.FROSTWYRM) {
					buffStr += 20;
					buffTou += 10;
				} else {
					buffStr += 15;
					buffSpe += 15;
				}
			}
			if (isTaur()) {
				buffSpe += 20;
			}
			if (isDrider()) {
				if (lowerBody == LowerBody.CANCER) {
					buffStr += 15;
					buffSpe += 5;
					buffTou += 10;
				} else {
					buffTou += 15;
					buffSpe += 15;
				}
			}
			if (isScylla()) {
				buffStr += 30;
			}
			if (isKraken()) {
				buffStr += 60;
				currentSen += 15;
			}
			if (lowerBody == LowerBody.CENTIPEDE) {
				buffStr += 15;
				buffTou += 5;
				buffSpe += 10;
			}
			if (isAlraune()) {
				buffTou += 15;
				buffLib += 15;
			}
			score = internalChimeraScore();
			if (score >= 1 && !hasPerk(PerkLib.RacialParagon)) {
				buffAll += 5 * score;
			}
			if (hasPerk(PerkLib.RacialParagon)) {
				buffAll += level;
			}
			if (hasPerk(PerkLib.Apex)) {
				buffAll += 2 * level;
			}
			if (hasPerk(PerkLib.AlphaAndOmega)) {
				buffAll += 2 * level;
			}
			if (hasPerk(PerkLib.AscensionOneRaceToRuleThemAllX)) {
				buffAll += 2 * perkv1(PerkLib.AscensionOneRaceToRuleThemAllX) * level;
			}
			StatUtils.mergeBuffObjects(buffs, {
				"str.mult": (buffStr+buffAll)/100,
				"tou.mult": (buffTou+buffAll)/100,
				"spe.mult": (buffSpe+buffAll)/100,
				"int.mult": (buffInt+buffAll)/100,
				"wis.mult": (buffWis+buffAll)/100,
				"lib.mult": (buffLib+buffAll)/100,
				"sens": currentSen
			});
			return buffs;
		}

		public function updateRacialAndPerkBuffs():void{
			updateRacialCache();
			if (hasPerk(PerkLib.TitanicStrength)) statStore.replaceBuffObject({'str.mult':(0.01 * Math.round(tallness*4))}, 'Titanic Strength', { text: 'Titanic Strength' });
			if (!hasPerk(PerkLib.TitanicStrength) && statStore.hasBuff('Titanic Strength')) statStore.removeBuffs('Titanic Strength');
			if (hasPerk(PerkLib.Enigma)) statStore.replaceBuffObject({'str.mult':Math.round(((intStat.mult.value/2)+(wisStat.mult.value/2))),'tou.mult':Math.round(((intStat.mult.value/2)+(wisStat.mult.value/2)))}, 'Enigma', { text: 'Enigma' });
			if (!hasPerk(PerkLib.Enigma) && statStore.hasBuff('Enigma')) statStore.removeBuffs('Enigma');
			if (hasPerk(PerkLib.AvatorOfCorruption) && isRaceCached(Races.UNICORN,2)) statStore.replaceBuffObject({'lib.mult':Math.round(intStat.mult.value/2)}, 'Avatar Of Corruption', { text: 'Avatar Of Corruption' });
			if ((!hasPerk(PerkLib.AvatorOfCorruption) || !isRaceCached(Races.UNICORN,2)) && statStore.hasBuff('Avatar Of Corruption')) statStore.removeBuffs('Avatar Of Corruption');
			if (hasPerk(PerkLib.AvatorOfPurity) && isRaceCached(Races.UNICORN,2)) statStore.replaceBuffObject({'wis.mult':Math.round(intStat.mult.value/2)}, 'Avatar Of Purity', { text: 'Avatar Of Purity' });
			if ((!hasPerk(PerkLib.AvatorOfPurity) || !isRaceCached(Races.UNICORN,2)) && statStore.hasBuff('Avatar Of Purity')) statStore.removeBuffs('Avatar Of Purity');
			if (hasPerk(PerkLib.StrengthOfStone)) statStore.replaceBuffObject({'str.mult':(0.01 * Math.round(tou/2))}, 'Strength of stone', { text: 'Strength of stone' });
			if (!hasPerk(PerkLib.StrengthOfStone) && statStore.hasBuff('Strength of stone')) statStore.removeBuffs('Strength of stone');
			if (hasPerk(PerkLib.PsionicEmpowerment)) statStore.replaceBuffObject({'int.mult':(0.01 * Mindbreaker.MindBreakerFullConvert)}, 'Psionic Empowerment', { text: 'Psionic Empowerment' });
			var power:Number = 0;
			if (hasPerk(PerkLib.BullStrength)){
				if (isRaceCached(Races.COW, 2)) power = lactationQ()*0.001;
				if (isRaceCached(Races.MINOTAUR, 2) >= 15) power = cumCapacity()*0.001;
				if (power > 0.5) power = 0.5;
				statStore.replaceBuffObject({'str.mult':(Math.round(power))}, 'Bull Strength', { text: 'Bull Strength' });
			}
			if (!hasPerk(PerkLib.BullStrength) && statStore.hasBuff('Bull Strength')) statStore.removeBuffs('Bull Strength');
			if (hasPerk(PerkLib.UnnaturalStrength)){
				if (flags[kFLAGS.HUNGER_ENABLED] > 0) power = (hunger/maxHunger())*0.01;
				else power = (lust/maxLust())*0.01;
				statStore.replaceBuffObject({'str.mult':(Math.round(power))}, 'Unnatural Strength', { text: 'Unnatural Strength' });
			}
			if (!hasPerk(PerkLib.UnnaturalStrength) && statStore.hasBuff('Unnatural Strength')) statStore.removeBuffs('Unnatural Strength');
			if (hasPerk(PerkLib.AbsoluteStrength) && (wrath > wrath100 * 0.5)){
				power = 0.25;
				if (wrath > wrath100 * 0.6) power += 0.05;
				if (wrath > wrath100 * 0.7) power += 0.05;
				if (wrath > wrath100 * 0.8) power += 0.05;
				if (wrath > wrath100 * 0.9) power += 0.05;
				if (wrath > wrath100) power += 0.05;
				if (wrath > wrath100 * 1.1) power += 0.05;
				if (wrath > wrath100 * 1.2) power += 0.05;
				if (wrath > wrath100 * 1.3) power += 0.05;
				if (wrath > wrath100 * 1.4) power += 0.05;
				//if (hasPerk(PerkLib.)) power *= 2;
				statStore.replaceBuffObject({'str.mult':(Math.round(power))}, 'Absolute Strength', { text: 'Absolute Strength' });
			}
			if (!hasPerk(PerkLib.AbsoluteStrength) && statStore.hasBuff('Absolute Strength')) statStore.removeBuffs('Absolute Strength');
			var buffs:Object = calcRacialBuffs(true);
			statStore.replaceBuffObject(buffs, "Racials", {text:"Racials"});
		}

		public function removeAllRacialMutation():void {
			for each (var pPerks:IMutationPerkType in IMutationsLib.mutationsArray("")){
				if (hasPerk(pPerks)){
					removePerk(pPerks);
					//perkPoints += 1;
				}
			}
			if (hasPerk(PerkLib.ChimericalBodyInitialStage)){
				removePerk(PerkLib.ChimericalBodyInitialStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiBasicStage)){
				removePerk(PerkLib.ChimericalBodySemiBasicStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodyBasicStage)){
				removePerk(PerkLib.ChimericalBodyBasicStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiImprovedStage)){
				removePerk(PerkLib.ChimericalBodySemiImprovedStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodyImprovedStage)){
				removePerk(PerkLib.ChimericalBodyImprovedStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiAdvancedStage)){
				removePerk(PerkLib.ChimericalBodySemiAdvancedStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodyAdvancedStage)){
				removePerk(PerkLib.ChimericalBodyAdvancedStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiSuperiorStage)){
				removePerk(PerkLib.ChimericalBodySemiSuperiorStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySuperiorStage)){
				removePerk(PerkLib.ChimericalBodySuperiorStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiPeerlessStage)){
				removePerk(PerkLib.ChimericalBodySemiPeerlessStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodyPeerlessStage)) {
				removePerk(PerkLib.ChimericalBodyPeerlessStage);
				perkPoints += 1;
			}
			if (hasPerk(PerkLib.ChimericalBodySemiEpicStage)) {
				removePerk(PerkLib.ChimericalBodySemiEpicStage);
				perkPoints += 1;
			}
		}

		public function requiredXP():int {
			var xpm:Number = 100;
			if (level >= 42) xpm += 100;
			if (level >= 102) xpm += 100;
			if (level >= 180) xpm += 100;
			//if (level >= 274)
			var temp:int = (level + 1) * xpm;
			if (temp > 74000) temp = 74000;//(max lvl)185 * 400(exp multi)
			return temp;
		}

		public function minotaurAddicted():Boolean {
			return !hasPerk(PerkLib.MinotaurCumResistance) && !hasPerk(PerkLib.ManticoreCumAddict) && (hasPerk(PerkLib.MinotaurCumAddict) || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1);
		}
		public function minotaurNeed():Boolean {
			return !hasPerk(PerkLib.MinotaurCumResistance) && !hasPerk(PerkLib.ManticoreCumAddict) && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1;
		}

		public function clearStatuses(visibility:Boolean):void
		{
			var HPPercent:Number;
			HPPercent = HP/maxHP();
			resetCooldowns();
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
				CoC.instance.mainView.statsView.showStatUp('str');
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.Sandstorm)) CoC.instance.monster.removeStatusEffect(StatusEffects.Sandstorm);
			if(hasStatusEffect(StatusEffects.Berzerking)) {
				removeStatusEffect(StatusEffects.Berzerking);
			}
			if(hasStatusEffect(StatusEffects.Lustzerking)) {
				removeStatusEffect(StatusEffects.Lustzerking);
			}
			if(hasStatusEffect(StatusEffects.TooAngryTooDie)) {
				removeStatusEffect(StatusEffects.TooAngryTooDie);
			}
			if(hasStatusEffect(StatusEffects.EverywhereAndNowhere)) {
				removeStatusEffect(StatusEffects.EverywhereAndNowhere);
			}
			if(hasStatusEffect(StatusEffects.Displacement)) {
				removeStatusEffect(StatusEffects.Displacement);
			}
			if(hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				removeStatusEffect(StatusEffects.BlazingBattleSpirit);
			}
			if(hasStatusEffect(StatusEffects.Cauterize)) {
				removeStatusEffect(StatusEffects.Cauterize);
			}
			if(hasStatusEffect(StatusEffects.WinterClaw)) {
				removeStatusEffect(StatusEffects.WinterClaw);
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				CoC.instance.monster.removeStatusEffect(StatusEffects.TailWhip);
			}
			if(hasStatusEffect(StatusEffects.Flying)) {
				removeStatusEffect(StatusEffects.Flying);
				if(hasStatusEffect(StatusEffects.FlyingNoStun)) {
					removeStatusEffect(StatusEffects.FlyingNoStun);
					removePerk(PerkLib.Resolute);
				}
			}
			if(statStore.hasBuff("Might")){
				statStore.removeBuffs("Might");
				removeStatusEffect(StatusEffects.Minimise);
			}
			if(hasStatusEffect(StatusEffects.Minimise)) {
				statStore.removeBuffs("Minimise");
				removeStatusEffect(StatusEffects.Minimise);
			}
			if(hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				dynStats("spe", -statusEffectv2(StatusEffects.UnderwaterCombatBoost), "scale", false);
				removeStatusEffect(StatusEffects.UnderwaterCombatBoost);
			}
			if(hasStatusEffect(StatusEffects.UnderwaterAndIgnis)) {
				removeStatusEffect(StatusEffects.UnderwaterAndIgnis);
			}
			if(hasStatusEffect(StatusEffects.EzekielCurse) && EvangelineFollower.EvangelineAffectionMeter >= 3 && hasPerk(PerkLib.EzekielBlessing)) {
				removeStatusEffect(StatusEffects.EzekielCurse);
			}
			if(hasStatusEffect(StatusEffects.DragonBreathCooldown) && perkv1(IMutationsLib.DraconicLungIM) >= 3) {
				removeStatusEffect(StatusEffects.DragonBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) && (perkv1(IMutationsLib.DraconicLungIM) >= 1 || perkv1(IMutationsLib.DrakeLungsIM) >= 3)) {
				removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonFireBreathCooldown) && (perkv1(IMutationsLib.DraconicLungIM) >= 1 || perkv1(IMutationsLib.DrakeLungsIM) >= 3)) {
				removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonIceBreathCooldown) && (perkv1(IMutationsLib.DraconicLungIM) >= 1 || perkv1(IMutationsLib.DrakeLungsIM) >= 3)) {
				removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonLightningBreathCooldown) && (perkv1(IMutationsLib.DraconicLungIM) >= 1 || perkv1(IMutationsLib.DrakeLungsIM) >= 3)) {
				removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonWaterBreathCooldown) && (perkv1(IMutationsLib.DraconicLungIM) >= 1 || perkv1(IMutationsLib.DrakeLungsIM) >= 3)) {
				removeStatusEffect(StatusEffects.DragonWaterBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.HeroBane)) {
				removeStatusEffect(StatusEffects.HeroBane);
			}
			if(hasStatusEffect(StatusEffects.PlayerRegenerate)) {
				removeStatusEffect(StatusEffects.PlayerRegenerate);
			}
			if(hasStatusEffect(StatusEffects.Disarmed)) {
				removeStatusEffect(StatusEffects.Disarmed);
				if (weapon == WeaponLib.FISTS) {
//					weapon = ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon;
//					(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon).doEffect(this, false);
					setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
				}
				else {
					flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
				}
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = 0;
			}
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
			}
			if(statusEffectv4(StatusEffects.CombatFollowerAlvina) > 0) addStatusValue(StatusEffects.CombatFollowerAlvina, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerAmily) > 0) addStatusValue(StatusEffects.CombatFollowerAmily, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerAurora) > 0) addStatusValue(StatusEffects.CombatFollowerAurora, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerAyane) > 0) addStatusValue(StatusEffects.CombatFollowerAyane, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerEtna) > 0) addStatusValue(StatusEffects.CombatFollowerEtna, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerExcellia) > 0) addStatusValue(StatusEffects.CombatFollowerExcellia, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerDiana) > 0) addStatusValue(StatusEffects.CombatFollowerDiana, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerDiva) > 0) addStatusValue(StatusEffects.CombatFollowerDiva, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerMitzi) > 0) addStatusValue(StatusEffects.CombatFollowerMitzi, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerNeisa) > 0) addStatusValue(StatusEffects.CombatFollowerNeisa, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerSiegweird) > 0) addStatusValue(StatusEffects.CombatFollowerSiegweird, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerZenji) > 0) addStatusValue(StatusEffects.CombatFollowerZenji, 4, -1);
			// All CombatStatusEffects are removed here
			for (var a:/*StatusEffectClass*/Array=statusEffects.slice(),n:int=a.length,i:int=0;i<n;i++) {
				// Using a copy of array in case effects are removed/added in handler
				if (statusEffects.indexOf(a[i])>=0) a[i].onCombatEnd();
			}
			statStore.removeCombatRoundTrackingBuffs();
			HP = HPPercent*maxHP();
		}

		public function consumeItem(itype:ItemType, amount:int = 1):Boolean {
			if (!hasItem(itype, amount)) {
				CoC_Settings.error("ERROR: consumeItem attempting to find " + amount + " item" + (amount > 1 ? "s" : "") + " to remove when the player has " + itemCount(itype) + ".");
				return false;
			}
			//From here we can be sure the player has enough of the item in inventory
			var slot:ItemSlotClass;
			while (amount > 0) {
				slot = getLowestSlot(itype); //Always draw from the least filled slots first
				if (slot.quantity > amount) {
					slot.quantity -= amount;
					amount = 0;
				}
				else { //If the slot holds the amount needed then amount will be zero after this
					amount -= slot.quantity;
					slot.emptySlot();
				}
			}
			return true;
/*
			var consumed:Boolean = false;
			var slot:ItemSlotClass;
			while (amount > 0)
			{
				if(!hasItem(itype,1))
				{
					CoC_Settings.error("ERROR: consumeItem in items.as attempting to find an item to remove when the has none.");
					break;
				}
				trace("FINDING A NEW SLOT! (ITEMS LEFT: " + amount + ")");
				slot = getLowestSlot(itype);
				while (slot != null && amount > 0 && slot.quantity > 0)
				{
					amount--;
					slot.quantity--;
					if(slot.quantity == 0) slot.emptySlot();
					trace("EATIN' AN ITEM");
				}
				//If on slot 5 and it doesn't have any more to take, break out!
				if(slot == undefined) amount = -1

			}
			if(amount == 0) consumed = true;
			return consumed;
*/
		}

		public function getLowestSlot(itype:ItemType):ItemSlotClass
		{
			var minslot:ItemSlotClass = null;
			for each (var slot:ItemSlotClass in itemSlots) {
				if (slot.itype == itype) {
					if (minslot == null || slot.quantity < minslot.quantity) {
						minslot = slot;
					}
				}
			}
			return minslot;
		}

		public function hasItem(itype:ItemType, minQuantity:int = 1):Boolean {
			return itemCount(itype) >= minQuantity;
		}

		public function itemCount(itype:ItemType):int {
			var count:int = 0;
			for each (var itemSlot:ItemSlotClass in itemSlots){
				if (itemSlot.itype == itype) count += itemSlot.quantity;
			}
			return count;
		}

		// 0..5 or -1 if no
		public function roomInExistingStack(itype:ItemType):Number {
			for (var i:int = 0; i<itemSlots.length; i++){
				if(itemSlot(i).itype == itype && itemSlot(i).quantity != 0 && itemSlot(i).quantity < 5)
					return i;
			}
			return -1;
		}

		public function itemSlot(idx:int):ItemSlotClass
		{
			return itemSlots[idx];
		}

		// 0..5 or -1 if no
		public function emptySlot():Number {
		    for (var i:int = 0; i<itemSlots.length;i++){
				if (itemSlot(i).isEmpty() && itemSlot(i).unlocked) return i;
			}
			return -1;
		}


		public function destroyItems(itype:ItemType, numOfItemToRemove:Number):Boolean
		{
			for (var slotNum:int = 0; slotNum < itemSlots.length; slotNum += 1)
			{
				if(itemSlot(slotNum).itype == itype)
				{
					while(itemSlot(slotNum).quantity > 0 && numOfItemToRemove > 0)
					{
						itemSlot(slotNum).removeOneItem();
						numOfItemToRemove--;
					}
				}
			}
			return numOfItemToRemove <= 0;
		}

		public function lengthChange(temp2:Number, ncocks:Number):void {

			if (temp2 < 0 && flags[kFLAGS.HYPER_HAPPY])  // Early return for hyper-happy cheat if the call was *supposed* to shrink a cock.
			{
				return;
			}
			//DIsplay the degree of length change.
			if(temp2 <= 1 && temp2 > 0) {
				if(cocks.length == 1) outputText("Your [cock] has grown slightly longer.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("One of your [cocks] grows slightly longer.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Some of your [cocks] grow slightly longer.");
					if(ncocks == cocks.length) outputText("Your [cocks] seem to fill up... growing a little bit larger.");
				}
			}
			if(temp2 > 1 && temp2 < 3) {
				if(cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your [cock] grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A very pleasurable feeling spreads from your groin as your [cocks] grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.");
					if(ncocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your [cocks] grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + num2Text(ncocks) + " of your [cocks] grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.");
				}
			}
			if(temp2 >=3){
				if(cocks.length == 1) outputText("Your [cock] feels incredibly tight as a few more inches of length seem to pour out from your crotch.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("Your [cocks] feel incredibly tight as one of their number begins to grow inch after inch of length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Your [cocks] feel incredibly number as " + num2Text(ncocks) + " of them begin to grow inch after inch of added length.");
					if(ncocks == cocks.length) outputText("Your [cocks] feel incredibly tight as inch after inch of length pour out from your groin.");
				}
			}
			//Display LengthChange
			if(temp2 > 0) {
				if(cocks[0].cockLength >= 8 && cocks[0].cockLength-temp2 < 8){
					if(cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>");
					if(cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>");
				}
				if(cocks[0].cockLength >= 12 && cocks[0].cockLength-temp2 < 12) {
					if(cocks.length == 1) outputText("  <b>Your [cock] is so long it nearly swings to your knee at its full length.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] are so long they nearly reach your knees when at full length.</b>");
				}
				if(cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if(cocks.length == 1) outputText("  <b>Your [cock] would look more at home on a large horse than you.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] would look more at home on a large horse than on your body.</b>");
					if (biggestTitSize() >= BreastCup.C) {
						if (cocks.length == 1) outputText("  You could easily stuff your [cock] between your breasts and give yourself the titty-fuck of a lifetime.");
						if (cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.");
					}
					else {
						if(cocks.length == 1) outputText("  Your [cock] is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.");
						if(cocks.length > 1) outputText("  Your [cocks] are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.");
					}
				}
				if(cocks[0].cockLength >= 20 && cocks[0].cockLength-temp2 < 20) {
					if(cocks.length == 1) outputText("  <b>As if the pulsing heat of your [cock] wasn't enough, the tip of your [cock] keeps poking its way into your view every time you get hard.</b>");
					if(cocks.length > 1) outputText("  <b>As if the pulsing heat of your [cocks] wasn't bad enough, every time you get hard, the tips of your [cocks] wave before you, obscuring the lower portions of your vision.</b>");
					if(cor > 40 && cor <= 60) {
						if(cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your [cocks]?");
						if(cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.");
					}
					if(cor > 60 && cor <= 80) {
						if(cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cocks] to their hilts, milking you dry.\n\nYou smile at the pleasant thought.");
						if(cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cock] to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.");
					}
					if(cor > 80) {
						if(cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your [cocks] in a year's time.");
					}
				}
			}
			//Display the degree of length loss.
			if(temp2 < 0 && temp2 >= -1) {
				if(cocks.length == 1) outputText("Your [cocks] has shrunk to a slightly shorter length.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] has shrunk to a slightly shorter length.");
				}
			}
			if(temp2 < -1 && temp2 > -3) {
				if(cocks.length == 1) outputText("Your [cocks] shrinks smaller, flesh vanishing into your groin.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
				}
			}
			if(temp2 <= -3) {
				if(cocks.length == 1) outputText("A large portion of your [cocks]'s length shrinks and vanishes.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A large portion of your [cocks] recedes towards your groin, receding rapidly in length.");
					if(ncocks == 1) outputText("A single member of your [cocks] vanishes into your groin, receding rapidly in length.");
					if(ncocks > 1 && cocks.length > ncocks) outputText("Your [cocks] tingles as " + num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.");
				}
			}
		}

		public function killCocks(deadCock:Number):void
		{
			//Count removal for text bits
			var removed:Number = 0;
			var temp:Number;
			//Holds cock index
			var storedCock:Number = 0;
			//Less than 0 = PURGE ALL
			if (deadCock < 0) {
				deadCock = cocks.length;
			}
			//Double loop - outermost counts down cocks to remove, innermost counts down
			while (deadCock > 0) {
				//Find shortest cock and prune it
				temp = cocks.length;
				while (temp > 0) {
					temp--;
					//If anything is out of bounds set to 0.
					if (storedCock > cocks.length - 1) storedCock = 0;
					//If temp index is shorter than stored index, store temp to stored index.
					if (cocks[temp].cockLength <= cocks[storedCock].cockLength) storedCock = temp;
				}
				//Smallest cock should be selected, now remove it!
				removeCock(storedCock, 1);
				removed++;
				deadCock--;
				if (cocks.length == 0) deadCock = 0;
			}
			//Texts
			if (removed == 1) {
				if (cocks.length == 0) {
					outputText("<b>Your manhood shrinks into your body, disappearing completely.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one [cock].</b>");
				}
				if (cocks.length > 1) {
					outputText("<b>Your smallest penis disappears forever, leaving you with just your [cocks].</b>");
				}
			}
			if (removed > 1) {
				if (cocks.length == 0) {
					outputText("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your [cock].</b>");
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with [cocks].</b>");
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusEffect(StatusEffects.Infested);
			if (cocks.length == 0 && balls > 0) {
				outputText(" <b>Your " + sackDescript() + " and [balls] shrink and disappear, vanishing into your groin.</b>");
				balls = 0;
				ballSize = 1;
			}
		}
		public function modCumMultiplier(delta:Number):Number
		{
			trace("modCumMultiplier called with: " + delta);

			if (delta == 0) {
				trace( "Whoops! modCumMuliplier called with 0... aborting..." );
				return delta;
			}
			else if (delta > 0) {
				trace("and increasing");
				if (hasPerk(PerkLib.MessyOrgasms)) {
					trace("and MessyOrgasms found");
					delta *= 2
				}
			}
			else if (delta < 0) {
				trace("and decreasing");
				if (hasPerk(PerkLib.MessyOrgasms)) {
					trace("and MessyOrgasms found");
					delta *= 1
				}
			}

			trace("and modifying by " + delta);
			cumMultiplier += delta;
			return delta;
		}

		public function increaseCock(cockNum:Number, lengthDelta:Number):Number
		{
			var bigCock:Boolean = false;
			if (hasPerk(PerkLib.BigCock)) bigCock = true;
			return cocks[cockNum].growCock(lengthDelta, bigCock);
		}

		public function increaseEachCock(lengthDelta:Number):Number
		{
			var totalGrowth:Number = 0;
			for (var i:Number = 0; i < cocks.length; i++) {
				trace( "increaseEachCock at: " + i);
				totalGrowth += increaseCock(i as Number, lengthDelta);
			}

			return totalGrowth;
		}

		// Attempts to put the player in heat (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if she is already pregnant or is a he.
		//
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the
		// duration and intensity. Defaults to 1.
		public function goIntoHeat(output:Boolean, intensity:int = 1):Boolean {
			if(!hasVagina() || pregnancyIncubation != 0) {
				// No vagina or already pregnant, can't go into heat.
				return false;
			}

			//Already in heat, intensify further.
			if (inHeat) {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.");
				}
				var sac:HeatEffect = statusEffectByType(StatusEffects.Heat) as HeatEffect;
				sac.value1 += 5 * intensity;
				sac.value2 += (0.25 * intensity);
				sac.value3 += 48 * intensity;
				sac.ApplyEffect();
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
			else {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>");
				}
				createStatusEffect(StatusEffects.Heat, 10 * intensity, (50 * intensity)/100, 48 * intensity, 0);
			}
			return true;
		}

		// Attempts to put the player in rut (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if he is a she.
		//
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the
		// duration and intensity. Defaults to 1.
		public function goIntoRut(output:Boolean, intensity:int = 1):Boolean {
			if (!hasCock()) {
				// No cocks, can't go into rut.
				return false;
			}
			//Has rut, intensify it!
			if (inRut) {
				if(output) {
					outputText("\n\nYour [cock] throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.");
				}
				var sac:RutEffect = statusEffectByType(StatusEffects.Rut) as RutEffect;
				sac.value1 += 100 * intensity;
				sac.value2 += 0.25 * intensity;
				sac.value3 += 48 * intensity;
				sac.ApplyEffect();
			}
			else {
				if(output) {
					outputText("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!");
				}
				//v1 - bonus cum production
				//v2 - bonus libido
				//v3 - time remaining!
				createStatusEffect(StatusEffects.Rut, 150 * intensity, (50 * intensity)/100, 100 * intensity, 0);
			}
			return true;
		}

		public function maxFeralCombatLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function FeralCombatExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryFeralCombatLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryFeralCombatLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function feralCombatXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryFeralCombatXP++;
					XP--;
				}
				else {
					masteryFeralCombatXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryFeralCombatLevel < maxFeralCombatLevel() && masteryFeralCombatXP >= FeralCombatExpToLevelUp()) {
					outputText("\n<b>Dao of Feral Beast leveled up to " + (masteryFeralCombatLevel + 1) + "!</b>\n");
					masteryFeralCombatLevel++;
					masteryFeralCombatXP = 0;
				}
			}
		}

		public function maxGauntletLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function GauntletExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryGauntletLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryGauntletLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function gauntletXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryGauntletXP++;
					XP--;
				}
				else {
					masteryGauntletXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryGauntletLevel < maxGauntletLevel() && masteryGauntletXP >= GauntletExpToLevelUp()) {
					outputText("\n<b>Dao of Gauntlet leveled up to " + (masteryGauntletLevel + 1) + "!</b>\n");
					masteryGauntletLevel++;
					masteryGauntletXP = 0;
				}
			}
		}

		public function maxSwordLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function SwordExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masterySwordLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masterySwordLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function swordXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masterySwordXP++;
					XP--;
				}
				else {
					masterySwordXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masterySwordLevel < maxSwordLevel() && masterySwordXP >= SwordExpToLevelUp()) {
					outputText("\n<b>Dao of Sword leveled up to " + (masterySwordLevel + 1) + "!</b>\n");
					masterySwordLevel++;
					masterySwordXP = 0;
				}
			}
		}

		public function maxAxeLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function AxeExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryAxeLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryAxeLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}

		public function axeXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryAxeXP++;
					XP--;
				}
				else {
					masteryAxeXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryAxeLevel < maxAxeLevel() && masteryAxeXP >= AxeExpToLevelUp()) {
					outputText("\n<b>Dao of Axe leveled up to " + (masteryAxeLevel + 1) + "!</b>\n");
					masteryAxeLevel++;
					masteryAxeXP = 0;
				}
			}
		}

		public function maxMaceHammerLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function MaceHammerExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryMaceHammerLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryMaceHammerLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function macehammerXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryMaceHammerXP++;
					XP--;
				}
				else {
					masteryMaceHammerXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryMaceHammerLevel < maxMaceHammerLevel() && masteryMaceHammerXP >= MaceHammerExpToLevelUp()) {
					outputText("\n<b>Dao of Mace/Hammer leveled up to " + (masteryMaceHammerLevel + 1) + "!</b>\n");
					masteryMaceHammerLevel++;
					masteryMaceHammerXP = 0;
				}
			}
		}

		public function maxDuelingSwordLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function DuelingSwordExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryDuelingSwordLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryDuelingSwordLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function duelingswordXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryDuelingSwordXP++;
					XP--;
				}
				else {
					masteryDuelingSwordXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryDuelingSwordLevel < maxDuelingSwordLevel() && masteryDuelingSwordXP >= DuelingSwordExpToLevelUp()) {
					outputText("\n<b>Dao of Dueling Sword leveled up to " + (masteryDuelingSwordLevel + 1) + "!</b>\n");
					masteryDuelingSwordLevel++;
					masteryDuelingSwordXP = 0;
				}
			}
		}

		public function maxPolearmLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function PolearmExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryPolearmLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryPolearmLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function polearmXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryPolearmXP++;
					XP--;
				}
				else {
					masteryPolearmXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryPolearmLevel < maxPolearmLevel() && masteryPolearmXP >= PolearmExpToLevelUp()) {
					outputText("\n<b>Dao of Polearm leveled up to " + (masteryPolearmLevel + 1) + "!</b>\n");
					masteryPolearmLevel++;
					masteryPolearmXP = 0;
				}
			}
		}

		public function maxSpearLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function SpearExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masterySpearLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masterySpearLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function spearXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masterySpearXP++;
					XP--;
				}
				else {
					masterySpearXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masterySpearLevel < maxSpearLevel() && masterySpearXP >= SpearExpToLevelUp()) {
					outputText("\n<b>Dao of Spear leveled up to " + (masterySpearLevel + 1) + "!</b>\n");
					masterySpearLevel++;
					masterySpearXP = 0;
				}
			}
		}

		public function maxDaggerLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function DaggerExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryDaggerLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryDaggerLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function daggerXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryDaggerXP++;
					XP--;
				}
				else {
					masteryDaggerXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryDaggerLevel < maxDaggerLevel() && masteryDaggerXP >= DaggerExpToLevelUp()) {
					outputText("\n<b>Dao of Dagger leveled up to " + (masteryDaggerLevel + 1) + "!</b>\n");
					masteryDaggerLevel++;
					masteryDaggerXP = 0;
				}
			}
		}

		public function maxWhipLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function WhipExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryWhipLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryWhipLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function whipXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryWhipXP++;
					XP--;
				}
				else {
					masteryWhipXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryWhipLevel < maxWhipLevel() && masteryWhipXP >= WhipExpToLevelUp()) {
					outputText("\n<b>Dao of Whip leveled up to " + (masteryWhipLevel + 1) + "!</b>\n");
					masteryWhipLevel++;
					masteryWhipXP = 0;
				}
			}
		}

		public function maxExoticLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function ExoticExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryExoticLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryExoticLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function exoticXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryExoticXP++;
					XP--;
				}
				else {
					masteryExoticXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryExoticLevel < maxExoticLevel() && masteryExoticXP >= ExoticExpToLevelUp()) {
					outputText("\n<b>Dao of Exotic Weapons leveled up to " + (masteryExoticLevel + 1) + "!</b>\n");
					masteryExoticLevel++;
					masteryExoticXP = 0;
				}
			}
		}

		public function maxArcheryLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.RangeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function ArcheryExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryArcheryLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryArcheryLevel + 1;
			if (hasPerk(PerkLib.RangeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.RangeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.RangeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function archeryXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryArcheryXP++;
					XP--;
				}
				else {
					masteryArcheryXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryArcheryLevel < maxArcheryLevel() && masteryArcheryXP >= ArcheryExpToLevelUp()) {
					outputText("\n<b>Dao of Archery leveled up to " + (masteryArcheryLevel + 1) + "!</b>\n");
					masteryArcheryLevel++;
					masteryArcheryXP = 0;
				}
			}
		}

		public function maxThrowingLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.RangeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function ThrowingExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryThrowingLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryThrowingLevel + 1;
			if (hasPerk(PerkLib.RangeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.RangeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.RangeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function throwingXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryThrowingXP++;
					XP--;
				}
				else {
					masteryThrowingXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryThrowingLevel < maxThrowingLevel() && masteryThrowingXP >= ThrowingExpToLevelUp()) {
					outputText("\n<b>Dao of Throwing Weapons leveled up to " + (masteryThrowingLevel + 1) + "!</b>\n");
					masteryThrowingLevel++;
					masteryThrowingXP = 0;
				}
			}
		}

		public function maxFirearmsLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.RangeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function FirearmsExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = masteryFirearmsLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = masteryFirearmsLevel + 1;
			if (hasPerk(PerkLib.RangeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.RangeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.RangeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function firearmsXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					masteryFirearmsXP++;
					XP--;
				}
				else {
					masteryFirearmsXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (masteryFirearmsLevel < maxFirearmsLevel() && masteryFirearmsXP >= FirearmsExpToLevelUp()) {
					outputText("\n<b>Dao of Firearms Weapons leveled up to " + (masteryFirearmsLevel + 1) + "!</b>\n");
					masteryFirearmsLevel++;
					masteryFirearmsXP = 0;
				}
			}
		}

		public function maxDualWieldSmallLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function DualWieldSmallExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = dualWSLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = dualWSLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function dualWieldSmallXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					dualWSXP++;
					XP--;
				}
				else {
					dualWSXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (dualWSLevel < maxDualWieldSmallLevel() && dualWSXP >= DualWieldSmallExpToLevelUp()) {
					outputText("\n<b>Dual Wield (Small) skill leveled up to " + (dualWSLevel + 1) + "!</b>\n");
					dualWSLevel++;
					dualWSXP = 0;
				}
			}
		}

		public function maxDualWieldNormalLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function DualWieldNormalExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = dualWNLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = dualWNLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function dualWieldNormalXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					dualWNXP++;
					XP--;
				}
				else {
					dualWNXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (dualWNLevel < maxDualWieldNormalLevel() && dualWNXP >= DualWieldNormalExpToLevelUp()) {
					outputText("\n<b>Dual Wield (Normal) skill leveled up to " + (dualWNLevel + 1) + "!</b>\n");
					dualWNLevel++;
					dualWNXP = 0;
				}
			}
		}

		public function maxDualWieldLargeLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function DualWieldLargeExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = dualWLLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = dualWLLevel + 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.MeleeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.MeleeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function dualWieldLargeXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					dualWLXP++;
					XP--;
				}
				else {
					dualWLXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (dualWLLevel < maxDualWieldLargeLevel() && dualWLXP >= DualWieldLargeExpToLevelUp()) {
					outputText("\n<b>Dual Wield (Large) skill leveled up to " + (dualWLLevel + 1) + "!</b>\n");
					dualWLLevel++;
					dualWLXP = 0;
				}
			}
		}

		public function maxDualWieldFirearmsLevel():Number {
			var maxLevel:Number = 10;
			if (level < 90) maxLevel += level;
			else maxLevel += 90;
			if (hasPerk(PerkLib.RangeWeaponsMasterySu)) maxLevel += 50;
			return maxLevel;
		}
		public function DualWieldFirearmsExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = dualWFLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = dualWFLevel + 1;
			if (hasPerk(PerkLib.RangeWeaponsMasterySu)) expToLevelUp00 *= 0.5;
			expToLevelUp00 = Math.round(expToLevelUp00);
			if (expToLevelUp00 < 1) expToLevelUp00 = 1;
			if (hasPerk(PerkLib.RangeWeaponsMastery)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.RangeWeaponsMasteryEx)) expToLevelUp02 *= 0.5;
			expToLevelUp02 = Math.round(expToLevelUp02);
			if (expToLevelUp02 < 1) expToLevelUp02 = 1;
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function dualWieldFirearmsXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					dualWFXP++;
					XP--;
				}
				else {
					dualWFXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (dualWFLevel < maxDualWieldFirearmsLevel() && dualWFXP >= DualWieldFirearmsExpToLevelUp()) {
					outputText("\n<b>Dual Wield (Firearms) skill leveled up to " + (dualWFLevel + 1) + "!</b>\n");
					dualWFLevel++;
					dualWFXP = 0;
				}
			}
		}

		public function maxMiningLevel():Number {
			var maxLevel:Number = 2;
			//if (hasPerk(PerkLib.SuperSensual)) {
				//if (level < 48) maxLevel += level;
				//else maxLevel += 48;
			//}
			//else {
				if (level < 18) maxLevel += level;
				else maxLevel += 18;
			//}
			return maxLevel;
		}
		public function MiningExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = miningLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = miningLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function mineXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					miningXP++;
					XP--;
				}
				else {
					miningXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (miningLevel < maxMiningLevel() && miningXP >= MiningExpToLevelUp()) {
					outputText("\n\n<b>Mining skill leveled up to " + (miningLevel + 1) + "!</b>");
					miningLevel++;
					miningXP = 0;
				}
			}
		}

		public function maxHerbalismLevel():Number {
			var maxLevel:Number = 2;
			//if (hasPerk(PerkLib.SuperSensual)) {
				//if (level < 48) maxLevel += level;
				//else maxLevel += 48;
			//}
			//else {
				if (level < 18) maxLevel += level;
				else maxLevel += 18;
			//}
			return maxLevel;
		}
		public function HerbExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = herbalismLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = herbalismLevel + 1;
			//if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			//if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			//if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			//if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			//if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}
		public function herbXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					herbalismXP++;
					XP--;
				}
				else {
					herbalismXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (herbalismLevel < maxHerbalismLevel() && herbalismXP >= HerbExpToLevelUp()) {
					outputText("\n\n<b>Herbalism skill leveled up to " + (herbalismLevel + 1) + "!</b>");
					herbalismLevel++;
					herbalismXP = 0;
				}
			}
		}

		public function HerbalismMulti():Number {
			var herbMlt:Number = 1;
			if (hasPerk(PerkLib.PlantKnowledge)) herbMlt *= 2;
			if (hasPerk(PerkLib.NaturalHerbalism)) herbMlt *= 2;
			if (hasKeyItem("Tel'Adre Magazine Issue 5") >= 0) herbMlt *= 2;
			return herbMlt;
		}
		
		public function usePotion(pt:PotionType):void {
			pt.effect();
			changeNumberOfPotions(pt, -1);
			EngineCore.doNext(EventParser.playerMenu);
		}

		public function maxTeaseLevel():Number {
			var maxLevel:Number = 16;
			if (hasPerk(PerkLib.SuperSensual)) {
				if (level < 54) maxLevel += level;
				else maxLevel += 54;
			}
			else {
				if (level < 24) maxLevel += level;
				else maxLevel += 24;
			}
			return maxLevel;
		}
		public function teaseExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = teaseLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = teaseLevel + 1;
			if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}

		public function SexXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					teaseXP++;
					XP--;
				}
				else {
					teaseXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (teaseLevel < maxTeaseLevel() && teaseXP >= teaseExpToLevelUp()) {
					outputText("\n<b>Tease skill leveled up to " + (teaseLevel + 1) + "!</b>");
					teaseLevel++;
					teaseXP = 0;
				}
			}
		}

		public function cumOmeter(changes:Number = 0):Number {
			flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] += changes;
			if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 100) flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] = 100;
			return flags[kFLAGS.SEXUAL_FLUIDS_LEVEL];
		}

		public function blockingBodyTransformations():Boolean {
			return hasPerk(PerkLib.TransformationImmunity) || hasPerk(PerkLib.TransformationImmunityFairy) || hasPerk(PerkLib.TransformationImmunityAtlach)
					|| hasPerk(PerkLib.Undeath) || hasPerk(PerkLib.WendigoCurse) || hasPerk(PerkLib.BlessingOfTheAncestorTree);
		}

		public function manticoreFeed():void {
			if (perkv1(IMutationsLib.ManticoreMetabolismIM) >= 1) {
				if (perkv1(IMutationsLib.ManticoreMetabolismIM) >= 2) {
					var PowerMultiplier:Number = 1;
					if (perkv1(IMutationsLib.ManticoreMetabolismIM) >= 3) PowerMultiplier *= 2;
					if (buff("Feeding Euphoria").getValueOfStatBuff("spe.mult") < (0.50*PowerMultiplier) + (0.5 * (1 + newGamePlusMod()))) {
						buff("Feeding Euphoria").addStats({"spe.mult": 0.5}).withText("Feeding Euphoria!").forHours(15);
					}
					else if (buff("Feeding Euphoria").getValueOfStatBuff("spe.mult") >= (1.50*PowerMultiplier) + (1.5 * (1 + newGamePlusMod()))) {
						buff("Feeding Euphoria").addDuration(3);
					}
				} else {
					if (buff("Feeding Euphoria").getValueOfStatBuff("spe.mult") < 0.50) {
						buff("Feeding Euphoria").addStats({"spe.mult": 0.5}).withText("Feeding Euphoria!").forHours(10);
					}
					else if (buff("Feeding Euphoria").getValueOfStatBuff("spe.mult") >= 1.50) {
						buff("Feeding Euphoria").addDuration(2);
					}
				}
			}
			EngineCore.HPChange(Math.round(maxHP() * .2), true);
			cumOmeter(40);
			cor += 2;
			var Ammount:Number = 100;
			if ((hunger+Ammount)>maxHunger()) Ammount = (maxHunger()-hunger-1);
			refillHunger(Ammount);
			var Amm2:Number = 50;
			if (perkv1(IMutationsLib.ManticoreMetabolismIM) >= 2) Amm2 *= 2;
			tailVenom += Amm2;
			if (tailVenom > maxVenom()) tailVenom = maxVenom();
		}

		public function displacerFeed():void {
			if (perkv1(IMutationsLib.DisplacerMetabolismIM) >= 1) {
				if (perkv1(IMutationsLib.DisplacerMetabolismIM) >= 2) {
					if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") < 0.25 + (0.25 * (1 + newGamePlusMod()))) {
						buff("Milking Euphoria").addStats({"str.mult": 0.25, "spe.mult": 0.25, "int.mult": -0.25}).withText("Milking Euphoria!").forHours(15);
					}
					else if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") >= 0.75 + (0.75 * (1 + newGamePlusMod()))) {
						buff("Milking Euphoria").addDuration(3);
					}
				} else {
					if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") < 0.25) {
						buff("Milking Euphoria").addStats({"str.mult": 0.25, "spe.mult": 0.25, "int.mult": -0.25}).withText("Milking Euphoria!").forHours(10);
					}
					else if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") >= 0.75) {
						buff("Milking Euphoria").addDuration(2);
					}
				}
			}
			EngineCore.HPChange(Math.round(maxHP() * .2), true);
			cumOmeter(40);
			cor += 2;
			var Ammount:Number = 100;
			if ((hunger+Ammount)>maxHunger()) Ammount = (maxHunger()-hunger-1);
			refillHunger(Ammount);
		}

		public function slimeGrowth():void {
			if (hasStatusEffect(StatusEffects.SlimeCraving)) {
				if (perkv1(IMutationsLib.SlimeMetabolismIM) >= 3) {
					buff("Fluid Growth").addStats({"tou.mult": 0.02}).withText("Fluid Growth!");
					if (hasPerk(PerkLib.DarkSlimeCore)){
						buff("Fluid Growth").addStats({"int.mult": 0.02}).withText("Fluid Growth!");
					}
				} else {
					buff("Fluid Growth").addStats({"tou.mult": 0.01}).withText("Fluid Growth!");
					if (hasPerk(PerkLib.DarkSlimeCore)){
						buff("Fluid Growth").addStats({"int.mult": 0.01}).withText("Fluid Growth!");
					}
				}
			}
			EngineCore.HPChange(Math.round(maxHP() * .2), true);
			cumOmeter(40);
			cor += 2;
			var Ammount:Number = 100;
			if ((hunger+Ammount)>maxHunger()) Ammount = (maxHunger()-hunger-1);
			refillHunger(Ammount);
		}

        /**
		 * fluidtype: "cum", "vaginalFluids", "saliva", "milk", "Default".
         *
		 * type: 'n', 'Vaginal', 'Anal', 'Dick', 'Lips', 'Tits', 'Nipples', 'Ovi', 'VaginalAnal', 'DickAnal', 'Default', 'Generic'
		 */
		public function sexReward(fluidtype:String = 'Default', type:String = 'Default', real:Boolean = true, Wasfluidinvolved:Boolean = true):void
		{
			if (Wasfluidinvolved) {
				slimeFeed();
				if (isGargoyle() && hasPerk(PerkLib.GargoyleCorrupted)) refillGargoyleHunger(30);
				if (isRace(Races.JIANGSHI) && hasPerk(PerkLib.EnergyDependent)) EnergyDependentRestore();
				if (hasPerk(PerkLib.DemonEnergyThirst)) createStatusEffect(StatusEffects.DemonEnergyThirstFeed, 0, 0, 0, 0);
				if (hasPerk(PerkLib.KitsuneEnergyThirst)) createStatusEffect(StatusEffects.KitsuneEnergyThirstFeed, 0, 0, 0, 0);
				switch (fluidtype)
				{
					// Start with that, whats easy
					case 'cum':
						if (hasStatusEffect(StatusEffects.Overheat) && inHeat) {
							if (statusEffectv3(StatusEffects.Overheat) != 1) addStatusValue(StatusEffects.Overheat, 3, 1);
						}
						if (hasPerk(PerkLib.ManticoreCumAddict)) manticoreFeed();
						if (hasPerk(PerkLib.EndlessHunger)) refillHunger(30, false);
						break;
					case 'vaginalFluids':
						if (hasStatusEffect(StatusEffects.Overheat) && inRut) {
							if (statusEffectv3(StatusEffects.Overheat) != 1) addStatusValue(StatusEffects.Overheat, 3, 1);
						}
						if (hasPerk(PerkLib.EndlessHunger)) refillHunger(30, false);
						break;
					case 'saliva':
						break;
					case 'milk':
						if (hasPerk(PerkLib.DisplacerMilkAddict)) displacerFeed();
						refillHunger(10, false);
						break;
				}
			}
			SexXP(5+level);
			if (armor == game.armors.SCANSC)SexXP(5+level);
			orgasm(type,real);
			if (type == "Dick") {
				if (hasPerk(PerkLib.EasterBunnyBalls)) {
					if (ballSize > 3) createStatusEffect(StatusEffects.EasterBunnyCame, 0, 0, 0, 0);
				}
				if (perkv1(IMutationsLib.NukiNutsIM) >= 2) {
					var cumAmmount:Number = cumQ();
					var payout:Number = 0;
					//Get rid of extra digits
					cumAmmount = int(cumAmmount);
					//Calculate payout
					if (cumAmmount > 10) payout = 2 + int(cumAmmount/100)*2;
					//Reduce payout if it would push past
					if (perkv1(IMutationsLib.NukiNutsIM) >= 3) payout *= 2;
					if (payout > 0) {
						gems += payout;
						EngineCore.outputText("\n\nBefore moving on you grab the " + payout + " gems you came from from your " + cockDescript(0) + ".</b>\n\n");
					}
				}
			}
		}

		public function orgasmReal():void
		{
			dynStats("lus=", 0, "sca", false);
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;
			if (countCockSocks("gilded") > 0) {
				var randomCock:int = rand( cocks.length );
				var bonusGems:int = rand( cocks[randomCock].cockThickness ) + countCockSocks("gilded"); // int so AS rounds to whole numbers
				EngineCore.outputText("\n\nFeeling some minor discomfort in your " + cockDescript(randomCock) + " you slip it out of your [armor] and examine it. <b>With a little exploratory rubbing and massaging, you manage to squeeze out " + bonusGems + " gems from its cum slit.</b>\n\n");
				gems += bonusGems;
			}
		}

		public function orgasm(type:String = 'Default', real:Boolean = true):void
		{
			switch (type) {
					// Start with that, whats easy
				case 'Vaginal': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_VAGINAL] < 10) flags[kFLAGS.TIMES_ORGASM_VAGINAL]++;
					break;
				case 'Anal':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_ANAL]    < 10) flags[kFLAGS.TIMES_ORGASM_ANAL]++;
					break;
				case 'Dick':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_DICK]    < 10) flags[kFLAGS.TIMES_ORGASM_DICK]++;
					break;
				case 'Lips':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_LIPS]    < 10) flags[kFLAGS.TIMES_ORGASM_LIPS]++;
					break;
				case 'Tits':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_TITS]    < 10) flags[kFLAGS.TIMES_ORGASM_TITS]++;
					break;
				case 'Nipples': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_NIPPLES] < 10) flags[kFLAGS.TIMES_ORGASM_NIPPLES]++;
					break;
				case 'Ovi':
					break;
					// Now to the more complex types
				case 'VaginalAnal':
					orgasm((hasVagina() ? 'Vaginal' : 'Anal'), real);
					return; // Prevent calling orgasmReal() twice
				case 'DickAnal':
					orgasm((rand(2) == 0 ? 'Dick' : 'Anal'), real);
					return;
				case 'Default':
				case 'Generic':
				default:
					if (!hasVagina() && !hasCock()) {
						orgasm('Anal'); // Failsafe for genderless PCs
						return;
					}
					if (hasVagina() && hasCock()) {
						orgasm((rand(2) == 0 ? 'Vaginal' : 'Dick'), real);
						return;
					}
					orgasm((hasVagina() ? 'Vaginal' : 'Dick'), real);
					return;
			}

			if (real) orgasmReal();
		}
		public function orgasmRaijuStyle():void
		{
			if (game.player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				EngineCore.outputText("\n\nAs you finish masturbating you feel a jolt in your genitals, as if for a small moment the raiju discharge was brought back, increasing the intensity of the pleasure and your desire to touch yourself. Electricity starts coursing through your body again by intermittence as something in you begins to change.");
				game.player.addStatusValue(StatusEffects.RaijuLightningStatus,1,6);
				dynStats("lus", (60 + rand(20)), "sca", false);
				game.mutations.voltageTopaz(false,CoC.instance.player);
			}
			else {
				EngineCore.outputText("\n\nAfter this electrifying orgasm your lust only raises higher than the sky above. You will need a partner to fuck with in order to discharge your ramping up desire and electricity.");
				dynStats("lus", (maxLust() * 0.1), "sca", false);
			}
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;
		}
		public function penetrated(where:ISexyPart, tool:ISexyPart, options:Object = null):void {
			options = Utils.extend({
				display:true,
				orgasm:false
			},options||{});
			if (where.host != null && where.host != this) {
				trace("Penetration confusion! Host is "+where.host);
				return;
			}
			var size:Number = 8;
			if ('size' in options) size = options.size;
			else if (tool is Cock) size = (tool as Cock).cArea();
			var otype:String = 'Default';
			if (where is AssClass) {
				buttChange(size, options.display);
				otype = 'Anal';
			} else if (where is VaginaClass) {
				cuntChange(size, options.display);
				otype = 'Vaginal';
			}
			if (options.orgasm) {
				orgasm(otype);
			}
		}

		public function EnergyDependentRestore():void {
			var intBuff:Number = buff("Energy Vampire").getValueOfStatBuff("int.mult");
			var speBuff:Number = buff("Energy Vampire").getValueOfStatBuff("spe.mult");
			if (hasStatusEffect(StatusEffects.AlterBindScroll2)) {
				if (intBuff < +1.8) buff("Energy Vampire").addStats({ "int.mult": +0.20 }).withText("Energy Vampire");
				if (speBuff < +0.9) buff("Energy Vampire").addStats({ "spe.mult": +0.10 }).withText("Energy Vampire");
			}
			else {
				if (intBuff < +0.9) buff("Energy Vampire").addStats({ "int.mult": +0.10 }).withText("Energy Vampire");
				if (speBuff < +0.45) buff("Energy Vampire").addStats({ "spe.mult": +0.05 }).withText("Energy Vampire");
			}
			if (!CoC.instance.monster.hasPerk(PerkLib.EnemyTrueDemon)) {
				if (hasStatusEffect(StatusEffects.AlterBindScroll2)) soulforce += maxSoulforce() * 0.08;
				else soulforce += maxSoulforce() * 0.04;
				if (soulforce > maxSoulforce()) soulforce = maxSoulforce();
				outputText(" You feel slightly more alive from the soulforce you vampirised from your sexual partner orgasm.");
			}
			if (HP < maxHP()) EngineCore.HPChange(25 + (lib/2), true);
			if (mana < maxMana()) EngineCore.ManaChange(25 + (inte/2), true);
			EngineCore.changeFatigue(-(25 + (spe/2)));
			removeCurse("lib", 5, 1);
			removeCurse("lib", 5, 2);
		}

		public function displacerFeedFromBottle():void {
			if (perkv1(IMutationsLib.DisplacerMetabolismIM) >= 1) {
				if (perkv1(IMutationsLib.DisplacerMetabolismIM) >= 2) {
					if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") < 0.25 + (0.25 * (1 + newGamePlusMod()))) {
						buff("Milking Euphoria").addStats({"str.mult": 0.05, "spe.mult": 0.05, "int.mult": -0.05}).withText("Milking Euphoria!").forHours(10);
					}
					else if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") >= 0.75 + (0.75 * (1 + newGamePlusMod()))) {
						buff("Milking Euphoria").addDuration(2);
					}
				} else {
					if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") < 0.05) {
						buff("Milking Euphoria").addStats({"str.mult": 0.05, "spe.mult": 0.05, "int.mult": -0.05}).withText("Milking Euphoria!").forHours(6);
					}
					else if (buff("Milking Euphoria").getValueOfStatBuff("spe.mult") >= 0.75) {
						buff("Milking Euphoria").addDuration(1);
					}
				}
			}
			EngineCore.HPChange(Math.round(maxHP() * .05), true);
		}

		public function hasUniquePregnancy():Boolean{
			if (isSlime() || isHarpy() || isGoblinoid() || isAlraune()) return true;
			else return false;
		}

		public function impregnationRacialCheck():void
		{
		    if (isGoblinoid()) knockUp(PregnancyStore.PREGNANCY_GOBLIN, PregnancyStore.INCUBATION_GOBLIN);
			else if (isSlime()) knockUp(PregnancyStore.PREGNANCY_GOO_GIRL, PregnancyStore.INCUBATION_GOO_GIRL);
			else if (isHarpy()){
				knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS, 1, 1);
				createStatusEffect(StatusEffects.Eggs, Utils.rand(6), 0, Utils.rand(3) + 5, 0);
			}
			//until we get a real harpy knock up
			else if (isAlraune()) knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
		}

		protected override function maxHP_base():Number {
			var max:Number = super.maxHP_base();
			if (isGargoyle() && Forgefather.material == "granite")
			{
				if (Forgefather.refinement == 1) max *= (1.15);
				if (Forgefather.refinement == 2) max *= (1.25);
				if (Forgefather.refinement == 3 || Forgefather.refinement == 4) max *= (1.35);
				if (Forgefather.refinement == 5) max *= (1.5);
			}
			if (hasPerk(PerkLib.ElementalBondFlesh) && statusEffectv1(StatusEffects.SummonedElementals) >= 2) max += maxHP_ElementalBondFleshMulti() * statusEffectv1(StatusEffects.SummonedElementals);
			return max;
		}
		protected override function maxLust_base():Number {
			var max:Number = super.maxLust_base();
			if (isRace(Races.COW)) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (isRace(Races.MINOTAUR)) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.ElementalBondUrges) && statusEffectv1(StatusEffects.SummonedElementals) >= 2) max += maxLust_ElementalBondUrgesMulti() * statusEffectv1(StatusEffects.SummonedElementals);
			if (perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 1) max += (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3) max += (90 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (perkv1(IMutationsLib.MinotaurTesticlesIM) >= 1) max += (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) max += (90 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			return max;
		}

		public function sadomasochismBoost():Number {
			var sadomasochismBoost:Number = 1;
			if (HP < maxHP() * 0.25) sadomasochismBoost += 0.2;
			if (lust > maxLust() * 75) sadomasochismBoost += 0.2;
			return sadomasochismBoost;
		}

		public function get additionalTransformationChances():Number {
			var additionalTransformationChancesCounter:Number = 0;
			if (hasPerk(PerkLib.HistoryAlchemist) || hasPerk(PerkLib.PastLifeAlchemist)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.Enhancement)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.Fusion)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.Enchantment)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.Refinement)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.Saturation)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.Perfection)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.Creationism)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.EzekielBlessing)) additionalTransformationChancesCounter++;
			if (hasPerk(PerkLib.TransformationResistance)) additionalTransformationChancesCounter--;
			return additionalTransformationChancesCounter;
		}

		public function MutagenBonus(statName: String, bonus: Number):Boolean
		{
			var cap:Number = 0.2;
			if (hasPerk(PerkLib.Enhancement)) cap += 0.02;
			if (hasPerk(PerkLib.Fusion)) cap += 0.02;
			if (hasPerk(PerkLib.Enchantment)) cap += 0.02;
			if (hasPerk(PerkLib.Refinement)) cap += 0.02;
			if (hasPerk(PerkLib.Saturation)) cap += 0.02;
			if (hasPerk(PerkLib.Perfection)) cap += 0.02;
			if (hasPerk(PerkLib.Creationism)) cap += 0.02;
			if (hasPerk(PerkLib.MunchkinAtGym)) cap += 0.05;
            if (bonus == 0)
                return false; //no bonus - no effect
            if (removeCurse(statName, bonus, 1) > 0)
                return false; //remove existing curses
            var current:Number = buff("Mutagen").getValueOfStatBuff(statName + ".mult");
            var bonus_sign:Number = (bonus > 0) ? 1 : -1;
            var current_sign:Number = (current > 0) ? 1 : -1;
            if ((bonus_sign == current_sign) && Math.abs(current) >= cap) //already max and matching signs
                return false;

            var addBonus:Number = bonus_sign * Math.min(Math.abs(bonus_sign * cap - current), Math.abs(bonus * 0.01));
            buff("Mutagen").addStat(statName + ".mult", addBonus);
            CoC.instance.mainView.statsView.refreshStats(CoC.instance);
            CoC.instance.mainView.statsView.showStatUp(statName);
            return true;
		}

		public function AlchemyBonus(statName: String, bonus: Number):void
		{
			var ABCap:Number = 0.2;
			if (hasPerk(PerkLib.Enhancement)) ABCap += 0.02;
			if (hasPerk(PerkLib.Fusion)) ABCap += 0.02;
			if (hasPerk(PerkLib.Enchantment)) ABCap += 0.02;
			if (hasPerk(PerkLib.Refinement)) ABCap += 0.02;
			if (hasPerk(PerkLib.Saturation)) ABCap += 0.02;
			if (hasPerk(PerkLib.Perfection)) ABCap += 0.02;
			if (hasPerk(PerkLib.Creationism)) ABCap += 0.02;
			if (hasPerk(PerkLib.MunchkinAtGym)) ABCap += 0.05;
			removeCurse(statName, bonus, -2);
			if (buff("Alchemical").getValueOfStatBuff(""+statName+".mult") < ABCap){
				buff("Alchemical").addStat(""+statName+".mult",0.01);
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp(statName);
			}
		}

		public function KnowledgeBonus(statName: String, bonus: Number):void
		{
			var KBCap:Number = 0.2;
			if (hasPerk(PerkLib.MunchkinAtGym)) KBCap += 0.05;
			removeCurse(statName, bonus, -2);
			if (buff("Knowledge").getValueOfStatBuff(""+statName+".mult") < KBCap){
				buff("Knowledge").addStat(""+statName+".mult",0.01);
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp(statName);
			}
		}

		public function BrainMeltBonus():void
		{
			var MBCap:Number = 1;
			if (hasPerk(PerkLib.MindbreakerBrain1toX)) MBCap += 0.50*perkv1(PerkLib.MindbreakerBrain1toX);
			removeCurse("inte", -3);
			removeCurse("wis", -3);
			removeCurse("lib", -3);
			if (buff("Devoured Mind").getValueOfStatBuff("int.mult") < MBCap){
				buff("Devoured Mind").addStat("int.mult",0.05);
				buff("Devoured Mind").addStat("wis.mult",0.05);
				buff("Devoured Mind").addStat("lib.mult",0.05);
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp("inte");
				CoC.instance.mainView.statsView.showStatUp("wis");
				CoC.instance.mainView.statsView.showStatUp("lib");
				outputText("Your mind surges with newfound knowledge, your brain expanding slightly from the stolen information. You orgasm in sympathy with this new added knowledge.");
			}
			else{
				outputText("Sadly as much as you try to extract new knowledge from your victims brain there's only so few to be had… " +
						"that Mareth is filled with idiots doesn't help that." +
						" Despite draining your victim into something about as smart as a mineral you fail to extract anything noteworthy.");
			}
		}

		public function VenomWebCost():Number
		{
			var VWC:Number = 5;
			if (hasPerk(PerkLib.ImprovedVenomGlandEx)) VWC -= 1;
			if (hasPerk(PerkLib.ImprovedVenomGlandSu)) VWC += 2;
			return VWC;
		}
		
		override public function looksFemale():Boolean {
			switch (flags[kFLAGS.MALE_OR_FEMALE]) {
				case 1: return false;
				case 2: return true;
				default: return super.looksFemale();
			}
		}

		override public function modStats(dstr:Number, dtou:Number, dspe:Number, dinte:Number, dwis:Number, dlib:Number, dsens:Number, dlust:Number, dcor:Number, scale:Boolean, max:Boolean):void {
			//Easy mode cuts lust gains!
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 && dlust > 0 && scale) dlust /= 10;
			//Set original values to begin tracking for up/down values if
			//they aren't set yet.
			//These are reset when up/down arrows are hidden with
			//hideUpDown();
			//Just check str because they are either all 0 or real values
			if(game.oldStats.oldStr == 0) {
				game.oldStats.oldStr = str;
				game.oldStats.oldTou = tou;
				game.oldStats.oldSpe = spe;
				game.oldStats.oldInte = inte;
				game.oldStats.oldWis = wis;
				game.oldStats.oldLib = lib;
				game.oldStats.oldSens = sens;
				game.oldStats.oldCor = cor;
				game.oldStats.oldHP = HP;
				game.oldStats.oldLust = lust;
				game.oldStats.oldFatigue = fatigue;
				game.oldStats.oldSoulforce = soulforce;
				game.oldStats.oldHunger = hunger;
			}
			if (scale) {
				//MOD CHANGES FOR PERKS
				//Bimbos learn slower
				if (hasPerk(PerkLib.FutaFaculties) || hasPerk(PerkLib.BimboBrains) || hasPerk(PerkLib.BroBrains)) {
					if (dinte > 0) dinte /= 2;
					if (dinte < 0) dinte *= 2;
				}
				if (hasPerk(PerkLib.FutaForm) || hasPerk(PerkLib.BimboBody) || hasPerk(PerkLib.BroBody)) {
					if (dlib > 0) dlib *= 2;
					if (dlib < 0) dlib /= 2;
				}
				// Uma's Perkshit
				if (hasPerk(PerkLib.ChiReflowLust) && dlib > 0) dlib *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				if (hasPerk(PerkLib.ChiReflowLust) && dsens > 0) dsens *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				//Apply lust changes in NG+.
				dlust *= 1 + (newGamePlusMod() * 0.2);
				//lust resistance
				if (dlust > 0 && scale) dlust *= EngineCore.lustPercent() / 100;
				if (dlib > 0 && hasPerk(PerkLib.PurityBlessing)) dlib *= 0.75;
				if (dcor > 0 && hasPerk(PerkLib.PurityBlessing)) dcor *= 0.5;
				if (dcor > 0 && hasPerk(PerkLib.PureAndLoving)) dcor *= 0.75;
				if (dcor > 0 && weapon == game.weapons.HNTCANE) dcor *= 0.5;
				if (hasPerk(PerkLib.AscensionMoralShifter)) dcor *= 1 + (perkv1(PerkLib.AscensionMoralShifter) * 0.2);
				if (hasPerk(PerkLib.Lycanthropy)) dcor *= 1.2;
				if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) dcor *= 2;
				if (sens > 50 && dsens > 0) dsens /= 2;
				if (sens > 75 && dsens > 0) dsens /= 2;
				if (sens > 90 && dsens > 0) dsens /= 2;
				if (sens > 50 && dsens < 0) dsens *= 2;
				if (sens > 75 && dsens < 0) dsens *= 2;
				if (sens > 90 && dsens < 0) dsens *= 2;
				//Bonus gain for perks!
				if(hasPerk(PerkLib.Strong)) dstr += dstr * perkv1(PerkLib.Strong);
				if(hasPerk(PerkLib.Tough)) dtou += dtou * perkv1(PerkLib.Tough);
				if(hasPerk(PerkLib.Fast)) dspe += dspe * perkv1(PerkLib.Fast);
				if(hasPerk(PerkLib.Smart)) dinte += dinte * perkv1(PerkLib.Smart);
				if(hasPerk(PerkLib.Wise)) dwis += dwis * perkv1(PerkLib.Wise);
				if(hasPerk(PerkLib.Lusty)) dlib += dlib * perkv1(PerkLib.Lusty);
				if(hasPerk(PerkLib.Sensitive)) dsens += dsens * perkv1(PerkLib.Sensitive);
				// Uma's Str Cap from Perks (Moved to max stats)
				/*if (hasPerk(PerkLib.ChiReflowSpeed))
				{
					if (str > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
					{
						str = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
					}
				}
				if (hasPerk(PerkLib.ChiReflowDefense))
				{
					if (spe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
					{
						spe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
					}
				}*/
			}
			//Change original stats
			super.modStats(dstr,dtou,dspe,dinte,dwis,dlib,dsens,dlust,dcor,false,max);
			//Refresh the stat pane with updated values
			//mainView.statsView.showUpDown();
			if (dlust != 0){
				raijuSuperchargedCheck();
			}
			if (!isRace(Races.RAIJU) && statStore.hasBuff('Supercharged')) statStore.removeBuffs('Supercharged');
			EngineCore.showUpDown();
			EngineCore.statScreenRefresh();
		}

		public function raijuSuperchargedCheck():void{
			if (isRace(Races.RAIJU) && lust100>=75){
				if (!statStore.hasBuff("Supercharged")){
					var buff:Number = 1;
					if (perkv1(IMutationsLib.RaijuCathodeIM) >= 3) buff *= 2
					statStore.replaceBuffObject({'spe.mult':Math.round(speStat.mult.value)*buff}, 'Supercharged', { text: 'Supercharged!' });
					CoC.instance.mainView.statsView.refreshStats(CoC.instance);
					CoC.instance.mainView.statsView.showStatUp('spe');
					outputText("\n\nAs your bottled up voltage ramps up you begin to lose yourself to lust turning increasingly feral as your overwhelming need to discharge override any rational thinking. FUCK… you need someone to fuck that voltage out of you!");
					if(game.inCombat) outputText(" [themonster] gulps as [he] see's your lust crazed expression. Should you win [he] won't get off the hook so easily!");
					outputText("\n\n<b>You entered the supercharged state!</b>\n\n");
				}
				if(lust100 >= 100){
					lust = maxLust()*99/100
				}
			}
		}

		public override function takeLustDamage(lustDmg:Number, display:Boolean = true, applyRes:Boolean = true):Number{
			var x:Number = super.takeLustDamage(lustDmg, display, applyRes);
			raijuSuperchargedCheck();
			return x;
		}

		public function knownAbilities():/*CombatAbility*/Array {
			return CombatAbilities.ALL.filter(
					function(ability:CombatAbility,index:int,array:Array):Boolean {
						return ability.isKnown
					}
			)
		}
		public function knownAbilitiesOfClass(klass:Class):/*CombatAbility*/Array {
			return CombatAbilities.ALL.filter(
					function(ability:CombatAbility,index:int,array:Array):Boolean {
						return ability is klass && ability.isKnown
					}
			)
		}
		public function resetCooldowns():void {
			for (var i:int = 0; i<cooldowns.length; i++) {
				cooldowns[i] = 0;
			}
		}
	}
}
