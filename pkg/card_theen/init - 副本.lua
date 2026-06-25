local extension = Package:new("card_theen", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/card_theen/skills")

--

--
local szyih_kouc = fk.CreateCard{
  name = "szyih_kouc",
  type = Card.TypeTrick,
  is_damage_card = true,
  skill = "szyih_kouc_skill",
  -- is_passive = true,  --埋伏
}



local ssaac_dzzjin_koac = fk.CreateCard{
  name = "ssaac_dzzjin_koac",
  type = Card.TypeTrick,  --待定
  sub_type = Card.SubtypeDelayedTrick,
  skill = "ssaac_dzzjin_koac_skill;",
}


local liuq_seec_soor_caamq_toav = fk.CreateCard{
  name = "liuq_seec_soor_caamq_toav",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 3,
  equip_skill = "#liuq_seec_soor_caamq_toav",
}



local soeojs_doac_ceej = fk.CreateCard{
  name = "soeojs_doac_ceej",
  type = Card.TypeBasic,
  skill = "soeojs_doac_ceej_skill",
}

local kiuc = fk.CreateCard{
  name = "kiuc",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 5,
  skill = "kiuc_skill",
}

local tshje_qiuc_hsooh_caenh_pjen= fk.CreateCard{
  name = "tshje_qiuc_hsooh_caenh_pjen",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 5,
  skill = "tshje_qiuc_hsooh_caenh_pjen_skill",
}



local thooms_theec = fk.CreateCard{
  name = "thooms_theec",
  type = Card.TypeBasic,
  skill = "thooms_theec_skill",
}

local thoeop_syet_hqoo_tszyi= fk.CreateCard{  --踏䨮烏騅
  name = "thoeop_syet_hqoo_tszyi",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#thoeop_syet_hqoo_tszyi_skill",
}

local  tszjevs_jjas_ciok_ssxi_tsih= fk.CreateCard{  --照夜玉獅子
  name = "tszjevs_jjas_ciok_ssxi_tsih",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#tszjevs_jjas_ciok_ssxi_tsih_skill",
}

local hzaac_tshjes = fk.CreateCard{
  name = "hzaac_tshjes",
  type = Card.TypeTrick,

  is_damage_card = true,
  skill = "hzaac_tshjes_skill",
--   is_passive = false,
}


local pik_dzziag_liac_ssaen = fk.CreateCard{
  name = "pik_dzziag_liac_ssaen",
  type = Card.TypeTrick,
  is_damage_card = false,
  skill = "pik_dzziag_liac_ssaen_skill",
}




local tsjek_tshoavh_doon_liac = fk.CreateCard{
  name = "tsjek_tshoavh_doon_liac",
  type = Card.TypeTrick,
  sub_type = Card.SubtypeDelayedTrick,
  skill = "tsjek_tshoavh_doon_liac_skill",
}





local tsiac_keejs_dzius_keejs = fk.CreateCard{
  name = "tsiac_keejs_dzius_keejs",
  type = Card.TypeTrick,
--   sub_type = Card.SubtypeDelayedTrick,
  skill = "tsiac_keejs_dzius_keejs_skill",
}


extension:loadCardSkels {
    hsoeojh_seevs,
    ssaac_dzzjin_koac,

    liuq_seec_soor_caamq_toav,
    soeojs_doac_ceej,
    tszjevs_jjas_ciok_ssxi_tsih,
    thoeop_syet_hqoo_tszyi,
    kiuc,
    tshje_qiuc_hsooh_caenh_pjen,

    szyih_kouc,

    thooms_theec,
    hzaac_tshjes,
    pik_dzziag_liac_ssaen,
    tsjek_tshoavh_doon_liac,
    tsiac_keejs_dzius_keejs,
}


extension:addCardSpec("ssaet",Card.Spade, 4)
-- extension:addCardSpec("ssaet",Card.Spade,6) --v2酒
extension:addCardSpec("ssaet",Card.Spade, 7)
-- extension:addCardSpec("ssaet",Card.Spade, 8)  --水攻
extension:addCardSpec("ssaet",Card.Diamond, 4)
-- extension:addCardSpec("ssaet",Card.Diamond, 5)  --v2 meej
extension:addCardSpec("ssaet",Card.Club, 4)
extension:addCardSpec("ssaet",Card.Club, 5)
extension:addCardSpec("ssaet",Card.Diamond, 8) --v1  ssaac_dzzjin_koac
extension:addCardSpec("ssaet", Card.Club, 3)  --v1 meej

extension:addCardSpec("thunder__ssaet", Card.Spade, 9)
extension:addCardSpec("thunder__ssaet", Card.Spade, 10)
extension:addCardSpec("thunder__ssaet", Card.Spade, 11)
-- extension:addCardSpec("thunder__ssaet", Card.Club, 6)  --v2 analeptic
extension:addCardSpec("thunder__ssaet", Card.Club, 9)

extension:addCardSpec("fire__ssaet", Card.Diamond, 3) --v2酒
extension:addCardSpec("fire__ssaet", Card.Diamond, 10)
extension:addCardSpec("fire__ssaet", Card.Heart, 2)

-- extension:addCardSpec("szjemh",Card.Diamond, 6) --analeptic
extension:addCardSpec("szjemh",Card.Diamond, 7)
-- extension:addCardSpec("szjemh",Card.Heart, 5)  --tsjek
extension:addCardSpec("szjemh",Card.Heart, 6)
extension:addCardSpec("szjemh",Card.Heart, 7)
extension:addCardSpec("szjemh",Card.Heart, 8)
extension:addCardSpec("szjemh",Card.Heart, 11)
extension:addCardSpec("szjemh", Card.Diamond, 9)  --analeptic

extension:addCardSpec("nziuk",Card.Diamond, 2)
extension:addCardSpec("nziuk",Card.Heart, 10)
extension:addCardSpec("nziuk", Card.Heart, 9)  --v1酒

-- extension:addCardSpec("analeptic", Card.Club, 9) --
-- extension:addCardSpec("analeptic", Card.Diamond, 9)  --
-- extension:addCardSpec("analeptic", Card.Heart, 9)
extension:addCardSpec("analeptic", Card.Spade, 6)  --v1 ssaet
extension:addCardSpec("analeptic", Card.Club, 6)  --v1 ssaet
extension:addCardSpec("analeptic", Card.Diamond, 6)  --

-- extension:addCardSpec("meej", Card.Club, 3)  --元酒Club, 3
extension:addCardSpec("meej", Card.Spade, 5)
extension:addCardSpec("meej", Card.Diamond, 5)  --v1 ssaet

-- extension:addCardSpec("buoh_teejh_tthiu_sjin", Card.Diamond, 1)  --止1  水攻 --Ex補


extension:addCardSpec("szyih_kouc",Card.Spade, 1) --v1 ssaet
extension:addCardSpec("szyih_kouc", Card.Spade, 2)  --v1 thunder__ssaet


extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Diamond, 13)  --將計就計 无懈
extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Heart, 13)

extension:addCardSpec("tsjek_tshoavh_doon_liac", Card.Heart, 4)
-- extension:addCardSpec("tsjek_tshoavh_doon_liac", Card.Spade, 1)
-- extension:addCardSpec("tsjek_tshoavh_doon_liac",Card.Club, 11) --Ex 
extension:addCardSpec("tsjek_tshoavh_doon_liac", Card.Heart, 5)

-- extension:addCardSpec("ssaac_dzzjin_koac",Card.Diamond, 8) --v1生辰綱 v2水攻

extension:addCardSpec("hzaac_tshjes",Card.Spade,1)
extension:addCardSpec("hzaac_tshjes",Card.Diamond,12)
-- extension:addCardSpec("hzaac_tshjes",Card.Spade, 2)  --v1生死之戰
extension:addCardSpec("hzaac_tshjes",Card.Diamond, 1)

extension:addCardSpec("thooms_theec", Card.Spade, 12)
extension:addCardSpec("thooms_theec", Card.Club, 11)

extension:addCardSpec("pik_dzziag_liac_ssaen",Card.Heart, 1)
extension:addCardSpec("pik_dzziag_liac_ssaen",Card.Spade, 13)

extension:addCardSpec("iron_chain", Card.Club, 12)  --鐵索連環 緟作
extension:addCardSpec("iron_chain", Card.Club, 13)

extension:addCardSpec("tshje_qiuc_hsooh_caenh_pjen", Card.Club, 7)  --雌雄虎眼鞭

extension:addCardSpec("kiuc", Card.Diamond, 11)  --天地日月弓

extension:addCardSpec("liuq_seec_soor_caamq_toav", Card.Spade, 3)  --刀

-- extension:addCardSpec("vine", Card.Club, 2)  --元藤甲 改爲仁王盾?

extension:addCardSpec("soeojs_doac_ceej", Card.Club, 10)  --賽唐猊

extension:addCardSpec("thoeop_syet_hqoo_tszyi", Card.Club, 8)  --踏䨮烏騅

extension:addCardSpec("tszjevs_jjas_ciok_ssxi_tsih", Card.Heart, 12)
--

-- extension:addCardSpec("hsoeojh_seevs", Card.Spade, 2)  --改爲寒仌劍? 行刺?

Fk:loadTranslationTable{

  ["card_theen"] = "水滸牌-天罡",

  ["meej"] = "迷",
  [":meej"] = "基本牌<br /><b>时机</b>：主動<br /><b>目标</b>：一名其他角色<br /><b>效果</b>：目幖角色附加昏迷,不能使用打出牌。",

  ["hzaac_tshjes"] = "行刺",
  [":hzaac_tshjes"] = "锦囊牌<br /><b>旹機</b>：出牌阶段<br /><b>目标</b>：一名其他角色<br /><b>效果</b>：目幖角色需打出2閃,否則伱予其1傷。",
  ["#hzaac_tshjes_skill"] = "选择一其他角色，其需打出2閃,否則伱予其1傷",
  ["hzaac_tshjes_skill"] = "行刺",

  ["pik_dzziag_liac_ssaen"] = "逼上梁山",
  [":pik_dzziag_liac_ssaen"] = "锦囊牌<br /><b>旹機</b>：出牌阶段<br /><b>目标</b>：一名其他角色<br /><b>效果</b>：目幖角色流失1體力,弃2牌,抽3。",
  ["#pik_dzziag_liac_ssaen_skill"] = "选择一其他角色，其流失1體力,弃2牌,抽3",
  ["pik_dzziag_liac_ssaen_skill"] = "逼上梁山",
  ["pik_dzziag_liac_ssaen_ask"] = "逼上梁山 弃2",

  ["szyih_kouc"] = "水攻",
  [":szyih_kouc"] = "锦囊牌<br /><b>时机</b>：其他角色對伱使用殺後<br /><b>目标</b>：一名其他角色<br /><b>效果</b>：目幖角色需弃全部裝僃,否則伱予其1傷。",

 
  ["ssaac_dzzjin_koac"] = "生辰綱",
  [":ssaac_dzzjin_koac"] = "锦囊牌<br /><b>旹機</b>：主動<br /><b>目标</b>：自己<br /><b>使用</b>置于其伏區<br /><b>生效</b>：目幖A判定阶段判定生效,A判定,若結果爲紅色AJQK,A抽5",


  ["tsjek_tshoavh_doon_liac"] = "積艸屯糧",
  [":tsjek_tshoavh_doon_liac"] = "延时锦囊牌<br/><b>旹機</b>：出牌阶段<br/><b>目标</b>：任一角色A<br/><b>效果</b>：将【积艸屯粮】横置于A伏區。A判定阶段，判定：若判定牌非虛,A獲得判定牌.除非若判定牌存在且爲♦️，否则跳过A的弃牌阶段。",
  ["#tsjek_tshoavh_doon_liac"] = "積艸屯糧 将此牌置于其判定区内。其判定阶段生效判定：<br/>若结果不为♦️，其跳过弃牌阶段",

  ["soeojs_doac_ceej"] = "賽唐猊",
  [":soeojs_doac_ceej"] = "裝僃牌防具<br/><b>防具技能</b>：屬性對伱生效歬,防止之.伱受傷後,若來源不爲伱且牌爲殺,來源弃其武器",


}


return extension

