local extension = Package:new("card_theen", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/cards/card_theen/skills")


--葢伏
local ambush__ssaet = fk.CreateCard{
  name = "ambush__ssaet",
  type = Card.TypeBasic,
  skill = "ssaet_skill",
  -- special_skills = { "koarbiuk_cardskill" },
  sub_type=Card.SubtypeDelayedTrick,
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
  ["ambush__ssaet"] = "伏殺",
  [":ambush__ssaet"] = "行動  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1  <br /><b>距離</b>：伱攻程内  <br /><b>次數</b>：同名牌每段限1次  <br /><b>效果</b>：對目幖脚色造成1点傷害。  <br /><b>額外</b>：伏段執行旹,伱可起動葢伏之｢殺｣",
  -- ["ambush__ssaet"] = "伏殺",
  
  ["ambush__szjemh"] = "伏閃",
  [":ambush__szjemh"] = "行動  <br /><b>旹機</b>:｢殺｣A對目幖生效前  <br /><b>目幖</b>:A  <br /><b>目幖數</b>：0  <br /><b>效果</b>：抵消A對目幖效果。  <br /><b>額外</b>：因動-抵消｡葢伏可用｡每旹機限1次｡全體脚色同旹選擇是否起動其葢伏之｢閃｣",

  ["ambush__buac_hzfan_mujs_nzjen"] = "伏_防患未肰",
  [":ambush__buac_hzfan_mujs_nzjen"] = "锦囊牌    <br /><b>旹機</b>：锦囊牌A生效前    <br /><b>目幖</b>：A    <br /><b>目幖數</b>：0  <br /><b>效果</b>：抵消A效果      <br /><b>額外</b>：因動-抵消｡葢伏可用｡每旹機限1次,全體脚色同旹選擇是否起動其葢伏之｢防患未肰｣",

}
--
local thoeoms_tsshaet = fk.CreateCard{
  name = "thoeoms_tsshaet",
  type = Card.TypeBasic,
  skill = "thoeoms_tsshaet_skill",
  special_skills = { "recast" },
}
extension:loadCardSkels {
thoeoms_tsshaet,
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


local mae_biuk = fk.CreateCard{
  name = "mae_biuk",
  type = Card.TypeBasic,
  skill = "mae_biuk_skill",
  is_damage_card=true,
  damage_type = fk.NormalDamage,
  -- is_passive = true, --0距離?
  special_skills = { "koarbiuk_cardskill" },
}
extension:loadCardSkels {
mae_biuk,
}

local thou_liac_hzvoans_dduoh = fk.CreateCard{
  name = "thou_liac_hzvoans_dduoh",
  type = Card.TypeBasic,
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
  damage_type = fk.NormalDamage,
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
  damage_type = fk.NormalDamage,
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
  skill = "self_equip_skill",
}
extension:loadCardSkels {
soeojs_doac_ceej,
}

local jjas_hzaac_hqij = fk.CreateCard{
  name = "jjas_hzaac_hqij",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#jjas_hzaac_hqij_skill",
  skill = "self_equip_skill",
}
extension:loadCardSkels {
jjas_hzaac_hqij,
}

local kiuc = fk.CreateCard{
  name = "kiuc",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 9,
  equip_skill = "#kiuc_skill",
  skill = "self_equip_skill",
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
  skill = "self_equip_skill",
}
extension:loadCardSkels {pjen,}



local thoeop_syet_hqoo_tszyi = fk.CreateCard{
  name = "thoeop_syet_hqoo_tszyi",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeOffensiveRide,
  equip_skill = "#thoeop_syet_hqoo_tszyi_skill",
  skill = "self_equip_skill",
}

local tszjevs_jjas_ciok_ssxi_tsih = fk.CreateCard{
  name = "tszjevs_jjas_ciok_ssxi_tsih",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#tszjevs_jjas_ciok_ssxi_tsih_skill",
  skill = "self_equip_skill",
}



extension:loadCardSkels {
    soeojs_doac_ceej,
    tszjevs_jjas_ciok_ssxi_tsih,
    thoeop_syet_hqoo_tszyi,
    -- kiuc,
    pjen,

    szyih_kouc,

    thoeoms_tsshaet,

    tsjek_tshoavh_doon_liac,

}

extension:addCardSpec("ssaet", Card.Spade, 2)
extension:addCardSpec("ssaet",Card.Spade, 4)
extension:addCardSpec("ssaet",Card.Spade, 7)
extension:addCardSpec("ssaet",Card.Club, 3)
extension:addCardSpec("ssaet", Card.Club, 11)
extension:addCardSpec("ssaet", Card.Diamond, 3)

extension:addCardSpec("thunder__ssaet", Card.Spade, 12)  --v1 thoeoms_tsshaet
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

extension:addCardSpec("mae_biuk",Card.Spade, 1)
extension:addCardSpec("mae_biuk",Card.Club, 1)
extension:addCardSpec("mae_biuk",Card.Diamond, 1)
-- extension:addCardSpec("mae_biuk",Card.Spade, 2)  --v1生死之戰

extension:addCardSpec("pik_dzziach_liac_ssaen",Card.Heart, 1)  --v1 theen
extension:addCardSpec("pik_dzziach_liac_ssaen",Card.Spade, 13)

extension:addCardSpec("thoeoms_tsshaet", Card.Spade, 10)
extension:addCardSpec("thoeoms_tsshaet", Card.Diamond, 5)  --v1 ssaet

extension:addCardSpec("thou_liac_hzvoans_dduoh", Card.Spade, 5)
extension:addCardSpec("thou_liac_hzvoans_dduoh", Card.Club, 12)  --鐵索連環 緟作 -- 探察 偷樑換柱

-- extension:addCardSpec("ssaac_dzzjin_koac",Card.Diamond, 8) --v1生辰綱

extension:addCardSpec("tsjek_tshoavh_doon_liac", Card.Heart, 4)
extension:addCardSpec("tsjek_tshoavh_doon_liac", Card.Heart, 5)


extension:addCardSpec("djis_douch", Card.Spade, 9)


extension:addCardSpec("pjen", Card.Club, 7)  --雌雄虎眼鞭
extension:addCardSpec("kiuc", Card.Diamond, 10)  --天地日月弓
extension:addCardSpec("ddiach", Card.Diamond, 12)  --水磨禪杖 Diamond, 12nziuk

extension:addCardSpec("jjas_hzaac_hqij", Card.Club, 2)  --v1藤甲, v1地 Club, 2 meej
extension:addCardSpec("soeojs_doac_ceej", Card.Club, 10)  --賽唐猊

extension:addCardSpec("thoeop_syet_hqoo_tszyi", Card.Club, 8)  --踏䨮烏騅
-- extension:addCardSpec("tszjevs_jjas_ciok_ssxi_tsih", Card.Heart, 12) --Card.Diamond, 11

Fk:loadTranslationTable{

  ["card_theen"] = "水滸牌-地煞",


  ["ddxims__tsiuh"] = "鴆酒",
  [":ddxims__tsiuh"] = "物資  <br /><b>旹機</b>主段執行旹  <br /><b>目幖</b>无限制  <br /><b>目幖</b>：伱  <br /><b>效果</b>：目幖體力上限減至體力數,正常酒",

  ["thoeoms_tsshaet"] = "探察",
  [":thoeoms_tsshaet"] = "锦囊牌  <br /><b>旹機</b>:主段執行旹  <br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1  <br /><b>效果</b>：伱觀看其區域全部牌,可展示其中1,若爲葢伏牌,伱弃置之｡目幖腳色區域內牌1轉內對伱可見｡",
  ["#thoeoms_tsshaet"] = "选择1其它脚色，觀看其區域全部牌",

  ["mae_biuk"] = "埋伏",
  [":mae_biuk"] = "锦囊牌  <br /><b>旹機</b>:伏段執行旹  <br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1  <br /><b>距離</b>：伱至其距離1  <br /><b>效果</b>：目幖脚色可演練2閃,不足則伱予其1傷。<br /><b>額外</b>：葢伏可用,否則不可用",
  ["#mae_biuk_skill"] = "选择1其它脚色，其需演練2閃,否則伱予其1傷",
  ["#mae_biuk_response"] = "%src 對伱起動 埋伏, 伱可演練閃  (當前第%arg, 總需 %arg2)",
  ["mae_biuk_skill"] = "埋伏",

  ["theem_prac_kaemh_tsoavs"] = "添兵減竈",  --添兵減竈theem_prac_kaemh_tsoavs 以退爲進 欲擒固縱 
  [":theem_prac_kaemh_tsoavs"] = "锦囊牌  <br /><b>旹機</b>:殺對伱生效歬  <br /><b>目幖</b>：无  <br /><b>目幖數</b>：0  <br /><b>效果</b>：抵消此殺對伱效果,殺起動者可對伱起動殺,若其未起動殺致傷,伱予其1傷。<br /><b>額外</b>：可且止可起動葢伏之｢添兵減竈｣",
  ["#theem_prac_kaemh_tsoavs_skill"] = "抵消此殺 殺起動者需對伱起動殺,否則伱予其1傷",
  ["#theem_prac_kaemh_tsoavs_ssaet"] = "添兵減竈 對 %src 起動殺,否則其予伱1傷",
  ["theem_prac_kaemh_tsoavs_skill"] = "添兵減竈",  --添兵減竈theem_prac_kaemh_tsoavs 以退爲進 欲擒固縱 

  ["pik_dzziach_liac_ssaen"] = "逼上梁山",
  [":pik_dzziach_liac_ssaen"] = "锦囊牌  <br /><b>旹機</b>:主段執行旹  <br /><b>目幖</b>：其它脚色,伱与其(手牌-體力)不同號  <br /><b>目幖數</b>：1   <br /><b>效果</b>：目幖脚色流失1,弃2牌,抽3。",
  ["#pik_dzziach_liac_ssaen_skill"] = "选择1其它脚色，其流失1,弃2牌,抽3",
  ["#pik_dzziach_liac_ssaen_ask"] = "逼上梁山 弃2",
  ["pik_dzziach_liac_ssaen_skill"] = "逼上梁山",

  ["tsiac_keejs_dzius_keejs"] = "將計就計",
  [":tsiac_keejs_dzius_keejs"] = "锦囊牌  <br /><b>旹機</b>計謀牌A生效歬,A目幖數不大于1  <br /><b>目幖</b>A  <br /><b>目幖數</b>：0   <br /><b>效果</b>:抵消A,伱于A結算後取得之  <br /><b>額外</b>：因動-抵消｡葢伏可用,否則不可用｡每旹機限1次,全體脚色同旹選擇是否起動其葢伏之｢將計就計｣",
  ["tsiac_keejs_dzius_keejs_skill"] = "將計就計",


  ["szyih_kouc"] = "水攻",
  [":szyih_kouc"] = "锦囊牌  <br /><b>旹機</b>：伏段執行旹  <br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1  <br /><b>效果</b>：目幖脚色需弃全部裝僃,否則伱予其1傷。  <br /><b>額外</b>：葢伏可用,否則不可用",
  ["szyih_kouc_skill"] = "水攻",

  ["thou_liac_hzvoans_dduoh"] = "偸樑換柱",
  [":thou_liac_hzvoans_dduoh"] = "锦囊牌  <br /><b>旹機</b>:伏段執行旹  <br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1  <br /><b>效果</b>：伱印取1空,觀看目幖脚色手牌,伱可用1手牌交換其1手牌  <br /><b>額外</b>：葢伏可用,否則不可用",
  ["#thou_liac_hzvoans_dduoh_skill"] = "偸樑換柱 觀看目幖脚色手牌,伱可用1手牌交換其1手牌",
  ["thou_liac_hzvoans_dduoh_skill"] = "偸樑換柱",


  ["tsjek_tshoavh_doon_liac"] = "積艸屯糧",
  [":tsjek_tshoavh_doon_liac"] = "锦囊牌  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>：无限制  <br /><b>目幖數</b>：1  <br /><b>延旹</b>：將此牌置于目幖脚色伏區,目幖伏段執行旹生效<br/><b>效果</b>：目幖占卜：若占卜牌非虛,A取得占卜牌.除非若占卜牌存在且爲♦️，否則跳过A的弃牌阶段。",
  ["#tsjek_tshoavh_doon_liac"] = "積艸屯糧 将此牌置于其占卜区内。其占卜阶段生效占卜：<br/>若结果不为<font color='red'>♦</font>，其跳过弃牌阶段",
  ["tsjek_tshoavh_doon_liac_skill"] = "積艸屯糧" ,
  [":tsjek_tshoavh_doon_liac_skill"] = "積艸屯糧 延旹 越過撤段" ,
  ["#tsjek_tshoavh_doon_liac_skill"] = "積艸屯糧 延旹 越過撤段" ,

  ["djis_douch"] = "地動",
  [":djis_douch"] = "法術-天災<br/><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：无限制  <br /><b>目幖數</b>：1  <br /><b>預起動</b>：伱  <br /><b>延旹</b>：將此牌置于目幖脚色伏區,目幖伏段執行旹生效<br/><b>效果</b>：目幖占卜,若:花色爲♥️,其弃置全部裝僃,受x傷(x爲所弃裝僃數);否則將此牌至入下家伏區  <br /><b>額外</b>：此牌被抵消後至入目幖下家伏區",
  ["#djis_douch"] = "地動",
  ["#djis_douch_skill"] = "起動地動 置入伱伏區",
  ["djis_douch_skill"] = "地動",


  ["soeojs_doac_ceej"] = "賽唐猊",
  [":soeojs_doac_ceej"] = "裝僃牌防具<br/><b>防具技能</b>：{屬性/虛/轉化}殺對伱生效歬,防止之.伱受傷後,若來源不爲伱且牌爲殺,來源弃其武器",
  ["#soeojs_doac_ceej_skill"] = "賽唐猊",
  ["soeojs_doac_ceej_skill"] = "賽唐猊",

  ["jjas_hzaac_hqij"] = "夜行衣",
  [":jjas_hzaac_hqij"] = "裝僃牌防具<br/><b>防具技能</b>：若殺无點或點數大于伱體力數,伱不是其合理目幖",
  ["#jjas_hzaac_hqij_skill"] = "夜行衣",
  ["jjas_hzaac_hqij_skill"] = "夜行衣",

  ["pjen"] = "鞭",
  [":pjen"] = "裝僃牌武器<br/><b>攻程</b>：2<br/><b>武器技能</b>：伱起動殺指定目幖A後,可演練1同花手牌發動,此殺對A傷害基數+1",
  ["#pjen-discard"] = "鞭 伱對 %dest 起動 %arg, 可演練同花牌令傷害基數對其+1",
  ["pjen_skill"] = "鞭",

  ["kiuc"] = "弓",
  [":kiuc"] = "裝僃牌武器<br/><b>攻程</b>：9<br/><b>武器技能</b>：伱起動无屬殺旹,可額外指定1目幖A,需伱至A距離等于伱至目幖1距離",
  ["kiuc_skill"] = "弓",

  ["tszjevs_jjas_ciok_ssxi_tsih"] = "照夜玉獅子",
  [":tszjevs_jjas_ciok_ssxi_tsih"] = "+1",

  ["thoeop_syet_hqoo_tszyi"] = "踏䨮烏騅",
  [":thoeop_syet_hqoo_tszyi"] = "-1",
}


return extension

