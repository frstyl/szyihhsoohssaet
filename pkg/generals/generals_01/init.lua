local extension = Package:new("generals_01")
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/generals/generals_01/skills")

Fk:loadTranslationTable{
["generals_01"] = "序",
["pujh"] = "匪",
["kvoan"] = "官",
["mjin"] = "民",
["tsiacs"] = "將",
}

--楔子　張天師祈禳瘟疫　洪太尉誤走妖魔
General:new(extension, "hzoucqsjin", "kvoan", 5):addSkills { "tsiocsmoa"}  --縱魔
Fk:loadTranslationTable{
["hzoucqsjin"] = "洪信",
["#hzoucqsjin"] = "洪太尉",
["designer:hzoucqsjin"] = "設計",
["cv:hzoucqsjin"] = "配音",
["illustrator:hzoucqsjin"] = "畫師",
["~hzoucqsjin"] = "走者是何等祅魔",
}

General:new(extension, "ttiacqtszjinqnzjin", "pujh", 3):addSkills { "khuoqmoa","gijqnziac","ddxevhhsioc"}
Fk:loadTranslationTable{
["ttiacqtszjinqnzjin"] = "張眞人",
["#ttiacqtszjinqnzjin"] = "天師",
["designer:ttiacqtszjinqnzjin"] = "設計",
["cv:ttiacqtszjinqnzjin"] = "配音",
["illustrator:ttiacqtszjinqnzjin"] = "畫師",
["~ttiacqtszjinqnzjin"] = "天意烏",
}



Fk:loadTranslationTable{
["hqxim"] = "侌",
["jiac"] = "昜",
}

local jiac__boojqnzioqhsoeojh = General:new(extension, "jiac__boojqnzioqhsoeojh", "pujh", 3)
jiac__boojqnzioqhsoeojh:addSkills { "buamshqxim","ljeqddxin","lunqhzooj"} 
jiac__boojqnzioqhsoeojh:addRelatedSkill("tsziukzzyit_hsoonqdzzyes")
Fk:loadTranslationTable{
["jiac__boojqnzioqhsoeojh"] = "裴如海",
["#jiac__boojqnzioqhsoeojh"] = "海闍黎",
["designer:jiac__boojqnzioqhsoeojh"] = "設計",
["cv:jiac__boojqnzioqhsoeojh"] = "配音",
["illustrator:jiac__boojqnzioqhsoeojh"] = "畫師",
["~jiac__boojqnzioqhsoeojh"] = "終究舍不去昰塵緣",
}

local hqxim__phoanqkhaavhqun = General:new(extension, "hqxim__phoanqkhaavhqun", "mjin", 3,3,General.Female)
hqxim__phoanqkhaavhqun:addSkills { "dzjecqdook","dooqmxe","dzyetjyen"}
hqxim__phoanqkhaavhqun:addRelatedSkill("tsziukzzyit_tthxinsdook")
Fk:loadTranslationTable{
["hqxim__phoanqkhaavhqun"] = "潘巧雲",
["#hqxim__phoanqkhaavhqun"] = "花開荼蘼",
["designer:hqxim__phoanqkhaavhqun"] = "設計",
["cv:hqxim__phoanqkhaavhqun"] = "配音",
["illustrator:hqxim__phoanqkhaavhqun"] = "畫師",
["~hqxim__phoanqkhaavhqun"] = "苦乎",
}


local jiac__lihkoos = General:new(extension, "jiac__lihkoos", "mjin", 4)
jiac__lihkoos:addSkills { "deevhloucs","meejqdzoeoj","koushzaems"}
jiac__lihkoos:addRelatedSkill("nzjipkous")
jiac__lihkoos:addRelatedSkill("tsziukzzyit_hsoonslvoans")
Fk:loadTranslationTable{
["jiac__lihkoos"] = "李固",
["#jiac__lihkoos"] = "惡管家",
["designer:jiac__lihkoos"] = "設計",
["cv:jiac__lihkoos"] = "配音",
["illustrator:jiac__lihkoos"] = "畫師",
["~jiac__lihkoos"] = "苦乎",
}

local hqxim__kaahdzzjeh = General:new(extension, "hqxim__kaahdzzjeh", "mjin", 3,3, General.Female)
hqxim__kaahdzzjeh:addSkills { "khitdzjec","piucshsiap","deecssjim"}
hqxim__kaahdzzjeh:addRelatedSkill("tsziukzzyit_hzaechquns")
Fk:loadTranslationTable{
["hqxim__kaahdzzjeh"] = "賈氏",
["#hqxim__kaahdzzjeh"] = "花折墜月",
["designer:hqxim__kaahdzzjeh"] = "設計",
["cv:hqxim__kaahdzzjeh"] = "配音",
["illustrator:hqxim__kaahdzzjeh"] = "畫師",
["~hqxim__kaahdzzjeh"] = "苦乎",
}

local jiac__muohdoarloac=General:new(extension, "jiac__muohdoarloac", "mjin", 1)
jiac__muohdoarloac:addSkills { "khutdzioc","nzjinhnziok","hzoeomqhzoeons"}
jiac__muohdoarloac:addRelatedSkill("tsziukzzyit_mxiqquns")
Fk:loadTranslationTable{
["jiac__muohdoarloac"] = "武大郎",
["#jiac__muohdoarloac"] = "三寸丁穀樹皮",
["designer:jiac__muohdoarloac"] = "設計",
["cv:jiac__muohdoarloac"] = "配音",
["illustrator:jiac__muohdoarloac"] = "畫師",
["~jiac__muohdoarloac"] = "苦乎",
}

local hqxim__phoanqkximqleen = General:new(extension, "hqxim__phoanqkximqleen", "mjin", 3,3,General.Female)
hqxim__phoanqkximqleen:addSkills { "loakkoan","leechjiak","ljetmuns"}
hqxim__phoanqkximqleen:addRelatedSkill("tsziukzzyit_dzjecshsfas")
Fk:loadTranslationTable{
["hqxim__phoanqkximqleen"] = "潘金蓮",
["#hqxim__phoanqkximqleen"] = "鏡花水月",
["designer:hqxim__phoanqkximqleen"] = "設計",
["cv:hqxim__phoanqkximqleen"] = "配音",
["illustrator:hqxim__phoanqkximqleen"] = "畫師",
["~hqxim__phoanqkximqleen"] = "苦乎",
}


local jiac__quacqkhracs= General:new(extension, "jiac__quacqkhracs", "mjin", 4)
jiac__quacqkhracs:addSkills { "meejqtsyis","zjimqhsfa","szikmuj"}
jiac__quacqkhracs:addRelatedSkill("tsziukzzyit_mxishqrach")
Fk:loadTranslationTable{
["jiac__quacqkhracs"] = "王慶",
["#jiac__quacqkhracs"] = "偷香竊玉", --陰險產屰
["designer:jiac__quacqkhracs"] = "設計",
["cv:jiac__quacqkhracs"] = "配音",
["illustrator:jiac__quacqkhracs"] = "畫師",
["~jiac__quacqkhracs"] = "苦乎",
}

local hqxim__doucqkxevqsius =General:new(extension, "hqxim__doucqkxevqsius", "mjin", 3,3, General.Female)
hqxim__doucqkxevqsius:addSkills { "liuqhzfa","hseekdziac","hsfaqtsoacs"}
hqxim__doucqkxevqsius:addRelatedSkill("tsziukzzyit_dzjisjuoh")
Fk:loadTranslationTable{
["hqxim__doucqkxevqsius"] = "童嬌秀",
["#hqxim__doucqkxevqsius"] = "秋水揚波",
["designer:hqxim__doucqkxevqsius"] = "設計",
["cv:hqxim__doucqkxevqsius"] = "配音",
["illustrator:hqxim__doucqkxevqsius"] = "畫師",
["~hqxim__doucqkxevqsius"] = "苦乎",
}

local jiac__tsziukpru=General:new(extension, "jiac__tsziukpru", "mjin", 4)
jiac__tsziukpru:addSkills { "deejqprac","hzoavhkhis","bjesphioc"}
jiac__tsziukpru:addRelatedSkill("tsziukzzyit_mracsttiucs")
Fk:loadTranslationTable{
["jiac__tsziukpru"] = "祝彪",
["#jiac__tsziukpru"] = "小郎君",
["designer:jiac__tsziukpru"] = "設計",
["cv:jiac__tsziukpru"] = "配音",
["illustrator:jiac__tsziukpru"] = "畫師",
["~jiac__tsziukpru"] = "苦乎",
}

local hqxim__hzoohsoamnniac = General:new(extension, "hqxim__hzoohsoamnniac", "mjin", 4,4, General.Female)
hqxim__hzoohsoamnniac:addSkills { "tthiuqtoav","deecstshjin",} --"hzaocqdzioc"
hqxim__hzoohsoamnniac:addRelatedSkill("tsziukzzyit_guacqboavs")
Fk:loadTranslationTable{
["hqxim__hzoohsoamnniac"] = "扈三娘",
["#hqxim__hzoohsoamnniac"] = "巾幗鬚眉",
["designer:hqxim__hzoohsoamnniac"] = "設計",
["cv:hqxim__hzoohsoamnniac"] = "配音",
["illustrator:hqxim__hzoohsoamnniac"] = "畫師",
["~hqxim__hzoohsoamnniac"] = "苦乎",
}

local jiac__ttiacqquacs =General:new(extension, "jiac__ttiacqquacs", "mjin", 3)
jiac__ttiacqquacs:addSkills { "hsoonqhsoojs","muoqtseejs","seenhkiap"}  --dzoeokzzyon
jiac__ttiacqquacs:addRelatedSkill("tsziukzzyit_maacqmiuk")
Fk:loadTranslationTable{
["jiac__ttiacqquacs"] = "張旺",
["#jiac__ttiacqquacs"] = "𢧵江鬼",  --不彀侌昜
["designer:jiac__ttiacqquacs"] = "設計",
["cv:jiac__ttiacqquacs"] = "配音",
["illustrator:jiac__ttiacqquacs"] = "畫師",
["~jiac__ttiacqquacs"] = "苦乎",
}

local hqxim__lihkhaavhnoo = General:new(extension, "hqxim__lihkhaavhnoo", "mjin", 3,3, General.Female)
hqxim__lihkhaavhnoo:addSkills { "tsziukmoan","maekmaek","dzziuqhquans"}
hqxim__lihkhaavhnoo:addRelatedSkill("tsziukzzyit_tssiostsziuk")
Fk:loadTranslationTable{
["hqxim__lihkhaavhnoo"] = "李巧奴",
["#hqxim__lihkhaavhnoo"] = "愁紅慘綠",
["designer:hqxim__lihkhaavhnoo"] = "設計",
["cv:hqxim__lihkhaavhnoo"] = "配音",
["illustrator:hqxim__lihkhaavhnoo"] = "畫師",
["~hqxim__lihkhaavhnoo"] = "苦乎",
}

local jiac__touchbrac = General:new(extension, "jiac__touchbrac", "mjin", 4,5)
jiac__touchbrac:addSkills { "puanhmiuk","giacqpaas","jiokhsoak"}
jiac__touchbrac:addRelatedSkill("tsziukzzyit_puanhdoan")
Fk:loadTranslationTable{
["jiac__touchbrac"] = "董平",
["#jiac__touchbrac"] = "濁流淸源",--東平都監
["designer:jiac__touchbrac"] = "設計",
["cv:jiac__touchbrac"] = "配音",
["illustrator:jiac__touchbrac"] = "畫師",
["~jiac__touchbrac"] = "苦乎",
}

local hqxim__ddxecqhquanhnzje = General:new(extension, "hqxim__ddxecqhquanhnzje", "mjin", 3,3, General.Female)
hqxim__ddxecqhquanhnzje:addSkills{ "sooshseec","leecqpheec","tsheejqdzyet"}
hqxim__ddxecqhquanhnzje:addRelatedSkill("tsziukzzyit_mxenhcioh")
Fk:loadTranslationTable{
["hqxim__ddxecqhquanhnzje"] = "程婉兒",
["#hqxim__ddxecqhquanhnzje"] = "淒風楚雨",
["designer:hqxim__ddxecqhquanhnzje"] = "設計",
["cv:hqxim__ddxecqhquanhnzje"] = "配音",
["illustrator:hqxim__ddxecqhquanhnzje"] = "畫師",
["~hqxim__ddxecqhquanhnzje"] = "苦乎",
}

---------------

General:new(extension, "caok__caokhzvoa", "tsiacs", 3):addSkills {"hzvoaqcaok" } --,
Fk:loadTranslationTable{
["caok__caokhzvoa"] = "樂和",
["#caok__caokhzvoa"] = "鐵叫子",
["designer:caok__caokhzvoa"] = "設計",
["cv:caok__caokhzvoa"] = "配音",
["illustrator:caok__caokhzvoa"] = "畫師",
["~caok__caokhzvoa"] = "此曲終已",
}

General:new(extension, "caok__maahljin", "pujh", 3):addSkills {"jiacqhqik" } --,
Fk:loadTranslationTable{
["caok__maahljin"] = "馬麟",
["#caok__maahljin"] = "鐵笛仙",
["designer:caok__maahljin"] = "設計",
["cv:caok__maahljin"] = "配音",
["illustrator:caok__maahljin"] = "畫師",
["~caok__maahljin"] = "此曲終已",
}

General:new(extension, "ttiacqsziukjjas", "pujh", 3):addSkills {"ttxinsphuoh","koucqbuat" } --,
Fk:loadTranslationTable{
["ttiacqsziukjjas"] = "張叔夜",
["#ttiacqsziukjjas"] = "天兵",
["designer:ttiacqsziukjjas"] = "設計",
["cv:ttiacqsziukjjas"] = "配音",
["illustrator:ttiacqsziukjjas"] = "畫師",
["~ttiacqsziukjjas"] = "",
}

General:new(extension, "ddiucqssxiqdoavh", "pujh", 5):addSkills {"touktszjens" } 
Fk:loadTranslationTable{
["ddiucqssxiqdoavh"] = "种師道",
["#ddiucqssxiqdoavh"] = "經略使",
["designer:ddiucqssxiqdoavh"] = "設計",
["cv:ddiucqssxiqdoavh"] = "配音",
["illustrator:ddiucqssxiqdoavh"] = "畫師",
["~ddiucqssxiqdoavh"] = "",
}

General:new(extension, "ddiucqssxiqttiuc", "pujh", 4):addSkills {"kiamsmrac","krachbuac" } --,
Fk:loadTranslationTable{
["ddiucqssxiqttiuc"] = "种師中",
["#ddiucqssxiqttiuc"] = "天兵",
["designer:ddiucqssxiqttiuc"] = "設計",
["cv:ddiucqssxiqttiuc"] = "配音",
["illustrator:ddiucqssxiqttiuc"] = "畫師",
["~ddiucqssxiqttiuc"] = "",
}

-- --
-- 1. 楔子　張天師祈禳瘟疫　洪太尉誤走妖魔
-- 2. 第一回　王教頭私走延安府　九紋龍大鬧史家村
-- 3. 第二回　史大郎夜走華陰縣　魯提轄拳打鎮關西
-- 4. 第三回　趙員外重修文殊院　魯智深大鬧五臺山
-- 5. 第四回　小霸王醉入銷金帳　花和尚大鬧桃花村
-- 6. 第五回　九紋龍翦徑赤松林　魯智深火燒瓦官寺
-- 7. 第六回　花和尚倒拔垂楊柳　豹子頭誤入白虎堂
-- 8. 第七回　林教頭刺配滄州道　魯智深大鬧野豬林
-- 9. 第八回　柴進門招天下客　林沖棒打洪教頭
-- 10. 第九回　林教頭風雪山神廟　陸虞候火燒草料場
-- 11. 第十回　朱貴水亭施號箭　林沖雪夜上梁山
-- 12. 第十一回　梁山泊林沖落草　汴京城楊志賣刀
-- 13. 第十二回　青面獸北京斗武　急先鋒東郭爭功
-- 14. 第十三回　赤發鬼醉臥靈官殿　晁天王認義東溪村
-- 15. 第十四回　吳學究說三阮撞籌　公孫勝應七星聚義
-- 16. 第十五回　楊志押送金銀擔　吳用智取生辰綱
-- 17. 第十六回　花和尚單打二龍山　青面獸雙奪寶珠寺
-- 18. 第十七回　美髯公智穩插翅虎　宋公明私放晁天王
-- 19. 第十八回　林沖水寨大並火　晁蓋梁山小奪泊
-- 20. 第十九回　梁山泊義士尊晁蓋　鄆城縣月夜走劉唐
-- 21. 第二十回　虔婆醉打唐牛兒　宋江怒殺閻婆惜
-- 22. 第二十一回　閻婆大鬧鄆城縣　朱仝義釋宋公明
-- 23. 第二十二回　橫海郡柴進留賓　景陽岡武松打虎
-- 24. 第二十三回　王婆貪賄說風情　鄆哥不忿鬧茶肆
-- 25. 第二十四回　王婆計啜西門慶　淫婦藥鴆武大郎
-- 26. 第二十五回　偷骨殖何九送喪　供人頭武二設祭
-- 27. 第二十六回　母夜叉孟州道賣人肉　武都頭十字坡遇張青
-- 28. 第二十七回　武松威震平安寨　施恩義奪快活林
-- 29. 第二十八回　施恩重霸孟州道　武松醉打蔣門神
-- 30. 第二十九回　施恩三入死囚牢　武松大鬧飛雲浦
-- 31. 第三十回　張都監血濺鴛鴦樓　武行者夜走蜈蚣嶺
-- 32. 第三十一回　武行者醉打孔亮　錦毛虎義釋宋江
-- 33. 第三十二回　宋江夜看小鰲山　花榮大鬧淸風寨
-- 34. 第三十三回　鎮三山大鬧青州道　霹靂火夜走瓦礫場
-- 35. 第三十四回　石將軍村店寄書　小李廣梁山射雁
-- 36. 第三十五回　梁山泊吳用舉戴宗　揭陽嶺宋江逢李俊
-- 37. 第三十六回　沒遮攔追趕及時雨　船火兒夜鬧潯陽江
-- 38. 第三十七回　及時雨會神行太保　黑旋風展浪裏白條
-- 39. 第三十八回　潯陽樓宋江吟反詩　梁山泊戴宗傳假信
-- 40. 第三十九回　梁山泊好漢劫法場　白龍廟英雄小聚義
-- 41. 第四十回　宋江智取無為軍　張順活捉黃文炳
-- 42. 第四十一回　還道村受三卷天書　宋公明遇九天玄女
-- 43. 第四十二回　假李逵剪徑劫單身　黑旋風沂嶺殺四虎
-- 44. 第四十三回　錦豹子小徑逢戴宗　病關索長街遇石秀
-- 45. 第四十四回　楊雄醉罵潘巧雲　石秀智殺裴如海
-- 46. 第四十五回　病關索大闹翠屏山　拚命三火燒祝家店
-- 47. 第四十六回　撲天鵰雙修生死書　宋公明一打祝家莊
-- 48. 第四十七回　一丈青單捉王矮虎　宋公明二打祝家莊
-- 49. 第四十八回　解珍解寶雙越獄　孫立孫新大劫牢
-- 50. 第四十九回　吳學究雙掌連環計　宋公明三打祝家莊
-- 51. 第五十回　插翅虎枷打白秀英　美髯公誤失小衙內
-- 52. 第五十一回　李逵打死殷天賜　柴進失陷高唐州
-- 53. 第五十二回　戴宗二取公孫勝　李逵獨劈羅真人
-- 54. 第五十三回　入雲龍鬥法破高廉　黑旋風下井救柴進
-- 55. 第五十四回　高太尉大興三路兵　呼延灼擺布連環馬
-- 56. 第五十五回　吳用使時遷偷甲　湯隆賺徐寧上山
-- 57. 第五十六回　徐寧教使鉤鐮槍　宋江大破連環馬
-- 58. 第五十七回　三山聚義打青州　眾虎同心歸水泊
-- 59. 第五十八回　吳用賺金鈴吊掛　宋江鬧西嶽華山
-- 60. 第五十九回　公孫勝芒碭山降魔　晁天王曾頭市中箭
-- 61. 第六十回　吳用智賺玉麒麟　張順夜鬧金沙渡
-- 62. 第六十一回　放冷箭燕青救主　劫法場石秀跳樓
-- 63. 第六十二回　宋江兵打大名城　關勝議取梁山泊
-- 64. 第六十三回　呼延灼月夜賺關勝　宋公明雪天擒索超
-- 65. 第六十四回　托塔天王夢中顯聖　浪裏白條水上報冤
-- 66. 第六十五回　時遷火燒翠雲樓　吳用智取大名府
-- 67. 第六十六回　宋江賞步三軍　關勝降水火二將
-- 68. 第六十七回　宋公明夜打曾頭市　盧俊義活捉史文恭
-- 69. 第六十八回　東平府誤陷九紋龍　宋公明義釋雙槍將
-- 70. 第六十九回　沒羽箭飛石打英雄　宋公明棄糧擒壯士
-- 71. 第七十回　忠義堂石碣受天文　梁山泊英雄驚惡夢
-- 72. 第七十一回　梁山泊英雄排座次　宋公明慷慨話宿願
-- 73. 第七十二回　柴進簪花入禁院　李逵元夜鬧東京
-- 74. 第七十三回　黑旋風喬捉鬼　梁山泊雙獻頭
-- 75. 第七十四回　燕青智撲「擎天柱」　李逵壽張喬坐衙
-- 76. 第七十五回　活閻羅倒船偷御酒　黑旋風扯詔罵欽差
-- 77. 第七十六回　吳加亮布四斗五方旗　宋公明排九宮八卦陣
-- 78. 第七十七回　梁山泊十面埋伏　宋公明兩贏童貫
-- 79. 第七十八回　十節度議取梁山泊　宋公明一敗高太尉
-- 80. 第七十九回　劉唐放火燒戰船　宋江兩敗高太尉
-- 81. 第八十回　張順鑿漏海鰍船　宋江三敗高太尉
-- 82. 第八十一回　燕青月夜遇道君　戴宗定計出樂和
-- 83. 第八十二回　梁山泊分金大買市　宋公明全夥受招安
-- 84. 第八十三回　宋公明奉詔破大遼　陳橋驛滴淚斬小卒
-- 85. 第八十四回　宋公明兵打薊州城　盧俊義大戰玉田縣
-- 86. 第八十五回　宋公明夜度益津關　吳學究智取文安縣
-- 87. 第八十六回　宋公明大戰獨鹿山　盧俊義兵陷青石峪
-- 88. 第八十七回　宋公明大戰幽州　呼延灼力擒番將
-- 89. 第八十八回　顏統軍陣列混天象　宋公明夢授玄女法
-- 90. 第八十九回　宋公明破陣成功　宿太尉頒恩降詔
-- 91. 第九十回　五臺山宋江參禪　雙林鎮燕青遇故
-- 92. 第九十一回　宋公明兵渡黃河　盧俊義賺城黑夜
-- 93. 第九十二回　振軍威小李廣神箭　打蓋郡智多星密籌
-- 94. 第九十三回　李逵夢鬧天池　宋江兵分兩路
-- 95. 第九十四回　關勝義降三將　李逵莽陷眾人
-- 96. 第九十五回　宋公明忠感后土　喬道淸術敗宋兵
-- 97. 第九十六回　幻魔君術窘五龍山　入雲龍兵圍百谷嶺
-- 98. 第九十七回　陳　諫官升安撫　瓊英處女做先鋒
-- 99. 第九十八回　張淸緣配瓊英　吳用計鴆鄔梨
-- 100. 第九十九回　花和尚解脫緣纏井　混江龍水灌太原城
-- 101. 第一百回　張淸瓊英雙建功　陳　宋江同奏捷
-- 102. 第一百零一回　謀墳地陰險產逆　蹈春陽妖　生奸
-- 103. 第一百零二回　王慶因奸　官司　龔端被打師軍犯
-- 104. 第一百零三回　張管營因妾弟喪身　範節級為表兄醫臉
-- 105. 第一百零四回　段家莊重招新女婿　房山寨雙並舊強人
-- 106. 第一百零五回　宋公明避暑療軍兵　喬道淸回風燒賊寇
-- 107. 第一百零六回　書生談笑卻強敵　水軍汨沒破堅城
-- 108. 第一百零七回　宋江大勝紀山軍　朱武打破六花陣
-- 109. 第一百零八回　喬道淸興霧取城　小旋風藏炮擊賊
-- 110. 第一百零九回　王慶渡江被捉　宋江剿寇成功
-- 111. 第一百一十回　燕青秋林渡射　宋江東京城獻俘
-- 112. 第一百一十一回　張順夜伏金山寺　宋江智取潤州城
-- 113. 第一百一十二回　盧俊義分兵宣州道　宋公明大戰毗陵郡
-- 114. 第一百一十三回　混江龍太湖小結義　宋公明蘇州大會垓
-- 115. 第一百一十四回　寧海軍宋江吊孝　湧金門張順歸神
-- 116. 第一百一十五回　張順魂捉方天定　宋江智取寧海軍
-- 117. 第一百一十六回　盧俊義分兵歙州道　宋公明大戰烏龍嶺
-- 118. 第一百一十七回　睦州城箭射鄧元覺　烏龍嶺神助宋公明
-- 119. 第一百一十八回　盧俊義大戰昱嶺關　宋公明智取淸溪洞
-- 120. 第一百一十九回　魯智深浙江坐化　宋公明衣錦還鄉
-- 121. 第一百二十回　宋公明神聚蓼兒　徽宗帝夢游梁山泊
--
return extension
