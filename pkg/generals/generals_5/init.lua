local extension = Package:new("generals_5")
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/generals/generals_5/skills")

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
General:new(extension, "lih_kujh", "pujh", 5):addSkills{}
Fk:loadTranslationTable{
["lih_kujh"] = "李鬼",
["#lih_kujh"] = "神鬼難測",
["designer:lih_kujh"] = "設計",
["cv:lih_kujh"] = "配音",
["illustrator:lih_kujh"] = "畫師",
["~lih_kujh"] = "好漢饒命 吾上有老下有小",
}

--殺虎李逵

General:new(extension, "ssaethsooh__lih_gwi", "mjin", 5):addSkills{"ttiucqhsaavs","ssaethsooh"}
Fk:loadTranslationTable{
["ssaethsooh__lih_gwi"] = "李逵",
["#ssaethsooh__lih_gwi"] = "鐵牛",
["designer:ssaethsooh__lih_gwi"] = "設計",
["cv:ssaethsooh__lih_gwi"] = "配音",
["illustrator:ssaethsooh__lih_gwi"] = "畫師",
["~ssaethsooh__lih_gwi"] = "俺之老娘嗚",
}

General:new(extension, "lih_qun", "kvoan", 3,4):addSkills{"ssaacqmaach"}
Fk:loadTranslationTable{
["lih_qun"] = "李雲",
["#lih_qun"] = "靑眼虎",
["designer:lih_qun"] = "設計",
["cv:lih_qun"] = "配音",
["illustrator:lih_qun"] = "畫師",
["~lih_qun"] = "如此只得隨你們去休",
}

General:new(extension, "kouc__lih_qun", "kvoan", 4):addSkills{"kaamqkouc","gianqkouc"}
Fk:loadTranslationTable{
["kouc__lih_qun"] = "李雲",
["#kouc__lih_qun"] = "靑眼虎",
["designer:kouc__lih_qun"] = "設計",
["cv:kouc__lih_qun"] = "配音",
["illustrator:kouc__lih_qun"] = "畫師",
["~kouc__lih_qun"] = "儘付流水",
}

General:new(extension, "tszuo_pius", "mjin", 3,4):addSkills{"hzoonqtsiuh","hqjemstsiok","kujhthoeoj"}
Fk:loadTranslationTable{
["tszuo_pius"] = "朱富",
["#tszuo_pius"] = "笑面虎",
["designer:tszuo_pius"] = "設計",
["cv:tszuo_pius"] = "配音",
["illustrator:tszuo_pius"] = "畫師",
["~tszuo_pius"] = "不是說伸手不打笑面人",
}
--44. 第四十三回　錦豹子小徑逢戴宗　病關索長街遇石秀

General:new(extension, "jiac_ljim", "pujh", 5):addSkills{"tshjesthoeoms",}
Fk:loadTranslationTable{
["jiac_ljim"] = "楊林",
["#jiac_ljim"] = "錦豹子",
["designer:jiac_ljim"] = "設計",
["cv:jiac_ljim"] = "配音",
["illustrator:jiac_ljim"] = "畫師",
["~jiac_ljim"] = "不好中計已",
}

General:new(extension, "doeocs_puj", "pujh", 5):addSkills{"tszjettszhioc",}
Fk:loadTranslationTable{
["doeocs_puj"] = "鄧飛",
["#doeocs_puj"] = "火眼狻猊",
["designer:doeocs_puj"] = "設計",
["cv:doeocs_puj"] = "配音",
["illustrator:doeocs_puj"] = "畫師",
["~doeocs_puj"] = "索大哥快走",
}

--舞劍裴宣
General:new(extension, "booj_syen", "kvoan", 4):addSkills{"ex__szjimhphoans","prachkouc", "ddiqhzaac"} --kouctszics  
Fk:loadTranslationTable{
["booj_syen"] = "裴宣",
["#booj_syen"] = "鐵面孔目",
["designer:booj_syen"] = "設計",
["cv:booj_syen"] = "配音",
["illustrator:booj_syen"] = "畫師",
["~booj_syen"] = "盡是暗箱操作",
}

-- General:new(extension, "kiams__booj_syen", "pujh", 4):addSkills{"qwerkiams","boacqthouc"}
-- Fk:loadTranslationTable{
-- ["kiams__booj_syen"] = "裴宣",
-- ["#kiams__booj_syen"] = "仗劍",
-- ["designer:kiams__booj_syen"] = "設計",
-- ["cv:kiams__booj_syen"] = "配音",
-- ["illustrator:kiams__booj_syen"] = "畫師",
-- ["~kiams__booj_syen"] = "盡是暗箱操作",
-- }

General:new(extension, "maacs_khoac", "pujh", 4):addSkills{"ttiucqliu"}--"dzoavhzzyen","moucqtthioc"
Fk:loadTranslationTable{
["maacs_khoac"] = "孟康",
["#maacs_khoac"] = "玉幡竿",
["designer:maacs_khoac"] = "設計",
["cv:maacs_khoac"] = "配音",
["illustrator:maacs_khoac"] = "畫師",
["~maacs_khoac"] = "火炮突襲,快撤",
}

General:new(extension, "jiac_qiuc", "tsiacs", 4):addSkills{"hzaacqhzeec","khoacsljer"}  --s2
Fk:loadTranslationTable{
["jiac_qiuc"] = "楊雄",
["#jiac_qiuc"] = "病關索",
["designer:jiac_qiuc"] = "設計",
["cv:jiac_qiuc"] = "配音",
["illustrator:jiac_qiuc"] = "畫師",
["~jiac_qiuc"] = "背瘡疼痛,恨不能戰死殺場",
}

General:new(extension, "dzzjek_sius", "tsiacs", 4,6):addSkills{"bxensmracs",}  --s2 --33
Fk:loadTranslationTable{
["dzzjek_sius"] = "石秀",
["#dzzjek_sius"] = "拚命三郎",
["designer:dzzjek_sius"] = "設計",
["cv:dzzjek_sius"] = "配音",
["illustrator:dzzjek_sius"] = "畫師",
["~dzzjek_sius"] = " 拚到底已",
}
--45. 第四十四回　楊雄醉罵潘巧雲　石秀智殺裴如海

General:new(extension, "phvoan_khaavh_qun", "mjin", 3, 3,General.Female):addSkills{"puanhmuo","piuqtoeok", "butjyen" }
Fk:loadTranslationTable{
["phvoan_khaavh_qun"] = "潘巧雲",
["#phvoan_khaavh_qun"] = "水楊花",
["designer:phvoan_khaavh_qun"] = "設計",
["cv:phvoan_khaavh_qun"] = "配音",
["illustrator:phvoan_khaavh_qun"] = "畫師",
["~phvoan_khaavh_qun"] = "愧",
}


General:new(extension, "ttiac_poavh", "tsiacs", 5):addSkills{"puacsteev" }
Fk:loadTranslationTable{
["ttiac_poavh"] = "張保",
["#ttiac_poavh"] = "踢殺羊",
["designer:ttiac_poavh"] = "設計",
["cv:ttiac_poavh"] = "配音",
["illustrator:ttiac_poavh"] = "畫師",
["~ttiac_poavh"] = "a",
}

--46. 第四十五回　病關索大闹翠屏山　拚命三火燒祝家店

General:new(extension, "dzzi_tshjen", "mjin", 3):addSkills{"zzjinqthou", "pujqjjem" }
Fk:loadTranslationTable{
["dzzi_tshjen"] = "時遷",
["#dzzi_tshjen"] = "鼓上蚤",
["designer:dzzi_tshjen"] = "設計",
["cv:dzzi_tshjen"] = "配音",
["illustrator:dzzi_tshjen"] = "畫師",
["~dzzi_tshjen"] = "上天不公无過于此",
}
--47. 第四十六回　撲天鵰雙修生死書　宋公明一打祝家莊
--林冲 小張飛
---祝氏三


General:new(extension, "tsziuk_pru", "tsiacs", 4):addSkills{"ciqprac","soansdzoeojs" }
Fk:loadTranslationTable{
["tsziuk_pru"] = "祝彪",
["#tsziuk_pru"] = "祝氏三",
["designer:tsziuk_pru"] = "設計",
["cv:tsziuk_pru"] = "配音",
["illustrator:tsziuk_pru"] = "畫師",
["~tsziuk_pru"] = "吾寍死絕不降",
}

General:new(extension, "lvoan_deec_ciok", "tsiacs", 5):addSkills{"jiacqmuoh" } -- punsmuoh
Fk:loadTranslationTable{
["lvoan_deec_ciok"] = "欒廷玉",
["#lvoan_deec_ciok"] = "鐵棒",
["designer:lvoan_deec_ciok"] = "設計",
["cv:lvoan_deec_ciok"] = "配音",
["illustrator:lvoan_deec_ciok"] = "畫師",
["~lvoan_deec_ciok"] = "吾寍死絕不降",
}

--飛刀李應
General:new(extension, "toav__lih_hqics", "tsiacs", 4):addSkills{"pujqtoav","pxemqkoot" }
Fk:loadTranslationTable{
["toav__lih_hqics"] = "李應",
["#toav__lih_hqics"] = "撲天雕",
["designer:toav__lih_hqics"] = "設計",
["cv:toav__lih_hqics"] = "配音",
["illustrator:toav__lih_hqics"] = "畫師",
["~toav__lih_hqics"] = "援盡糧絕已何取勝",
}
General:new(extension, "lih_hqics", "pujh", 4):addSkills{"szuoqquns" }
Fk:loadTranslationTable{
["lih_hqics"] = "李應",
["#lih_hqics"] = "撲天雕",
["designer:lih_hqics"] = "設計",
["cv:lih_hqics"] = "配音",
["illustrator:lih_hqics"] = "畫師",
["~lih_hqics"] = "援盡糧絕已何取勝",
}

General:new(extension, "dooh_hsic", "tsiacs", 3):addSkills{"kujhmjens","gwisliac" }
Fk:loadTranslationTable{
["dooh_hsic"] = "杜興",
["#dooh_hsic"] = "鬼臉兒",
["designer:dooh_hsic"] = "設計",
["cv:dooh_hsic"] = "配音",
["illustrator:dooh_hsic"] = "畫師",
["~dooh_hsic"] = "糧艸沒已 我如何嚮哥哥交代",
}

--48. 第四十七回　一丈青單捉王矮虎　宋公明二打祝家莊

--祝家
General:new(extension, "hzooh_soam__nniac", "tsiacs", 4,4,General.Female):addSkills{"tszjipmaach","siuqmuoh" }
Fk:loadTranslationTable{
["hzooh_soam__nniac"] = "扈三娘",
["#hzooh_soam__nniac"] = "一丈靑",
["designer:hzooh_soam__nniac"] = "設計",
["cv:hzooh_soam__nniac"] = "配音",
["illustrator:hzooh_soam__nniac"] = "畫師",
["~hzooh_soam__nniac"] = "稼已昰",
}
--49. 第四十八回　解珍解寶雙越獄　孫立孫新大劫牢

General:new(extension, "hzaes_ttxin", "tsiacs", 4):addSkills{"zyinqljep" }
Fk:loadTranslationTable{
["hzaes_ttxin"] = "解珍",
["#hzaes_ttxin"] = "兩頭蛇",
["designer:hzaes_ttxin"] = "設計",
["cv:hzaes_ttxin"] = "配音",
["illustrator:hzaes_ttxin"] = "畫師",
["~hzaes_ttxin"] = "顧不已若多",
}

General:new(extension, "hzaes_poavh", "tsiacs", 4):addSkills{"ljephzfak" }
Fk:loadTranslationTable{
["hzaes_poavh"] = "解寶",
["#hzaes_poavh"] = "雙尾蠍",
["designer:hzaes_poavh"] = "設計",
["cv:hzaes_poavh"] = "配音",
["illustrator:hzaes_poavh"] = "畫師",
["~hzaes_poavh"] = "哥",
}


General:new(extension, "soon_ljip", "mjin", 4):addSkills{"kaenskeejs","noeojshqics"}
Fk:loadTranslationTable{
["soon_ljip"] = "孫立",
["#soon_ljip"] = "病尉遲",
["designer:soon_ljip"] = "設計",
["cv:soon_ljip"] = "配音",
["illustrator:soon_ljip"] = "畫師",
["~soon_ljip"] = "燕雀焉知鴻鵠之志",
}


General:new(extension, "soon_sjin", "kvoan", 5):addSkills{"kiaploav","sziuhbxis"  }
Fk:loadTranslationTable{
["soon_sjin"] = "孫新",
["#soon_sjin"] = "小尉遲",
["designer:soon_sjin"] = "設計",
["cv:soon_sjin"] = "配音",
["illustrator:soon_sjin"] = "畫師",
["~soon_sjin"] = "吾之才 欸",
}

General:new(extension, "koos_doar_soavh", "mjin", 5,5,General.Female):addSkills{"tshjeqhsooh" }
Fk:loadTranslationTable{
["koos_doar_soavh"] = "顧大嫂",
["#koos_doar_soavh"] = "母大蟲",
["designer:koos_doar_soavh"] = "設計",
["cv:koos_doar_soavh"] = "配音",
["illustrator:koos_doar_soavh"] = "畫師",
["~koos_doar_soavh"] = "尒等竟敢暗算",
}
--樂娘子
General:new(extension, "caok_hzvoa", "tsiacs", 3):addSkills{"koohtszhye","lihcaok" } --"mvoanqkoa" "tshjecqsziac", "siacqhzvoa" 
Fk:loadTranslationTable{
["caok_hzvoa"] = "樂和",
["#caok_hzvoa"] = "鐵叫子",
["designer:caok_hzvoa"] = "設計",
["cv:caok_hzvoa"] = "配音",
["illustrator:caok_hzvoa"] = "畫師",
["~caok_hzvoa"] = "此曲終已",
}


General:new(extension, "tshiu_hqveen", "mjin", 4):addSkills{"liocqhsfas" }
Fk:loadTranslationTable{
["tshiu_hqveen"] = "鄒淵",
["#tshiu_hqveen"] = "出林龍",
["designer:tshiu_hqveen"] = "設計",
["cv:tshiu_hqveen"] = "配音",
["illustrator:tshiu_hqveen"] = "畫師",
["~tshiu_hqveen"] = "今夜山凹裏去夢䰟安得歸",
}

General:new(extension, "tshiu_nnyins", "mjin", 4):addSkills{"liocqdzjem" }
Fk:loadTranslationTable{
["tshiu_nnyins"] = "鄒潤",
["#tshiu_nnyins"] = "獨角龍",
["designer:tshiu_nnyins"] = "設計",
["cv:tshiu_nnyins"] = "配音",
["illustrator:tshiu_nnyins"] = "畫師",
["~tshiu_nnyins"] = "竟肰撞不倒",
}
--50. 第四十九回　吳學究雙掌連環計　宋公明三打祝家莊

--51. 第五十回　插翅虎枷打白秀英　美髯公誤失小衙內
General:new(extension, "baak_sius_hqrac", "mjin", 3,3,General.Female):addSkills{"maestthiacs", "ddiachszjer" }  --hqoakcian
Fk:loadTranslationTable{
["baak_sius_hqrac"] = "白秀英",
["#baak_sius_hqrac"] = "白罌粟",
["designer:baak_sius_hqrac"] = "設計",
["cv:baak_sius_hqrac"] = "配音",
["illustrator:baak_sius_hqrac"] = "畫師",
["~baak_sius_hqrac"] = "誰都幫不得我",
}
--小衙內

  
return extension
