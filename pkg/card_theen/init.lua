local extension = Package:new("card_theen", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/card_theen/skills")



local thooms_theec = fk.CreateCard{
  name = "thooms_theec",
  type = Card.TypeBasic,
  skill = "thooms_theec_skill",
  special_skills = { "recast" },
}
extension:loadCardSkels {
thooms_theec,
}

local pik_dzziach_liac_ssaen = fk.CreateCard{
  name = "pik_dzziach_liac_ssaen",
  type = Card.TypeBasic,
  is_damage_card = false,
  skill = "pik_dzziach_liac_ssaen_skill",
}
extension:loadCardSkels {
pik_dzziach_liac_ssaen,
}


local hzaac_tshjes = fk.CreateCard{
  name = "hzaac_tshjes",
  type = Card.TypeBasic,
  skill = "hzaac_tshjes_skill",
  is_damage_card=true,
  -- is_passive = true, --0距離?
  special_skills = { "koarbiuk_cardskill" },
}
extension:loadCardSkels {
hzaac_tshjes,
}

local thou_liac_hzvoans_dduoh = fk.CreateCard{
  name = "thou_liac_hzvoans_dduoh",
  type = Card.TypeBasic,
  is_damage_card = false,
  -- is_passive = true,
  special_skills = { "koarbiuk_cardskill" },
  skill = "thou_liac_hzvoans_dduoh_skill",

}
extension:loadCardSkels {
thou_liac_hzvoans_dduoh,
}
--
local szyih_kouc = fk.CreateCard{
  name = "szyih_kouc",
  type = Card.TypeBasic,
  is_damage_card = true,
  skill = "szyih_kouc_skill",
  special_skills = { "koarbiuk_cardskill" },  --鬼 skill
  -- is_passive = true,
}

extension:loadCardSkels {
szyih_kouc,
}

local theem_prac_kaemh_tsoavs = fk.CreateCard{
  name = "theem_prac_kaemh_tsoavs",
  type = Card.TypeBasic,
  skill = "theem_prac_kaemh_tsoavs_skill",
  is_passive = true, 
  special_skills = { "koarbiuk_cardskill" },
}
extension:loadCardSkels {
theem_prac_kaemh_tsoavs,
}


local tsiac_keejs_dzius_keejs = fk.CreateCard{
  name = "tsiac_keejs_dzius_keejs",
  type = Card.TypeBasic,
--   sub_type = Card.SubtypeDelayedTrick,
  skill = "tsiac_keejs_dzius_keejs_skill",
  is_passive=true,
  special_skills = { "koarbiuk_cardskill" },
}
extension:loadCardSkels {
tsiac_keejs_dzius_keejs,
}

local tsjek_tshoavh_doon_liac = fk.CreateCard{
  name = "tsjek_tshoavh_doon_liac",
  type = Card.TypeTrick,
  sub_type = Card.SubtypeDelayedTrick,
  skill = "tsjek_tshoavh_doon_liac_skill",
}
extension:loadCardSkels {
tsjek_tshoavh_doon_liac,
}

local djis_douch = fk.CreateCard{
  name = "djis_douch",
  type = Card.TypeTrick,
  sub_type=Card.SubtypeDelayedTrick,
  stackable_delayed = true,
  skill = "djis_douch_skill",
  is_damage_card = true,
}
extension:loadCardSkels {
djis_douch,
}

--

local soeojs_doac_ceej = fk.CreateCard{
  name = "soeojs_doac_ceej",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#soeojs_doac_ceej_skill",
}
extension:loadCardSkels {
soeojs_doac_ceej,
}

local jjas_hzaac_hqij = fk.CreateCard{
  name = "jjas_hzaac_hqij",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#jjas_hzaac_hqij_skill",
}
extension:loadCardSkels {
jjas_hzaac_hqij,
}

local kiuc = fk.CreateCard{
  name = "kiuc",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 5,
  equip_skill = "#kiuc_skill",
}
extension:loadCardSkels {
kiuc,
}

local pjen= fk.CreateCard{
  name = "pjen",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 2,
  equip_skill = "#pjen_skill",
}
extension:loadCardSkels {
pjen,
}



local thoop_syet_hqoo_tszyi = fk.CreateCard{
  name = "thoop_syet_hqoo_tszyi",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeOffensiveRide,
  equip_skill = "#thoop_syet_hqoo_tszyi_skill",
}

local tszjevs_jjas_ciok_ssxi_tsih = fk.CreateCard{
  name = "tszjevs_jjas_ciok_ssxi_tsih",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#tszjevs_jjas_ciok_ssxi_tsih_skill",
}



extension:loadCardSkels {
    soeojs_doac_ceej,
    tszjevs_jjas_ciok_ssxi_tsih,
    thoop_syet_hqoo_tszyi,
    -- kiuc,
    pjen,

    szyih_kouc,

    thooms_theec,

    tsjek_tshoavh_doon_liac,

}

extension:addCardSpec("ssaet", Card.Spade, 2)
extension:addCardSpec("ssaet",Card.Spade, 4)
extension:addCardSpec("ssaet",Card.Spade, 7)
extension:addCardSpec("ssaet",Card.Club, 3)
extension:addCardSpec("ssaet", Card.Club, 11)
extension:addCardSpec("ssaet", Card.Diamond, 3)

extension:addCardSpec("thunder__ssaet", Card.Spade, 12)  --v1 thooms_theec
extension:addCardSpec("thunder__ssaet",Card.Club, 4)
extension:addCardSpec("thunder__ssaet",Card.Club, 5)

extension:addCardSpec("fire__ssaet",Card.Diamond, 4)
extension:addCardSpec("fire__ssaet",Card.Heart, 8)

extension:addCardSpec("ambush__ssaet", Card.Spade, 11)
extension:addCardSpec("ambush__ssaet", Card.Club, 9)


extension:addCardSpec("szjemh", Card.Heart, 2)
extension:addCardSpec("szjemh", Card.Heart, 6)
extension:addCardSpec("szjemh", Card.Heart, 7)
extension:addCardSpec("szjemh", Card.Diamond, 2)
extension:addCardSpec("szjemh", Card.Diamond, 6)  --analeptic
extension:addCardSpec("ambush__szjemh", Card.Diamond, 7)
extension:addCardSpec("ambush__szjemh", Card.Diamond, 8)
extension:addCardSpec("ambush__szjemh", Card.Diamond, 9)  --analeptic 
extension:addCardSpec("ambush__szjemh", Card.Diamond, 11)

extension:addCardSpec("nziuk", Card.Heart, 3)  --v2
extension:addCardSpec("nziuk", Card.Heart, 9)  --v1酒
extension:addCardSpec("nziuk", Card.Heart, 10)
extension:addCardSpec("nziuk", Card.Heart, 11)


extension:addCardSpec("tsiuh", Card.Spade, 6)  --v1 ssaet
extension:addCardSpec("tsiuh", Card.Club, 6)  --v1 ssaet


-- extension:addCardSpec("theem_prac_kaemh_tsoavs", Card.Diamond, 10)
-- extension:addCardSpec("theem_prac_kaemh_tsoavs", Card.Heart, 2)

-- extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Diamond, 13)  --將計就計 无懈
-- -- extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Heart, 13)
-- extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Club, 13)

extension:addCardSpec("ambush__buac_hzfan_mujs_nzjen", Card.Diamond, 13)  --將計就計 无懈
extension:addCardSpec("ambush__buac_hzfan_mujs_nzjen", Card.Heart, 12)
extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Heart, 13)
extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Club, 13)

extension:addCardSpec("szyih_kouc",Card.Spade, 3) --v1 ssaet
extension:addCardSpec("szyih_kouc", Card.Spade, 8)  --v1 thunder__ssaet

extension:addCardSpec("hzaac_tshjes",Card.Spade, 1)
extension:addCardSpec("hzaac_tshjes",Card.Club, 1)
extension:addCardSpec("hzaac_tshjes",Card.Diamond, 1)
-- extension:addCardSpec("hzaac_tshjes",Card.Spade, 2)  --v1生死之戰

extension:addCardSpec("pik_dzziach_liac_ssaen",Card.Heart, 1)  --v1 theen
extension:addCardSpec("pik_dzziach_liac_ssaen",Card.Spade, 13)

extension:addCardSpec("thooms_theec", Card.Spade, 10)
extension:addCardSpec("thooms_theec", Card.Diamond, 5)  --v1 ssaet

extension:addCardSpec("thou_liac_hzvoans_dduoh", Card.Spade, 5)
extension:addCardSpec("thou_liac_hzvoans_dduoh", Card.Club, 12)  --鐵索連環 緟作 -- 探聽 偷樑換柱

-- extension:addCardSpec("ssaac_dzzjin_koac",Card.Diamond, 8) --v1生辰綱

extension:addCardSpec("tsjek_tshoavh_doon_liac", Card.Heart, 4)
extension:addCardSpec("tsjek_tshoavh_doon_liac", Card.Heart, 5)


extension:addCardSpec("djis_douch", Card.Spade, 9)


extension:addCardSpec("pjen", Card.Club, 7)  --雌雄虎眼鞭
extension:addCardSpec("kiuc", Card.Diamond, 10)  --天地日月弓
extension:addCardSpec("ddiach", Card.Diamond, 12)  --水磨禪杖 Diamond, 12nziuk

extension:addCardSpec("jjas_hzaac_hqij", Card.Club, 2)  --v1藤甲, v1地 Club, 2 meej
extension:addCardSpec("soeojs_doac_ceej", Card.Club, 10)  --賽唐猊

extension:addCardSpec("thoop_syet_hqoo_tszyi", Card.Club, 8)  --踏䨮烏騅
-- extension:addCardSpec("tszjevs_jjas_ciok_ssxi_tsih", Card.Heart, 12) --Card.Diamond, 11

Fk:loadTranslationTable{

  ["card_theen"] = "水滸牌-地煞",

  ["ambush__ssaet"] = "伏殺",
  [":ambush__ssaet"] = "基本牌-行動  <br /><b>旹機</b>:主旹/伏段旹  <br /><b>目幖</b>：1其它角色  <br /><b>距離</b>：伱攻程内  <br /><b>次數</b>：每段限1次  <br /><b>效果</b>：對目幖角色造成1点傷害。  <br /><b>額外</b>：伏段旹,伱可使用葢伏之｢殺｣",
  -- ["ambush__ssaet"] = "伏殺",
  
  ["ambush__szjemh"] = "伏閃",
  [":ambush__szjemh"] = "基本牌-行動  <br /><b>旹機</b>:｢殺｣A對目幖生效前  <br /><b>目幖</b>:A  <br /><b>效果</b>：抵消A對目幖效果。  <br /><b>額外</b>：因動-抵消｡葢伏可用｡每旹機限1次｡全體角色同旹選擇是否使用其葢伏之｢閃｣",

  ["ddxims__analeptic"] = "鴆酒",
  [":ddxims__analeptic"] = "基本牌-物資  <br /><b>旹機</b>主旹  <br /><b>目幖</b>伱  <br /><b>效果</b>：目幖體力上限減至體力值,酒",

  ["thooms_theec"] = "探察",
  [":thooms_theec"] = "锦囊牌  <br /><b>旹機</b>:主旹  <br /><b>目幖</b>：任1其它角色  <br /><b>效果</b>：伱觀看其區域全部牌,肰後可展示其中1,若爲葢伏牌,伱弃置之",
  ["#thooms_theec"] = "选择1其它角色，觀看其區域全部牌",

  ["hzaac_tshjes"] = "行刺",
  [":hzaac_tshjes"] = "锦囊牌  <br /><b>旹機</b>:伏段旹  <br /><b>目幖</b>：1其它角色  <br /><b>距離</b>：伱至其距離1  <br /><b>效果</b>：目幖角色需打出2閃,否則伱予其1傷。<br /><b>額外</b>：葢伏可用,否則不可用",
  ["#hzaac_tshjes_skill"] = "选择1其它角色，其需打出2閃,否則伱予其1傷",
  ["#hzaac_tshjes_response"] = "%src 對伱使用 行刺, 伱可打出閃  (當前第%arg, 總需 %arg2)",

  ["theem_prac_kaemh_tsoavs"] = "添兵減竈",  --添兵減竈theem_prac_kaemh_tsoavs 以退爲進 欲擒固縱 
  [":theem_prac_kaemh_tsoavs"] = "锦囊牌  <br /><b>旹機</b>:殺對伱生效歬  <br /><b>目幖</b>：无  <br /><b>效果</b>：抵消此殺對伱效果,殺使用者可對伱使用殺,若其未使用殺致傷,伱予其1傷。<br /><b>額外</b>：可且止可使用葢伏之｢添兵減竈｣",
  ["#theem_prac_kaemh_tsoavs_skill"] = "抵消此殺 殺使用者需對伱使用殺,否則伱予其1傷",
  ["#theem_prac_kaemh_tsoavs_ssaet"] = "添兵減竈 對 %src 使用殺,否則其予伱1傷",

  ["pik_dzziach_liac_ssaen"] = "逼上梁山",
  [":pik_dzziach_liac_ssaen"] = "锦囊牌  <br /><b>旹機</b>:主旹  <br /><b>目幖</b>：1其它角色,伱与其(手牌-體力)不同號  <br /><b>效果</b>：目幖角色流失1體力,弃2牌,抽3。",
  ["#pik_dzziach_liac_ssaen_skill"] = "选择1其它角色，其流失1體力,弃2牌,抽3",
  ["#pik_dzziach_liac_ssaen_ask"] = "逼上梁山 弃2",

  ["tsiac_keejs_dzius_keejs"] = "將計就計",
  [":tsiac_keejs_dzius_keejs"] = "锦囊牌  <br /><b>旹機</b>錦囊牌A生效歬,A目幖數不大于1  <br /><b>目幖</b>A  <br /><b>效果</b>:抵消A,伱于A結算後獲得之  <br /><b>額外</b>：因動-抵消｡葢伏可用,否則不可用｡每旹機限1次,全體角色同旹選擇是否使用其葢伏之｢將計就計｣",

  ["ambush__buac_hzfan_mujs_nzjen"] = "防患未肰",
  [":ambush__buac_hzfan_mujs_nzjen"] = "锦囊牌    <br /><b>旹機</b>：锦囊牌A生效前    <br /><b>目幖</b>：A    <br /><b>效果</b>：抵消A效果      <br /><b>額外</b>：因動-抵消｡葢伏可用｡每旹機限1次,全體角色同旹選擇是否使用其葢伏之｢防患未肰｣",

  ["szyih_kouc"] = "水攻",
  [":szyih_kouc"] = "锦囊牌  <br /><b>旹機</b>：伏段旹  <br /><b>目幖</b>：1其它角色  <br /><b>效果</b>：目幖角色需弃全部裝僃,否則伱予其1傷。  <br /><b>額外</b>：葢伏可用,否則不可用",

  ["thou_liac_hzvoans_dduoh"] = "偸樑換柱",
  [":thou_liac_hzvoans_dduoh"] = "锦囊牌  <br /><b>旹機</b>:伏段旹  <br /><b>目幖</b>：1其它角色  <br /><b>效果</b>：伱印取1空,觀看目幖角色手牌,伱可用1手牌交換其1手牌  <br /><b>額外</b>：葢伏可用,否則不可用",
  ["#thou_liac_hzvoans_dduoh_skill"] = "偸樑換柱 觀看目幖角色手牌,伱可用1手牌交換其1手牌",

  ["djis_douch"] = "地動",
  [":djis_douch"] = "法術-天災<br/><b>旹機</b>：主旹  <br /><b>目幖</b>：伱  <br /><b>延旹</b>：將此牌置于目幖角色伏區,目幖伏段生效<br/><b>效果</b>：目幖判定,若:花色爲♥️,其弃置全部裝僃,受x傷(x爲所弃裝僃數);否則將此牌至入下家伏區  <br /><b>額外</b>：此牌被抵消後至入目幖下家伏區",
  ["#hsoo_piuc_hsvoans_quoh_skill"] = "呼風喚雨",

  ["hsoeojh_seevs"] = "海嘯",
  [":hsoeojh_seevs"] = "法術-天災  <br /><b>旹機</b>：主動  <br /><b>目幖</b>：伱  <br /><b>延旹</b>：將此牌置于目幖角色伏區,目幖伏段生效  <br /><b>生效</b>：目幖A判定阶段判定生效,A判定,若結果爲黑色AJQK,A弃全部牌,;否則將此牌至入下家伏區  <br /><b>額外</b>：此牌被抵消後至入目幖下家伏區",

  ["tsjek_tshoavh_doon_liac"] = "積艸屯糧",
  [":tsjek_tshoavh_doon_liac"] = "锦囊牌<br/><b>旹機</b>:主旹<br/><b>旹機</b>：任一角色A  <br /><b>延旹</b>：將此牌置于目幖角色伏區,目幖伏段生效<br/><b>效果</b>：目幖判定：若判定牌非虛,A獲得判定牌.除非若判定牌存在且爲♦️，否則跳过A的弃牌阶段。",
  ["#tsjek_tshoavh_doon_liac"] = "積艸屯糧 将此牌置于其判定区内。其判定阶段生效判定：<br/>若结果不为<font color='red'>♦</font>，其跳过弃牌阶段",

  ["soeojs_doac_ceej"] = "賽唐猊",
  [":soeojs_doac_ceej"] = "裝僃牌防具<br/><b>防具技能</b>：{屬性/虛/轉化}殺對伱生效歬,防止之.伱受傷後,若來源不爲伱且牌爲殺,來源弃其武器",
  ["#soeojs_doac_ceej_skill"] = "賽唐猊",

  ["jjas_hzaac_hqij"] = "夜行衣",
  [":jjas_hzaac_hqij"] = "裝僃牌防具<br/><b>防具技能</b>：若殺无點或點數大于伱體力值,伱不是其合理目幖",
  ["#jjas_hzaac_hqij_skill"] = "夜行衣",

  ["pjen"] = "鞭",
  [":pjen"] = "裝僃牌武器<br/><b>攻程</b>：2<br/><b>武器技能</b>：伱使用殺指定目幖A旹,可打出1同花手牌發動,此殺對A傷害基數+1",
  ["#pjen-discard"] = "鞭 伱對 %dest 使用 %arg, 可打出同花牌令傷害基數+1",

  ["kiuc"] = "弓",
  [":kiuc"] = "裝僃牌武器<br/><b>攻程</b>：5<br/><b>武器技能</b>：伱使用无屬殺旹,可額外指定1目幖A,需伱至A距離等于伱至目幖1距離",

  ["tszjevs_jjas_ciok_ssxi_tsih"] = "照夜玉獅子",
  [":tszjevs_jjas_ciok_ssxi_tsih"] = "+1",

  ["thoop_syet_hqoo_tszyi"] = "踏䨮烏騅",
  [":thoop_syet_hqoo_tszyi"] = "-1",
}


return extension

