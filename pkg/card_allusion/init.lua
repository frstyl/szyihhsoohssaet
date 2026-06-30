local extension = Package:new("card_allusion", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/card_allusion/skills")

Fk:loadTranslationTable{
  ["card_allusion"] = "水滸牌-事件",
  ["allusion"] = "事件牌",
}

---裝僃牌?

local liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac = fk.CreateCard{
  name = "liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac",
  type = Card.TypeTrick,
  skill = "liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac_skill",
  is_passive = true,
  special_skills ={"bvoat_toav_siac_dzsios"},
}
extension:loadCardSkels {
liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac,
}
extension:addCardSpec("liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac",Card.Diamond, 13)
Fk:loadTranslationTable{
  ["liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac"] = "梁山好漢劫法場",
  [":liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac"] = "事件牌  <br /><b>大鬧江州</b>: 一角色轉終旹,若其下家牢,對其使用迻除牢。  <br /><b>拔刀相助</b>: 主旹,弃1名角色伏區1延旹錦囊。",
  ["liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac_skill"] = "梁山好漢劫法場",

  ["doar_nnaavs_kaoc_tsziu"] = "大鬧江州",
  ["#doar_nnaavs_kaoc_tsziu"] = "大鬧江州 是否解救%src", 

  ["bvoat_toav_siac_dzsios"] = "拔刀相助",
  ["#bvoat_toav_siac_dzsios"] = "拔刀相助 弃此牌与1其它角色伏區1延旹牌",
}

local zjim_jiac_lou_deej_puad_szi = fk.CreateCard{
  name = "zjim_jiac_lou_deej_puad_szi",
  type = Card.TypeTrick,
  skill = "zjim_jiac_lou_deej_puad_szi_skill",--笑黃巢
  is_passive = true,
  special_skills ={"kiat_koan_nzi_khih"},
}
extension:loadCardSkels {
zjim_jiac_lou_deej_puad_szi,
}
extension:addCardSpec("zjim_jiac_lou_deej_puad_szi",Card.Spade, 7)
Fk:loadTranslationTable{
  ["zjim_jiac_lou_deej_puad_szi"] = "潯陽樓提反䛐",
  [":zjim_jiac_lou_deej_puad_szi"] = "事件牌  <br /><b>笑黃巢</b>: 伱使用酒後對伱使用,伱抽x(x爲存活反賊數)  <br /><b>揭竿而起</b>: 主旹,伱可選1其它有手牌角色,伱弃此牌,令其弃1手牌",


  ["sjevs_hzvoac_dzaav"] = "笑黃巢",
  ["#sjevs_hzvoac_dzaav"] = "笑黃巢 使用潯陽樓提反䛐 抽%arg",

  ["kiat_koan_nzi_khih"] = "揭竿而起",
  ["#kiat_koan_nzi_khih"] = "揭竿而起 令1其它角色弃1手牌",
  -- ["#kiat_koan_nzi_khih-choose"] = "揭竿而起 選擇弃牌角色",
  ["#kiat_koan_nzi_khih-discard"] = "揭竿而起 選擇弃牌1",
}


local dzzi_tshjen_doavs_kaap = fk.CreateCard{
  name = "dzzi_tshjen_doavs_kaap",
  type = Card.TypeTrick,
  skill = "dzzi_tshjen_doavs_kaap_skill",
  special_skills ={"thou_theen_hzvoans_nzjit"},
  is_passive = true,
  }
extension:loadCardSkels {
dzzi_tshjen_doavs_kaap,
}
extension:addCardSpec("dzzi_tshjen_doavs_kaap",Card.Club, 12)
Fk:loadTranslationTable{
  ["dzzi_tshjen_doavs_kaap"] = "時遷盜甲",
  [":dzzi_tshjen_doavs_kaap"] = "事件牌  <br /><b>狸貓九變</b>: 一因敵爲資結算後,對一其它角色裝僃防具者使用,獲取其防具  <br /><b>偷天換日</b>: 主旹,伱可以此牌交換牌堆頂1牌",

  ["dzzi_tshjen_doavs_kaap_skill"] = "時遷盜甲",
  [":dzzi_tshjen_doavs_kaap_skill"] = "時遷盜甲",
  
  ["li_mxev_kiuh_pxens"] = "狸貓九變",
  ["#li_mxev_kiuh_pxens"] = "狸貓九變 獲取其它角色防具",

  ["thou_theen_hzvoans_nzjit"] = "偷天換日",
  ["#thou_theen_hzvoans_nzjit"] = "主旹,以此牌交換牌堆頂1牌",
}


local soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh = fk.CreateCard{
  name = "soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh",
  type = Card.TypeTrick,
  skill = "soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh_skill",
  is_passive = true,
  special_skills ={"sjen_nzjin_tszjih_loos"},
}
extension:loadCardSkels {
soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh,
}
extension:addCardSpec("soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh",Card.Heart, 2)
Fk:loadTranslationTable{
  ["soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh"] = "宋公明遇九天玄女",
  [":soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh"] = "事件牌  <br /><b>神授天書</b>: 伱受傷旹使用,防止傷害  <br /><b>仙人指路</b>: 主旹,伱可選1其它有手牌角色,伱弃此牌,獲取其1手牌",

  ["soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh_skill"] = "神授天書",

  ["zzjin_dzzius_theen_szio"] = "神授天書",
  ["#zzjin_dzzius_theen_szio"] = "神授天書 使用宋公明遇九天玄女 防止傷害",

  ["sjen_nzjin_tszjih_loos"] = "仙人指路",
  ["#sjen_nzjin_tszjih_loos"] = "仙人指路 獲取其它角色1手牌",
}


local tous_puap_phoas_koav_ljem = fk.CreateCard{
  name = "tous_puap_phoas_koav_ljem",
  type = Card.TypeTrick,
  is_damage_card = true,
  skill = "tous_puap_phoas_koav_ljem_skill",
  is_passive = true,
}
extension:loadCardSkels {
tous_puap_phoas_koav_ljem,
}
extension:addCardSpec("tous_puap_phoas_koav_ljem",Card.Heart, 8)
Fk:loadTranslationTable{
  ["tous_puap_phoas_koav_ljem"] = "鬥法破高廉",
  [":tous_puap_phoas_koav_ljem"] = "事件牌  <br /><b>高唐鬥法</b>: 任意角色的判定牌结果为黑桃且生效后，对除你以外任一角色使用。目标角色受到1点雷电伤害。  <br /><b>斗轉星迻 </b>: 任意角色的判定牌生效前，你可以用这张牌替换之。",
  ["tous_puap_phoas_koav_ljem_skill"] = "鬥法破高廉",

  ["koav_doac_tous_puap"] = "高唐鬥法：",
  ["#koav_doac_tous_puap"] = "高唐鬥法： 使用鬥法破高廉 選擇一其他角色，伱予其1雷傷",

  ["touh_ttwenh_seec_jje"] = "斗轉星迻",
  ["#touh_ttwenh_seec_jje"] = "斗轉星迻 以鬥法破高廉 交換%dest 之%arg判定牌",
}

local tsyis_toah_tsiach_moon_zzjin = fk.CreateCard{
  name = "tsyis_toah_tsiach_moon_zzjin",
  type = Card.TypeTrick,
  skill = "tsyis_toah_tsiach_moon_zzjin_skill",
  is_passive = true,
}
extension:loadCardSkels {
tsyis_toah_tsiach_moon_zzjin,
}
extension:addCardSpec("tsyis_toah_tsiach_moon_zzjin",Card.Club, 9)
Fk:loadTranslationTable{
  ["tsyis_toah_tsiach_moon_zzjin"] = "醉打蔣門神",
  [":tsyis_toah_tsiach_moon_zzjin"] = "事件牌  <br /><b>快活林</b>: 伱使用酒後，對伱使用,伱下次使用殺傷害基數+1  <br /><b>无酒不歡</b>: 伱轉外,1酒進入弃牌堆,你可以此牌替換之。",

  ["khfar_hzvoat_ljim"] = "快活林",
  ["#khfar_hzvoat_ljim"] = "快活林 令伱下1殺傷害基數+1",
  ["@khfar_hzvoat_ljim-turn"] = "快活林",

  ["muo_tsiuh_piu_hsvoan"] = "无酒不歡",
  ["#muo_tsiuh_piu_hsvoan"] = "无酒不歡 以 醉打蔣門神 交換 %arg",
  ["#muo_tsiuh_piu_hsvoan-choose"] = "无酒不歡 選擇1酒",
}

local ttxes_tshuoh_ssaac_dzzjin_koac = fk.CreateCard{
  name = "ttxes_tshuoh_ssaac_dzzjin_koac",
  type = Card.TypeTrick,
  skill = "ttxes_tshuoh_ssaac_dzzjin_koac_skill",
  is_passive = true,
  -- special_skills ={"giac_tshuoh_hzoav_dvoat"},
}
extension:loadCardSkels {
ttxes_tshuoh_ssaac_dzzjin_koac,
}
extension:addCardSpec("ttxes_tshuoh_ssaac_dzzjin_koac",Card.Diamond, 10)
Fk:loadTranslationTable{
  ["ttxes_tshuoh_ssaac_dzzjin_koac"] = "智取生辰綱",
  [":ttxes_tshuoh_ssaac_dzzjin_koac"] = "事件牌  <br /><b>七星聚義</b>: 任一角色使用迷後,對1其它角色伏區有生辰綱者使用｡廢置生辰綱,伱抽5  <br /><b>彊取𠢕敚</b>: 主旹,伱可選1其它有手牌角色,伱弃此牌,令其弃1手牌",


  ["tshjit_seec_dzuoh_cxes"] = "七星聚義",
  ["#tshjit_seec_dzuoh_cxes"] = "七星聚義 智取生辰綱" ,

  ["giac_tshuoh_hzoav_dvoat"] = "彊取𠢕敚",
  ["#giac_tshuoh_hzoav_dvoat-invoke"] = "彊取𠢕敚 弃智取生辰綱 獲取 %src %arg牌",
}


local hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac = fk.CreateCard{
  name = "hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac",
  type = Card.TypeTrick,
  skill = "hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac_skill",
  is_passive = true,
}
extension:loadCardSkels {
hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac,
}
extension:addCardSpec("hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac",Card.Spade, 11)
Fk:loadTranslationTable{
  ["hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac"] = "花和尙痛打小霸王",
  [":hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac"] = "事件牌  <br /><b>憐香惜玉</b>: 其它角色A對B致傷旹使用,A自弃2  <br /><b>一錯再錯</b>: 伱對其它角色致傷後可弃置此牌伱抽1。",
  ["hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac_skill"] = "鬥法破高廉",

  ["leen_hsiac_sjek_ciok"] = "憐香惜玉：",
  ["#leen_hsiac_sjek_ciok"] = "憐香惜玉： 使用 花和尙痛打小霸王 令 %src 弃2",

  ["hqjit_tshoak_tsoeojs_tshoak"] = "一錯再錯",
  ["#hqjit_tshoak_tsoeojs_tshoak-same"] = "一錯再錯 棄 花和尙痛打小霸王 弃%src",
  ["#hqjit_tshoak_tsoeojs_tshoak-n"] = "一錯再錯 棄 花和尙痛打小霸王 抽%arg",
}


local quac_boa_thoom_hsoojh_szyet_piuc_dzjec = fk.CreateCard{
  name = "quac_boa_thoom_hsoojh_szyet_piuc_dzjec",
  type = Card.TypeTrick,
  -- skill = "quac_boa_thoom_hsoojh_szyet_piuc_dzjec",
  is_passive = true,
}
extension:loadCardSkels {
quac_boa_thoom_hsoojh_szyet_piuc_dzjec,
}
extension:addCardSpec("quac_boa_thoom_hsoojh_szyet_piuc_dzjec",Card.Club, 1)
Fk:loadTranslationTable{
  ["quac_boa_thoom_hsoojh_szyet_piuc_dzjec"] = "王婆貪賄說風情",
  [":quac_boa_thoom_hsoojh_szyet_piuc_dzjec"] = "事件牌  <br /><b>王婆說媒</b>: A殺死B後,對A与C使用,交換A与C全部手牌裝僃,伱獲取A之1牌.A/B/C皆不爲伱.  <br /><b>魚水之歡</b>: 一角色A防具進入弃牌堆後,伱可弃此牌,令A回1",

  ["cio_szyih_tszi_hsvoan"] = "魚水之歡",

  ["quac_boa_szyet_mooj"] = "王婆說媒",
}







return extension

