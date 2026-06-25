local extension = Package:new("card_ssaac", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/card_ssaac/skills")

local chaos__ssaet = fk.CreateCard{
  name = "chaos__ssaet",
  type = Card.TypeBasic,
  is_damage_card = true,
  skill = "chaos__ssaet_skill",
}

local chaos__szjemh = fk.CreateCard{
  name = "chaos__szjemh",
  type = Card.TypeBasic,
  is_damage_card = false,
  skill = "szjemh_skill",
  is_passive=true,
}

local jiak = fk.CreateCard{
  name = "jiak",
  type = Card.TypeBasic,
  is_damage_card = false,
  skill = "jiak_skill",
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
  is_damage_card = false,
  skill = "mxevs_svoans_quo_seen_skill",
}
extension:loadCardSkels {
mxevs_svoans_quo_seen,
}
--
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
local tsoeojs_ssaac = fk.CreateCard{
  name = "tsoeojs_ssaac",
  type = Card.TypeTrick,
  skill = "tsoeojs_ssaac_skill",
  multiple_targets = true,
}
extension:loadCardSkels {
tsoeojs_ssaac,
}

local tshjit = fk.CreateCard{
  name = "tshjit",
  type = Card.TypeTrick,
  skill = "tshjit_skill",
  -- multiple_targets = true,
}
extension:loadCardSkels {
tshjit,
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

local hzvoans_tsiacs = fk.CreateCard{
  name = "hzvoans_tsiacs",
  type = Card.TypeTrick,
  skill = "hzvoans_tsiacs_skill",
  -- multiple_targets = true,
}

extension:loadCardSkels {
hzvoans_tsiacs,
}

local lih_doeojs_doav_kiac = fk.CreateCard{
  name = "lih_doeojs_doav_kiac",
  type = Card.TypeTrick,
  is_damage_card = false,
  skill = "lih_doeojs_doav_kiac_skill",
  is_passive=true,
}
extension:loadCardSkels {
lih_doeojs_doav_kiac,
}

local nniuh_ttwenh_gxen_khoon = fk.CreateCard{
  name = "nniuh_ttwenh_gxen_khoon",
  type = Card.TypeTrick,
  is_damage_card = false,
  skill = "nniuh_ttwenh_gxen_khoon_skill",
}
extension:loadCardSkels {
nniuh_ttwenh_gxen_khoon,
}
local bioc_hsioc_hsfas_kjit = fk.CreateCard{
  name = "bioc_hsioc_hsfas_kjit",
  type = Card.TypeTrick, --法術 
  skill = "bioc_hsioc_hsfas_kjit_skill",
  multiple_targets = true,
  -- is_damage_card = false,
--   is_passive = false,
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

local khuo_kujh_dzziuk_zja = fk.CreateCard{
  name = "khuo_kujh_dzziuk_zja",
  type = Card.TypeTrick,
  skill = "khuo_kujh_dzziuk_zja_skill",
  multiple_targets = true,
}
extension:loadCardSkels {
khuo_kujh_dzziuk_zja,
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
  is_damage_card=true
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
}
extension:loadCardSkels {
phaavs,
}

local tshiac = fk.CreateCard{
  name = "tshiac",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
  attack_range = 3,
  equip_skill = "#tshiac_skill",
}
extension:loadCardSkels {
tshiac,
}

local ljen_hzfan_maah = fk.CreateCard{
  name = "ljen_hzfan_maah",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
  equip_skill = "#ljen_hzfan_maah_skill",
}
extension:loadCardSkels {
ljen_hzfan_maah,
}

local tsheec_tshouc_maah = fk.CreateCard{
  name = "tsheec_tshouc_maah",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeOffensiveRide,
  equip_skill = "#tsheec_tshouc_maah_skill",
}
extension:loadCardSkels {
tsheec_tshouc_maah,
}

local hsoeojh_tshiu = fk.CreateCard{
  name = "hsoeojh_tshiu",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeTreasure,
  -- equip_skill = "#hsoeojh_tshiu_skill",
}
extension:loadCardSkels {
hsoeojh_tshiu,
}

local soam_dzzjin_gi = fk.CreateCard{
  name = "soam_dzzjin_gi",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeTreasure,
  -- equip_skill = "#soam_dzzjin_gi_skill",
}
extension:loadCardSkels {
soam_dzzjin_gi,
}

local kaap_maah = fk.CreateCard{
  name = "kaap_maah",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeTreasure,
  -- equip_skill = "#kaap_maah_skill",
}
extension:loadCardSkels {
kaap_maah,
}

extension:loadCardSkels {
  chaos__szjemh, chaos__ssaet, jiak,
}


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


-- extension:addCardSpec("hzaac_tshjes", Card.Spade, 2)  --v1行刺
-- extension:addCardSpec("hsoeojh_seevs", Card.Spade, 2)  --v1行刺 --

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

extension:addCardSpec("nniuh_ttwenh_gxen_khoon", Card.Spade, 13)

extension:addCardSpec("tshjit", Card.Club, 7)

extension:addCardSpec("tsoeojs_ssaac", Card.Heart, 2)  --挩胎換骨

-- extension:addCardSpec("hzoon_puj_phoas_soans", Card.Diamond, 5)
-- extension:addCardSpec("hzoon_puj_phoas_soans", Card.Spade, 8)




extension:addCardSpec("tsoeoj_hzvoah", Card.Diamond, 1)

-- extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Club, 3)

extension:addCardSpec("tsjas_szji_hzfan_hzoon", Card.Diamond, 2)

extension:addCardSpec("hzvoans_tsiacs", Card.Club, 11)

extension:addCardSpec("lih_doeojs_doav_kiac", Card.Diamond, 13)

extension:addCardSpec("douc_ssaac_giocx_sjih", Card.Club, 9)

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

Fk:loadTranslationTable{
  ["card_ssaac"] = "水滸牌-生死之戰",

  ["magic"] = "法術牌",

  -- ["lvoans_tszjens_ssaet"] = "亂戰殺",
  -- [":lvoans_tszjens_ssaet"] = "基本牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：攻程內其他角色  <br /><b>效果</b>：此牌隨機轉爲3種殺之1。",

  ["chaos__ssaet"] = "亂戰殺",
  [":chaos__ssaet"] = "基本牌-行動  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：1其它角色  <br /><b>距離</b>：伱攻程内  <br /><b>次數</b>：每段限1次 <br/><b>額外</b>:結算前隨機變爲{无屬/雷/火}殺",
  ["chaos__ssaet_skill"] = "亂戰殺",
  ["#chaos__ssaet_skill"] = "亂戰殺 選攻程內1其他角色,對予其1傷",
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
  [":jiak"] = "基本牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：1已損角色  <br /><b>效果</b>：目幖角色回1,解除咒術。",
  ["jiak_skill"] = "藥 目幖角色回1,解除咒術",

  ["deep"] = "諜",
  [":deep"] = "基本牌  <br /><b>旹機</b>：主旹,展示旹  <br /><b>目幖</b>：无  <br /><b>效果</b>：此牌本身无效果,可使用.當伱手牌中諜被展示,伱弃之.當諜離開伱手牌區,因花執行效果。",
  ["#deep_skill"] = "諜 自暴",



  ["mxevs_svoans_quo_seen"] = "廟算于先",
  [":mxevs_svoans_quo_seen"] = "錦囊  <br/><b>旹機</b>:主旹  <br/><b>目幖</b>:伱  <br/><b>效果</b>:目幖自3个隨機錦囊名選1,錦囊无視距離不可抵消",
  ["mxevs_svoans_quo_seen_skill"] = "廟算于先",
  ["#mxevs_svoans_quo_seen_skill"] = "廟算于先 對自己使用 自3个隨機錦囊名選1獲得",
  ["#mxevs_svoans_quo_seen_skill-choose"] = "廟算于先 選擇牌名",
  ["@@mxevs_svoans_quo_seen-turn"] = "廟算于先",

  
  ["tsjas_szji_hzfan_hzoon"] = "借屍還䰟",
  [":tsjas_szji_hzfan_hzoon"] = "法術  <br/><b>旹機</b>:1角色A進入瀕死旹  <br/><b>目幖</b>:1死亾角色B  <br/><b>效果</b>:A死亡,B 抽3牌1體力復活  <br /><b>額外</b>：因動｡每旹機限1次,全體角色同旹選擇是否使用",
  ["tsjas_szji_hzfan_hzoon_skill"] = "借屍還䰟",
  ["#tsjas_szji_hzfan_hzoon_skill"] = "借屍還䰟 對死亾角色使用 其復活",



  ["hzvoans_tsiacs"] = "應物變化",
  [":hzvoans_tsiacs"] = "法術  <br/><b>旹機</b>:主旹  <br/><b>目幖</b>:伱  <br/><b>效果</b>:目幖自3个隨機將牌選1替換當前將牌",
  ["hzvoans_tsiacs_skill"] = "應物變化",
  ["#hzvoans_tsiacs_skill"] = "應物變化 對自己使用 自3个隨機將牌選1替換當前將牌",
  ["#hzvoans_tsiacs_skill-choose"] = "應物變化 選擇將牌",

  ["douc_ssaac_giocx_sjih"] = "同生共死", --靈魂連
  [":douc_ssaac_giocx_sjih"] = "法術  <br/><b>旹機</b>:主旹  <br/><b>目幖</b>:全  <br/><b>效果</b>:任一角色體力變化後,其它角色執行相同效果",
  ["douc_ssaac_giocx_sjih_skill"] = "同生共死",
  ["#douc_ssaac_giocx_sjih_skill"] = "同生共死 任一角色體力變化後,其它角色執行相同效果", --靈魂連
  ["@@douc_ssaac_giocx_sjih"] = "同生共死",

  ["tshjit"] = "龍蛇起陸", --
  [":tshjit"] = "法術  <br/><b>旹機</b>:主旹  <br/><b>目幖</b>:无  <br/><b>效果</b>:使用者下家執行:伱失去1體力,若伱未因此死亾,伱下家執行此效果  <br /><b>額外</b>：全體角色已損才可使用",
  ["tshjit_skill"] = "龍蛇起陸",
  ["#tshjit_skill"] = "龍蛇起陸  伱下家執行:其失去1體力,若其未因此死亾,其下家執行", --

  ["nniuh_ttwenh_gxen_khoon"] = "天地反覆",
  [":nniuh_ttwenh_gxen_khoon"] = "法術牌  <br /><b>旹機</b>：主旹  <br /><b>目幖</b>：无  <br /><b>效果</b>：全體角色依次執行,若其存𣴠其流失1體力,若其死亾,其復𣴠(若體力上限小于1改爲1)。",
  ["#nniuh_ttwenh_gxen_khoon_skill"] = "天地反覆 全體角色依次執行,若其存𣴠其流失1體力,若其死亾,其復𣴠",

  ["szjep_hzoon"] = "攝䰟",
  [":szjep_hzoon"] = "法術  <br/><b>旹機</b>:主旹  <br/><b>目幖</b>:A,B  <br/><b>效果</b>:A生爲死B爲死  <br/><b>額外</b>:死角色受傷後,生角色回復傷害值體力",
  ["#szjep_hzoon_skill"] = "攝䰟 A生爲死B爲死",

  ["tsoeojs_ssaac"] = "枯木逢萅",--khoo_mouk_bioc_tszhyin
  [":tsoeojs_ssaac"] = "法術  <br/><b>旹機</b>:主旹  <br/><b>目幖</b>:全角色  <br/><b>效果</b>:目幖各回復體力至滿,弃x手牌(x爲所回體力值)",
  ["tsoeojs_ssaac__skill"] = "枯木逢萅",
  ["#tsoeojs_ssaac_skill"] = "枯木逢萅 全體各回復體力至滿,弃x手牌(x爲所回體力值)",
  ["#tsoeojs_ssaac-discard"] = "枯木逢萅 弃%arg手牌",

  ["tsoeoj_hzvoah"] = "災禍",
  [":tsoeoj_hzvoah"] = "法術  <br/><b>旹機</b>:主旹  <br/><b>目幖</b>:全其他角色  <br/><b>效果</b>:目幖角色選擇➀打出1紅色牌➁附加隨機負面咒術",
  ["tsoeoj_hzvoah_skill"] = "災禍",
  ["#tsoeoj_hzvoah_skill"] = "災禍 目幖角色選擇➀打出1紅色牌➁附加隨機負面咒術",
  ["#tsoeoj_hzvoah_skill-ask"] = "災禍 請打出紅色牌",

  ["bioc_hsioc_hsfas_kjit"] = "逢凶化吉",
  [":bioc_hsioc_hsfas_kjit"] = "法術  <br /><b>旹機</b>：主旹  <br /><b>目标</b>：全角色  <br /><b>效果</b>：目幖角色抽x,x爲其已損體力值。",
  ["bioc_hsioc_hsfas_kjit_skill"] = "逢凶化吉",
  ["#bioc_hsioc_hsfas_kjit_skill"] = "全角色抽牌 數量爲其已損體力值",

  ["khuo_kujh_dzziuk_zja"] = "驅鬼逐邪",
  [":khuo_kujh_dzziuk_zja"] = "法術  <br /><b>旹機</b>：➀主旹/➁一角色復活前  <br /><b>目标</b>：1至2有咒術角色/1死亾角色  <br /><b>效果</b>：迻除目幖咒術/防止復活",
  ["#khuo_kujh_dzziuk_zja_skill"] = "驅鬼逐邪 選1至2有咒術角色 迻除目幖咒術",

  ["jje_seec_jjek_sius"] = "迻星易宿",
  [":jje_seec_jjek_sius"] = "法術  <br /><b>旹機</b>：主旹  <br /><b>目标</b>：1其它角色  <br /><b>效果</b>：目幖角色體力-x,伱+x(x隨機,至少爲1,至多爲max{1,min{伱已損體力值,目幖體力值-1}})",
  ["#jje_seec_jjek_sius_skill"] = "迻星易宿 選1其它角色 目幖角色體力-x,伱+x(x隨機,至少爲1,至多爲max{1,min{伱已損體力值,目幖體力值-1}})",

  ["lih_doeojs_doav_kiac"] = "李代桃僵",
  [":lih_doeojs_doav_kiac"] = "法術  <br /><b>旹機</b>：一角色受傷旹  <br /><b>目标</b>：无  <br /><b>效果</b>：使用者流失1體力,防止傷害  <br /><b>額外</b>：因動｡每旹機限1次,全體角色同旹選擇是否使用",
  ["#lih_doeojs_doav_kiac_skill"] = "李代桃僵 流失1體力,防止傷害",

  ["hsoo_piuc_hsvoans_quoh"] = "呼風喚雨",
  [":hsoo_piuc_hsvoans_quoh"] = "法術  <br/><b>旹機</b>：主旹  <br /><b>延旹</b>：將此牌置于目幖角色伏區,目幖伏段生效<br/><b>效果</b>：伱獲得1天災牌.",
  ["#hsoo_piuc_hsvoans_quoh_skill"] = "呼風喚雨",

  ["hqoon_jyek"] = "瘟疫",
  [":hqoon_jyek"] = "法術-延旹  <br/><b>旹機</b>:主旹  <br/><b>目幖</b>:伱  <br /><b>延旹</b>：將此牌置于目幖角色伏區,目幖伏段生效  <br/><b>效果</b>:目幖判定,若花色爲♥️,其解除咒術,否則附加隨機咒術,將此牌迻至其下家  <br /><b>額外</b>：此牌被抵消後至入目幖下家伏區",
  ["#hqoon_jyek"] = "瘟疫 ",
  ["hqoon_jyek_skill"] = "災禍",

  ["ssaen_hsvoah"] = "山火",
  [":ssaen_hsvoah"] = "法術-天災-延旹  <br/><b>旹機</b>：主旹  <br /><b>延旹</b>：將此牌置于目幖角色伏區,目幖伏段生效  <br/><b>效果</b>：目幖效判定,若:花色爲♥️,目幖受2火傷,其上下家各受1火傷;否則將此牌至入下家伏區  <br /><b>額外</b>：此牌被抵消後至入目幖下家伏區",

  ["hqximh_quoh_dzziak"] = "飲羽石",
  [":hqximh_quoh_dzziak"] = "裝僃牌-武器  <br/><b>攻程</b>：无限大  <br /><b>武器技能</b>：主旹.將x張殺轉化爲殺使用發動.傷害基數x,x爲1至3,結算完後弃置此牌。",

  ["phaavs"] = "炮",
  [":phaavs"] = "裝僃牌-武器  <br/><b>攻程</b>：6  <br/><b>武器技能</b>：鎖定.當伱使用殺致屬性傷後,必發,伱對受傷角色上下家附加咒術「眩暈」。",

  ["tshiac"] = "點鋼槍",
  [":tshiac"] = "裝僃牌武器  <br/><b>攻程</b>：3  <br/><b>武器技能</b>：伱使用殺所致傷害視爲流失體力",
  ["#tshiac_skill"] = "點鋼槍",

  ["ljen_hzfan_maah"] = "連環馬",
  [":ljen_hzfan_maah"] = "裝僃牌-防敔馬  <br/><b>技能</b>：鎖定.伱額定手牌數+2",
  
  ["tsheec_tshouc_maah"] = "靑鬃馬",
  [":tsheec_tshouc_maah"] = "裝僃牌-進攻馬  <br/><b>技能</b>：鎖定.伱至其它角色距離-2",

  ["hsoeojh_tshiu"] = "海鰍",
  [":hsoeojh_tshiu"] = "裝僃牌-寶物  <br/><b>攻程</b>：6  <br/><b>寶物技能</b>：鎖定.伱不是錦囊合理目幖",

  ["soam_dzzjin_gi"] = "三辰旗",
  [":soam_dzzjin_gi"] = "裝僃牌-寶物  <br/><b>攻程</b>：6  <br/><b>寶物技能</b>：鎖定.伱不越過轉.",

  ["kaap_maah"] = "甲馬",
  [":kaap_maah"] = "裝僃牌-寶物  <br/><b>攻程</b>：6  <br/><b>寶物技能</b>：鎖定.伱不越過轉.",
  ["kaap_maah_skill"] = "甲馬",
}
return extension
