local extension = Package:new("generals_2")
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/generals/generals_2/skills")

Fk:loadTranslationTable{
["generals_2"] = "11~20",
-- ["pujh"] = "匪",
-- ["kvoan"] = "官",
-- ["mjin"] = "民",
-- ["tsiacs"] = "將",
}


--12 梁山泊林沖落草　汴京城楊志賣刀
General:new(extension, "jiac_tszis", "kvoan", 4):addSkills{"hzeethzoac","syenqhquj"}
Fk:loadTranslationTable{
["jiac_tszis"] = "楊志",  --同
["#jiac_tszis"] = "靑面獸",
["designer:jiac_tszis"] = "設計",
["cv:jiac_tszis"] = "配音",
["illustrator:jiac_tszis"] = "畫師",
["~jiac_tszis"] = "无顏面對列祖列宗",

["sziac"] = "商",
}

General:new(extension, "sziac__jiac_tszis", "kvoan", 5):addSkills{"maestoav","phiocqmoac"}  --賣刀楊志
Fk:loadTranslationTable{
["sziac__jiac_tszis"] = "楊志",  --同
["#sziac__jiac_tszis"] = "靑面獸",
["designer:sziac__jiac_tszis"] = "設計",
["cv:sziac__jiac_tszis"] = "配音",
["illustrator:sziac__jiac_tszis"] = "畫師",
["~sziac__jiac_tszis"] = "无顏面對列祖列宗",

["sziac"] = "商",
}

General:new(extension, "ciu_nzjis", "mjin", 4):addSkills{"zjimqkhrak"}
Fk:loadTranslationTable{
["ciu_nzjis"] = "牛二",  --同
["#ciu_nzjis"] = "沒毛大蟲",
["designer:ciu_nzjis"] = "設計",
["cv:ciu_nzjis"] = "配音",
["illustrator:ciu_nzjis"] = "畫師",
["~ciu_nzjis"] = "好刀",
}

General:new(extension, "liac_szjer_gxet", "kvoan", 3):addSkills{"ssiuqkfat","liuqsziuh"}
Fk:loadTranslationTable{
["liac_szjer_gxet"] = "梁世杰",  --同
["#liac_szjer_gxet"] = "樑中書",
["designer:liac_szjer_gxet"] = "設計",
["cv:liac_szjer_gxet"] = "配音",
["illustrator:liac_szjer_gxet"] = "畫師",
["~liac_szjer_gxet"] = "phu",
}
-- 13 青面獸北京斗武　急先鋒東郭爭功
--周謹
General:new(extension, "soak_tthxev", "kvoan", 4):addSkills {"punsjioch", "tszhiocqphioc" }
Fk:loadTranslationTable{
["soak_tthxev"] = "索超",
["#soak_tthxev"] = "急先鋒",
["designer:soak_tthxev"] = "設計",
["cv:soak_tthxev"] = "配音",
["illustrator:soak_tthxev"] = "畫師",
["~soak_tthxev"] = "成也蕭何,敗也蕭何",
}

--14 赤發鬼醉臥靈官殿　晁天王認義東溪村  自此換版本,此上爲一本,自此及
General:new(extension, "tszuo_douc", "kvoan", 4):addSkills{"sjiqkius","cxesszjek"}
Fk:loadTranslationTable{
["tszuo_douc"] = "朱仝",  --同
["#tszuo_douc"] = "美髯公",
["designer:tszuo_douc"] = "設計",
["cv:tszuo_douc"] = "配音",
["illustrator:tszuo_douc"] = "畫師",
["~tszuo_douc"] = "可恨那黑廝",
}

General:new(extension, "looj_hzfac", "kvoan", 4):addSkills{"tszjinshzaek","koostsiocs"}
Fk:loadTranslationTable{
["looj_hzfac"] = "雷橫",  --同
["#looj_hzfac"] = "美髯公",
["designer:looj_hzfac"] = "設計",
["cv:looj_hzfac"] = "配音",
["illustrator:looj_hzfac"] = "畫師",
["~looj_hzfac"] = "終究其不如人",
}
--14 赤發鬼醉臥靈官殿　晁天王認義東溪村
General:new(extension, "liu_doac", "tsiacs", 5):addSkills { "seenqtoeoc","kooqtsjins" }
Fk:loadTranslationTable{
["liu_doac"] = "劉唐",
["#liu_doac"] = "赤髮鬼",
["designer:liu_doac"] = "設計",
["cv:liu_doac"] = "配音",
["illustrator:liu_doac"] = "畫師",
["~liu_doac"] = "如此身死,眞是委屈",
}

General:new(extension, "ddxev_koar", "pujh", 5):addSkills { "kiappoavh","dzzjerdzziu"}
Fk:loadTranslationTable{
["ddxev_koar"] = "晁葢",
["#ddxev_koar"] = "托塔天王",
["designer:ddxev_koar"] = "設計",
["cv:ddxev_koar"] = "配音",
["illustrator:ddxev_koar"] = "畫師",
["~ddxev_koar"] = "如",
}

General:new(extension, "thoeop__ddxev_koar", "tsiacs", 5):addSkills { "szioqnoans","gracqthoeop"} 
Fk:loadTranslationTable{
["thoeop__ddxev_koar"] = "晁葢",
["#thoeop__ddxev_koar"] = "托塔天王",
["designer:thoeop__ddxev_koar"] = "設計",
["cv:thoeop__ddxev_koar"] = "配音",
["illustrator:thoeop__ddxev_koar"] = "畫師",
["~thoeop__ddxev_koar"] = "如",
}

General:new(extension, "coo_jiocs", "mjin", 3):addSkills { "qunsddiu", "hzfektsshaek" }
Fk:loadTranslationTable{
["coo_jiocs"] = "吳用",
["#coo_jiocs"] = "智多星",
["designer:coo_jiocs"] = "設計",
["cv:coo_jiocs"] = "配音",
["illustrator:coo_jiocs"] = "畫師",
["~coo_jiocs"] = "八百里水洦,化作南珂一夢",
}

--15 吳學究說三阮撞籌　公孫勝應七星聚義

General:new(extension, "cuanh_sjevh_nzjis", "mjin", 5):addSkills { "biukkeek" }  
Fk:loadTranslationTable{
["cuanh_sjevh_nzjis"] = "阮小二",
["#cuanh_sjevh_nzjis"] = "立地太歲",
["designer:cuanh_sjevh_nzjis"] = "設計",
["cv:cuanh_sjevh_nzjis"] = "配音",
["illustrator:cuanh_sjevh_nzjis"] = "畫師",
["~cuanh_sjevh_nzjis"] = "不好被勹囗已",
}

General:new(extension, "cuanh_sjevh_cooh", "mjin", 4):addSkills { "hqoeomszjip", "szyihloav" }  
Fk:loadTranslationTable{
["cuanh_sjevh_cooh"] = "阮小五",
["#cuanh_sjevh_cooh"] = "短命三郎",
["designer:cuanh_sjevh_cooh"] = "設計",
["cv:cuanh_sjevh_cooh"] = "配音",
["illustrator:cuanh_sjevh_cooh"] = "畫師",
["~cuanh_sjevh_cooh"] = "人生在世艸木一秌",
}

General:new(extension, "cuanh_sjevh_tshjit", "mjin", 5):addSkills { "doavqthoav"}   
Fk:loadTranslationTable{
["cuanh_sjevh_tshjit"] = "阮小七",
["#cuanh_sjevh_tshjit"] = "𣴠閻羅",
["designer:cuanh_sjevh_tshjit"] = "設計",
["cv:cuanh_sjevh_tshjit"] = "配音",
["illustrator:cuanh_sjevh_tshjit"] = "畫師",
["~cuanh_sjevh_tshjit"] = "",
}

General:new(extension, "cxes__cuanh_sjevh_tshjit", "mjin", 5):addSkills { "cxesljet","kveetmracs" }  
Fk:loadTranslationTable{
["cxes__cuanh_sjevh_tshjit"] = "阮小七",
["#cxes__cuanh_sjevh_tshjit"] = "𣴠閻羅",
["designer:cxes__cuanh_sjevh_tshjit"] = "設計",
["cv:cxes__cuanh_sjevh_tshjit"] = "配音",
["illustrator:cxes__cuanh_sjevh_tshjit"] = "畫師",
["~cxes__cuanh_sjevh_tshjit"] = "",
}

--游兵公孫
General:new(extension, "kouc_soon_szics", "pujh", 3):addSkills { "gxeqmoon", "jjeqseec" }  
Fk:loadTranslationTable{
["kouc_soon_szics"] = "公孫勝",
["#kouc_soon_szics"] = "入雲龍",
["designer:kouc_soon_szics"] = "設計",
["cv:kouc_soon_szics"] = "配音",
["illustrator:kouc_soon_szics"] = "畫師",
["~kouc_soon_szics"] = "天罡䀆已歸天界,地煞還應入地中",
}

--16 楊志押送金銀擔　吳用智取生辰綱
General:new(extension, "baak_szics", "mjin", 3):addSkills { "hzaahjiak", "sziohtoamh" }  
Fk:loadTranslationTable{
["baak_szics"] = "白勝",
["#baak_szics"] = "白日鼠",
["designer:baak_szics"] = "設計",
["cv:baak_szics"] = "配音",
["illustrator:baak_szics"] = "畫師",
["~baak_szics"] = "天罡䀆已歸天界,地煞還應入地中",
}
--17 花和尚單打二龍山　青面獸雙奪寶珠寺

--二龍山 金眼虎鄧龍deocslioc
--何濤hzoaqdoav

General:new(extension, "dzoav_tszjecs", "kvoan", 5):addSkills { "dooqtsoeojh","mvoaqtoav"}
Fk:loadTranslationTable{
["dzoav_tszjecs"] = "曹正",
["#dzoav_tszjecs"] = "操刀鬼",
["designer:dzoav_tszjecs"] = "設計",
["cv:dzoav_tszjecs"] = "配音",
["illustrator:dzoav_tszjecs"] = "畫師",
["~dzoav_tszjecs"] = "平生宰牛殺羊今日命喪屠刀",
}

General:new(extension, "doeocs_lioc", "pujh", 5):addSkills { "peejskfan"}
Fk:loadTranslationTable{
["doeocs_lioc"] = "鄧龍",
["#doeocs_lioc"] = "金眼虎",
["designer:doeocs_lioc"] = "設計",
["cv:doeocs_lioc"] = "配音",
["illustrator:doeocs_lioc"] = "畫師",
["~doeocs_lioc"] = "",
}

--18 美髯公智穩插翅虎　宋公明私放晁天王
General:new(extension, "soocs_kaoc", "kvoan", 5):addSkills { "koamqljim"}
Fk:loadTranslationTable{
["soocs_kaoc"] = "宋江",
["#soocs_kaoc"] = "及旹雨",
["designer:soocs_kaoc"] = "設計",
["cv:soocs_kaoc"] = "配音",
["illustrator:soocs_kaoc"] = "畫師",
["~soocs_kaoc"] = "它日若遂凌雲志 敢笑黃巢不丈夫",
}

--19 林沖水寨大並火　晁蓋梁山小奪泊

General:new(extension, "soocs_muans", "pujh", 5):addSkills { "cijsljet","sjihcxes"}
Fk:loadTranslationTable{
["soocs_muans"] = "宋萬",
["#soocs_muans"] = "雲裏金剛",
["designer:soocs_muans"] = "設計",
["cv:soocs_muans"] = "配音",
["illustrator:soocs_muans"] = "畫師",
["~soocs_muans"] = "義到盡頭終是命",
}

General:new(extension, "dooh_tshjen", "pujh", 4,5):addSkills { "noeophzeen","tshjahhqximh"}
Fk:loadTranslationTable{
["dooh_tshjen"] = "杜遷",
["#dooh_tshjen"] = "摸著天",
["designer:dooh_tshjen"] = "設計",
["cv:dooh_tshjen"] = "配音",
["illustrator:dooh_tshjen"] = "畫師",
["~dooh_tshjen"] = "還是吾若山寨快𣴠",
}

--20 梁山泊義士尊晁蓋　鄆城縣月夜走劉唐
--黃安
--21 虔婆醉打唐牛兒　宋江怒殺閻婆惜
--虔婆閻婆
--唐牛兒
General:new(extension, "leejh__liu_doac", "pujh", 5):addSkills { "gwisleejh", }
Fk:loadTranslationTable{
["leejh__liu_doac"] = "劉唐",
["#leejh__liu_doac"] = "百金還恩",
["designer:leejh__liu_doac"] = "設計",
["cv:leejh__liu_doac"] = "配音",
["illustrator:leejh__liu_doac"] = "畫師",
["~leejh__liu_doac"] = "出城",
}

General:new(extension, "jjem_boa_sjek", "kvoan", 3, 3,General.Female):addSkills { "soakdzoeoj", "tsyisnzjit"}  --醉日閉月
Fk:loadTranslationTable{
["jjem_boa_sjek"] = "閻婆惜",
["#jjem_boa_sjek"] = "花魁",
["designer:jjem_boa_sjek"] = "設計",
["cv:jjem_boa_sjek"] = "配音",
["illustrator:jjem_boa_sjek"] = "畫師",
["~jjem_boa_sjek"] = "宋三郎伱",
}

General:new(extension, "ttiac_mun_quanh", "kvoan", 3):addSkills { "tshjeqhzvoac", "thouqhsiac"}
Fk:loadTranslationTable{
["ttiac_mun_quanh"] = "張文遠",
["#ttiac_mun_quanh"] = "小張三",
["designer:ttiac_mun_quanh"] = "設計",
["cv:ttiac_mun_quanh"] = "配音",
["illustrator:ttiac_mun_quanh"] = "畫師",
["~ttiac_mun_quanh"] = "歡愉嫌夜短 寂寞恨更長",
}


return extension
