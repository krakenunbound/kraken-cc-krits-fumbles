-- Package script "KrakenKritsData" for Castles & Crusades (official CnCRPG
-- and SiegeCore). The tables are the Castle Keeper's Guide's own optional
-- rules for natural 20s and natural 1s (Chapter 17, Options 1, 4, 5 and 6);
-- the CK picks one in Options. Option 5 (the d20 tables) is the default.
-- Rows: { from, to, title, text, { effects } } (see the engine for the parts).

GAME = {
  tag = "Kraken Krits & Fumbles C&C",
  pfx = "KKFC_",
  defaultCrit = "always",
  defaultFumble = "always",
  hasDeath = true,
  tableChoices = {
    base = "opt5", baselabel = "option_val_kkfc_opt5",
    values = "opt6|opt1|opt4", labels = "option_val_kkfc_opt6|option_val_kkfc_opt1|option_val_kkfc_opt4",
    default = "opt5",
  },
}

local LOSE = { effect = "Kraken Loses next round", dur = 1 }
local function T(name, die, rows) return { name = name, die = die, rows = rows } end
local function r(a, b, title, text, fx) return { a, b, title, text, fx or {} } end
local function r1(n, text, fx) return { n, n, text, text, fx or {} } end

TABLES = {
  opt5_crit = T("CKG Table 17.1A - Critical Hits (Option 5)", 20, {
    r1(1, "Knock opponent down", { { effect = "Prone" } }),
    r1(2, "Head blow, teeth shatter, 1d4 damage, can't eat until healed",
      { { dmg = "1d4", title = "teeth shatter" }, { effect = "Kraken Teeth shattered (cannot eat until healed)" } }),
    r1(3, "Ear cut off, 1 point of damage, -1 listen checks",
      { { dmg = "1", title = "ear cut off" }, { effect = "Kraken Ear cut off; ABIL: -1 listen" } }),
    r1(4, "Chop off 1-4 fingers, 1 point of damage per finger, -1 dexterity",
      { { dmg = "1d4", title = "fingers" }, { effect = "Kraken Fingers lost (-1 dexterity per finger)" } }),
    r1(5, "Crushing/stabbing blow, blade stuck in rib cage. Reduces AC by 2, 1d8 damage per round",
      { { effect = "Kraken Blade in ribs; AC: -2; DMGO: 1d8" } }),
    r1(6, "Crush bone, render one limb of opponent useless, 1d8 damage",
      { { dmg = "1d8", title = "crushed bone" }, { effect = "Kraken Limb useless" } }),
    r1(7, "Jaw destroyed, 1d8 damage, can't speak or eat",
      { { dmg = "1d8", title = "jaw destroyed" }, { effect = "Kraken Jaw destroyed (cannot speak or eat)" } }),
    r1(8, "Elbow shattered by blow, arm crippled, 1d8 damage",
      { { dmg = "1d8", title = "elbow shattered" }, { effect = "Kraken Arm crippled" } }),
    r1(9, "Knee shattered by blow, crippled, can't walk, 1d10 damage",
      { { dmg = "1d10", title = "knee shattered" }, { effect = "Kraken Knee shattered (cannot walk)" }, { effect = "Prone" } }),
    r1(10, "Crushing blow to opponent's chest, collapsed lung, 1d10 damage, constitution cut in half",
      { { dmg = "1d10", title = "collapsed lung" }, { effect = "Kraken Collapsed lung (constitution halved)" } }),
    r1(11, "Gut wound, spleen ruptures or is punctured, 1d12 damage", { { dmg = "1d12", title = "gut wound" } }),
    r1(12, "Slice opponent in the face, blinded in both eyes", { { effect = "Blinded" } }),
    r1(13, "Lung punctured; reduce constitution by 50% per round until 0 (monsters lose physical primes), then death",
      { { effect = "Kraken Lung punctured (constitution halves each round, then death)" }, { note = "halve the victim's constitution each round until healed" } }),
    r1(14, "Head blow, force knocks eye out of socket, explodes globe, blind in that eye, 1d10 damage",
      { { dmg = "1d10", title = "eye lost" }, { effect = "Kraken Blind in one eye" } }),
    r1(15, "Massive blow to chest, victim's chest collapses, can't breathe, death in 1d4 rounds unless healed",
      { { effect = "Kraken Chest collapsed (death in 1d4 rounds unless healed)" }, { note = "roll 1d4: the victim dies after that many rounds unless healed" } }),
    r1(16, "Sever artery, if wound goes untreated 1d12 damage per round until healed",
      { { effect = "Kraken Severed artery; DMGO: 1d12" } }),
    r1(17, "Chop off random limb, 1d12 points of bleed damage until wound staunched",
      { { effect = "Kraken Limb severed; DMGO: 1d12" }, { note = "roll for the limb lost" } }),
    r1(18, "Crushing blow to the skull, opponent knocked unconscious, 1d12 points damage",
      { { dmg = "1d12", title = "skull crushed" }, { effect = "Unconscious" } }),
    r1(19, "Eviscerated, instant death", { { death = true } }),
    r1(20, "Chop off opponent's head, instant death", { { death = true } }),
  }),

  opt5_fumble = T("CKG Table 17.1B - Critical Fumble (Option 5)", 20, {
    r1(1, "Trip and fall upon the ground. Lose round of combat", { { effect = "Prone" }, LOSE }),
    r1(2, "Drop weapon, lose round of combat", { { note = "the weapon drops" }, LOSE }),
    r1(3, "Weapon breaks, lose round of combat", { { note = "the weapon breaks" }, LOSE }),
    r1(4, "Blow ricochets off target hits wielder, 1d4 damage", { { dmg = "1d4", title = "ricochet" } }),
    r1(5, "Slip on ground, on battlefield, hit ground, 1d4 damage", { { dmg = "1d4", title = "slip" }, { effect = "Prone" } }),
    r1(6, "Strike companion next to wielder. Companion takes 1d6 damage", { { note = "an adjacent companion takes 1d6 damage (roll it on them)" } }),
    r1(7, "Wild exertions cause attacker to bite own tongue off", { { effect = "Kraken Tongue bitten off (cannot speak)" } }),
    r1(8, "Stab or crush foot, 1d6 damage", { { dmg = "1d6", title = "own foot" } }),
    r1(9, "Stab or crush knee, 1d8 damage, initiative reduced by 2",
      { { dmg = "1d8", title = "own knee" }, { effect = "Kraken Crushed knee; INIT: -2" } }),
    r1(10, "Strike eye, blind in that eye", { { effect = "Kraken Blind in one eye" } }),
    r1(11, "Blow ricochets and smashes helm, helm driven into skull, temporarily blind", { { effect = "Blinded", dur = 2 } }),
    r1(12, "Thrust/swing places arm in cusp of enemy grip and remains stuck on armor, scales, etc.",
      { { effect = "Kraken Arm stuck on the foe (lose next attack)", dur = 1 } }),
    r1(13, "Weapon shatters, shards strike wielder for 1d4 damage", { { dmg = "1d4", title = "shards" }, { note = "the weapon shatters" } }),
    r1(14, "Overshoot blow, wrist strike opponent and shatters, drop weapon",
      { { effect = "Kraken Shattered wrist" }, { note = "the weapon drops" } }),
    r1(15, "Force of swing causes weight imbalance and knee blows out, crippled for 1 week",
      { { effect = "Kraken Knee blown out (crippled 1 week)" } }),
    r1(16, "Weapon shatters, large chunk lacerates wielder's eye",
      { { effect = "Kraken Lacerated eye" }, { note = "the weapon shatters" } }),
    r1(17, "Wild swing, gore, imbalance, wielder trips, and falls, breaking weapon punctures self, 1d12 damage",
      { { dmg = "1d12", title = "fell on own weapon" }, { effect = "Prone" }, { note = "the weapon breaks" } }),
    r1(18, "Trip past opponent, fall and drop weapon, 1d8 damage from fall, broken jaw",
      { { dmg = "1d8", title = "fall" }, { effect = "Prone" }, { effect = "Kraken Broken jaw" }, { note = "the weapon drops" } }),
    r1(19, "Weapon shatters; small piece punctures head/skull. Instant death", { { death = true } }),
    r1(20, "Smash self in head or fall on blade, spear, etc. Instant death", { { death = true } }),
  }),

  opt6_crit = T("CKG Table 17.1C - Critical Hit (Option 6)", 20, {
    r(1, 5, "No critical", "Normal damage."),
    r(6, 10, "Normal damage +1d4", "Add 1d4.", { { dmg = "1d4", title = "+1d4" } }),
    r(11, 14, "Max damage", "The damage roll is maximum.", { { mark = "max" } }),
    r(15, 17, "Max damage x2", "Twice the maximum damage.", { { mark = 2 } }),
    r(18, 19, "Max damage x3", "Three times the maximum damage.", { { mark = 3 } }),
    r(20, 20, "Max damage x4", "Four times the maximum damage.", { { mark = 4 } }),
  }),

  opt6_fumble = T("CKG Table 17.1D - Critical Fumble (Option 6)", 20, {
    r(1, 1, "Damage self for 1-8 hp", "", { { dmg = "1d8", title = "self" } }),
    r(2, 3, "Damage self for 1-4 hp", "", { { dmg = "1d4", title = "self" } }),
    r(4, 6, "Break weapon", "", { { note = "the weapon breaks" } }),
    r(7, 10, "Minimum damage", "The next hit does minimum damage.", { { mark = "min", who = "a" } }),
    r(11, 15, "Lose next round's action", "", { LOSE }),
    r(16, 20, "No fumble", ""),
  }),

  opt1_crit = T("CKG Option 1 - Critical Hit", 1, {
    r(1, 1, "Critical hit", "The weapon does maximum damage +1d4, +strength modifier.",
      { { mark = "max" }, { dmg = "1d4", title = "+1d4" }, { note = "add the attacker's strength modifier" } }),
  }),
  opt4_crit = T("CKG Option 4 - Roadhouse Critical", 1, {
    r(1, 1, "Roadhouse critical", "Double the attack dice and double any bonus damage.", { { mark = "double" } }),
  }),
  opt1_fumble = T("CKG Option 1 - Fumble", 1, {
    r(1, 1, "Fumble", "The character drops their weapon (a noosed weapon only loses its grip).", { { note = "the weapon drops (noosed: only the grip is lost)" } }),
  }),
  opt1_fumble_ranged = T("CKG Option 1 - Fumble (missile)", 6, {
    r(1, 1, "Bow breaks", "The bow breaks (not the string).", { { effect = "Kraken Bow broken" } }),
    r(2, 6, "Bowstring breaks", "The bowstring breaks.", { { effect = "Kraken Bowstring broken (restring)" } }),
  }),
}

function pickTable(sKind, rSource, rTarget, rRoll)
  local sMode = OptionsManager.getOption(GAME.pfx .. "MODE")
  if sMode == "" then sMode = "opt5" end
  local sDesc = ((rRoll and rRoll.sDesc) or ""):lower()
  local bRanged = (rRoll and rRoll.sRange == "R") or sDesc:find("(r)", 1, true) ~= nil
  if sKind == "crit" then
    if sMode == "opt1" then return "opt1_crit" end
    if sMode == "opt4" then return "opt4_crit" end
    return sMode .. "_crit"
  end
  if sMode == "opt1" or sMode == "opt4" then
    return bRanged and "opt1_fumble_ranged" or "opt1_fumble"
  end
  return sMode .. "_fumble"
end

-- Both C&C rulesets resolve attacks in their "attack" result handler; a
-- natural 20 is a critical hit and a natural 1 a fumble (CKG Chapter 17).
local function naturalDie(rRoll)
  local d = rRoll and rRoll.aDice and rRoll.aDice[1]
  if type(d) == "table" then return d.result or d.value or 0 end
  return 0
end

GAME.pickTable = pickTable
GAME.hook = function()
  local fOrig = ActionsManager.getResultHandler("attack")
  ActionsManager.registerResultHandler("attack", function(rSource, rTarget, rRoll)
    local vResult
    if fOrig then vResult = fOrig(rSource, rTarget, rRoll) end
    local n = naturalDie(rRoll)
    if n == 20 then
      KrakenKrits.onAttackResult(rSource, rTarget, rRoll, "crit")
    elseif n == 1 then
      KrakenKrits.onAttackResult(rSource, rTarget, rRoll, "fumble")
    end
    return vResult
  end)
end
