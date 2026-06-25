local extension = Package:new("card_djis", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/card_djis/skills")


Fk:addDamageNature(fk.FireDamage, "fire_damage")
Fk:addDamageNature(fk.ThunderDamage, "thunder_damage")

local meej = fk.CreateCard{
  name = "&meej",
  type = Card.TypeBasic,
  is_damage_card = false,
  skill = "meej_skill",
}

local free__meej = fk.CreateCard{
  name = "&free__meej",
  type = Card.TypeBasic,
  is_damage_card = false,
  skill = "free__meej_skill",
}

local sjevs_lih_dzoac_toav = fk.CreateCard{
  name = "sjevs_lih_dzoac_toav",
  type = Card.TypeBasic,
  is_damage_card = false,
  skill = "sjevs_lih_dzoac_toav_skill",
}



local thunder__ssaet = fk.CreateCard{
  name = "thunder__ssaet",
  type = Card.TypeBasic,
  is_damage_card = true,
  skill = "thunder__ssaet_skill",
}

local fire__ssaet = fk.CreateCard{
  name = "fire__ssaet",
  type = Card.TypeBasic,
  is_damage_card = true,
  skill = "fire__ssaet_skill",
}

-- local tsiuh = fk.CreateCard{
--   name = "tsiuh",
--   type = Card.TypeBasic,
--   skill = "tsiuh_skill",
-- }



local hsio_hzvoach_hqjit_tshiac = fk.CreateCard{  --theen?
  name = "hsio_hzvoach_hqjit_tshiac",
  type = Card.TypeBasic, --int
  is_damage_card = false,  --不算
  skill = "hsio_hzvoach_hqjit_tshiac_skill",
}
extension:loadCardSkels {
hsio_hzvoach_hqjit_tshiac,
}

local hqjin_szjer_ljis_doavs = fk.CreateCard{
  name = "hqjin_szjer_ljis_doavs",
  type = Card.TypeBasic,
  skill = "hqjin_szjer_ljis_doavs_skill",
  special_skills = { "recast" },  --?
  -- is_damage_card=true,  --?
  is_passive=true,
}

local hsvoah_kouc = fk.CreateCard{
  name = "hsvoah_kouc",
  type = Card.TypeBasic,
  skill = "hsvoah_kouc_skill",
  is_damage_card = true,
}

local tvoans_liac_dzyet_quan = fk.CreateCard{
  name = "tvoans_liac_dzyet_quan",
  type = Card.TypeTrick,
  sub_type = Card.SubtypeDelayedTrick,
  skill = "tvoans_liac_dzyet_quan_skill",
  stackable_delayed = true,
}


--
local hsoeojh_seevs = fk.CreateCard{
  name = "hsoeojh_seevs",
  type = Card.TypeTrick,
  sub_type = Card.SubtypeDelayedTrick,
  stackable_delayed = true,
  skill = "hsoeojh_seevs_skill",
}
extension:loadCardSkels {
hsoeojh_seevs,
}



local tshoak_hsvoah_tsjek_sjin = fk.CreateCard{
  name = "tshoak_hsvoah_tsjek_sjin",
  type = Card.TypeTrick,
  sub_type=Card.SubtypeDelayedTrick,
  stackable_delayed = true,
  skill = "tshoak_hsvoah_tsjek_sjin_skill",
  -- multiple_targets = true,
}
extension:loadCardSkels {
tshoak_hsvoah_tsjek_sjin,
}

--
local pheek_piuc_toav = fk.CreateCard{
  name = "pheek_piuc_toav",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 2,
  equip_skill = "#pheek_piuc_toav_skill",
}

local baoh = fk.CreateCard{  --烽火
  name = "baoh",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 4,
  equip_skill = "#baoh_skill",
}



local boav = fk.CreateCard{
  name = "boav",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#boav_skill",
}

local tou_miu = fk.CreateCard{
  name = "tou_miu",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#tou_miu_skill",
}

local hqeen_tszji = fk.CreateCard{
  name = "hqeen_tszji",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#hqeen_tszji_skill",
}


-- local heen_tszji = fk.CreateCard{
--   name = "heen_tszji",
--   type = Card.TypeEquip,
--   sub_type = Card.SubtypeDefensiveRide,
--   equip_skill = "#heen_tszji_skill",
-- }



extension:loadCardSkels {
  thunder__ssaet, fire__ssaet, 
  meej, free__meej,
  tvoans_liac_dzyet_quan, --tshoak_hsvoah_tsjek_sjin

  sjevs_lih_dzoac_toav,hqjin_szjer_ljis_doavs,hsvoah_kouc,

      -- tsiac_keejs_dzius_keejs,
  pheek_piuc_toav, baoh, boav, tou_miu,
  hqeen_tszji,

}

extension:addCardSpec("thunder__ssaet", Card.Club, 5)  --同
extension:addCardSpec("thunder__ssaet", Card.Club, 6)
extension:addCardSpec("thunder__ssaet", Card.Club, 7)
extension:addCardSpec("thunder__ssaet", Card.Club, 8)
extension:addCardSpec("thunder__ssaet", Card.Spade, 4)
extension:addCardSpec("thunder__ssaet", Card.Spade, 5)
extension:addCardSpec("thunder__ssaet", Card.Spade, 6)
extension:addCardSpec("thunder__ssaet", Card.Spade, 7)
extension:addCardSpec("thunder__ssaet", Card.Spade, 8)

extension:addCardSpec("fire__ssaet", Card.Heart, 4)
extension:addCardSpec("fire__ssaet", Card.Heart, 7)
extension:addCardSpec("fire__ssaet", Card.Heart, 10)
extension:addCardSpec("fire__ssaet", Card.Diamond, 4)
extension:addCardSpec("fire__ssaet", Card.Diamond, 5)

extension:addCardSpec("szjemh", Card.Heart, 8)  --同
extension:addCardSpec("szjemh", Card.Heart, 9)
extension:addCardSpec("szjemh", Card.Heart, 11)
extension:addCardSpec("szjemh", Card.Heart, 12)
extension:addCardSpec("szjemh", Card.Diamond, 6)
extension:addCardSpec("szjemh", Card.Diamond, 7)
extension:addCardSpec("szjemh", Card.Diamond, 8)  --
extension:addCardSpec("szjemh", Card.Diamond, 10)
extension:addCardSpec("szjemh", Card.Diamond, 11)

extension:addCardSpec("nziuk", Card.Heart, 5)  --v1迷 --v2 Spade, 3
extension:addCardSpec("nziuk", Card.Heart, 6)
extension:addCardSpec("nziuk", Card.Diamond, 2)
extension:addCardSpec("nziuk", Card.Diamond, 3)

-- extension:addCardSpec("tsiuh", Card.Spade, 3)  --v0 tsiuh --v1tsiuh
extension:addCardSpec("tsiuh", Card.Spade, 9)  --v0 tsiuh --v1tsiuh
extension:addCardSpec("tsiuh", Card.Club, 9)  --v0 tsiuh --v1tsiuh
-- extension:addCardSpec("tsiuh", Card.Club, 3)  --v0 tsiuh v1 chain
extension:addCardSpec("tsiuh", Card.Diamond, 9)  --v0 tsiuh v1fire_slah


-- extension:addCardSpec("hqjin_szjer_ljis_doavs", Card.Spade, 2)  --增 元藤甲
-- extension:addCardSpec("hqjin_szjer_ljis_doavs", Card.Spade, 11)
extension:addCardSpec("hqjin_szjer_ljis_doavs", Card.Spade, 12)
-- extension:addCardSpec("hqjin_szjer_ljis_doavs", Card.Club, 3)  --v0酒
-- extension:addCardSpec("hqjin_szjer_ljis_doavs", Card.Club, 10)
-- extension:addCardSpec("hqjin_szjer_ljis_doavs", Card.Club, 11)
extension:addCardSpec("hqjin_szjer_ljis_doavs", Card.Club, 12)
extension:addCardSpec("hqjin_szjer_ljis_doavs", Card.Club, 13)


extension:addCardSpec("hsvoah_kouc", Card.Heart, 2)  --元
extension:addCardSpec("hsvoah_kouc", Card.Heart, 3)
extension:addCardSpec("hsvoah_kouc", Card.Diamond, 12)

extension:addCardSpec("hsio_hzvoach_hqjit_tshiac", Card.Club, 10)
extension:addCardSpec("hsio_hzvoach_hqjit_tshiac", Card.Club, 11)

-- extension:addCardSpec("sjevs_lih_dzoac_toav", Card.Club, 3)  --v0boav
extension:addCardSpec("sjevs_lih_dzoac_toav", Card.Spade, 3)  --v0酒
extension:addCardSpec("sjevs_lih_dzoac_toav", Card.Spade, 11)  --chain

extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Heart, 1)
extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Heart, 13)
extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Spade, 13)  --將計就計
-- extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Club, 12)  --v1 theeit_soak
-- extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Club, 13)

-- extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Spade, 13)

extension:addCardSpec("tvoans_liac_dzyet_quan", Card.Spade, 10)  --斷糧
extension:addCardSpec("tvoans_liac_dzyet_quan", Card.Club, 4)

-- extension:addCardSpec("ssaac_dzzjin_koac",Card.Diamond, 8)


extension:addCardSpec("hsoeojh_seevs", Card.Spade, 2)  --v0藤甲 v1鐵索 v2天罡海嘯 v1海嘯爲行刺
extension:addCardSpec("tshoak_hsvoah_tsjek_sjin", Card.Club, 3)  --v0boav

extension:addCardSpec("pheek_piuc_toav", Card.Spade, 1)  --古錠刀
extension:addCardSpec("baoh", Card.Diamond, 1)  --元扇子
-- extension:addCardSpec("tshiac", Card.Club, 3)  --刀 v1 Spade, 3
-- extension:addCardSpec("boav", Card.Spade, 2)  --元藤甲 鐵索
extension:addCardSpec("tou_miu", Card.Club, 1)  --白銀獅子
extension:addCardSpec("boav", Card.Club, 2)  --元藤甲 v1改爲迷 boav迻至天罡 --v2復

extension:addCardSpec("hqeen_tszji", Card.Diamond, 13)  --胭脂


Fk:loadTranslationTable{
  ["card_djis"] = "水滸牌-天罡",

  ["fire__ssaet"] = "火殺",
  [":fire__ssaet"] = "基本牌-行動<br /><b>旹機</b>：主旹<br /><b>目幖</b>：1其它角色<br /><b>距離</b>：伱攻程内<br /><b>次數</b>：每段限1次<br /><b>效果</b>：對目幖角色造成1火傷。",
  ["fire__ssaet_skill"] = "火殺",
  ["#fire__ssaet_skill"] = "火殺",
  ["#fire__ssaet_skill_multi"] = "選擇攻程內至多 %arg 名角色，各予其1火傷",

  ["thunder__ssaet"] = "雷殺",
  [":thunder__ssaet"] = "基本牌-行動<br /><b>旹機</b>：主旹<br /><b>目幖</b>：1其它角色<br /><b>距離</b>：伱攻程内<br /><b>次數</b>：每段限1次<br /><b>效果</b>：對目幖角色造成1火傷。",
  ["thunder__ssaet_skill"] = "雷殺",
  ["#thunder__ssaet"] = "雷殺",
  ["#thunder__ssaet_skill_multi"] = "選擇攻程內至多 %arg 名角色，各予其1雷傷",


  ["meej"] = "迷",
  [":meej"] = "基本牌-物資<br /><b>旹機</b>：主動<br /><b>目幖</b>：1攻程內其它角色<br /><b>效果</b>：目幖角色附加昏迷,不能使用打出殺閃。",
  ["free__meej"] = "迷",
  ["meej_skill"] = "迷",
  ["#meej_skill"] = "迷",

  ["sjevs_lih_dzoac_toav"] = "笑裏藏刀",
  [":sjevs_lih_dzoac_toav"] = "锦囊牌<br /><b>旹機</b>:主旹<br /><b>目幖</b>:1其它角色<br /><b>效果</b>：其視爲使用酒,效果改爲迷",
  ["sjevs_lih_dzoac_toav_skill"] = "笑裏藏刀",
  ["#sjevs_lih_dzoac_toav_skill"] = "笑裏藏刀 選擇攻程內1角色 其不能使用打出殺閃",

  ["hsvoah_kouc"] = "火攻",
  [":hsvoah_kouc"] = "錦囊-延旹<br/><b>旹機</b>:主旹<br/><b>目幖</b>：1有有牌角色<br/><b>效果</b>：其展示1手牌,伱可打出1牌与展示牌同花者予目幖1火傷",
  ["hsvoah_kouc_skill"] = "火攻",
  ["#hsvoah_kouc_skill"] = "選擇有手牌角色，令其展示1手牌，<br />伱可以打出1同花色手牌 予其1火傷",
  ["#hsvoah_kouc-show"] = "%src 對伱使用火攻，伱需展示1手牌",
  ["#hsvoah_kouc-discard"] = "打出一张 %arg 手牌，予 %src 1火傷",

  ["hqjin_szjer_ljis_doavs"] = "因勢利導",
  [":hqjin_szjer_ljis_doavs"] = "錦囊牌<br /><b>旹機</b>：一角色受到屬性傷害後<br /><b>目幖</b>：受傷角色上家或下家(已有方向則止能依之)<br /><b>效果</b>：与目幖相同傷害",
  ["hqjin_szjer_ljis_doavs_skill"] = "因勢利導",
  ["#hqjin_szjer_ljis_doavs_skill"] = "因勢利導 對 ",

  ["hsio_hzvoach_hqjit_tshiac"] = "虛晃一槍",
  [":hsio_hzvoach_hqjit_tshiac"] = "錦囊牌<br/><b>旹機</b>:主旹<br/><b>目幖</b>：1其它角色<br/><b>效果</b>：伱展示1殺,目幖角色選擇1項,➀令伱回1(若伱未損則不可選)➁視爲伱對其使用此殺",
  ["hsio_hzvoach_hqjit_tshiac_skill"] = "虛晃一槍",
  ["#hsio_hzvoach_hqjit_tshiac_skill"] = "虛晃一槍 伱展示1殺,選擇1目幖角色",

  ["tshoak_hsvoah_tsjek_sjin"] = "厝火積薪",
  [":tshoak_hsvoah_tsjek_sjin"] = "錦囊牌<br/><b>旹機</b>:主旹<br/><b>目幖</b>：1其它角色<br /><b>延旹</b>：將此牌置于目幖角色伏區,目幖受到火傷旹生效。<br/><b>效果</b>：傷害值+1,結算後將此牌置入目幖伏區.",
  ["tshoak_hsvoah_tsjek_sjin_skill"] = "厝火積薪",
  ["#tshoak_hsvoah_tsjek_sjin_skill"] = "厝火積薪 延旹",

  ["tvoans_liac_dzyet_quan"] = "斷糧絕援",
  [":tvoans_liac_dzyet_quan"] = "锦囊牌<br /><b>旹機</b>：主動<br /><b>目幖</b>：1其它角色<br /><b>距離</b>：伱至其距離等于1<br /><b>延旹</b>：將此牌置于目幖角色伏區,目幖伏段生效<br /><b>生效</b>：目幖A判定阶段判定生效,A判定,若結果爲非♣️,A越過補段",
  ["tvoans_liac_dzyet_quan_skill"] = "斷糧絕援",
  ["#tvoans_liac_dzyet_quan_skill"] = "斷糧絕援 延旹,選擇距離1角色使用",



  ["pheek_piuc_toav"] = "劈風刀",
  [":pheek_piuc_toav"] = "装备牌·武器<br/><b>攻程</b>：2<br/><b>武器技能</b>：鎖定。伱使用【殺】對目幖致傷时，若其无手牌，傷害值+1。",
  ["#pheek_piuc_toav"] = "劈風刀",

  ["baoh"] = "棒",
  [":baoh"] = "装备牌·武器<br/><b>攻程</b>：4<br/><b>武器技能</b>：伱傷明使用普【殺】後，伱可發動,此【殺】改爲火【殺】。",
  ["#baoh_skill"] = "棒",


  ["boav"] = "袍",
  [":boav"] = "裝僃牌·防具<br /><b>防具技能</b>：鎖定.{无屬殺/猛虎下山/弓矢斯張}對伱无效。伱受到火傷旹,傷害值+1",
  ["boav_skill"] = "袍",

  ["tou_miu"] = "兜鍪",
  [":tou_miu"] = "裝僃牌·防具<br /><b>防具技能</b>：鎖定.➀伱受傷旹,若傷害大于1,減至1。➁伱失去所裝僃兜鍪後,伱抽2",
  ["tou_miu_skill"] = "兜鍪",

  ["hqeen_tszji"] = "胭脂",
  [":hqeen_tszji"] = "装备牌·坐骑<br/><b>坐骑技能</b>：其它角色至伱距离+1。",
  ["hqeen_tszji_skill"] = "胭脂",
}

return extension
