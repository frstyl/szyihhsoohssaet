local extension = Package:new("card_ki", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/card_ki/skills")

local ssaet = fk.CreateCard{
  name = "ssaet",
  type = Card.TypeBasic, --int
  is_damage_card = true,  --tag
  skill = "ssaet_skill",
}


local normal__ssaet = fk.CreateCard{
  name = "normal__ssaet",
  type = Card.TypeBasic, --int
  is_damage_card = true,
  skill = "normal__ssaet_skill",
}

local szjemh = fk.CreateCard{
  name = "szjemh",
  type = Card.TypeBasic, --int
  skill = "szjemh_skill",
  is_passive=true,
  is_damage_card = false,
}

local nziuk = fk.CreateCard{
  name = "nziuk",
  type = Card.TypeBasic, --int
  skill = "nziuk_skill",
}

local tsiuh = fk.CreateCard{
  name = "tsiuh",
  type = Card.TypeBasic, --int
  skill = "tsiuh_skill",
  -- special_skills = { "tsiuh_recover" },
}

local buoh_teejh_tthiu_sjin = fk.CreateCard{
  name = "buoh_teejh_tthiu_sjin",
  type = Card.TypeBasic,
  skill = "buoh_teejh_tthiu_sjin_skill",
}

local hqjin_deek_qwe_tsji = fk.CreateCard{
  name = "hqjin_deek_qwe_tsji",
  type = Card.TypeBasic,
  skill = "hqjin_deek_qwe_tsji_skill",
}

local buac_hzfan_mujs_nzjen = fk.CreateCard{
  name = "buac_hzfan_mujs_nzjen",
  type = Card.TypeBasic, --int
  skill = "buac_hzfan_mujs_nzjen_skill",
  is_passive=true,
}


local hsiap_paak = fk.CreateCard{
  name = "hsiap_paak",
  type = Card.TypeBasic, --int
  -- is_damage_card = true, --失去體力
  skill = "hsiap_paak_skill",
}


local tous_tsiacs = fk.CreateCard{
  name = "tous_tsiacs",
  type = Card.TypeBasic,
  skill = "tous_tsiacs_skill",
  is_damage_card = true,
}

local distance__tous_tsiacs = fk.CreateCard{
  name = "&distance__tous_tsiacs",
  type = Card.TypeBasic,
  skill = "distance__tous_tsiacs_skill",
  is_damage_card = true,
}
extension:loadCardSkels {
  distance__tous_tsiacs,
}
Fk:loadTranslationTable{
  ["distance__tous_tsiacs"] = "鬥將",
  [":distance__tous_tsiacs"] = "锦囊牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：攻程内1其它角色  <br /><b>效果</b>：由目幖角色始，其与伱輪流選擇執行1項➀打出1殺➁受到對方1傷,終止",
  ["distance__tous_tsiacs_skill"] = "鬥將",
  ["#distance__tous_tsiacs"] = "选择一名其它角色，由其开始，其与伱轮流打出1｢殺｣，直到其与伱中的一名角色未打出｢殺｣。<br />未打出｢殺｣的角色受到其与伱中的另一名角色造成的1点傷害",
}
local liac_tshoavh_seen_hzaac = fk.CreateCard{
  name = "liac_tshoavh_seen_hzaac",
  type = Card.TypeBasic,
  skill = "liac_tshoavh_seen_hzaac_skill",
}


local maach_hsooh_hzaah_ssaen = fk.CreateCard{
  name = "maach_hsooh_hzaah_ssaen",
  type = Card.TypeBasic,
  skill = "maach_hsooh_hzaah_ssaen_skill",
  is_damage_card = true,
  multiple_targets = true,
}

local kiuc_szjih_sje_ttiac = fk.CreateCard{
  name = "kiuc_szjih_sje_ttiac",
  type = Card.TypeBasic,
  skill = "kiuc_szjih_sje_ttiac_skill",
  is_damage_card = true,
  multiple_targets = true,
}

local ttxis_tsiuh_szjet_jjen = fk.CreateCard{
  name = "ttxis_tsiuh_szjet_jjen",
  type = Card.TypeBasic,
  skill = "ttxis_tsiuh_szjet_jjen_skill",
  multiple_targets = true,
}

local hsiu_jiach_ssaac_sik = fk.CreateCard{
  name = "hsiu_jiach_ssaac_sik",
  type = Card.TypeBasic,
  skill = "hsiu_jiach_ssaac_sik_skill",
  multiple_targets = true,
}

local theen_looj = fk.CreateCard{  --閃電 可緟
  name = "theen_looj",
  type = Card.TypeTrick,
  sub_type = Card.SubtypeDelayedTrick,
  is_damage_card = true,
  skill = "theen_looj_skill",
  stackable_delayed = true,
}

local khxes_kheet_sis_tssaas = fk.CreateCard{
  name = "khxes_kheet_sis_tssaas",
  type = Card.TypeTrick,
  sub_type = Card.SubtypeDelayedTrick,
  skill = "khxes_kheet_sis_tssaas_skill",
  stackable_delayed = true,
}

local kaeh_hqvoans_toav = fk.CreateCard{  --弩 改爲刀
  name = "kaeh_hqvoans_toav",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 1,
  equip_skill = "#kaeh_hqvoans_toav_skill",
}

local cio_ddiac_kiams = fk.CreateCard{
  name = "cio_ddiac_kiams",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 2,
  equip_skill = "#cio_ddiac_kiams_skill",
}

local ssaoc_toav = fk.CreateCard{
  name = "ssaoc_toav",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 2,
  equip_skill = "#ssaoc_toav_skill",
}
local tshjit_seec_kiams = fk.CreateCard{
  name = "tshjit_seec_kiams",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 2,
  equip_skill = "#tshjit_seec_kiams_skill",
}


local hqianh_cuat_toav = fk.CreateCard{  --刀hqianh_cuat_toav
  name = "hqianh_cuat_toav",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 3,
  equip_skill = "#hqianh_cuat_toav_skill",
}
local miu = fk.CreateCard{
  name = "miu",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 3,
  equip_skill = "miu_skill&",
}

local puoh = fk.CreateCard{
  name = "puoh",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 3,
  equip_skill = "#puoh_skill",
}

local ddiach = fk.CreateCard{
  name = "ddiach",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 3,
  equip_skill = "#ddiach_skill",
}

local krak = fk.CreateCard{
  name = "krak",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 4,
  equip_skill = "#krak_skill",
}


local ssaok = fk.CreateCard{
  name = "ssaok",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 4,
  equip_skill = "#ssaok_skill",
}

local soam_ddioc_khoeojh = fk.CreateCard{
  name = "soam_ddioc_khoeojh",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#soam_ddioc_khoeojh_skill",
}
local svoah_tsih_kaap = fk.CreateCard{
  name = "svoah_tsih_kaap",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#svoah_tsih_kaap_skill",
}

local boos_nzjin_kaap = fk.CreateCard{
  name = "boos_nzjin_kaap",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#boos_nzjin_kaap_skill",
}

local gi_ljin_szius = fk.CreateCard{
  name = "gi_ljin_szius",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#gi_ljin_szius_skill",
}

local tsheen_lih_seej_piuc = fk.CreateCard{
  name = "tsheen_lih_seej_piuc",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#tsheen_lih_seej_piuc_skill",
}

local syet_baak_kwenh_moav = fk.CreateCard{
  name = "syet_baak_kwenh_moav",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#syet_baak_kwenh_moav_skill",
}

local tszhjek_thoos = fk.CreateCard{
  name = "tszhjek_thoos",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeOffensiveRide,
  equip_skill = "#tszhjek_thoos_skill",
}

local syet_paavs = fk.CreateCard{
  name = "syet_paavs",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeOffensiveRide,
  equip_skill = "#syet_paavs_skill",
}

local cxin_ssik_gwen_hsfa = fk.CreateCard{
  name = "cxin_ssik_gwen_hsfa",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeOffensiveRide,
  equip_skill = "#cxin_ssik_gwen_hsfa_skill",
}

extension:loadCardSkels {
  ssaet, szjemh, normal__ssaet, nziuk,tsiuh,

  buoh_teejh_tthiu_sjin, hqjin_deek_qwe_tsji, tous_tsiacs, hsiap_paak, liac_tshoavh_seen_hzaac,
  buac_hzfan_mujs_nzjen,
  maach_hsooh_hzaah_ssaen, kiuc_szjih_sje_ttiac, hsiu_jiach_ssaac_sik, ttxis_tsiuh_szjet_jjen,
  theen_looj, khxes_kheet_sis_tssaas,


  kaeh_hqvoans_toav,
  tshjit_seec_kiams, ssaoc_toav,cio_ddiac_kiams,
  hqianh_cuat_toav, puoh,miu, ddiach,
  krak,  ssaok,


  svoah_tsih_kaap, boos_nzjin_kaap,soam_ddioc_khoeojh,

  gi_ljin_szius, tsheen_lih_seej_piuc, syet_baak_kwenh_moav,
  tszhjek_thoos, syet_paavs, cxin_ssik_gwen_hsfa,
}

extension:addCardSpec("ssaet", Card.Spade, 7)
extension:addCardSpec("ssaet", Card.Spade, 8)
extension:addCardSpec("ssaet", Card.Spade, 8)
extension:addCardSpec("ssaet", Card.Spade, 9)
extension:addCardSpec("ssaet", Card.Spade, 9)
extension:addCardSpec("ssaet", Card.Spade, 10)
extension:addCardSpec("ssaet", Card.Spade, 10)
-- extension:addCardSpec("ssaet", Card.Club, 2)  --v1 ssaet
extension:addCardSpec("ssaet", Card.Club, 3)
extension:addCardSpec("ssaet", Card.Club, 4)
extension:addCardSpec("ssaet", Card.Club, 5)
extension:addCardSpec("ssaet", Card.Club, 6)
extension:addCardSpec("ssaet", Card.Club, 7)
extension:addCardSpec("ssaet", Card.Club, 8)
extension:addCardSpec("ssaet", Card.Club, 8)
extension:addCardSpec("ssaet", Card.Club, 9)
extension:addCardSpec("ssaet", Card.Club, 9)
extension:addCardSpec("ssaet", Card.Club, 10)
extension:addCardSpec("ssaet", Card.Club, 10)
extension:addCardSpec("ssaet", Card.Club, 11)
extension:addCardSpec("ssaet", Card.Club, 11)
-- extension:addCardSpec("ssaet", Card.Heart, 9)  --v0无中
extension:addCardSpec("ssaet", Card.Heart, 10)
extension:addCardSpec("ssaet", Card.Heart, 10)
extension:addCardSpec("ssaet", Card.Heart, 11)
extension:addCardSpec("ssaet", Card.Diamond, 6)
extension:addCardSpec("ssaet", Card.Diamond, 7)
extension:addCardSpec("ssaet", Card.Diamond, 8)
extension:addCardSpec("ssaet", Card.Diamond, 9)
extension:addCardSpec("ssaet", Card.Diamond, 10)
extension:addCardSpec("ssaet", Card.Diamond, 13)

extension:addCardSpec("szjemh", Card.Heart, 2)
extension:addCardSpec("szjemh", Card.Heart, 2)
extension:addCardSpec("szjemh", Card.Heart, 13)
extension:addCardSpec("szjemh", Card.Diamond, 2)
extension:addCardSpec("szjemh", Card.Diamond, 2)
extension:addCardSpec("szjemh", Card.Diamond, 3)
extension:addCardSpec("szjemh", Card.Diamond, 4)
extension:addCardSpec("szjemh", Card.Diamond, 5)
-- extension:addCardSpec("szjemh", Card.Diamond, 6) --v2anal
extension:addCardSpec("szjemh", Card.Diamond, 7)
extension:addCardSpec("szjemh", Card.Diamond, 8)
extension:addCardSpec("szjemh", Card.Diamond, 9)
extension:addCardSpec("szjemh", Card.Diamond, 10)
extension:addCardSpec("szjemh", Card.Diamond, 11)
extension:addCardSpec("szjemh", Card.Diamond, 11)

extension:addCardSpec("nziuk", Card.Heart, 3)  --肉
extension:addCardSpec("nziuk", Card.Heart, 4)
extension:addCardSpec("nziuk", Card.Heart, 6)
extension:addCardSpec("nziuk", Card.Heart, 7)
extension:addCardSpec("nziuk", Card.Heart, 8)
extension:addCardSpec("nziuk", Card.Heart, 9)
extension:addCardSpec("nziuk", Card.Heart, 12)
extension:addCardSpec("nziuk", Card.Diamond, 12)

extension:addCardSpec("tsiuh", Card.Spade, 3)  --順手椉機 同 因敌爲資 --v3酒
extension:addCardSpec("tsiuh", Card.Club, 3)  --v3酒
extension:addCardSpec("tsiuh", Card.Heart, 9)  --元无中
extension:addCardSpec("tsiuh", Card.Diamond, 6)  --

extension:addCardSpec("buoh_teejh_tthiu_sjin", Card.Spade, 3)  --釜底抽薪 同
extension:addCardSpec("buoh_teejh_tthiu_sjin", Card.Spade, 4)
extension:addCardSpec("buoh_teejh_tthiu_sjin", Card.Spade, 12)
-- extension:addCardSpec("buoh_teejh_tthiu_sjin", Card.Club, 3)  --v3酒
extension:addCardSpec("buoh_teejh_tthiu_sjin", Card.Club, 4)
extension:addCardSpec("buoh_teejh_tthiu_sjin", Card.Heart, 12)

-- extension:addCardSpec("hqjin_deek_qwe_tsji", Card.Spade, 3)  --順手椉機 同 因敌爲資 --v3酒
extension:addCardSpec("hqjin_deek_qwe_tsji", Card.Spade, 4)
extension:addCardSpec("hqjin_deek_qwe_tsji", Card.Spade, 11)
extension:addCardSpec("hqjin_deek_qwe_tsji", Card.Diamond, 3)
extension:addCardSpec("hqjin_deek_qwe_tsji", Card.Diamond, 4)

-- extension:addCardSpec("hsiap_paak", Card.Club, 12)  --借刀殺人 Ex♣️7
-- extension:addCardSpec("hsiap_paak", Card.Club, 13)
extension:addCardSpec("hsiap_paak", Card.Club, 12)  --脅迫
extension:addCardSpec("hsiap_paak", Card.Club, 13)

extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Spade, 11)  --防微杜漸 防患未肰 識鑑機先
extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Club, 12)
extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Club, 13)
-- extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Diamond, 12)  --轉爲nziuk


extension:addCardSpec("khxes_kheet_sis_tssaas", Card.Spade, 6)  --掎挈伺詐
extension:addCardSpec("khxes_kheet_sis_tssaas", Card.Club, 6)
extension:addCardSpec("khxes_kheet_sis_tssaas", Card.Heart, 6)

extension:addCardSpec("tous_tsiacs", Card.Spade, 1)  --決鬥
extension:addCardSpec("tous_tsiacs", Card.Club, 1)
extension:addCardSpec("tous_tsiacs", Card.Diamond, 1)


extension:addCardSpec("maach_hsooh_hzaah_ssaen", Card.Spade, 7)  --猛虎下山
extension:addCardSpec("maach_hsooh_hzaah_ssaen", Card.Spade, 13)
extension:addCardSpec("maach_hsooh_hzaah_ssaen", Card.Club, 7)

extension:addCardSpec("kiuc_szjih_sje_ttiac", Card.Heart, 1)  --萬箭齊發

extension:addCardSpec("hsiu_jiach_ssaac_sik", Card.Heart, 1)  --修養生息

extension:addCardSpec("ttxis_tsiuh_szjet_jjen", Card.Heart, 3)  --五穀 設筵管待
extension:addCardSpec("ttxis_tsiuh_szjet_jjen", Card.Heart, 4)

extension:addCardSpec("liac_tshoavh_seen_hzaac", Card.Heart, 7)  --糧艸先行
extension:addCardSpec("liac_tshoavh_seen_hzaac", Card.Heart, 8)
-- extension:addCardSpec("liac_tshoavh_seen_hzaac", Card.Heart, 9)  --轉爲殺
extension:addCardSpec("liac_tshoavh_seen_hzaac", Card.Heart, 11)

-- extension:addCardSpec("crossbow", Card.Club, 1)
-- extension:addCardSpec("crossbow", Card.Diamond, 1)  --轉爲殺

extension:addCardSpec("theen_looj", Card.Spade, 1)  --閃電 緟寫
-- extension:addCardSpec("theen_looj", Card.Heart, 12)  --Ex

extension:addCardSpec("kaeh_hqvoans_toav", Card.Diamond, 1)  --弩 
extension:addCardSpec("cio_ddiac_kiams", Card.Spade, 6)  --魚腸劍
extension:addCardSpec("tshjit_seec_kiams", Card.Spade, 2)  --v1 Ex --v1甲馬 --v2 用v0殺  
extension:addCardSpec("ssaoc_toav", Card.Spade, 2)  --雙劍
extension:addCardSpec("hqianh_cuat_toav", Card.Spade, 5)  --青龍偃月刀
extension:addCardSpec("miu", Card.Spade, 12)  --杖八鉈矛
extension:addCardSpec("puoh", Card.Diamond, 5)  --斧

extension:addCardSpec("krak", Card.Diamond, 12)  --補 元无懈可擊
extension:addCardSpec("ssaok", Card.Heart, 5)  --鉤鐮  改爲rang4?

extension:addCardSpec("boos_nzjin_kaap", Card.Club, 2)  --甲馬
-- extension:addCardSpec("boos_nzjin_kaap", Card.Club, 2)  --v0八卦 甲馬
extension:addCardSpec("soam_ddioc_khoeojh", Card.Club, 2)  --元八卦 ⬅️Ex仁王

extension:addCardSpec("svoah_tsih_kaap", Card.Club, 1)  --v0弩

extension:addCardSpec("gi_ljin_szius", Card.Club, 5)
extension:addCardSpec("tsheen_lih_seej_piuc", Card.Spade, 5)
extension:addCardSpec("syet_baak_kwenh_moav", Card.Heart, 13)

extension:addCardSpec("tszhjek_thoos", Card.Heart, 5)  --赤兔
extension:addCardSpec("syet_paavs", Card.Spade, 13)
extension:addCardSpec("cxin_ssik_gwen_hsfa", Card.Diamond, 13)


Fk:loadTranslationTable{
  ["card_ki"] = "水滸牌-基本包",


  ["ssaet"] = "殺",
  [":ssaet"] = "基本牌-行動  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：1其它角色  <br /><b>距離</b>：伱攻程内  <br /><b>次數</b>：每段限1次  <br /><b>效果</b>：對目幖角色造成1点傷害。",
  ["#ssaet-szjemh"] = "%src 對伱使用了｢殺｣，请使用1｢閃｣",
  ["#ssaet-szjemh-multi"] = "%src 對伱使用了｢殺｣，请使用1｢閃｣（此为第 %arg 張，共需 %arg2 張）",
  ["#ssaet_skill"] = "选择攻程内的一名角色，對其造成1点傷害",
  ["#ssaet_skill_multi"] = "选择攻程内的至多%arg名角色，對这些角色各造成1点傷害",

  
  ["szjemh"] = "閃",
  [":szjemh"] = "基本牌-行動  <br /><b>旹機</b>：｢殺｣A對伱生效前  <br /><b>目幖</b>：A  <br /><b>效果</b>：抵消A對伱效果。  <br /><b>額外</b>：因動-抵消｡每旹機限1次｡",
  ["szjemh_skill"] = "閃",

  ["nziuk"] = "肉",
  [":nziuk"] = "基本牌-物資  <br /><b>旹機</b>：主旹/一名角色瀕死結算旹  <br /><b>目幖</b>：已受伤的伱/瀕死結算角色  <br /><b>效果</b>：目幖角色回1。",
  ["#nziuk_skill"] = "目幖回1",

  ["tsiuh"] = "酒",
  [":tsiuh"] = "基本牌-物資<br/><b>旹機</b>：主旹/伱瀕死結算旹<br/><b>目幖</b>：伱  <br /><b>次數</b>：每轉限1次/任意次<br/><b>效果</b>：目幖角色當轉使用的下1｢殺｣傷害基數+1/目幖角色回1。",
  ["#tsiuh_skill"] = "伱于此回合内使用的下1｢殺｣的傷害值基数+1",
  ["@tsyis-turn"] = "醉",

  ["buac_hzfan_mujs_nzjen"] = "防患未肰",
  [":buac_hzfan_mujs_nzjen"] = "锦囊牌  <br /><b>旹機</b>：锦囊牌A對伱生效前  <br /><b>目幖</b>：A  <br /><b>效果</b>：抵消A對伱效果    <br /><b>額外</b>：因動-抵消｡每旹機限1次",
  ["buac_hzfan_mujs_nzjen_skill"] = "防患未肰",

  ["buoh_teejh_tthiu_sjin"] = "釜底抽薪",
  [":buoh_teejh_tthiu_sjin"] = "锦囊牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：1其它角色區域内有牌  <br /><b>效果</b>：伱弃置目幖角色區域内的1牌。",
  ["buoh_teejh_tthiu_sjin_skill"] = "釜底抽薪",
  ["#buoh_teejh_tthiu_sjin_skill"] = "选择一名區域内有牌的其它角色，伱弃置其區域内的1牌",

  ["hqjin_deek_qwe_tsji"] = "因敵爲資",
  [":hqjin_deek_qwe_tsji"] = "锦囊牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：1其它角色區域内有牌  <br /><b>距離</b>：伱至其距離等于1  <br /><b>效果</b>：伱获得目幖角色區域内的1牌。",
  ["hqjin_deek_qwe_tsji_skill"] = "因敵爲資",
  ["#hqjin_deek_qwe_tsji_skill"] = "选择距离1的區域内有牌的角色，伱获得其區域内的1牌",

  ["tous_tsiacs"] = "鬥將",
  [":tous_tsiacs"] = "锦囊牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：1其它角色  <br /><b>距離</b>：伱攻程内  <br /><b>效果</b>：由目幖角色始，其与伱輪流選擇執行1項➀打出1殺➁受到對方1傷,終止",
  ["#tous_tsiacs_skill"] = "选择一名其它角色，由其开始，其与伱轮流打出1｢殺｣，直到其与伱中的一名角色未打出｢殺｣。<br />未打出｢殺｣的角色受到其与伱中的另一名角色造成的1点傷害",

  ["hsiap_paak"] = "脅迫",
  [":hsiap_paak"] = "錦囊牌<br/><b>旹機</b>：主旹<br/><b>目幖</b>：其它角色A与A殺合理目幖B<br/><b>效果</b>：A需選擇➀對B使用殺,➁伱選擇獲取A 1裝僃或令A流失1體力",
  ["hsiap_paak_skill"] = "脅迫",
  ["#hsiap_paak_skill"] = "選擇1其它角色A體力小于伱者,A之殺合理目幖B,對A使用 A需對B使用殺,否則伱選擇其將裝僃區1牌,其交与伱或令其流失1體力",
  -- ["#hsiap_paak-choose"] = "脅迫 選擇1項令 %src 執行",
  ["#hsiap_paak-gainCard"] = "獲得裝僃",
  ["#hsiap_paak-ssaet"] ="%src 對伱使用 脅迫, 伱需對 %src 使用殺",


  ["liac_tshoavh_seen_hzaac"] = "粮艸先行",
  [":liac_tshoavh_seen_hzaac"] = "锦囊牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：伱  <br /><b>效果</b>：目幖角色抽2。",
  ["#liac_tshoavh_seen_hzaac"] = "伱抽2",


  
  ["maach_hsooh_hzaah_ssaen"] = "猛虎下山",
  [":maach_hsooh_hzaah_ssaen"] = "锦囊牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：全部其它角色  <br /><b>效果</b>：目幖角色選擇執行1項➀打出1｢殺｣，➁受到伱1点傷害。",
  ["#maach_hsooh_hzaah_ssaen_skill"] = "全部其它角色選擇執行1項➀打出1｢殺｣，➁受到伱1点傷害",


  ["kiuc_szjih_sje_ttiac"] = "弓矢斯張",
  [":kiuc_szjih_sje_ttiac"] = "锦囊牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：全部其它角色  <br /><b>效果</b>：目幖角色選擇執行1項➀打出1｢閃｣，➁受到伱1点傷害。",
  ["#kiuc_szjih_sje_ttiac_skill"] = "全部其它角色選擇執行1項➀打出1｢閃｣，➁受到伱1点傷害",

  ["hsiu_jiach_ssaac_sik"] = "修養生息",
  [":hsiu_jiach_ssaac_sik"] = "锦囊牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：全部角色  <br /><b>效果</b>：每名目幖角色回1。",
  ["#hsiu_jiach_ssaac_sik_skill"] = "全部角色回1",

  ["ttxis_tsiuh_szjet_jjen"] = "置酒設筵",
  [":ttxis_tsiuh_szjet_jjen"] = "锦囊牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：全部角色  <br /><b>額外</b>：執行前,亮出牌堆頂等于目幖角色数的牌，結算後廢置餘牌。  <br /><b>效果</b>：目幖角色獲得其中1牌，",
  ["ttxis_tsiuh_szjet_jjen_skill"] = "置酒設筵",
  ["Please choose cards"] = "请选择1卡牌",
  ["#ttxis_tsiuh_szjet_jjen_skill"] = "亮出牌堆顶等于全部角色数的牌，每名角色获得其中1牌",

  ["theen_looj"] = "天雷",
  [":theen_looj"] = "法術-天災  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：伱  <br /><b>延旹</b>：將此牌置于目幖角色伏區,目幖伏段生效  <br /><b>效果</b>：目幖判定｡若結果:爲♠2-9，其受到3点无來源雷电傷害;否則將｢閃电｣至入至其下家伏區。  <br /><b>額外</b>：此牌被抵消後至入目幖下家伏區",

  ["khxes_kheet_sis_tssaas"] = "掎挈伺詐",
  [":khxes_kheet_sis_tssaas"] = "锦囊牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：一名其它角色  <br /><b>延旹</b>：將此牌置于目幖角色伏區,目幖伏段生效  <br /><b>效果</b>：目幖判定｡若判定結果:不爲<font color='#CC3131'>♥</font>，目幖越過當轉(全部)主段。",
  ["#khxes_kheet_sis_tssaas_skill"] = "选择一名其它角色，將此牌置于其伏區。其伏段判定：<br />若結果不为<font color='#CC3131'>♥</font>，其越過當轉(全部)主段",

  ["kaeh_hqvoans_toav"] = "解腕刀",
  [":kaeh_hqvoans_toav"] = "裝僃牌·武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效  <br/><b>攻程</b>：1  <br/><b>武器技能</b>：每段伱使用殺次數上限+2",
  ["#kaeh_hqvoans_toav"] = "解腕刀",

  ["cio_ddiac_kiams"] = "魚腸劍",
  [":cio_ddiac_kiams"] = "裝僃牌·武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br /><b>攻程</b>：２  <br /><b>武器技能</b>：鎖定.伱使用殺无視防具",
  ["#cio_ddiac_kiams_skill"] = "魚腸劍",

  ["tshjit_seec_kiams"] = "七星劍",
  [":tshjit_seec_kiams"] = "裝僃牌·武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br /><b>攻程</b>：２  <br /><b>武器技能</b>：伱使用｢殺｣對目幖角色致傷旹，若目幖有牌且傷害未被防止，伱可發動｡防止此傷害，然後依次弃置目幖2x牌(x爲傷害值)。",
  ["#tshjit_seec_kiams_skill"] = "七星劍",

  ["ssaoc_toav"] = "日月雙刀",
  [":ssaoc_toav"] = "裝僃牌·武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br /><b>攻程</b>：２  <br /><b>武器技能</b>：伱使用殺指定目幖後，伱可發動｡其執行一项：➀自弃1手牌➁令伱抽1。",
  ["#ssaoc_toav_skill"] = "日月雙刀",
  ["#ssaoc_toav-invoke"] = "日月雙刀： 伱需弃置1手牌，否則 %src 摸1牌",

  ["hqianh_cuat_toav"] = "靑龍偃月刀",
  [":hqianh_cuat_toav"] = "裝僃牌·武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br/><b>攻程</b>：3<br/><b>武器技能</b>：伱使用殺被閃抵消後,伱可无視距離次數使用1殺發動",
  ["#hqianh_cuat_toav_skill"] = "靑龍偃月刀",
  -- [":#hqianh_cuat_toav_skill"] = "伱使用殺被閃抵消後,伱可无視距離使用1殺",
  ["#hianh_cuat_toav_ssaet"]="无視距離使用殺",

  ["miu"] = "丈八鉈矛",
  [":miu"] = "裝僃牌·武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br /><b>攻程</b>：３  <br /><b>武器技能</b>：伱可{使用/打出}殺旹,可將两張手牌轉化爲｢殺｣發動。視爲伱于元旹機{使用/打出}之",
  ["miu_skill&"] = "矛",
  [":miu_skill&"] = "伱可將两張手牌轉化｢殺｣使用或打出。",
  ["#miu_skill&"] = "伱可將两張手牌轉爲｢殺｣使用或打出",

  ["puoh"] = "金蘸斧",
  [":puoh"] = "裝僃牌·武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br /><b>攻程</b>：３  <br /><b>武器技能</b>：伱使用的｢殺｣被｢閃｣抵消後，伱可打出2牌發動，反抵消。",
  ["#puoh_skill"] = "金蘸斧",
  ["#puoh-invoke"] = "金蘸斧：伱可打出两張牌，令伱對 %dest 使用｢殺｣生效",


  ["ddiach"] = "水磨禪杖",  --改于此
  [":ddiach"] = "裝僃牌·武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br/><b>攻程</b>：4<br/><b>武器技能</b>：鎖定｡伱使用殺指定目幖後,若目幖手牌數大于體力值,必發,此殺不可被響應",
  ["#ddiach_skill"] = "水磨禪杖",

  ["krak"] = "方天畫戟",
  [":krak"] = "裝僃牌·武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br /><b>攻程</b>：４  <br /><b>武器技能</b>：鎖定｡恆續,伱預使用殺選目幖旹,若伱體力值不大于1或除此殺外无手牌,此殺目幖上限+2。",
  ["#krak_skill"] = "方天畫戟",

  ["ssaok"] = "槊",
  [":ssaok"] = "裝僃牌·武器  <br/><b>武器</b>：使用後將此牌置于目幖角色武器欄,持續生效    <br /><b>攻程</b>：４  <br /><b>武器技能</b>：伱使用｢殺｣對目幖角色致傷旹，伱可弃置其1坐騎發動",
  ["#ssaok_skill"] = "槊",

  ["boos_nzjin_kaap"] = "步人甲",
  [":boos_nzjin_kaap"] = "裝僃牌·防具  <br/><b>防具</b>：使用後將此牌置于目幖角色防具欄,持續生效    <br /><b>防具技能</b>：殺指定伱爲目幖旹,伱可發動,伱判定,若結果爲紅,伱自目幖迻除。", --<font color='red'>♥</font>
  ["#boos_nzjin_kaap_skill"] = "步人甲",

  ["soam_ddioc_khoeojh"] = "三緟鎧",
  [":soam_ddioc_khoeojh"] = "裝僃牌·防具  <br/><b>防具</b>：使用後將此牌置于目幖角色防具欄,持續生效  <br /><b>防具技能</b>：鎖定.恆續,殺對伱生效前,若其非紅,必發,其對伱无效。",
  ["#soam_ddioc_khoeojh_skill"] = "三緟鎧",

  ["svoah_tsih_kaap"] = "鎖子甲",
  [":svoah_tsih_kaap"] = "裝僃牌·防具  <br/><b>防具</b>：使用後將此牌置于目幖角色防具欄,持續生效  <br /><b>防具技能</b>：鎖定.殺對伱生效歬,必發,使用者執行1項➀弃1与殺同花手牌➁此殺對伱无效",
  ["#svoah_tsih_kaap_skill"] = "鎖子甲",
  ["#svoah_tsih_kaap_skill-discard"] = "鎖子甲 弃同花牌 否則%arg 對%src无效",

  ["gi_ljin_szius"] = "麒麟獸",
  [":gi_ljin_szius"] = "裝僃牌·防敔坐騎  <br/><b>防敔坐騎</b>：使用後將此牌置于目幖角色防敔坐騎欄,持續生效  <br /><b>坐騎技能</b>：其它角色至伱距离+1。",

  ["tsheen_lih_seej_piuc"] = "千里嘶風",
  [":tsheen_lih_seej_piuc"] = "裝僃牌·防敔坐騎  <br/><b>防敔坐騎</b>：使用後將此牌置于目幖角色防敔坐騎欄,持續生效  <br /><b>坐騎技能</b>：其它角色至伱距离+1。",

  ["syet_baak_kwenh_moav"] = "䨮白卷毛",
  [":syet_baak_kwenh_moav"] = "裝僃牌·防敔坐騎  <br/><b>防敔坐騎</b>：使用後將此牌置于目幖角色防敔坐騎欄,持續生效  <br /><b>坐騎技能</b>：其它角色至伱距离+1。",

  ["tszhjek_thoos"] = "赤兔",
  [":tszhjek_thoos"] = "裝僃牌·進攻坐騎  <br/><b>進攻坐騎 </b>：使用後將此牌置于目幖角色進攻坐騎欄,持續生效  <br /><b>坐騎技能</b>：伱至其它角色距離-1。",

  ["syet_paavs"] = "䨮豹",
  [":syet_paavs"] = "裝僃牌·進攻坐騎  <br/><b>進攻坐騎 </b>：使用後將此牌置于目幖角色進攻坐騎欄,持續生效  <br /><b>坐騎技能</b>：伱至其它角色距離-1。",

  ["cxin_ssik_gwen_hsfa"] = "銀色拳花",
  [":cxin_ssik_gwen_hsfa"] = "裝僃牌·進攻坐騎  <br/><b>進攻坐騎 </b>：使用後將此牌置于目幖角色進攻坐騎欄,持續生效  <br /><b>坐騎技能</b>：伱至其它角色距離-1。",


}
return extension

