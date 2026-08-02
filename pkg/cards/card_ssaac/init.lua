local extension = Package:new("card_ssaac", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/cards/card_ssaac/skills")

local chaos__ssaet = fk.CreateCard{
  name = "chaos__ssaet",
  type = Card.TypeBasic,
  is_damage_card = true,
  skill = "chaos__ssaet_skill",
}

local chaos__szjemh = fk.CreateCard{
  name = "chaos__szjemh",
  type = Card.TypeBasic,
  skill = "szjemh_skill",
  is_passive=true,
}

local jiak = fk.CreateCard{
  name = "jiak",
  type = Card.TypeBasic,
  skill = "jiak_skill",
}
extension:loadCardSkels {
  chaos__szjemh, chaos__ssaet, jiak,
}



local deep = fk.CreateCard{
  name = "&deep",
  type = Card.TypeBasic,
  skill = "deep_skill",
  -- multiple_targets = true,
}
extension:loadCardSkels {
deep,
}
--
local mxevs_svoans_quo_seen = fk.CreateCard{
  name = "mxevs_svoans_quo_seen",
  type = Card.TypeBasic,
  skill = "mxevs_svoans_quo_seen_skill",
}
extension:loadCardSkels {
mxevs_svoans_quo_seen,
}
--
local hzvoans_tsiacs = fk.CreateCard{
  name = "hzvoans_tsiacs",
  type = Card.TypeTrick,
  skill = "hzvoans_tsiacs_skill",
  -- multiple_targets = true,
}
extension:loadCardSkels {
hzvoans_tsiacs,
}


local jje_seec_jjek_sius = fk.CreateCard{
  name = "jje_seec_jjek_sius",
  type = Card.TypeTrick,
  skill = "jje_seec_jjek_sius_skill",
  -- is_passive = true, 
}
extension:loadCardSkels {
jje_seec_jjek_sius,
}

local tsjas_szji_hzfan_hzoon = fk.CreateCard{
  name = "tsjas_szji_hzfan_hzoon",
  type = Card.TypeTrick,
  skill = "tsjas_szji_hzfan_hzoon_skill",
  is_passive = true, 
}
extension:loadCardSkels {
tsjas_szji_hzfan_hzoon,
}

local szjep_hzoon = fk.CreateCard{
  name = "szjep_hzoon",
  type = Card.TypeTrick,
  skill = "szjep_hzoon_skill",
}
extension:loadCardSkels {
szjep_hzoon,
}


local khuo_kujh_dzziuk_zja = fk.CreateCard{
  name = "khuo_kujh_dzziuk_zja",
  type = Card.TypeTrick,
  skill = "khuo_kujh_dzziuk_zja_skill",
  multiple_targets = true,
}
extension:loadCardSkels {
khuo_kujh_dzziuk_zja,
}


local tsoeojs_ssaac = fk.CreateCard{
  name = "tsoeojs_ssaac",
  type = Card.TypeTrick,
  skill = "tsoeojs_ssaac_skill",
  multiple_targets = true,
}
extension:loadCardSkels {
tsoeojs_ssaac,
}



local douc_ssaac_giocx_sjih = fk.CreateCard{
  name = "douc_ssaac_giocx_sjih",
  type = Card.TypeTrick,
  skill = "douc_ssaac_giocx_sjih_skill",
  multiple_targets = true,
}

extension:loadCardSkels {
douc_ssaac_giocx_sjih,
}


local bioc_hsioc_hsfas_kjit = fk.CreateCard{
  name = "bioc_hsioc_hsfas_kjit",
  type = Card.TypeTrick, --法術 
  skill = "bioc_hsioc_hsfas_kjit_skill",
  multiple_targets = true,
}
extension:loadCardSkels {
bioc_hsioc_hsfas_kjit,
}

local tsoeoj_hzvoah = fk.CreateCard{
  name = "tsoeoj_hzvoah",
  type = Card.TypeTrick,
  skill = "tsoeoj_hzvoah_skill",
  multiple_targets = true,
}
extension:loadCardSkels {
tsoeoj_hzvoah,
}

local lih_doeojs_doav_kiac = fk.CreateCard{
  name = "lih_doeojs_doav_kiac",
  type = Card.TypeTrick,
  skill = "lih_doeojs_doav_kiac_skill",
  is_passive=true,
}
extension:loadCardSkels {
lih_doeojs_doav_kiac,
}

local lioc_zzja_khih_liuk = fk.CreateCard{
  name = "lioc_zzja_khih_liuk",
  type = Card.TypeTrick,
  skill = "lioc_zzja_khih_liuk_skill",
  -- multiple_targets = true,
}
extension:loadCardSkels {lioc_zzja_khih_liuk,}

local theen_djis_puanh_phius = fk.CreateCard{
  name = "theen_djis_puanh_phius",
  type = Card.TypeTrick,
  is_damage_card = false,
  skill = "theen_djis_puanh_phius_skill",
}
extension:loadCardSkels {
theen_djis_puanh_phius,
}



local hsoo_piuc_hsvoans_quoh = fk.CreateCard{
  name = "hsoo_piuc_hsvoans_quoh",
  type = Card.TypeTrick,
  sub_type = Card.SubtypeDelayedTrick,
  skill = "hsoo_piuc_hsvoans_quoh_skill",
}
extension:loadCardSkels {
hsoo_piuc_hsvoans_quoh,
}

local hqoon_jyek = fk.CreateCard{
  name = "hqoon_jyek",
  type = Card.TypeTrick,
  sub_type=Card.SubtypeDelayedTrick,
  stackable_delayed = true,
  skill = "hqoon_jyek_skill",
  -- multiple_targets = true,
}
extension:loadCardSkels {
hqoon_jyek,
}

local ssaen_hsvoah = fk.CreateCard{
  name = "ssaen_hsvoah",
  type = Card.TypeTrick,
  sub_type=Card.SubtypeDelayedTrick,
  stackable_delayed = true,
  skill = "ssaen_hsvoah_skill",
  is_damage_card=true,
  damage_type = fk.FireDamage,
}
extension:loadCardSkels {
ssaen_hsvoah,
}

--
local phaavs = fk.CreateCard{
  name = "phaavs",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 6,
  equip_skill = "#phaavs_skill",
  skill = "self_equip_skill",
}
extension:loadCardSkels {phaavs,}

local tshiac = fk.CreateCard{
  name = "tshiac",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 3,
  equip_skill = "#tshiac_skill",
  skill = "self_equip_skill",
}
extension:loadCardSkels {tshiac,}

local ljen_hzfan_maah = fk.CreateCard{
  name = "ljen_hzfan_maah",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#ljen_hzfan_maah_skill",
  skill = "self_equip_skill",
}
extension:loadCardSkels {ljen_hzfan_maah,}

local tsheec_tshouc_maah = fk.CreateCard{
  name = "tsheec_tshouc_maah",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeOffensiveRide,
  equip_skill = "#tsheec_tshouc_maah_skill",
  skill = "self_equip_skill",
}
extension:loadCardSkels {tsheec_tshouc_maah,}

local hsoeojh_tshiu = fk.CreateCard{
  name = "hsoeojh_tshiu",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeTreasure,
  -- equip_skill = "#hsoeojh_tshiu_skill",
  skill = "self_equip_skill",
}
extension:loadCardSkels {hsoeojh_tshiu,}

local soam_dzzjin_gi = fk.CreateCard{
  name = "soam_dzzjin_gi",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeTreasure,
  -- equip_skill = "#soam_dzzjin_gi_skill",
  skill = "self_equip_skill",
}
extension:loadCardSkels {soam_dzzjin_gi,}

local kaap_maah = fk.CreateCard{
  name = "kaap_maah",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeTreasure,
  -- equip_skill = "#kaap_maah_skill",
  skill = "self_equip_skill",
}
extension:loadCardSkels {kaap_maah,}

local nzuo_biuk = fk.CreateCard{
  name = "nzuo_biuk",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
  equip_skill = "#nzuo_biuk_skill",
  skill = "self_equip_skill",
}
extension:loadCardSkels {nzuo_biuk,}

-- extension:addCardSpec("chaos__ssaet", Card.Spade, 1)  --v1 v2逢
extension:addCardSpec("chaos__ssaet", Card.Spade, 11)
extension:addCardSpec("chaos__ssaet", Card.Spade, 12)
extension:addCardSpec("chaos__ssaet", Card.Club, 1)
extension:addCardSpec("chaos__ssaet", Card.Club, 5)
extension:addCardSpec("chaos__ssaet", Card.Club, 6)
extension:addCardSpec("chaos__ssaet", Card.Club, 11)
extension:addCardSpec("chaos__ssaet", Card.Club, 12)
-- extension:addCardSpec("chaos__ssaet", Card.Club, 13)  --海鰍
extension:addCardSpec("chaos__ssaet", Card.Heart, 3)
extension:addCardSpec("chaos__ssaet", Card.Heart, 4)
extension:addCardSpec("chaos__ssaet", Card.Diamond, 3)
extension:addCardSpec("chaos__ssaet", Card.Diamond, 8)


extension:addCardSpec("chaos__szjemh", Card.Heart, 5)
extension:addCardSpec("chaos__szjemh", Card.Diamond, 4)
extension:addCardSpec("chaos__szjemh", Card.Diamond, 6)
extension:addCardSpec("chaos__szjemh", Card.Diamond, 7)
extension:addCardSpec("chaos__szjemh", Card.Diamond, 12)

extension:addCardSpec("chaos__ssaet", Card.Spade, 10)  --deep
extension:addCardSpec("chaos__ssaet", Card.Club, 10)
extension:addCardSpec("chaos__szjemh", Card.Heart, 10)
extension:addCardSpec("chaos__szjemh", Card.Diamond, 10)
-- extension:addCardSpec("deep", Card.Spade, 10)  --作爲衍生牌
-- extension:addCardSpec("deep", Card.Club, 10)
-- extension:addCardSpec("deep", Card.Heart, 10)
-- extension:addCardSpec("deep", Card.Diamond, 10)

extension:addCardSpec("jiak", Card.Heart, 6)
extension:addCardSpec("jiak", Card.Heart, 7)
extension:addCardSpec("jiak", Card.Heart, 12)
extension:addCardSpec("jiak", Card.Diamond, 11)


--


-- extension:addCardSpec("mae_biuk", Card.Spade, 2)  --v1埋伏
-- extension:addCardSpec("hsoeojh_seevs", Card.Spade, 2)  --v1埋伏 --

-- extension:addCardSpec("hsio_hzvoach_hqjit_tshiac", Card.Club, 5)
-- extension:addCardSpec("hsio_hzvoach_hqjit_tshiac", Card.Spade, 7)
-- extension:addCardSpec("hsio_hzvoach_hqjit_tshiac", Card.Heart, 11)

extension:addCardSpec("mxevs_svoans_quo_seen", Card.Spade, 3)
extension:addCardSpec("mxevs_svoans_quo_seen", Card.Spade, 2)
extension:addCardSpec("mxevs_svoans_quo_seen", Card.Heart, 8)


extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Heart, 13)
--
extension:addCardSpec("khuo_kujh_dzziuk_zja", Card.Diamond, 5)
extension:addCardSpec("khuo_kujh_dzziuk_zja", Card.Heart, 8)

extension:addCardSpec("szjep_hzoon", Card.Spade, 4)
extension:addCardSpec("szjep_hzoon", Card.Diamond, 9)

extension:addCardSpec("bioc_hsioc_hsfas_kjit",Card.Spade, 1) --v1 Ex Spade, 4

extension:addCardSpec("theen_djis_puanh_phius", Card.Spade, 13)

extension:addCardSpec("lioc_zzja_khih_liuk", Card.Club, 7)

extension:addCardSpec("tsoeojs_ssaac", Card.Heart, 2)  --挩胎換骨

-- extension:addCardSpec("hzoon_puj_phoas_soans", Card.Diamond, 5)
-- extension:addCardSpec("hzoon_puj_phoas_soans", Card.Spade, 8)




extension:addCardSpec("tsoeoj_hzvoah", Card.Diamond, 1)

-- extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Club, 3)

extension:addCardSpec("tsjas_szji_hzfan_hzoon", Card.Diamond, 2)

extension:addCardSpec("hzvoans_tsiacs", Card.Club, 11)

extension:addCardSpec("lih_doeojs_doav_kiac", Card.Diamond, 13)

-- extension:addCardSpec("douc_ssaac_giocx_sjih", Card.Club, 9)

-- extension:addCardSpec("hqximh_quoh_dzziak", Card.Diamond, 13)
extension:addCardSpec("jje_seec_jjek_sius", Card.Club, 8)



--
extension:addCardSpec("hqoon_jyek", Card.Spade, 9)
extension:addCardSpec("ssaen_hsvoah", Card.Club, 2)

--
extension:addCardSpec("phaavs", Card.Club, 4)
extension:addCardSpec("tshiac", Card.Club, 3)  --刀 v1 Spade, 3

extension:addCardSpec("hsoeojh_tshiu", Card.Club, 13)  --海鰍 v1 ssaet
extension:addCardSpec("kaap_maah", Card.Heart, 11)
extension:addCardSpec("soam_dzzjin_gi", Card.Heart, 1)

--
extension:addCardSpec("ljen_hzfan_maah", Card.Spade, 5)  --連環馬

-- extension:addCardSpec("kaap", Card.Heart, 9)

extension:addCardSpec("tsheec_tshouc_maah", Card.Spade, 6)


---

extension:addCardSpec("hsoo_piuc_hsvoans_quoh", Card.Spade, 7)
--
extension:addCardSpec("nzuo_biuk", Card.Club, 9)

Fk:loadTranslationTable{
  ["card_ssaac"] = "水滸牌-生死之戰",

  ["magic"] = "法術牌",

  -- ["lvoans_tszjens_ssaet"] = "亂戰殺",
  -- [":lvoans_tszjens_ssaet"] = "基本牌  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：攻程內其它脚色  <br /><b>效果</b>：此牌隨機轉爲3種殺之1。",

  ["chaos__ssaet"] = "亂戰殺",
  [":chaos__ssaet"] = "基本牌-行動  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1 <br /><b>距離</b>：伱攻程内  <br /><b>次數</b>：同名牌每段限1次  額外</b>:結算前隨機變爲{无屬/雷/火}殺",
  ["chaos__ssaet_skill"] = "亂戰殺",
  ["#chaos__ssaet_skill"] = "亂戰殺 選攻程內1其它脚色,對予其1傷",
  ["@@card_damage_nature-phase"] = "亂戰殺",
  ["#chaos__ssaet_nature"] = "%arg2 屬性爲 %arg",

  ["chaos__szjemh"] = "亂戰閃",
  [":chaos__szjemh"] = "基本牌  <br /><b>旹機</b>：｢殺｣对你生效前  <br /><b>目幖</b>：此｢殺｣  <br /><b>效果</b>：抵消此｢殺｣效果,迻除伱咒術。 <br /><b>額外</b>：因動-抵消｡殺目幖需爲伱｡每旹機限1次｡",
  ["chaos__szjemh_skill"] = "亂戰閃",
  ["#chaos__szjemh_skill"] = "亂戰閃",

  -- ["lvoans_tszjens_szjemh"] = "亂戰閃",
  -- [":lvoans_tszjens_szjemh"] = "基本牌  <br /><b>旹機</b>：殺對伱生效歬  <br /><b>目幖</b>：此殺  <br /><b>效果</b>：抵消此殺。",
  -- ["lvoans_tszjens_szjemh"] = "亂戰閃 抵消此殺。",

  ["jiak"] = "藥",
  [":jiak"] = "基本牌  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：已損脚色      <br/><b>目幖數</b>:1  <br /><b>效果</b>：目幖回1,解除咒術。",
  ["jiak_skill"] = "藥 目幖回1,解除咒術",

  ["deep"] = "諜",
  [":deep"] = "基本牌  <br /><b>旹機</b>：主段執行旹/展示旹  <br /><b>目幖</b>：无  <br />  <b>效果</b>：此牌本身无效果,可起動.  <b>額外</b>：當伱手牌中諜被展示,伱弃置之.當諜離開伱手牌區,因花執行效果{♥️火傷/♦️无屬傷/♠️流失/♣️雷傷}。",
  ["#deep_skill"] = "諜 自暴",



  ["mxevs_svoans_quo_seen"] = "廟算于先",
  [":mxevs_svoans_quo_seen"] = "錦囊  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>:无限制      <br/><b>目幖數</b>:伱  <br/><b>效果</b>:目幖自3个隨機錦囊名選1,錦囊无視距離不可抵消",
  ["mxevs_svoans_quo_seen_skill"] = "廟算于先",
  ["#mxevs_svoans_quo_seen_skill"] = "廟算于先 對自己起動 自3个隨機錦囊名選1獲得",
  ["#mxevs_svoans_quo_seen_skill-choose"] = "廟算于先 選擇牌名",
  ["@@mxevs_svoans_quo_seen-turn"] = "廟算于先",

  ["hzvoans_tsiacs"] = "應物變化",
  [":hzvoans_tsiacs"] = "法術  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>:无限制    <br/><b>目幖數</b>:1  <br/><b>預起動</b>:伱 <br/><b>效果</b>:目幖自3个隨機將牌選1替換當前將牌",
  ["hzvoans_tsiacs_skill"] = "應物變化",
  ["#hzvoans_tsiacs_skill"] = "應物變化 對自己起動 自3个隨機將牌選1替換當前將牌",
  ["#hzvoans_tsiacs_skill-choose"] = "應物變化 選擇將牌",

  
  ["tsjas_szji_hzfan_hzoon"] = "借屍還䰟",
  [":tsjas_szji_hzfan_hzoon"] = "法術  <br/><b>旹機</b>:1脚色A進入瀕死旹  <br/><b>目幖</b>:死亾脚色B    <br/><b>目幖數</b>:1   <br/><b>效果</b>:A死亡,B 抽3牌1體力復活  <br /><b>額外</b>：因動｡每旹機限1次,全體脚色同旹選擇是否起動",
  ["tsjas_szji_hzfan_hzoon_skill"] = "借屍還䰟",
  ["#tsjas_szji_hzfan_hzoon_skill"] = "借屍還䰟 對死亾脚色起動 其復活",


  ["szjep_hzoon"] = "攝䰟",
  [":szjep_hzoon"] = "法術  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>:A,B    <br /><b>目幖數</b>：1  <br/><b>效果</b>:A生爲死B爲死  <br/><b>額外</b>:死脚色受傷後,生脚色回復傷害值體力",
  ["#szjep_hzoon_skill"] = "攝䰟 A生爲死B爲死",

  ["jje_seec_jjek_sius"] = "迻星易宿",
  [":jje_seec_jjek_sius"] = "法術  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：其它脚色  <br /><b>目幖數</b>：1  <br /><b>效果</b>：目幖體力-x,伱+x(x隨機,至少爲1,至多爲max{1,min{伱已損體力值,目幖體力值-1}})",
  ["#jje_seec_jjek_sius_skill"] = "迻星易宿 選1其它脚色 目幖體力-x,伱+x(x隨機,至少爲1,至多爲max{1,min{伱已損體力值,目幖體力值-1}})",
  ["douc_ssaac_giocx_sjih"] = "同生共死", --靈魂連
  [":douc_ssaac_giocx_sjih"] = "法術  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>:无限制    <br/><b>目幖數</b>:1至多  <br/><b>預起動</b>:全部脚色  <br/><b>效果</b>:一脚色體力變化後,其它脚色執行相同效果",
  ["douc_ssaac_giocx_sjih_skill"] = "同生共死",
  ["#douc_ssaac_giocx_sjih_skill"] = "同生共死 一脚色體力變化後,其它脚色執行相同效果", --靈魂連
  ["@@douc_ssaac_giocx_sjih"] = "同生共死",

  ["khuo_kujh_dzziuk_zja"] = "驅鬼逐邪",
  [":khuo_kujh_dzziuk_zja"] = "法術  <br /><b>旹機</b>：➀主段執行旹/➁一脚色復活前  <br /><b>目幖</b>：1至2有咒術脚色/此死亾脚色  <br /><b>目幖數</b>：1至2/1  <br /><b>效果</b>：迻除目幖咒術/防止復活",
  ["#khuo_kujh_dzziuk_zja_skill"] = "驅鬼逐邪 選1至2有咒術脚色 迻除目幖咒術",

  ["tsoeojs_ssaac"] = "枯木逢萅",--khoo_mouk_bioc_tszhyin
  [":tsoeojs_ssaac"] = "法術  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>:无限制  <br /><b>目幖數</b>：1至多  <br /><b>預起動</b>：選擇全部合理目幖  <br/><b>效果</b>:目幖各回復體力至滿,弃x手牌(x爲所回體力值)",
  ["tsoeojs_ssaac__skill"] = "枯木逢萅",
  ["#tsoeojs_ssaac_skill"] = "枯木逢萅 全體各回復體力至滿,弃x手牌(x爲所回體力值)",
  ["#tsoeojs_ssaac-discard"] = "枯木逢萅 弃%arg手牌",

  ["tsoeoj_hzvoah"] = "災禍",
  [":tsoeoj_hzvoah"] = "法術  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>:其它脚色    <br /><b>目幖數</b>：1至多  <br /><b>預起動</b>：選擇全部合理目幖  <br/><b>效果</b>:目幖選擇可演練1紅色牌,未執行附加隨機負面咒術",
  ["tsoeoj_hzvoah_skill"] = "災禍",
  ["#tsoeoj_hzvoah_skill"] = "災禍 目幖選擇➀演練1紅色牌➁附加隨機負面咒術",
  ["#tsoeoj_hzvoah_skill-ask"] = "災禍 請演練紅色牌",

  ["bioc_hsioc_hsfas_kjit"] = "逢凶化吉",
  [":bioc_hsioc_hsfas_kjit"] = "法術  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：无限制  <br /><b>目幖數</b>：1至多  <br /><b>預起動</b>：選擇全部合理目幖   <br /><b>效果</b>：目幖抽x,x爲其已損體力值。",
  ["bioc_hsioc_hsfas_kjit_skill"] = "逢凶化吉",
  ["#bioc_hsioc_hsfas_kjit_skill"] = "全脚色抽牌 數量爲其已損體力值",


  ["lioc_zzja_khih_liuk"] = "龍蛇起陸", --
  [":lioc_zzja_khih_liuk"] = "法術  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>:无目幖    <br/><b>目幖數</b>:0  <br/><b>效果</b>:起動者下家執行:伱失去1體力,若伱未因此死亾,伱下家執行此效果  <br /><b>額外</b>：全體脚色已損才可起動",
  ["lioc_zzja_khih_liuk_skill"] = "龍蛇起陸",
  ["#lioc_zzja_khih_liuk_skill"] = "龍蛇起陸  伱下家執行:其失去1體力,若其未因此死亾,其下家執行", --

  ["theen_djis_puanh_phius"] = "天地反覆",
  [":theen_djis_puanh_phius"] = "法術牌  <br /><b>旹機</b>：主段執行旹  <br /><b>目幖</b>：无  <br /><b>目幖數</b>：0  <br /><b>效果</b>：全體脚色依次執行,若其存𣴠其流失1體力,若其死亾,其復𣴠(若體力上限小于1改爲1)。",
  ["#theen_djis_puanh_phius_skill"] = "天地反覆 全體脚色依次執行,若其存𣴠其流失1體力,若其死亾,其復𣴠",

  ["lih_doeojs_doav_kiac"] = "李代桃僵",
  [":lih_doeojs_doav_kiac"] = "法術  <br /><b>旹機</b>：一脚色受傷旹  <br /><b>目幖</b>：无  <br /><b>目幖數</b>：0   <br /><b>效果</b>：起動者流失1體力,防止傷害  <br /><b>額外</b>：因動｡每旹機限1次,全體脚色同旹選擇是否起動",
  ["#lih_doeojs_doav_kiac_skill"] = "李代桃僵 流失1體力,防止傷害",
  ["#lih_doeojs_doav_kiac-invoke"] = "李代桃僵 流失1體力,防止 %src 傷害",
 
  ["hsoo_piuc_hsvoans_quoh"] = "呼風喚雨",
  [":hsoo_piuc_hsvoans_quoh"] = "法術  <br/><b>旹機</b>：主段執行旹    <br /><b>目幖</b>：无限制   <br /><b>目幖數</b>：1     <br /><b>預起動</b>：伱    <br /><b>延旹</b>：將此牌置于目幖伏區,目幖伏段執行旹生效<br/><b>效果</b>：伱獲得1天災牌.",
  ["#hsoo_piuc_hsvoans_quoh_skill"] = "呼風喚雨",

  ["hqoon_jyek"] = "瘟疫",
  [":hqoon_jyek"] = "法術-延旹  <br/><b>旹機</b>:主段執行旹  <br/><b>目幖</b>:无限制    <br /><b>目幖數</b>：1     <br /><b>預起動</b>：伱   <br /><b>延旹</b>：將此牌置于目幖伏區,目幖伏段執行旹生效  <br/><b>效果</b>:目幖占卜,若花色爲♥️,其解除咒術,否則附加隨機咒術,將此牌迻至其下家  <br /><b>額外</b>：此牌被抵消後至入目幖下家伏區",
  ["#hqoon_jyek"] = "瘟疫 ",
  ["hqoon_jyek_skill"] = "災禍",

  ["ssaen_hsvoah"] = "山火",
  [":ssaen_hsvoah"] = "法術-天災-延旹  <br/><b>旹機</b>：主段執行旹  <br/><b>目幖</b>:无限制    <br /><b>目幖數</b>：1     <br /><b>預起動</b>：伱     <br /><b>延旹</b>：將此牌置于目幖伏區,目幖伏段執行旹生效  <br/><b>效果</b>：目幖效占卜,若:花色爲♥️,目幖受2火傷,其上下家各受1火傷;否則將此牌至入下家伏區  <br /><b>額外</b>：此牌被抵消後至入目幖下家伏區",

  ["hqximh_quoh_dzziak"] = "飲羽石",
  [":hqximh_quoh_dzziak"] = "裝僃牌-武器  <br/><b>攻程</b>：无限大  <br /><b>武器技能</b>：主段執行旹.將x張殺轉化爲殺起動發動.傷害基數x,x爲1至3,結算完後弃置此牌。",

  ["phaavs"] = "炮",
  [":phaavs"] = "裝僃牌-武器  <br/><b>攻程</b>：6  <br/><b>武器技能</b>：當伱起動殺致屬性傷後,必發,伱對受傷脚色上下家附加咒術「眩暈」。",

  ["tshiac"] = "點鋼槍",
  [":tshiac"] = "裝僃牌武器  <br/><b>攻程</b>：3  <br/><b>武器技能</b>：伱起動殺所致傷害視爲流失體力",
  ["#tshiac_skill"] = "點鋼槍",

  ["ljen_hzfan_maah"] = "連環馬",
  [":ljen_hzfan_maah"] = "裝僃牌-防敔馬  <br/><b>技能</b>：伱額定手牌數+2",
  
  ["tsheec_tshouc_maah"] = "靑鬃馬",
  [":tsheec_tshouc_maah"] = "裝僃牌-進攻馬  <br /><b>目幖</b>：有進攻坐騎欄者  <br /><b>目幖數</b>：1     <br /><b>預起動</b>：伱            <br/><b>進攻坐騎</b>：起動結算旹將此牌置于目幖進攻坐騎欄,持續生效    <br/><b>技能</b>：伱至其它脚色距離-2",

  ["hsoeojh_tshiu"] = "海鰍",
  [":hsoeojh_tshiu"] = "裝僃牌-寶物  <br /><b>目幖</b>：有寶物欄者  <br /><b>目幖數</b>：1     <br /><b>預起動</b>：伱   <br/><b>寶物</b>：起動結算旹將此牌置于目幖寶物欄,持續生效  <br/><b>寶物技能</b>：伱不是錦囊合理目幖",

  ["soam_dzzjin_gi"] = "三辰旗",
  [":soam_dzzjin_gi"] = "裝僃牌-寶物  <br /><b>目幖</b>：有寶物欄者  <br /><b>目幖數</b>：1     <br /><b>預起動</b>：伱  <br/><b>寶物技能</b>：伱不越過轉.",

  ["kaap_maah"] = "甲馬",
  [":kaap_maah"] = "裝僃牌-寶物  <br /><b>目幖</b>：有寶物欄者  <br /><b>目幖數</b>：1     <br /><b>預起動</b>：伱  <br/><b>寶物技能</b>：伱不越過轉.",
  ["kaap_maah_skill"] = "甲馬",

  ["nzuo_biuk"] = "鶴氅",--hzoak_tszhiach
  [":kaap_maah"] = "裝僃牌-防具  <br /><b>目幖</b>：有防具欄者  <br /><b>目幖數</b>：1     <br /><b>預起動</b>：伱  <br/><b>防具技能</b>：恆續｡伱不是卽旹錦囊合理目幖",
  ["kaap_maah_skill"] = "鶴氅",
}
return extension
