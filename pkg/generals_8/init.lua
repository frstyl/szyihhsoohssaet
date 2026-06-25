local extension = Package:new("generals_8")
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/generals_8/skills")

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
General:new(extension, "lihssxiqssxi", "mjin", 3,3,General.Female):addSkills{"tshjimssjim", "jinhkeens"}
Fk:loadTranslationTable{
["lihssxiqssxi"] = "李師師",
["#lihssxiqssxi"] = "",
["designer:lihssxiqssxi"] = "設計",
["cv:lihssxiqssxi"] = "配音",
["illustrator:lihssxiqssxi"] = "畫師",
["~lihssxiqssxi"] = "a",
}
-- 74. 第七十三回　黑旋風喬捉鬼　梁山泊雙獻頭

-- 75. 第七十四回　燕青智撲「擎天柱」　李逵壽張喬坐衙
--擎天柱任原
local nzjimscuan = General:new(extension, "nzjimscuan", "tsiacs", 5)
nzjimscuan:addSkills{"szjetloojs"}  --6? --,"tssaacljis"
nzjimscuan:addRelatedSkill("tssaacqljis")
Fk:loadTranslationTable{
["nzjimscuan"] = "任原",
["#nzjimscuan"] = "擎天柱",
["designer:nzjimscuan"] = "設計",
["cv:nzjimscuan"] = "配音",
["illustrator:nzjimscuan"] = "畫師",
["~nzjimscuan"] = "a",
}
-- 76. 第七十五回　活閻羅倒船偷御酒　黑旋風扯詔罵欽差
-- 77. 第七十六回　吳加亮布四斗五方旗　宋公明排九宮八卦陣

-- 78. 第七十七回　梁山泊十面埋伏　宋公明兩贏童貫
General:new(extension, "__doucqkvoans", "kvoan", 3):addSkills{"tszjecqbuat","hqoavhsiacs"}
local hzfanskvoan = General:new(extension, "hzfanskvoan__doucqkvoans", "kvoan", 2,2, General.Agender)  --??
hzfanskvoan:addSkills { "tszjecqbuat", "hqoavhsiacs","quacqhzfans" }-- "hqoavhsiacs","quacqhzfans" 
hzfanskvoan.hidden = true

Fk:loadTranslationTable{
["__doucqkvoans"] = "童貫",
["#__doucqkvoans"] = "廣陽郡王",
["designer:__doucqkvoans"] = "設計",
["cv:__doucqkvoans"] = "配音",
["illustrator:__doucqkvoans"] = "畫師",
["~__doucqkvoans"] = "歬有伏兵後有追兵似此爲之奈何",

["hzfanskvoan"] = "宦官",

["hzfanskvoan__doucqkvoans"] = "童貫",
["#hzfanskvoan__doucqkvoans"] = "廣陽郡王",
-- ["designer:hzfanskvoan__doucqkvoans"] = "設計",
-- ["cv:hzfanskvoan__doucqkvoans"] = "配音",
-- ["illustrator:hzfanskvoan__doucqkvoans"] = "畫師",
["~hzfanskvoan__doucqkvoans"] = "歬有伏兵後有追兵似此爲之奈何",

}
-- 79. 第七十八回　十節度議取梁山泊　宋公明一敗高太尉
--十節度   梅展-三尖两刃刀  李从吉 徐京 楊溫-攔路虎 張開-獨行虎 王文德-搶?九環刀  荆忠-大杆刀
--聞煥章 黨世雄 牛邦喜

General:new(extension, "munqhsvoanstsziac", "kvoan", 3):addSkills{"loonsszjer","ljemhthoojs"}
Fk:loadTranslationTable{
["munqhsvoanstsziac"] = "聞煥章",
["#munqhsvoanstsziac"] = "參謀",
["designer:munqhsvoanstsziac"] = "設計",
["cv:munqhsvoanstsziac"] = "配音",
["illustrator:munqhsvoanstsziac"] = "畫師",
["~munqhsvoanstsziac"] = "惜不用吾計",
}

General:new(extension, "liuqmiucslioc", "kvoan", 4):addSkills{"crakljin","liocqhquj"}
Fk:loadTranslationTable{
["liuqmiucslioc"] = "劉夢龍",
["#liuqmiucslioc"] = "黑龍",
["designer:liuqmiucslioc"] = "設計",
["cv:liuqmiucslioc"] = "配音",
["illustrator:liuqmiucslioc"] = "畫師",
["~liuqmiucslioc"] = "火 好大之火",
}
General:new(extension, "hzoanqdzoonqpoavh", "kvoan", 5):addSkills{"keektszjens","kaavqprac"}
Fk:loadTranslationTable{
["hzoanqdzoonqpoavh"] = "韓存保",
["#hzoanqdzoonqpoavh"] = "鐵戟銀鉤",
["designer:hzoanqdzoonqpoavh"] = "設計",
["cv:hzoanqdzoonqpoavh"] = "配音",
["illustrator:hzoanqdzoonqpoavh"] = "畫師",
["~hzoanqdzoonqpoavh"] = "昰一戰也算是䀆興",
}

General:new(extension, "quacqhsvans", "kvoan", 5):addSkills{"gianskoot"}
Fk:loadTranslationTable{
["quacqhsvans"] = "王渙",
["#quacqhsvans"] = "風流老將",
["designer:quacqhsvans"] = "設計",
["cv:quacqhsvans"] = "配音",
["illustrator:quacqhsvans"] = "畫師",
["~quacqhsvans"] = "廉頗老矣尙能飯否",
}


General:new(extension, "hzaochcuanqttxins", "kvoan", 5):addSkills{"muohbxis","laachtsjens"}
Fk:loadTranslationTable{
["hzaochcuanqttxins"] = "項元鎮",
["#hzaochcuanqttxins"] = "七星弓",
["designer:hzaochcuanqttxins"] = "設計",
["cv:hzaochcuanqttxins"] = "配音",
["illustrator:hzaochcuanqttxins"] = "畫師",
["~hzaochcuanqttxins"] = "昰火賊寇竟也臥虎藏龍",
}

General:new(extension, "ttiacqkhoeoj", "kvoan", 5):addSkills{"ddiuktsjins"}
Fk:loadTranslationTable{
["ttiacqkhoeoj"] = "張開",
["#ttiacqkhoeoj"] = "獨行虎",
["designer:ttiacqkhoeoj"] = "設計",
["cv:ttiacqkhoeoj"] = "配音",
["illustrator:ttiacqkhoeoj"] = "畫師",
["~ttiacqkhoeoj"] = "｡",
}

General:new(extension, "jiacqhqoon", "kvoan", 5):addSkills{"kxevqgxes","tszhiocqhzaems"}
Fk:loadTranslationTable{
["jiacqhqoon"] = "楊溫",
["#jiacqhqoon"] = "攔路虎",
["designer:jiacqhqoon"] = "設計",
["cv:jiacqhqoon"] = "配音",
["illustrator:jiacqhqoon"] = "畫師",
["~jiacqhqoon"] = "｡",
}


General:new(extension, "kracqttiuc", "kvoan", 5):addSkills{"doachddio"}
Fk:loadTranslationTable{
["kracqttiuc"] = "荊忠",
["#kracqttiuc"] = "大杆刀",
["designer:kracqttiuc"] = "設計",
["cv:kracqttiuc"] = "配音",
["illustrator:kracqttiuc"] = "畫師",
["~kracqttiuc"] = "｡",
}

General:new(extension, "quacqmuntoeok", "kvoan", 5):addSkills{"dzyettssaamh"}
Fk:loadTranslationTable{
["quacqmuntoeok"] = "王文德",
["#quacqmuntoeok"] = "九環刀",
["designer:quacqmuntoeok"] = "設計",
["cv:quacqmuntoeok"] = "配音",
["illustrator:quacqmuntoeok"] = "畫師",
["~quacqmuntoeok"] = "｡",
}

General:new(extension, "moojqttxenh", "kvoan", 5):addSkills{"pracqkaap"}
Fk:loadTranslationTable{
["moojqttxenh"] = "梅展",
["#moojqttxenh"] = "三尖两刃刀",
["designer:moojqttxenh"] = "設計",
["cv:moojqttxenh"] = "配音",
["illustrator:moojqttxenh"] = "畫師",
["~moojqttxenh"] = "｡",
}

General:new(extension, "lihddiacqkjit", "kvoan", 5):addSkills{"pracqkaap"}
Fk:loadTranslationTable{
["lihddiacqkjit"] = "李長吉",
["#lihddiacqkjit"] = "",
["designer:lihddiacqkjit"] = "設計",
["cv:lihddiacqkjit"] = "配音",
["illustrator:lihddiacqkjit"] = "畫師",
["~lihddiacqkjit"] = "｡",
}

General:new(extension, "zioqkrac", "kvoan", 4):addSkills{"hzfacqtszhioc"}
Fk:loadTranslationTable{
["zioqkrac"] = "徐京",
["#zioqkrac"] = "",
["designer:zioqkrac"] = "設計",
["cv:zioqkrac"] = "配音",
["illustrator:zioqkrac"] = "畫師",
["~zioqkrac"] = "｡",
}
-- 80. 第七十九回　劉唐放火燒戰船　宋江兩敗高太尉
-- 81. 第八十回　張順鑿漏海鰍船　宋江三敗高太尉

return extension
