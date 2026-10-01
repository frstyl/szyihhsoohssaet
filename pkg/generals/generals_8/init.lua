local extension = Package:new("generals_8")
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/generals/generals_8/skills")

Fk:loadTranslationTable{
["generals_8"] = "71~80",
-- ["pujh"] = "匪",
-- ["kvoan"] = "官",
-- ["mjin"] = "民",
-- ["tsiacs"] = "將",
}

-- 71. 第七十回　忠義堂石碣受天文　梁山泊英雄驚惡夢
-- 72. 第七十一回　梁山泊英雄排座次　宋公明慷慨話宿願
-- 73. 第七十二回　柴進簪花入禁院　李逵元夜鬧東京
General:new(extension, "lih_ssxi_ssxi", "mjin", 3,3,General.Female):addSkills{"tshjimssjim", "jinhkeens"}
Fk:loadTranslationTable{
["lih_ssxi_ssxi"] = "李師師",
["#lih_ssxi_ssxi"] = "煙花",
["designer:lih_ssxi_ssxi"] = "設計",
["cv:lih_ssxi_ssxi"] = "配音",
["illustrator:lih_ssxi_ssxi"] = "畫師",
["~lih_ssxi_ssxi"] = "a",
}

General:new(extension, "jiac_tsjenh", "kvoan", 2,2,General.Agender):addSkills{"jiuhpaar", "dzjiskik","biuknzjen"}  --2上限?
Fk:loadTranslationTable{
["jiac_tsjenh"] = "楊戩",
["#jiac_tsjenh"] = "太尉",
["designer:jiac_tsjenh"] = "設計",
["cv:jiac_tsjenh"] = "配音",
["illustrator:jiac_tsjenh"] = "畫師",
["~jiac_tsjenh"] = "a",
}
-- 74. 第七十三回　黑旋風喬捉鬼　梁山泊雙獻頭

-- 75. 第七十四回　燕青智撲「擎天柱」　李逵壽張喬坐衙
--擎天柱任原
local nzjims_cuan = General:new(extension, "nzjims_cuan", "tsiacs", 5)
nzjims_cuan:addSkills{"szjetloojs"}  --6? --,"tssaacljis"
Fk:loadTranslationTable{
["nzjims_cuan"] = "任原",
["#nzjims_cuan"] = "擎天柱",
["designer:nzjims_cuan"] = "設計",
["cv:nzjims_cuan"] = "配音",
["illustrator:nzjims_cuan"] = "畫師",
["~nzjims_cuan"] = "a",
}

--御史大夫崔靖 太尉陳宗善
General:new(extension, "tshooj_dzjech", "kvoan", 3):addSkills{"ddiqtszjecs","kvoanqpiuc"}
Fk:loadTranslationTable{
["tshooj_dzjech"] = "催靖",
["#tshooj_dzjech"] = "御史大夫",
["designer:tshooj_dzjech"] = "設計",
["cv:tshooj_dzjech"] = "配音",
["illustrator:tshooj_dzjech"] = "畫師",
["~tshooj_dzjech"] = "a",
}

General:new(extension, "ddxin_tsooc_dzzjenh", "kvoan", 3):addSkills{"tszihkvoa","hzoojqkaas"}
Fk:loadTranslationTable{
["ddxin_tsooc_dzzjenh"] = "陳宗善",
["#ddxin_tsooc_dzzjenh"] = "陳太尉",
["designer:ddxin_tsooc_dzzjenh"] = "設計",
["cv:ddxin_tsooc_dzzjenh"] = "配音",
["illustrator:ddxin_tsooc_dzzjenh"] = "畫師",
["~ddxin_tsooc_dzzjenh"] = "a",
}
-- 76. 第七十五回　活閻羅倒船偷御酒　黑旋風扯詔罵欽差
--張叔夜
-- 77. 第七十六回　吳加亮布四斗五方旗　宋公明排九宮八卦陣

-- 78. 第七十七回　梁山泊十面埋伏　宋公明兩贏童貫
--段鹏舉、陈翥、吴秉彝、韩天麟、李明、王義、馬萬里、周信
General:new(extension, "__douc_kvoans", "kvoan", 3,4):addSkills{"tszjecqbuat","hqoavhsiacs"}
local hzfanskvoan = General:new(extension, "hzfanskvoan__douc_kvoans", "kvoan", 2,2, General.Agender)  --??
hzfanskvoan:addSkills { "tszjecqbuat", "hqoavhsiacs","quacqhzfans" }
hzfanskvoan.hidden = true

Fk:loadTranslationTable{
["__douc_kvoans"] = "童貫",
["#__douc_kvoans"] = "廣陽郡王",
["designer:__douc_kvoans"] = "設計",
["cv:__douc_kvoans"] = "配音",
["illustrator:__douc_kvoans"] = "畫師",
["~__douc_kvoans"] = "歬有伏兵後有追兵似此爲之奈何",

["hzfanskvoan"] = "宦官",

["hzfanskvoan__douc_kvoans"] = "童貫",
["#hzfanskvoan__douc_kvoans"] = "廣陽郡王",
-- ["designer:hzfanskvoan__douc_kvoans"] = "設計",
-- ["cv:hzfanskvoan__douc_kvoans"] = "配音",
-- ["illustrator:hzfanskvoan__douc_kvoans"] = "畫師",
["~hzfanskvoan__douc_kvoans"] = "歬有伏兵後有追兵似此爲之奈何",

}
-- 79. 第七十八回　十節度議取梁山泊　宋公明一敗高太尉
--十節度   梅展-三尖两刃刀  李从吉 徐京 楊溫-攔路虎 張開-獨行虎 王文德-搶?九環刀  荆忠-大杆刀
-- 黨世英 黨世雄 牛邦喜
--聞煥章

General:new(extension, "toach_szjer_qiuc", "kvoan", 4):addSkills{"tszjechljet",}
Fk:loadTranslationTable{
["toach_szjer_qiuc"] = "党世雄",
["#toach_szjer_qiuc"] = "万夫不當",
["designer:toach_szjer_qiuc"] = "設計",
["cv:toach_szjer_qiuc"] = "配音",
["illustrator:toach_szjer_qiuc"] = "畫師",
["~toach_szjer_qiuc"] = "",
}

General:new(extension, "toach_szjer_hqrac", "kvoan", 5):addSkills{"kaamqprac"} --"hzfacqtszhioc" "ddikddaos"
Fk:loadTranslationTable{
["toach_szjer_hqrac"] = "党世英",
["#toach_szjer_hqrac"] = "万夫不當",
["designer:toach_szjer_hqrac"] = "設計",
["cv:toach_szjer_hqrac"] = "配音",
["illustrator:toach_szjer_hqrac"] = "畫師",
["~toach_szjer_hqrac"] = "",
}



General:new(extension, "liu_miucs_lioc", "kvoan", 4):addSkills{"crakljin","liocqhquj"}
Fk:loadTranslationTable{
["liu_miucs_lioc"] = "劉夢龍",
["#liu_miucs_lioc"] = "黑龍",
["designer:liu_miucs_lioc"] = "設計",
["cv:liu_miucs_lioc"] = "配音",
["illustrator:liu_miucs_lioc"] = "畫師",
["~liu_miucs_lioc"] = "火 好大之火",
}


General:new(extension, "quac_hsvans", "kvoan", 5):addSkills{"gianskoot","tssisnzjins"}  --teejhlik
Fk:loadTranslationTable{
["quac_hsvans"] = "王渙",
["#quac_hsvans"] = "風流老將",
["designer:quac_hsvans"] = "設計",
["cv:quac_hsvans"] = "配音",
["illustrator:quac_hsvans"] = "畫師",
["~quac_hsvans"] = "廉頗老矣尙能飯否",
}

General:new(extension, "zio_krac", "kvoan", 4):addSkills{"kyinqszjer","keekjyer"}
Fk:loadTranslationTable{
["zio_krac"] = "徐京",
["#zio_krac"] = "",
["designer:zio_krac"] = "設計",
["cv:zio_krac"] = "配音",
["illustrator:zio_krac"] = "畫師",
["~zio_krac"] = "｡",
}

--左
General:new(extension, "ttiac_khoeoj", "kvoan", 5):addSkills{"tthaakddxins"}
Fk:loadTranslationTable{
["ttiac_khoeoj"] = "張開",
["#ttiac_khoeoj"] = "獨行虎",
["designer:ttiac_khoeoj"] = "設計",
["cv:ttiac_khoeoj"] = "配音",
["illustrator:ttiac_khoeoj"] = "畫師",
["~ttiac_khoeoj"] = "｡",
}

General:new(extension, "jiac_hqoon", "kvoan", 5):addSkills{ "khioktshuoh"} 
Fk:loadTranslationTable{
["jiac_hqoon"] = "楊溫",
["#jiac_hqoon"] = "攔路虎",
["designer:jiac_hqoon"] = "設計",
["cv:jiac_hqoon"] = "配音",
["illustrator:jiac_hqoon"] = "畫師",
["~jiac_hqoon"] = "｡",
}



General:new(extension, "quac_mun_toeok", "kvoan", 5):addSkills{"ddiuktsjins" }
Fk:loadTranslationTable{
["quac_mun_toeok"] = "王文德",
["#quac_mun_toeok"] = "九環刀",
["designer:quac_mun_toeok"] = "設計",
["cv:quac_mun_toeok"] = "配音",
["illustrator:quac_mun_toeok"] = "畫師",
["~quac_mun_toeok"] = "｡",
}

General:new(extension, "mooj_ttxenh", "kvoan", 5):addSkills{"tssaamhbuat"}
Fk:loadTranslationTable{
["mooj_ttxenh"] = "梅展",
["#mooj_ttxenh"] = "三尖两刃刀",
["designer:mooj_ttxenh"] = "設計",
["cv:mooj_ttxenh"] = "配音",
["illustrator:mooj_ttxenh"] = "畫師",
["~mooj_ttxenh"] = "｡",
}
--又
General:new(extension, "hzoan_dzoon_poavh", "kvoan", 5):addSkills{"keektszjens","kaavqprac"}
Fk:loadTranslationTable{
["hzoan_dzoon_poavh"] = "韓存保",
["#hzoan_dzoon_poavh"] = "鐵戟銀鉤",
["designer:hzoan_dzoon_poavh"] = "設計",
["cv:hzoan_dzoon_poavh"] = "配音",
["illustrator:hzoan_dzoon_poavh"] = "畫師",
["~hzoan_dzoon_poavh"] = "昰一戰也算是䀆興",
}
General:new(extension, "lih_ddiac_kjit", "kvoan", 5):addSkills{"phiuskun","hqoavqljet"}  --
Fk:loadTranslationTable{
["lih_ddiac_kjit"] = "李从吉",
["#lih_ddiac_kjit"] = "",
["designer:lih_ddiac_kjit"] = "設計",
["cv:lih_ddiac_kjit"] = "配音",
["illustrator:lih_ddiac_kjit"] = "畫師",
["~lih_ddiac_kjit"] = "｡",
}

General:new(extension, "hzaoc_cuan_ttxins", "kvoan", 5):addSkills{"muohbxis","laachtsjens"}
Fk:loadTranslationTable{
["hzaoc_cuan_ttxins"] = "項元鎮",
["#hzaoc_cuan_ttxins"] = "七星弓",
["designer:hzaoc_cuan_ttxins"] = "設計",
["cv:hzaoc_cuan_ttxins"] = "配音",
["illustrator:hzaoc_cuan_ttxins"] = "畫師",
["~hzaoc_cuan_ttxins"] = "昰火賊寇竟也臥虎藏龍",
}


General:new(extension, "krac_ttiuc", "kvoan", 5):addSkills{"kxevqgxes","tszhiocqhzaems"}
Fk:loadTranslationTable{
["krac_ttiuc"] = "荊忠",
["#krac_ttiuc"] = "大杆刀",
["designer:krac_ttiuc"] = "設計",
["cv:krac_ttiuc"] = "配音",
["illustrator:krac_ttiuc"] = "畫師",
["~krac_ttiuc"] = "｡",
}

General:new(extension, "mun_hsvoans_tsziac", "kvoan", 3):addSkills{"loonsszjer","ljemhthoojs"}
Fk:loadTranslationTable{
["mun_hsvoans_tsziac"] = "聞煥章",
["#mun_hsvoans_tsziac"] = "參謀",
["designer:mun_hsvoans_tsziac"] = "設計",
["cv:mun_hsvoans_tsziac"] = "配音",
["illustrator:mun_hsvoans_tsziac"] = "畫師",
["~mun_hsvoans_tsziac"] = "惜不用吾計",
}


General:new(extension, "ciu_paoc_hsih", "kvoan", 5):addSkills{"ljenqtsziuq"}
Fk:loadTranslationTable{
["ciu_paoc_hsih"] = "牛邦喜",
["#ciu_paoc_hsih"] = "統軍",
["designer:ciu_paoc_hsih"] = "設計",
["cv:ciu_paoc_hsih"] = "配音",
["illustrator:ciu_paoc_hsih"] = "畫師",
["~ciu_paoc_hsih"] = "",
}

--韓忠彥 鄭居忠 余深
--剜心王瑾 张叔夜
--丘嶽 周昂  三停刀 劈棱简
General:new(extension, "khiu_caok", "kvoan", 4):addSkills{"doachddio"} 
Fk:loadTranslationTable{
["khiu_caok"] = "丘嶽",  --?岳
["#khiu_caok"] = "統軍",
["designer:khiu_caok"] = "設計",
["cv:khiu_caok"] = "配音",
["illustrator:khiu_caok"] = "畫師",
["~khiu_caok"] = "",
}

General:new(extension, "tsziu_coac", "kvoan", 5):addSkills{"soavhdzjinh"} 
Fk:loadTranslationTable{
["tsziu_coac"] = "周昂",  --?岳
["#tsziu_coac"] = "統軍",
["designer:tsziu_coac"] = "設計",
["cv:tsziu_coac"] = "配音",
["illustrator:tsziu_coac"] = "畫師",
["~tsziu_coac"] = "",
}
--葉春 艁船

-- 80. 第七十九回　劉唐放火燒戰船　宋江兩敗高太尉
-- 81. 第八十回　張順鑿漏海鰍船　宋江三敗高太尉

return extension
