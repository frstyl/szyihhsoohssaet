local extension = Package:new("generals_5")
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/generals_5/skills")

Fk:loadTranslationTable{
["generals_5"] = "41~50",
-- ["pujh"] = "匪",
-- ["kvoan"] = "官",
-- ["mjin"] = "民",
-- ["tsiacs"] = "將",
}

--42 還道村受三卷天書　宋公明遇九天玄女

--43 假李逵剪徑劫單身　黑旋風沂嶺殺四虎

--李鬼
General:new(extension, "lihkujh", "pujh", 5):addSkills{}
Fk:loadTranslationTable{
["lihkujh"] = "李鬼",
["#lihkujh"] = "神鬼難測",
["designer:lihkujh"] = "設計",
["cv:lihkujh"] = "配音",
["illustrator:lihkujh"] = "畫師",
["~lihkujh"] = "好漢饒命 吾上有老下有小",
}

--殺虎李逵

General:new(extension, "ssaethsooh__lihgwi", "mjin", 5):addSkills{"ttiucqhsaavs","ssaethsooh"}
Fk:loadTranslationTable{
["ssaethsooh__lihgwi"] = "李逵",
["#ssaethsooh__lihgwi"] = "鐵牛",
["designer:ssaethsooh__lihgwi"] = "設計",
["cv:ssaethsooh__lihgwi"] = "配音",
["illustrator:ssaethsooh__lihgwi"] = "畫師",
["~ssaethsooh__lihgwi"] = "俺之老娘嗚",
}

General:new(extension, "lihqun", "kvoan", 3,4):addSkills{"ssaacqmaach"}
Fk:loadTranslationTable{
["lihqun"] = "李雲",
["#lihqun"] = "靑眼虎",
["designer:lihqun"] = "設計",
["cv:lihqun"] = "配音",
["illustrator:lihqun"] = "畫師",
["~lihqun"] = "如此只得隨你們去休",
}

General:new(extension, "kouc__lihqun", "kvoan", 4):addSkills{"kaamqkouc","gianqkouc"}
Fk:loadTranslationTable{
["kouc__lihqun"] = "李雲",
["#kouc__lihqun"] = "靑眼虎",
["designer:kouc__lihqun"] = "設計",
["cv:kouc__lihqun"] = "配音",
["illustrator:kouc__lihqun"] = "畫師",
["~kouc__lihqun"] = "儘付流水",
}

General:new(extension, "tszuoqpius", "mjin", 3,4):addSkills{"hzoonqtsiuh","hqjemstsiok","kujhthoeoj"}
Fk:loadTranslationTable{
["tszuoqpius"] = "朱富",
["#tszuoqpius"] = "笑面虎",
["designer:tszuoqpius"] = "設計",
["cv:tszuoqpius"] = "配音",
["illustrator:tszuoqpius"] = "畫師",
["~tszuoqpius"] = "不是說伸手不打笑面人",
}
--44. 第四十三回　錦豹子小徑逢戴宗　病關索長街遇石秀

General:new(extension, "jiacqljim", "pujh", 5):addSkills{"tshjesthooms",}
Fk:loadTranslationTable{
["jiacqljim"] = "楊林",
["#jiacqljim"] = "錦豹子",
["designer:jiacqljim"] = "設計",
["cv:jiacqljim"] = "配音",
["illustrator:jiacqljim"] = "畫師",
["~jiacqljim"] = "不好中計已",
}

General:new(extension, "doeocspuj", "pujh", 5):addSkills{"tszjettszhioc",}
Fk:loadTranslationTable{
["doeocspuj"] = "鄧飛",
["#doeocspuj"] = "火眼狻猊",
["designer:doeocspuj"] = "設計",
["cv:doeocspuj"] = "配音",
["illustrator:doeocspuj"] = "畫師",
["~doeocspuj"] = "索大哥快走",
}

--舞劍裴宣
General:new(extension, "boojqsyen", "kvoan", 4):addSkills{"ex__szjimhphoans","prachkouc"} --kouctszics  
Fk:loadTranslationTable{
["boojqsyen"] = "裴宣",
["#boojqsyen"] = "鐵面孔目",
["designer:boojqsyen"] = "設計",
["cv:boojqsyen"] = "配音",
["illustrator:boojqsyen"] = "畫師",
["~boojqsyen"] = "盡是暗箱操作",
}

General:new(extension, "kiams__boojqsyen", "pujh", 4):addSkills{"qwerkiams","boacqthouc"}
Fk:loadTranslationTable{
["kiams__boojqsyen"] = "裴宣",
["#kiams__boojqsyen"] = "仗劍",
["designer:kiams__boojqsyen"] = "設計",
["cv:kiams__boojqsyen"] = "配音",
["illustrator:kiams__boojqsyen"] = "畫師",
["~kiams__boojqsyen"] = "盡是暗箱操作",
}

General:new(extension, "maacskhoac", "pujh", 4):addSkills{"dzoavhzzyen","moucqtthioc"}
Fk:loadTranslationTable{
["maacskhoac"] = "孟康",
["#maacskhoac"] = "玉幡竿",
["designer:maacskhoac"] = "設計",
["cv:maacskhoac"] = "配音",
["illustrator:maacskhoac"] = "畫師",
["~maacskhoac"] = "火炮突襲,快撤",
}

General:new(extension, "jiacqqiuc", "tsiacs", 5):addSkills{"hzaacqhzeec",}  --s2
Fk:loadTranslationTable{
["jiacqqiuc"] = "楊雄",
["#jiacqqiuc"] = "病關索",
["designer:jiacqqiuc"] = "設計",
["cv:jiacqqiuc"] = "配音",
["illustrator:jiacqqiuc"] = "畫師",
["~jiacqqiuc"] = "背瘡疼痛,恨不能戰死殺場",
}

General:new(extension, "dzzjeksius", "tsiacs", 4,6):addSkills{"bxensmracs",}  --s2 --33
Fk:loadTranslationTable{
["dzzjeksius"] = "石秀",
["#dzzjeksius"] = "拚命三郎",
["designer:dzzjeksius"] = "設計",
["cv:dzzjeksius"] = "配音",
["illustrator:dzzjeksius"] = "畫師",
["~dzzjeksius"] = " 拚到底矣",
}
--45. 第四十四回　楊雄醉罵潘巧雲　石秀智殺裴如海

General:new(extension, "phvoanqkhaavhqun", "mjin", 3, 3,General.Female):addSkills {"puanhmuo","piuqtoeok", "butjyen" }
Fk:loadTranslationTable{
["phvoanqkhaavhqun"] = "潘巧雲",
["#phvoanqkhaavhqun"] = "水楊花",
["designer:phvoanqkhaavhqun"] = "設計",
["cv:phvoanqkhaavhqun"] = "配音",
["illustrator:phvoanqkhaavhqun"] = "畫師",
["~phvoanqkhaavhqun"] = "愧",
}


General:new(extension, "ttiacqpoavh", "tsiacs", 5):addSkills {"puacsteev" }
Fk:loadTranslationTable{
["ttiacqpoavh"] = "張保",
["#ttiacqpoavh"] = "踢殺羊",
["designer:ttiacqpoavh"] = "設計",
["cv:ttiacqpoavh"] = "配音",
["illustrator:ttiacqpoavh"] = "畫師",
["~ttiacqpoavh"] = "a",
}

--46. 第四十五回　病關索大闹翠屏山　拚命三火燒祝家店

General:new(extension, "dzziqtshjen", "mjin", 3):addSkills {"zzjinqthou", "pujqjjem" }
Fk:loadTranslationTable{
["dzziqtshjen"] = "時遷",
["#dzziqtshjen"] = "鼓上蚤",
["designer:dzziqtshjen"] = "設計",
["cv:dzziqtshjen"] = "配音",
["illustrator:dzziqtshjen"] = "畫師",
["~dzziqtshjen"] = "上天不公无過于此",
}
--47. 第四十六回　撲天鵰雙修生死書　宋公明一打祝家莊
--林冲 小張飛
---祝氏三

General:new(extension, "luanqdeecqciok", "tsiacs", 5):addSkills {"jiacqmuoh" } -- punsmuoh
Fk:loadTranslationTable{
["luanqdeecqciok"] = "欒廷玉",
["#luanqdeecqciok"] = "鐵棒",
["designer:luanqdeecqciok"] = "設計",
["cv:luanqdeecqciok"] = "配音",
["illustrator:luanqdeecqciok"] = "畫師",
["~luanqdeecqciok"] = "吾寍死絕不降",
}
--飛刀李應
General:new(extension, "lihhqics", "tsiacs", 4):addSkills {"szuoqquns" }
Fk:loadTranslationTable{
["lihhqics"] = "李應",
["#lihhqics"] = "撲天雕",
["designer:lihhqics"] = "設計",
["cv:lihhqics"] = "配音",
["illustrator:lihhqics"] = "畫師",
["~lihhqics"] = "援盡糧絕已何取勝",
}

General:new(extension, "doohhsic", "tsiacs", 4):addSkills {"kujhmjens","gwisliac" }
Fk:loadTranslationTable{
["doohhsic"] = "杜興",
["#doohhsic"] = "鬼臉兒",
["designer:doohhsic"] = "設計",
["cv:doohhsic"] = "配音",
["illustrator:doohhsic"] = "畫師",
["~doohhsic"] = "糧艸沒已 我如何嚮哥哥交代",
}

--48. 第四十七回　一丈青單捉王矮虎　宋公明二打祝家莊

--祝家
General:new(extension, "hzoohsoamqnniac", "tsiacs", 4,4,General.Female):addSkills {"tszjipmaach","siuqmuoh" }
Fk:loadTranslationTable{
["hzoohsoamqnniac"] = "扈三娘",
["#hzoohsoamqnniac"] = "一丈靑",
["designer:hzoohsoamqnniac"] = "設計",
["cv:hzoohsoamqnniac"] = "配音",
["illustrator:hzoohsoamqnniac"] = "畫師",
["~hzoohsoamqnniac"] = "稼已昰",
}
--49. 第四十八回　解珍解寶雙越獄　孫立孫新大劫牢

General:new(extension, "hzaesttxin", "tsiacs", 4):addSkills {"zyinqljep" }
Fk:loadTranslationTable{
["hzaesttxin"] = "解珍",
["#hzaesttxin"] = "兩頭蛇",
["designer:hzaesttxin"] = "設計",
["cv:hzaesttxin"] = "配音",
["illustrator:hzaesttxin"] = "畫師",
["~hzaesttxin"] = "顧不已若多",
}

General:new(extension, "hzaespoavh", "tsiacs", 4):addSkills {"ljephzfak" }
Fk:loadTranslationTable{
["hzaespoavh"] = "解寶",
["#hzaespoavh"] = "雙尾蠍",
["designer:hzaespoavh"] = "設計",
["cv:hzaespoavh"] = "配音",
["illustrator:hzaespoavh"] = "畫師",
["~hzaespoavh"] = "哥",
}


General:new(extension, "soonqljip", "mjin", 5):addSkills {"kiaploav","sziuhbxis" }
Fk:loadTranslationTable{
["soonqljip"] = "孫立",
["#soonqljip"] = "小尉遲",
["designer:soonqljip"] = "設計",
["cv:soonqljip"] = "配音",
["illustrator:soonqljip"] = "畫師",
["~soonqljip"] = "燕雀焉知鴻鵠之志",
}


General:new(extension, "soonqsjin", "kvoan", 4):addSkills {"kaenskeejs","noeojshqics" }
Fk:loadTranslationTable{
["soonqsjin"] = "孫新",
["#soonqsjin"] = "病尉遲",
["designer:soonqsjin"] = "設計",
["cv:soonqsjin"] = "配音",
["illustrator:soonqsjin"] = "畫師",
["~soonqsjin"] = "吾之才 欸",
}

General:new(extension, "koosdoarsoavh", "mjin", 5,5,General.Female):addSkills {"tshjeqhsooh" }
Fk:loadTranslationTable{
["koosdoarsoavh"] = "顧大嫂",
["#koosdoarsoavh"] = "母大蟲",
["designer:koosdoarsoavh"] = "設計",
["cv:koosdoarsoavh"] = "配音",
["illustrator:koosdoarsoavh"] = "畫師",
["~koosdoarsoavh"] = "尒等竟敢暗算",
}
--樂娘子
General:new(extension, "caokhzvoa", "tsiacs", 3):addSkills {"mvoanqkoa","lihcaok" } --siacqhzvoa
Fk:loadTranslationTable{
["caokhzvoa"] = "樂和",
["#caokhzvoa"] = "鐵叫子",
["designer:caokhzvoa"] = "設計",
["cv:caokhzvoa"] = "配音",
["illustrator:caokhzvoa"] = "畫師",
["~caokhzvoa"] = "此曲終已",
}

General:new(extension, "caok__caokhzvoa", "tsiacs", 3):addSkills {"hqoatqun","jioqqwins" }
Fk:loadTranslationTable{
["caok__caokhzvoa"] = "樂和",
["#caok__caokhzvoa"] = "鐵叫子",
["designer:caok__caokhzvoa"] = "設計",
["cv:caok__caokhzvoa"] = "配音",
["illustrator:caok__caokhzvoa"] = "畫師",
["~caok__caokhzvoa"] = "此曲終已",
}

General:new(extension, "tsshioqhqveen", "mjin", 4):addSkills {"liocqhsfas" }
Fk:loadTranslationTable{
["tsshioqhqveen"] = "鄒淵",
["#tsshioqhqveen"] = "出林龍",
["designer:tsshioqhqveen"] = "設計",
["cv:tsshioqhqveen"] = "配音",
["illustrator:tsshioqhqveen"] = "畫師",
["~tsshioqhqveen"] = "今夜山凹裏去夢䰟安得歸",
}

General:new(extension, "tsshioqnnyins", "mjin", 4):addSkills {"liocqdzjem" }
Fk:loadTranslationTable{
["tsshioqnnyins"] = "鄒潤",
["#tsshioqnnyins"] = "獨角龍",
["designer:tsshioqnnyins"] = "設計",
["cv:tsshioqnnyins"] = "配音",
["illustrator:tsshioqnnyins"] = "畫師",
["~tsshioqnnyins"] = "竟肰撞不倒",
}
--50. 第四十九回　吳學究雙掌連環計　宋公明三打祝家莊

--51. 第五十回　插翅虎枷打白秀英　美髯公誤失小衙內
General:new(extension, "baaksiushqrac", "mjin", 3,3,General.Female):addSkills {"maestthiacs", "ddiachszjer" }  --hqoakcian
Fk:loadTranslationTable{
["baaksiushqrac"] = "白秀英",
["#baaksiushqrac"] = "白罌粟",
["designer:baaksiushqrac"] = "設計",
["cv:baaksiushqrac"] = "配音",
["illustrator:baaksiushqrac"] = "畫師",
["~baaksiushqrac"] = "誰都幫不得我",
}
--小衙內

  
return extension
