local extension = Package:new("card_djis", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/cards/card_djis/skills")


Fk:addDamageNature(fk.FireDamage, "fire_damage",true )
Fk:addDamageNature(fk.ThunderDamage, "thunder_damage", true)

local meej = fk.CreateCard{
  name = "meej",
  type = Card.TypeTrick,
  sub_type = Card.SubtypeDelayedTrick,
  is_damage_card = false,
  skill = "meej_skill",
}

-- local free__meej = fk.CreateCard{
--   name = "&free__meej",
--   type = Card.TypeBasic,
--   is_damage_card = false,
--   skill = "free__meej_skill",
-- }
extension:loadCardSkels {meej,}


local dou_dook = fk.CreateCard{
  name = "dou_dook",
  type = Card.TypeBasic,
  is_damage_card = false,
  skill = "dou_dook_skill",
}



local thunder__ssaet = fk.CreateCard{
  name = "thunder__ssaet",
  type = Card.TypeBasic,
  is_damage_card = true,
  damage_type = fk.ThunderDamage,
  skill = "thunder__ssaet_skill",
}

local fire__ssaet = fk.CreateCard{
  name = "fire__ssaet",
  type = Card.TypeBasic,
  is_damage_card = true,
  damage_type = fk.FireDamage,
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



local hsvoah_kouc = fk.CreateCard{
  name = "hsvoah_kouc",
  type = Card.TypeBasic,
  skill = "hsvoah_kouc_skill",
  is_damage_card = true,
  damage_type = fk.FireDamage,
}

local hqjin_szjer_ljis_doavs = fk.CreateCard{
  name = "hqjin_szjer_ljis_doavs",
  type = Card.TypeTrick,
  sub_type=Card.SubtypeDelayedTrick,
  skill = "hqjin_szjer_ljis_doavs_skill",
  special_skills = { "recast" },  --?
  -- is_damage_card=true,  --?
  -- is_passive=true,
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
extension:loadCardSkels {hsoeojh_seevs,}



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
  skill = "self_equip_skill",
}

local baoch = fk.CreateCard{  --狼牙棒
  name = "baoch",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 4,
  equip_skill = "#baoch_skill",
  skill = "self_equip_skill",
}



local boav = fk.CreateCard{
  name = "boav",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#boav_skill",
  skill = "self_equip_skill",
}

local soeojs_doac_ceej = fk.CreateCard{
  name = "soeojs_doac_ceej",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#soeojs_doac_ceej_skill",
  skill = "self_equip_skill",
}
extension:loadCardSkels {soeojs_doac_ceej,}

local hqeen_tszji = fk.CreateCard{
  name = "hqeen_tszji",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#hqeen_tszji_skill",
  skill = "self_equip_skill",
}




extension:loadCardSkels {
  thunder__ssaet, fire__ssaet, 

  tvoans_liac_dzyet_quan, --tshoak_hsvoah_tsjek_sjin

  dou_dook,hqjin_szjer_ljis_doavs,hsvoah_kouc,

      -- tsiac_keejs_dzius_keejs,
  pheek_piuc_toav, baoch, boav, 
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

extension:addCardSpec("hsio_hzvoach_hqjit_tshiac", Card.Club, 1)
extension:addCardSpec("hsio_hzvoach_hqjit_tshiac", Card.Club, 11)

-- extension:addCardSpec("dou_dook", Card.Club, 3)  --v0boav
extension:addCardSpec("meej", Card.Spade, 3)  --v0酒
extension:addCardSpec("meej", Card.Spade, 11)  --chain

extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Heart, 1)
extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Heart, 13)
extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Spade, 13)  --將計就計
-- extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Club, 12)  --v1 theeit_soak
-- extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Club, 13)

-- extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Spade, 13)

extension:addCardSpec("tvoans_liac_dzyet_quan", Card.Spade, 10)  --斷糧
extension:addCardSpec("tvoans_liac_dzyet_quan", Card.Club, 4)

-- extension:addCardSpec("ssaac_dzzjin_koac",Card.Diamond, 8)


extension:addCardSpec("hsoeojh_seevs", Card.Spade, 2)  --v0藤甲 v1鐵索 v2天罡海嘯 v1海嘯爲埋伏
extension:addCardSpec("tshoak_hsvoah_tsjek_sjin", Card.Club, 3)  --v0boav

extension:addCardSpec("pheek_piuc_toav", Card.Spade, 1)  --古錠刀
extension:addCardSpec("baoch", Card.Diamond, 1)  --元扇子
-- extension:addCardSpec("tshiac", Card.Club, 3)  --刀 v1 Spade, 3
-- extension:addCardSpec("boav", Card.Spade, 2)  --元藤甲 鐵索
extension:addCardSpec("soeojs_doac_ceej", Card.Club, 10)  --賽唐猊
extension:addCardSpec("boav", Card.Club, 2)  --元藤甲 v1改爲迷 boav迻至天罡 --v2復

extension:addCardSpec("hqeen_tszji", Card.Diamond, 13)  --胭脂


Fk:loadTranslationTable{
  ["card_djis"] = "水滸牌-天罡",

  ["fire__ssaet"] = "火殺",
  [":fire__ssaet"] = "/行動牌/  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1 <br /><b>距離</b>：伱攻程内  <br /><b>次數</b>：同名牌每段限1次  <br /><b>效果</b>：伱予目幖1火傷｡",
  ["fire__ssaet_skill"] = "火殺",
  ["#fire__ssaet_skill"] = "火殺 予伱攻程内1腳色1火傷",
  ["#fire__ssaet_skill_multi"] = "選擇攻程內至多 %arg 名脚色，各予其1火傷",

  ["thunder__ssaet"] = "雷殺",
  [":thunder__ssaet"] = "/行動牌/  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1 <br /><b>距離</b>：伱攻程内  <br /><b>次數</b>：同名牌每段限1次  <br /><b>效果</b>：伱予目幖1火傷｡",
  ["thunder__ssaet_skill"] = "雷殺",
  ["#thunder__ssaet_skill"] = "雷殺 予伱攻程内1腳色1雷傷",
  ["#thunder__ssaet_skill_multi"] = "選擇攻程內至多 %arg 名脚色，各予其1雷傷",


  ["meej"] = "迷",
  [":meej"] = "/物資牌/  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1  <br /><b>距離</b>：伱攻程内  <br /><b>次數</b>：同名牌每轉限1次   <br /><b>延旹</b>：置于目幖伏區  <br /><b>效果</b>：伏區有｢迷｣牌者起動或演練子牌不可含手牌,轉終或其受傷後,廢除伏區｢迷｣｡",
  -- ["free__meej"] = "迷",
  ["meej_skill"] = "迷",
  ["#meej_skill"] = "迷 令伱伱攻程内1腳色不能起動演練",

  ["dou_dook"] = "投毒",
  [":dou_dook"] = "/謀策牌/  <br /><b>旹機</b>:主段執行旹<br /><b>目幖</b>:其它脚色  <br /><b>目幖數</b>：1    <br /><b>效果</b>：其視爲起動酒,效果改爲迷",
  ["dou_dook_skill"] = "投毒",
  ["#dou_dook_skill"] = "投毒 選擇攻程內1脚色 其不可起動或演練殺閃",

  ["hsvoah_kouc"] = "火攻",
  [":hsvoah_kouc"] = "/謀策牌/  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>：有手牌脚色    <br /><b>目幖數</b>：1    <br/><b>效果</b>：目幖展示1手牌,伱可投出1牌与展示牌同花者予目幖1火傷",
  ["hsvoah_kouc_skill"] = "火攻",
  ["#hsvoah_kouc_skill"] = "選擇有手牌脚色，令其展示1手牌，<br />伱可以投出1同花色手牌 予其1火傷",
  ["#hsvoah_kouc-show"] = "%src 對伱起動火攻，伱需展示1手牌",
  ["#hsvoah_kouc-discard"] = "演練一张 %arg 手牌，予 %src 1火傷",


  ["hsio_hzvoach_hqjit_tshiac"] = "虛晃一槍",
  [":hsio_hzvoach_hqjit_tshiac"] = "/謀策牌/  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1   <br/><b>效果</b>：伱展示1殺,目幖脚色選擇1項,➀令伱回1(若伱未損則不可選)➁視爲伱對其起動此殺",
  ["hsio_hzvoach_hqjit_tshiac_skill"] = "虛晃一槍",
  ["#hsio_hzvoach_hqjit_tshiac_skill"] = "虛晃一槍 伱展示1殺,選擇1目幖脚色",

  ["hqjin_szjer_ljis_doavs"] = "因勢利導",
  [":hqjin_szjer_ljis_doavs"] = "/謀策牌/  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：：其它脚色  <br /><b>目幖數</b>：1  <br /><b>延旹</b>：將此牌置于目幖脚色伏區,目幖上下家受到屬性傷後生效｡   <br /><b>效果</b>：与目幖相同傷害",
  ["hqjin_szjer_ljis_doavs_skill"] = "因勢利導",
  ["#hqjin_szjer_ljis_doavs_skill"] = "因勢利導 對 ",

  ["tshoak_hsvoah_tsjek_sjin"] = "厝火積薪",
  [":tshoak_hsvoah_tsjek_sjin"] = "/謀策牌/  <br/><b>旹機</b>:主段執行旹<br/><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1  <br /><b>延旹</b>：將此牌置于目幖脚色伏區,目幖受到火傷旹生效｡<br/><b>效果</b>：傷害值+1,結算後將此牌置入目幖伏區.",
  ["tshoak_hsvoah_tsjek_sjin_skill"] = "厝火積薪",
  ["#tshoak_hsvoah_tsjek_sjin_skill"] = "厝火積薪 延旹",

  ["tvoans_liac_dzyet_quan"] = "斷糧絕援",
  [":tvoans_liac_dzyet_quan"] = "/謀策牌/  <br /><b>旹機</b>：主段執行旹<br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1   <br /><b>距離</b>：伱至目幖距離等于1  <br /><b>延旹</b>：將此牌置于目幖脚色伏區,目幖伏段始前生效  <br /><b>生效</b>：目幖A占卜,若結果爲非♣️,A越過補段    <br /><b>額外</b>：每腳色伏區同名限1",
  ["tvoans_liac_dzyet_quan_skill"] = "斷糧絕援",
  ["#tvoans_liac_dzyet_quan_skill"] = "斷糧絕援 延旹,選擇距離1脚色起動",


  ["hsoeojh_seevs"] = "海嘯",
  [":hsoeojh_seevs"] = "/天災牌/  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：伏區无同名牌者  <br /><b>目幖數</b>：1  <br /><b>預起動</b>：伱   <br /><b>延旹</b>：將此牌置于目幖脚色伏區,目幖伏段執行旹生效  <br /><b>生效</b>：目幖占卜,若結果爲黑色AJ//Q/K,目幖弃置其全部牌,;否則將此牌至入下家伏區  <br /><b>額外</b>：此牌被抵消後至入目幖下家伏區",
  ["hsoeojh_seevs_skill"] = "海嘯",
  ["#hsoeojh_seevs_skill"] = "起動海嘯 置入伱伏區",

  ["pheek_piuc_toav"] = "劈風刀",
  [":pheek_piuc_toav"] = "/軍器牌/兵器/  <br/><b>攻程</b>：2<br/><b>兵器技能</b>：｡伱起動【殺】對目幖致傷时，若其无手牌，傷害值+1｡",
  ["#pheek_piuc_toav"] = "劈風刀",

  ["baoch"] = "棒",
  [":baoch"] = "/軍器牌/兵器/  <br/><b>攻程</b>：4<br/><b>兵器技能</b>：伱傷明起動普【殺】後，伱可發動,此【殺】改爲火【殺】｡",
  ["#baoch_skill"] = "棒",


  ["boav"] = "袍",
  [":boav"] = "/軍器牌/甲冑/<br /><b>甲冑技能</b>：{无屬殺/猛虎下山/弓矢斯張}對伱无效｡伱受到火傷旹,傷害值+1",
  ["boav_skill"] = "袍",

  ["soeojs_doac_ceej"] = "賽唐猊",
  [":soeojs_doac_ceej"] = "/軍器牌/甲冑/  <br/><b>甲冑技能</b>：{屬性/虛/轉化}殺對伱生效歬,防止之.伱受傷後,若來源不爲伱且牌爲殺,來源弃其兵器",
  ["#soeojs_doac_ceej_skill"] = "賽唐猊",
  ["soeojs_doac_ceej_skill"] = "賽唐猊",

  ["hqeen_tszji"] = "胭脂",
  [":hqeen_tszji"] = "/軍器牌/防敔坐騎/ <br/><b>坐騎技能</b>：其它脚色至伱距离+1｡",
  ["hqeen_tszji_skill"] = "胭脂",
}

return extension
