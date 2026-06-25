local extension = Package:new("generals_10")
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/generals_10/skills")

Fk:loadTranslationTable{
["generals_10"] = "91~100",
-- ["pujh"] = "匪",
-- ["kvoan"] = "官",
-- ["mjin"] = "民",
["tsjins__kvoan"] = "晉",
}
--

General:new(extension, "deenhsooh", "tsjins__kvoan", 4):addSkills{"coohtsziu"}  --"hzoosqwer"
Fk:loadTranslationTable{
["deenhsooh"] = "田虎",
["#deenhsooh"] = "晉王",
["designer:deenhsooh"] = "設計",
["cv:deenhsooh"] = "配音",
["illustrator:deenhsooh"] = "畫師",
["~deenhsooh"] = "天喪我也",
}
--

--92. 第九十一回　宋公明兵渡黃河　盧俊義賺城黑夜
General:new(extension, "maahleec", "tsjins__kvoan", 3):addSkills{"piucqhzaac", "lvoansqun"}
Fk:loadTranslationTable{
["maahleec"] = "馬靈",
["#maahleec"] = "神駒子",
["designer:maahleec"] = "設計",
["cv:maahleec"] = "配音",
["illustrator:maahleec"] = "畫師",
["~maahleec"] = "星落雲㪔華灮烕",
}
General:new(extension, "bxensziac", "tsjins__kvoan", 4):addSkills{"tszuohtszjens"}
Fk:loadTranslationTable{
["bxensziac"] = "卞祥",
["#bxensziac"] = "介子",
["designer:bxensziac"] = "設計",
["cv:bxensziac"] = "配音",
["illustrator:bxensziac"] = "畫師",
["~bxensziac"] = "昰祅火",
}
--93. 第九十二回　振軍威小李廣神箭　打蓋郡智多星密籌
--94. 第九十三回　李逵夢鬧天池　宋江兵分兩路
--95. 第九十四回　關勝義降三將　李逵莽陷眾人
General:new(extension, "soonqhqoan", "tsjins__kvoan", 5):addSkills{"pikhzaoc"}
Fk:loadTranslationTable{
["soonqhqoan"] = "孫安",
["#soonqhqoan"] = "屠龍手",
["designer:soonqhqoan"] = "設計",
["cv:soonqhqoan"] = "配音",
["illustrator:soonqhqoan"] = "畫師",
["~soonqhqoan"] = "吾 愿降",
}
--96. 第九十五回　宋公明忠感后土　喬道清術敗宋兵
General:new(extension, "gxevqdoavhtshjec", "tsjins__kvoan", 4):addSkills{"hzfenszzyit","moaqtsziacs"}
Fk:loadTranslationTable{
["gxevqdoavhtshjec"] = "喬道清",
["#gxevqdoavhtshjec"] = "幻魔君",
["designer:gxevqdoavhtshjec"] = "設計",
["cv:gxevqdoavhtshjec"] = "配音",
["illustrator:gxevqdoavhtshjec"] = "畫師",
["~gxevqdoavhtshjec"] = "昰就是五雷轟頂之滋味",
}
--97. 第九十六回　幻魔君術窘五龍山　入雲龍兵圍百谷嶺
--98. 第九十七回　陳　諫官升安撫　瓊英處女做先鋒
General:new(extension, "khyecqhqrac", "tsjins__kvoan", 4):addSkills{"jyenqphoojs"}
Fk:loadTranslationTable{
["khyecqhqrac"] = "瓊英",
["#khyecqhqrac"] = "瓊矢鉃",
["designer:khyecqhqrac"] = "設計",
["cv:khyecqhqrac"] = "配音",
["illustrator:khyecqhqrac"] = "畫師",
["~khyecqhqrac"] = "結兒保重",
}
--99. 第九十八回　張清緣配瓊英　吳用計鴆鄔梨
--100. 第九十九回　花和尚解脫緣纏井　混江龍水灌太原城
--101. 第一百回　張清瓊英雙建功　陳　宋江同奏捷
--102. 第一百零一回　謀墳地陰險產逆　蹈春陽妖　生奸

return extension
