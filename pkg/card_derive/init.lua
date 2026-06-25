local extension = Package:new("card_derive", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/card_derive/skills")



Fk:loadTranslationTable{
  -- ["card_derive"] = "<b>水滸牌-衍生</b>",
  ["card_derive"] = "水滸牌-衍生",
}

--葢伏
local ambush__ssaet = fk.CreateCard{
  name = "ambush__ssaet",
  type = Card.TypeBasic,
  skill = "ssaet_skill",
  special_skills = { "koarbiuk_cardskill" },
  is_damage_card=true,
}

local ambush__szjemh = fk.CreateCard{
  name = "ambush__szjemh",
  type = Card.TypeBasic,
  skill = "szjemh_skill",
  special_skills = { "koarbiuk_cardskill" },
  is_passive=true,
}

local ambush__buac_hzfan_mujs_nzjen = fk.CreateCard{
  name = "ambush__buac_hzfan_mujs_nzjen",
  type = Card.TypeBasic, --int
  skill = "buac_hzfan_mujs_nzjen_skill",
  special_skills = { "koarbiuk_cardskill" },
  is_passive=true,
}
extension:loadCardSkels {
ambush__ssaet,
ambush__szjemh,
ambush__buac_hzfan_mujs_nzjen,
}
Fk:loadTranslationTable{
  ["ambush__ssaet"] = "葢_殺",
  ["ambush__szjemh"] = "葢_閃",
  ["ambush__buac_hzfan_mujs_nzjen"] = "葢_防患未肰",
}
local hand__szjemh = fk.CreateCard{  --名不同
  name = "&hand__szjemh",
  type = Card.TypeBasic,
--   sub_type = Card.SubtypeDelayedTrick,
  skill = "szjemh_skill",
  is_passive=true,
}
local hand__buac_hzfan_mujs_nzjen = fk.CreateCard{  --名不同
  name = "&hand__buac_hzfan_mujs_nzjen",
  type = Card.TypeBasic,
--   sub_type = Card.SubtypeDelayedTrick,
  skill = "buac_hzfan_mujs_nzjen_skill",
  is_passive=true,
}

local hand__tsiac_keejs_dzius_keejs = fk.CreateCard{  --名不同
  name = "&hand__tsiac_keejs_dzius_keejs",
  type = Card.TypeBasic,
--   sub_type = Card.SubtypeDelayedTrick,
  skill = "tsiac_keejs_dzius_keejs_skill",
  is_passive=true,
}

local hand__theem_prac_kaemh_tsoavs = fk.CreateCard{
  name = "&hand__theem_prac_kaemh_tsoavs",
  type = Card.TypeBasic,
  skill = "theem_prac_kaemh_tsoavs_skill",
  is_passive = true, 
}
extension:loadCardSkels {
  hand__szjemh, hand__buac_hzfan_mujs_nzjen,
hand__tsiac_keejs_dzius_keejs,
hand__theem_prac_kaemh_tsoavs,
}
extension:addCardSpec("hand__szjemh")
extension:addCardSpec("hand__buac_hzfan_mujs_nzjen")
extension:addCardSpec("hand__tsiac_keejs_dzius_keejs")
extension:addCardSpec("hand__theem_prac_kaemh_tsoavs")

Fk:loadTranslationTable{
  ["hand__szjemh"] = "護_閃",
  ["hand__buac_hzfan_mujs_nzjen"] = "護_防患未肰",
  ["hand__tsiac_keejs_dzius_keejs"] = "護_將計就計",
  ["hand__theem_prac_kaemh_tsoavs"] = "護_添兵減竈",
}

----動作

local dzzjek__ssaet = fk.CreateCard{
  name = "&dzzjek__ssaet",
  type = Card.TypeBasic,
  skill = "ssaet_skill",
  -- is_passive = true, 
}

extension:loadCardSkels {
dzzjek__ssaet,
}
extension:addCardSpec("dzzjek__ssaet")

Fk:loadTranslationTable{
  ["dzzjek__ssaet"] = "飛石殺",
  [":ambush__ssaet"] = "基本牌<br /><b>旹機</b>主旹<br /><b>目幖</b>攻程內其它角色<br /><b>效果</b>：与其1傷.因花色具有效果",
  ["#dzzjek__ssaet_skill"] = "飛石殺",
}
---
local fake__nziuk = fk.CreateCard{
  name = "&fake__nziuk",
  type = Card.TypeBasic,
  skill = "fake__nziuk_skill",
}
Fk:loadTranslationTable{
  ["fake__nziuk"] = "僞肉",
  [":fake__nziuk"] = "基本牌<br/><b>旹機:</b>主旹<br/><b>目幖:</b>自己<br/><b>效果:</b>(肉同名牌)目幖回1,選擇弃1手牌或流失1體力",
}

extension:loadCardSkels {
fake__nziuk,
}
extension:addCardSpec("fake__nziuk")



---------------------------------------------------------------------------------------------
--錦囊
local buak_koavh_qwe_nzjin = fk.CreateCard{
  name = "&buak_koavh_qwe_nzjin",
  type = Card.TypeBasic,
  skill = "buak_koavh_qwe_nzjin_skill",
  -- multiple_targets = true,
}
Fk:loadTranslationTable{
  ["buak_koavh_qwe_nzjin"] = "縛藁爲人",
  [":buak_koavh_qwe_nzjin"] = "錦囊<br/><b>旹機:</b>主旹<br/><b>目幖:</b>攻程內1其他角色<br/><b>效果:</b>伱隱祕選擇僞或眞.目幖選擇打出殺或不響應.若皆爲前者,伱獲得殺,皆爲後者,伱將此牌轉化爲殺對其使用(无視次數距離不可響應)",
  ["buak_koavh_qwe_nzjin_skill"] = "縛藁爲人",
  ["#buak_koavh_qwe_nzjin_skill"] = "縛藁爲人 選擇眞僞 對1其他角色使用",
  ["#buak_koavh_qwe_nzjin_skill-response"] = "縛藁爲人 打出殺,%src可能獲得之; 不打出殺,%src可能對伱使用殺",
  ["#buak_koavh_qwe_nzjin_skill_choose"] = "選擇眞僞",
}
extension:loadCardSkels {buak_koavh_qwe_nzjin,}
extension:addCardSpec("buak_koavh_qwe_nzjin")


--
local muo_ttiuc_ssaac_qiuh = fk.CreateCard{
  name = "&muo_ttiuc_ssaac_qiuh",
  type = Card.TypeBasic,
  skill = "muo_ttiuc_ssaac_qiuh_skill",
}
Fk:loadTranslationTable{
  ["muo_ttiuc_ssaac_qiuh"] = "无中生有",
  [":muo_ttiuc_ssaac_qiuh"] = "錦囊<br/><b>旹機:</b>主旹<br/><b>目幖:</b>1其它角色<br/><b>效果:</b>伱抽2,其選擇1項➀對伱使用殺,此殺結算後若其傷致,伱弃所抽牌➁本局額定手牌數-1",
}
extension:loadCardSkels {muo_ttiuc_ssaac_qiuh,}
extension:addCardSpec("muo_ttiuc_ssaac_qiuh")

--
local tsjas_toav_ssaet_nzjin = fk.CreateCard{
  name = "&tsjas_toav_ssaet_nzjin",
  type = Card.TypeBasic,
  is_damage_card = false,
  skill = "tsjas_toav_ssaet_nzjin_skill",
  is_passive = true,
}
Fk:loadTranslationTable{
  ["tsjas_toav_ssaet_nzjin"] = "借刀殺人",
  [":tsjas_toav_ssaet_nzjin"] = "錦囊牌<br/><b>旹機:</b>主旹<br/><b>目幖:</b>1其它角色A与A殺合理目幖B,對A使用.<br/><b>效果:</b> A可對B使用1殺,且A可將此牌轉化爲殺",
}
extension:loadCardSkels {tsjas_toav_ssaet_nzjin,}
extension:addCardSpec("tsjas_toav_ssaet_nzjin")


--
local dzzuoh_dzziach_khoeoj_hsfa = fk.CreateCard{
  name = "&dzzuoh_dzziach_khoeoj_hsfa",
  type = Card.TypeBasic,
  skill = "dzzuoh_dzziach_khoeoj_hsfa_skill",
}
Fk:loadTranslationTable{
  ["dzzuoh_dzziach_khoeoj_hsfa"] = "樹上開花",
  [":dzzuoh_dzziach_khoeoj_hsfa"] = "錦囊牌<br/><b>旹機:</b>主旹<br/><b>目幖:</b>伱自己,若伱有空裝僃欄<br/><b>效果:</b>緟複,若伱有空裝僃欄,伱將牌堆頂1牌置入其中",
}
extension:loadCardSkels {dzzuoh_dzziach_khoeoj_hsfa,}
extension:addCardSpec("dzzuoh_dzziach_khoeoj_hsfa")



local lje_kaens = fk.CreateCard{
  name = "&lje_kaens",
  type = Card.TypeBasic,
  skill = "lje_kaens_skill",
}
Fk:loadTranslationTable{
  ["lje_kaens"] = "離閒",
  [":lje_kaens"] = "錦囊牌  <br/><b>旹機:</b>主旹  <br/><b>目幖:</b>任意角色  <br/><b>目幖數:</b>2  <br/><b>效果:</b>目幖參与共同拼點",
}
extension:loadCardSkels {lje_kaens,}
extension:addCardSpec("lje_kaens")


local tthxins_hsvoah_toah_kiap = fk.CreateCard{
  name = "&tthxins_hsvoah_toah_kiap",
  type = Card.TypeBasic,
  skill = "tthxins_hsvoah_toah_kiap_skill",
}
Fk:loadTranslationTable{
  ["tthxins_hsvoah_toah_kiap"] = "趁火打劫",
  [":tthxins_hsvoah_toah_kiap"] = "錦囊牌  <br/><b>旹機:</b>其它角色受傷後  <br/><b>目幖:</b>受傷角色需其有牌  <br/><b>目幖數:</b>1  <br/><b>效果:</b>伱獲取目幖1脾  <br/><b>額外:</b>因動",
}
extension:loadCardSkels {tthxins_hsvoah_toah_kiap,}
extension:addCardSpec("tthxins_hsvoah_toah_kiap")
-------------------------------------------------------------------------------------------------裝僃
local moucqtszhioc__hzaach = fk.CreateCard{
  name = "&moucqtszhioc__hzaach",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeTreasure,
  -- equip_skill = "#moucqtszhioc__hzaach_skill",
}
extension:loadCardSkels {moucqtszhioc__hzaach,}
Fk:loadTranslationTable{
  ["moucqtszhioc__hzaach"] = "戰艦",
  [":moucqtszhioc__hzaach"] = "裝僃牌-寶物  <br/><b>寶物 </b>：使用後將此牌置于目幖角色寶物欄,持續生效  寶物技能</b>：伱使用",
  ["moucqtszhioc__hzaach_skill"] = "戰艦",
}


local phaavshsfec__phaavs = fk.CreateCard{
  name = "&phaavshsfec__phaavs",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 6,
  -- equip_skill = "#phaavshsfec__phaavs_skill",
}
extension:loadCardSkels {phaavshsfec__phaavs,}
Fk:loadTranslationTable{
  ["phaavshsfec__phaavs"] = "炮",
  [":phaavshsfec__phaavs"] = "裝僃牌武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br/><b>攻程</b>：6<br/><b>武器技能</b>：伱使用殺旹,若伱半損(上取整)此殺不可響應",
  ["phaavshsfec__phaavs_skill"] = "炮",
}

--
local phiocqmoac_toav = fk.CreateCard{
  name = "&phiocqmoac_toav",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 2,
  equip_skill = "#phiocqmoac_toav_skill",
}
extension:loadCardSkels {phiocqmoac_toav,}
-- extension:addCardSpec("phiocqmoac_toav")
Fk:loadTranslationTable{
  ["phiocqmoac_toav"] = "刀",
  [":phiocqmoac_toav"] = "裝僃牌武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br/><b>攻程</b>：2<br/><b>武器技能</b>：伱使用｢殺｣旹,若伱半損(上取整)此｢殺｣不可響應",
  ["phiocqmoac_toav_skill"] = "刀",
}
--
local gracqgi__gi = fk.CreateCard{
  name = "&gracqgi__gi",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeTreasure,
  -- skill = "#gracqgi__gi_skill",
  equip_skill= "#gracqgi__gi_skill",
}
extension:loadCardSkels {gracqgi__gi,}
-- extension:addCardSpec("gracqgi__gi",5,Card.Heart)
Fk:loadTranslationTable{
  ["gracqgi__gi"] = "杏黃旗",
  [":gracqgi__gi"] =  "裝僃牌寶物  <br/><b>寶物</b>：使用後將此牌置于目幖角色寶物欄,持續生效    <br/><b>寶物技能</b>与伱同陣營(隊列)角色攻程+1。",
  ["gracqgi__gi_skill"] = "杏黃旗",
  [":gracqgi__gi_skill"] = "杏黃旗",
}

return extension

