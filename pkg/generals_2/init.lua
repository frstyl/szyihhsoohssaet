local extension = Package:new("generals_2")
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/generals_2/skills")

Fk:loadTranslationTable{
["generals_2"] = "11~20",
-- ["pujh"] = "匪",
-- ["kvoan"] = "官",
-- ["mjin"] = "民",
-- ["tsiacs"] = "將",
}


--12 梁山泊林沖落草　汴京城楊志賣刀
General:new(extension, "jiacqtszis", "kvoan", 4):addSkills{"maestoav","phiocqmoac"}  --賣刀楊志
Fk:loadTranslationTable{
["jiacqtszis"] = "楊志",  --同
["#jiacqtszis"] = "靑面獸",
["designer:jiacqtszis"] = "設計",
["cv:jiacqtszis"] = "配音",
["illustrator:jiacqtszis"] = "畫師",
["~jiacqtszis"] = "可恨那黑廝",
}

General:new(extension, "ciuqnzjis", "mjin", 4):addSkills{"zjimqkhrak"}
Fk:loadTranslationTable{
["ciuqnzjis"] = "牛二",  --同
["#ciuqnzjis"] = "沒毛大蟲",
["designer:ciuqnzjis"] = "設計",
["cv:ciuqnzjis"] = "配音",
["illustrator:ciuqnzjis"] = "畫師",
["~ciuqnzjis"] = "好刀",
}

General:new(extension, "liacqttiucszio", "kvoan", 3):addSkills{"ssiuqkfat","liuqsziuh"}
Fk:loadTranslationTable{
["liacqttiucszio"] = "梁世杰",  --同
["#liacqttiucszio"] = "樑中書",
["designer:liacqttiucszio"] = "設計",
["cv:liacqttiucszio"] = "配音",
["illustrator:liacqttiucszio"] = "畫師",
["~liacqttiucszio"] = "phu",
}
-- 13 青面獸北京斗武　急先鋒東郭爭功
--周謹
General:new(extension, "soaktthxev", "kvoan", 4):addSkills {"punsjioch", "tszhiocqphioc" }
Fk:loadTranslationTable{
["soaktthxev"] = "索超",
["#soaktthxev"] = "急先鋒",
["designer:soaktthxev"] = "設計",
["cv:soaktthxev"] = "配音",
["illustrator:soaktthxev"] = "畫師",
["~soaktthxev"] = "成也蕭何,敗也蕭何",
}

--14 赤發鬼醉臥靈官殿　晁天王認義東溪村  自此換版本,此上爲一本,自此及
General:new(extension, "tszioqdouc", "kvoan", 4):addSkills{"sjiqkius","cxesszjek"}
Fk:loadTranslationTable{
["tszioqdouc"] = "朱仝",  --同
["#tszioqdouc"] = "美髯公",
["designer:tszioqdouc"] = "設計",
["cv:tszioqdouc"] = "配音",
["illustrator:tszioqdouc"] = "畫師",
["~tszioqdouc"] = "可恨那黑廝",
}

General:new(extension, "loojqhzfac", "kvoan", 4):addSkills{"tszjinshzaek","koostsiocs"}
Fk:loadTranslationTable{
["loojqhzfac"] = "雷橫",  --同
["#loojqhzfac"] = "美髯公",
["designer:loojqhzfac"] = "設計",
["cv:loojqhzfac"] = "配音",
["illustrator:loojqhzfac"] = "畫師",
["~loojqhzfac"] = "終究其不如人",
}
--14 赤發鬼醉臥靈官殿　晁天王認義東溪村
General:new(extension, "liuqdoac", "tsiacs", 5):addSkills { "seenqtoeoc","kooqszjer" }
Fk:loadTranslationTable{
["liuqdoac"] = "劉唐",
["#liuqdoac"] = "赤髮鬼",
["designer:liuqdoac"] = "設計",
["cv:liuqdoac"] = "配音",
["illustrator:liuqdoac"] = "畫師",
["~liuqdoac"] = "如此身死,眞是委屈",
}

General:new(extension, "ddxevqkoar", "pujh", 5):addSkills { "kiappoavh","dzzjerdzziu"}
Fk:loadTranslationTable{
["ddxevqkoar"] = "晁葢",
["#ddxevqkoar"] = "托塔天王",
["designer:ddxevqkoar"] = "設計",
["cv:ddxevqkoar"] = "配音",
["illustrator:ddxevqkoar"] = "畫師",
["~ddxevqkoar"] = "如",
}

General:new(extension, "thoop__ddxevqkoar", "tsiacs", 5):addSkills { "szioqnoans","gracqthoop"} 
Fk:loadTranslationTable{
["thoop__ddxevqkoar"] = "晁葢",
["#thoop__ddxevqkoar"] = "托塔天王",
["designer:thoop__ddxevqkoar"] = "設計",
["cv:thoop__ddxevqkoar"] = "配音",
["illustrator:thoop__ddxevqkoar"] = "畫師",
["~thoop__ddxevqkoar"] = "如",
}

General:new(extension, "cooqjiocs", "mjin", 3):addSkills { "qunsddiu", "hzfektsshaek" }
Fk:loadTranslationTable{
["cooqjiocs"] = "吳用",
["#cooqjiocs"] = "智多星",
["designer:cooqjiocs"] = "設計",
["cv:cooqjiocs"] = "配音",
["illustrator:cooqjiocs"] = "畫師",
["~cooqjiocs"] = "八百里水洦,化作南珂一夢",
}

--15 吳學究說三阮撞籌　公孫勝應七星聚義

General:new(extension, "cuanhsjevhsnzjis", "mjin", 5):addSkills { "biukkeek" }  
Fk:loadTranslationTable{
["cuanhsjevhsnzjis"] = "阮小二",
["#cuanhsjevhsnzjis"] = "立地太歲",
["designer:cuanhsjevhsnzjis"] = "設計",
["cv:cuanhsjevhsnzjis"] = "配音",
["illustrator:cuanhsjevhsnzjis"] = "畫師",
["~cuanhsjevhsnzjis"] = "不好被勹囗已",
}

General:new(extension, "cuanhsjevhscooh", "mjin", 4):addSkills { "hqoomszjip", "szyihloav" }  
Fk:loadTranslationTable{
["cuanhsjevhscooh"] = "阮小五",
["#cuanhsjevhscooh"] = "短命三郎",
["designer:cuanhsjevhscooh"] = "設計",
["cv:cuanhsjevhscooh"] = "配音",
["illustrator:cuanhsjevhscooh"] = "畫師",
["~cuanhsjevhscooh"] = "人生在世艸木一秌",
}

General:new(extension, "cuanhsjevhtshjit", "mjin", 5):addSkills { "cxesljet","kveetmracs" }  
Fk:loadTranslationTable{
["cuanhsjevhtshjit"] = "阮小七",
["#cuanhsjevhtshjit"] = "𣴠閻羅",
["designer:cuanhsjevhtshjit"] = "設計",
["cv:cuanhsjevhtshjit"] = "配音",
["illustrator:cuanhsjevhtshjit"] = "畫師",
["~cuanhsjevhtshjit"] = "不好被勹囗已",
}

--游兵公孫
General:new(extension, "koucqsoonqszics", "pujh", 3):addSkills { "gxeqmoon", "jjeqseec" }  
Fk:loadTranslationTable{
["koucqsoonqszics"] = "公孫勝",
["#koucqsoonqszics"] = "入雲龍",
["designer:koucqsoonqszics"] = "設計",
["cv:koucqsoonqszics"] = "配音",
["illustrator:koucqsoonqszics"] = "畫師",
["~koucqsoonqszics"] = "天罡䀆已歸天界,地煞還應入地中",
}

--16 楊志押送金銀擔　吳用智取生辰綱
General:new(extension, "baakszics", "mjin", 3):addSkills { "hzaahjiak", "sziohtoamh" }  
Fk:loadTranslationTable{
["baakszics"] = "白勝",
["#baakszics"] = "白日鼠",
["designer:baakszics"] = "設計",
["cv:baakszics"] = "配音",
["illustrator:baakszics"] = "畫師",
["~baakszics"] = "天罡䀆已歸天界,地煞還應入地中",
}
--17 花和尚單打二龍山　青面獸雙奪寶珠寺

--二龍山 金眼虎鄧龍deocslioc
--何濤hzoaqdoav

General:new(extension, "dzoavqtszjecs", "kvoan", 5):addSkills { "dooqtsoeojh"}
Fk:loadTranslationTable{
["dzoavqtszjecs"] = "曹正",
["#dzoavqtszjecs"] = "操刀鬼",
["designer:dzoavqtszjecs"] = "設計",
["cv:dzoavqtszjecs"] = "配音",
["illustrator:dzoavqtszjecs"] = "畫師",
["~dzoavqtszjecs"] = "平生宰牛殺羊今日命喪屠刀",
}
--18 美髯公智穩插翅虎　宋公明私放晁天王
General:new(extension, "soocskaoc", "kvoan", 5):addSkills { "koamqljim"}
Fk:loadTranslationTable{
["soocskaoc"] = "宋江",
["#soocskaoc"] = "及旹雨",
["designer:soocskaoc"] = "設計",
["cv:soocskaoc"] = "配音",
["illustrator:soocskaoc"] = "畫師",
["~soocskaoc"] = "它日若遂凌雲志 敢笑黃巢不丈夫",
}

--19 林沖水寨大並火　晁蓋梁山小奪泊

General:new(extension, "soocsmuans", "pujh", 5):addSkills { "cxestseet"}
Fk:loadTranslationTable{
["soocsmuans"] = "宋萬",
["#soocsmuans"] = "雲裏金剛",
["designer:soocsmuans"] = "設計",
["cv:soocsmuans"] = "配音",
["illustrator:soocsmuans"] = "畫師",
["~soocsmuans"] = "義到盡頭終是命",
}

General:new(extension, "doohtshjen", "pujh", 4,5):addSkills { "noophzeen","tshiaahhqximh"}
Fk:loadTranslationTable{
["doohtshjen"] = "杜遷",
["#doohtshjen"] = "摸著天",
["designer:doohtshjen"] = "設計",
["cv:doohtshjen"] = "配音",
["illustrator:doohtshjen"] = "畫師",
["~doohtshjen"] = "還是吾若山寨快𣴠",
}

--20 梁山泊義士尊晁蓋　鄆城縣月夜走劉唐
--黃安
--21 虔婆醉打唐牛兒　宋江怒殺閻婆惜
--虔婆閻婆
--唐牛兒
General:new(extension, "leejh__liuqdoac", "pujh", 5):addSkills { "gwisleejh", }
Fk:loadTranslationTable{
["leejh__liuqdoac"] = "劉唐",
["#leejh__liuqdoac"] = "百金還恩",
["designer:leejh__liuqdoac"] = "設計",
["cv:leejh__liuqdoac"] = "配音",
["illustrator:leejh__liuqdoac"] = "畫師",
["~leejh__liuqdoac"] = "出城",
}

General:new(extension, "jjemqboasjek", "kvoan", 3, 3,General.Female):addSkills { "soakdzoeoj", "tsyisnzjit"}  --醉日閉月
Fk:loadTranslationTable{
["jjemqboasjek"] = "閻婆惜",
["#jjemqboasjek"] = "花魁",
["designer:jjemqboasjek"] = "設計",
["cv:jjemqboasjek"] = "配音",
["illustrator:jjemqboasjek"] = "畫師",
["~jjemqboasjek"] = "宋三郎伱",
}

General:new(extension, "ttiacqmunqquanh", "kvoan", 3):addSkills { "thouqhsiac", "biuksjins"}
Fk:loadTranslationTable{
["ttiacqmunqquanh"] = "張文遠",
["#ttiacqmunqquanh"] = "小張三",
["designer:ttiacqmunqquanh"] = "設計",
["cv:ttiacqmunqquanh"] = "配音",
["illustrator:ttiacqmunqquanh"] = "畫師",
["~ttiacqmunqquanh"] = "歡愉嫌夜短寂寞限更長",
}


return extension
