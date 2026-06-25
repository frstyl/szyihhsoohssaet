local extension = Package:new("generals_01")
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/generals_01/skills")

Fk:loadTranslationTable{
["generals_01"] = "序",
["pujh"] = "匪",
["kvoan"] = "官",
["mjin"] = "民",
["tsiacs"] = "將",
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
jiac__muohdoarloac:addSkills { "khutdzioc","nzjinhnziok","hzoomqhzoeons"}
jiac__muohdoarloac:addRelatedSkill("tsziukzzyit_mxiqquns")
Fk:loadTranslationTable{
["jiac__muohdoarloac"] = "武大郎",
["#jiac__muohdoarloac"] = "三寸丁穀樹皮",
["designer:jiac__muohdoarloac"] = "設計",
["cv:jiac__muohdoarloac"] = "配音",
["illustrator:jiac__muohdoarloac"] = "畫師",
["~jiac__muohdoarloac"] = "苦乎",
}

local hqxim__muohdoarloac = General:new(extension, "hqxim__muohdoarloac", "mjin", 3,3,General.Female)
hqxim__muohdoarloac:addSkills { "loakkoan","leechjiak","ljetmuns"}
hqxim__muohdoarloac:addRelatedSkill("tsziukzzyit_dzjecshsfas")
Fk:loadTranslationTable{
["hqxim__muohdoarloac"] = "潘金蓮",
["#hqxim__muohdoarloac"] = "鏡花水月",
["designer:hqxim__muohdoarloac"] = "設計",
["cv:hqxim__muohdoarloac"] = "配音",
["illustrator:hqxim__muohdoarloac"] = "畫師",
["~hqxim__muohdoarloac"] = "苦乎",
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
hqxim__doucqkxevqsius:addSkills { "liuqhzfa","hseekdziac","hsfaqdzoacs"}
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

local hqxim__hzoohsoamnniac = General:new(extension, "hqxim__hzoohsoamnniac", "mjin", 3,3, General.Female)
hqxim__hzoohsoamnniac:addSkills { "tthiuqtoav","doucqsjim","hzaocqdzioc"}
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

local jiac__touchbrac = General:new(extension, "jiac__touchbrac", "mjin", 4/5)
jiac__touchbrac:addSkills { "puanhmiuk","giacqpaas","jiokhsoak"}
jiac__touchbrac:addRelatedSkill("tsziukzzyit_puanhdoan")
Fk:loadTranslationTable{
["jiac__touchbrac"] = "董平",
["#jiac__touchbrac"] = "濁流清源",--東平都監
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

-- General:new(extension, "soocskaoc", "kvoan", 4):addSkills { "koamqljim","dzuohcxes"}  --霖ljim lieom
-- Fk:loadTranslationTable{
-- ["soocskaoc"] = "宋江",
-- ["#soocskaoc"] = "及旹雨",
-- ["designer:soocskaoc"] = "設計",
-- ["cv:soocskaoc"] = "配音",
-- ["illustrator:soocskaoc"] = "畫師",
-- ["~soocskaoc"] = "望天王降詔,早招安,心方足",
-- }
    
-- General:new(extension, "looqtsyinscxes", "kvoan", 4):addSkills { "poavskvoeok" }
-- Fk:loadTranslationTable{
-- ["looqtsyinscxes"] = "盧俊義",
-- ["#looqtsyinscxes"] = "玉麒麟",
-- ["designer:looqtsyinscxes"] = "設計",
-- ["cv:looqtsyinscxes"] = "配音",
-- ["illustrator:looqtsyinscxes"] = "畫師",
-- ["~looqtsyinscxes"] = "我生爲大宋人,死爲大宋鬼",
-- }

-- General:new(extension, "koucqsoonqszics", "pujh", 3):addSkills { "gxeqmoon", "jjeqseec" }
-- Fk:loadTranslationTable{
-- ["koucqsoonqszics"] = "公孫勝",
-- ["#koucqsoonqszics"] = "入雲龍",
-- ["designer:koucqsoonqszics"] = "設計",
-- ["cv:koucqsoonqszics"] = "配音",
-- ["illustrator:koucqsoonqszics"] = "畫師",
-- ["~koucqsoonqszics"] = "天罡䀆已歸天界,地煞還應入地中",
-- }



-- General:new(extension, "cooqjiocs", "mjin", 3):addSkills { "qunsddiuq", "hzfektsshaek" }
-- Fk:loadTranslationTable{
-- ["cooqjiocs"] = "吳用",
-- ["#cooqjiocs"] = "智多星",
-- ["designer:cooqjiocs"] = "設計",
-- ["cv:cooqjiocs"] = "配音",
-- ["illustrator:cooqjiocs"] = "畫師",
-- ["~cooqjiocs"] = "八百里水洦,化作南珂一夢",
-- }

-- General:new(extension, "kfanqszics", "kvoan", 4):addSkills{"hsoohgxes","thoucqmuoh"}
-- Fk:loadTranslationTable{
-- ["kfanqszics"] = "關勝",
-- ["#kfanqszics"] = "大刀",
-- ["designer:kfanqszics"] = "設計",
-- ["cv:kfanqszics"] = "配音",
-- ["illustrator:kfanqszics"] = "畫師",
-- ["~kfanqszics"] = "武雖通,人難長",
-- }

-- General:new(extension, "ljimqtthioc", "tsiacs", 5):addSkills { "toojskveet" }
-- Fk:loadTranslationTable{
-- ["ljimqtthioc"] = "林冲",
-- ["#ljimqtthioc"] = "豹子頭",
-- ["designer:ljimqtthioc"] = "設計",
-- ["cv:ljimqtthioc"] = "配音",
-- ["illustrator:ljimqtthioc"] = "畫師",
-- ["~ljimqtthioc"] = "家讎何日報",
-- }


-- General:new(extension, "dzjinqmrac", "tsiacs", 4):addSkills { "boavsnoos" }
-- Fk:loadTranslationTable{
-- ["dzjinqmrac"] = "秦明",
-- ["#dzjinqmrac"] = "霹靂火",
-- ["designer:dzjinqmrac"] = "設計",
-- ["cv:dzjinqmrac"] = "配音",
-- ["illustrator:dzjinqmrac"] = "畫師",
-- ["~dzjinqmrac"] = "可憐霹靂火,滅地竟无聲",
-- }

-- General:new(extension, "hsooqjenqtsziak", "kvoan", 5):addSkills { "ljenqmaah" }
-- Fk:loadTranslationTable{
-- ["hsooqjenqtsziak"] = "呼延灼",
-- ["#hsooqjenqtsziak"] = "雙鞭",
-- ["designer:hsooqjenqtsziak"] = "設計",
-- ["cv:hsooqjenqtsziak"] = "配音",
-- ["illustrator:hsooqjenqtsziak"] = "畫師",
-- ["~hsooqjenqtsziak"] = "老當益壯報國家,敢叫金人喪破膽",
-- }


-- General:new(extension, "hsfaqqvrec", "kvoan", 4):addSkills { "tsjectszyinh","kheejhhzeen" }
-- Fk:loadTranslationTable{
-- ["hsfaqqvrec"] = "花榮",
-- ["#hsfaqqvrec"] = "小李廣",
-- ["designer:hsfaqqvrec"] = "設計",
-- ["cv:hsfaqqvrec"] = "配音",
-- ["illustrator:hsfaqqvrec"] = "畫師",
-- ["~hsfaqqvrec"] = "一腔義烈元相契,封樹高懸兩命亾",
-- }


-- General:new(extension, "dzsaeqtsjins", "kvoan", 3):addSkills { "hzoavqszjin","toanqszio" }
-- Fk:loadTranslationTable{
-- ["dzsaeqtsjins"] = "柴進",
-- ["#dzsaeqtsjins"] = "小旋風",
-- ["designer:dzsaeqtsjins"] = "設計",
-- ["cv:dzsaeqtsjins"] = "配音",
-- ["illustrator:dzsaeqtsjins"] = "畫師",
-- ["~dzsaeqtsjins"] = "難道,昰先朝之物,沒用l",
-- }

-- General:new(extension, "lihhqics", "kvoan", 5):addSkills { "khoucsliac" }
-- Fk:loadTranslationTable{
-- ["lihhqics"] = "李應",
-- ["#lihhqics"] = "撲天雕",
-- ["designer:lihhqics"] = "設計",
-- ["cv:lihhqics"] = "配音",
-- ["illustrator:lihhqics"] = "畫師",
-- ["~lihhqics"] = "源䀆糧絕,以何取勝",
-- }



-- General:new(extension, "tszioqdouc", "pujh", 4):addSkills{"likbvat","dzvashsfas"}
-- Fk:loadTranslationTable{
-- ["tszioqdouc"] = "朱仝",  --同
-- ["#tszioqdouc"] = "美髯公",
-- ["designer:tszioqdouc"] = "設計",
-- ["cv:tszioqdouc"] = "配音",
-- ["illustrator:tszioqdouc"] = "畫師",
-- ["~tszioqdouc"] = "可恨那黑廝",
-- }

-- General:new(extension, "loohttxesszjin", "pujh", 4):addSkills{"likbvat","dzvashsfas"}  --13
-- Fk:loadTranslationTable{
-- ["loohttxesszjin"] = "魯智㴱",
-- ["#loohttxesszjin"] = "花和尚",
-- ["designer:loohttxesszjin"] = "設計",
-- ["cv:loohttxesszjin"] = "配音",
-- ["illustrator:loohttxesszjin"] = "畫師",
-- ["~loohttxesszjin"] = "錢塘江上朝信來,今日方知我是我",
-- }

-- General:new(extension, "muohsioc", "tsiacs", 5):addSkills { "biukhsooh" }
-- Fk:loadTranslationTable{
-- ["muohsioc"] = "武松",
-- ["#muohsioc"] = "沒羽箭",
-- ["designer:muohsioc"] = "設計",
-- ["cv:muohsioc"] = "配音",
-- ["illustrator:muohsioc"] = "畫師",
-- ["~muohsioc"] = "還我哥哥命來",
-- }

-- General:new(extension, "touchbrac", "kvoan", 4):addSkills{"saocqlioc"}    --15
-- Fk:loadTranslationTable{
-- ["touchbrac"] = "董平",
-- ["#touchbrac"] = "雙槍將",
-- ["designer:touchbrac"] = "設計",
-- ["cv:touchbrac"] = "配音",
-- ["illustrator:touchbrac"] = "畫師",
-- ["~touchbrac"] = "背後有人",
-- }

-- General:new(extension, "ttiacqtshjec", "kvoan", 4):addSkills{"hqximhquoh"}
-- Fk:loadTranslationTable{
-- ["ttiacqtshjec"] = "張清",
-- ["#ttiacqtshjec"] = "沒羽箭",
-- ["designer:ttiacqtshjec"] = "設計",
-- ["cv:ttiacqtshjec"] = "配音",
-- ["illustrator:ttiacqtshjec"] = "畫師",
-- ["~ttiacqtshjec"] = "一技之長不足傍身na",
-- }

-- General:new(extension, "jiacqtszis", "kvaon", 5):addSkills {"maestoav", "phiocqmoac" }
-- Fk:loadTranslationTable{
-- ["jiacqtszis"] = "楊志",
-- ["#jiacqtszis"] = "靑面獸",
-- ["designer:jiacqtszis"] = "設計",
-- ["cv:jiacqtszis"] = "配音",
-- ["illustrator:jiacqtszis"] = "畫師",
-- ["~jiacqtszis"] = "无顏面對列祖列宗",
-- }

-- General:new(extension, "zioqneec", "tsiacs", 5):addSkills {"kouqljem", "kximqkaap" }
-- Fk:loadTranslationTable{
-- ["zioqneec"] = "徐寧",
-- ["#zioqneec"] = "金槍手",
-- ["designer:zioqneec"] = "設計",
-- ["cv:zioqneec"] = "配音",
-- ["illustrator:zioqneec"] = "畫師",
-- ["~zioqneec"] = "刀槍入庫,馬放南山",
-- }

-- General:new(extension, "soaktthxev", "tsiacs", 4):addSkills {"thoopddxins", "tshziocqphioc" }
-- Fk:loadTranslationTable{
-- ["soaktthxev"] = "索超",
-- ["#soaktthxev"] = "神行太保",
-- ["designer:soaktthxev"] = "設計",
-- ["cv:soaktthxev"] = "配音",
-- ["illustrator:soaktthxev"] = "畫師",
-- ["~soaktthxev"] = "成也蕭何,敗也蕭何",
-- }

-- General:new(extension, "toeojstsooc", "tsiacs", 4):addSkills { "mrittshzjek" }  --20
-- Fk:loadTranslationTable{
-- ["toeojstsooc"] = "戴宗",
-- ["#toeojstsooc"] = "神行太保",
-- ["designer:toeojstsooc"] = "設計",
-- ["cv:toeojstsooc"] = "配音",
-- ["illustrator:toeojstsooc"] = "畫師",
-- ["~toeojstsooc"] = "消息有誤",
-- }

-- General:new(extension, "liuqdoac", "tsiacs", 5):addSkills { "hzaahszio" }
-- Fk:loadTranslationTable{
-- ["liuqdoac"] = "劉唐",
-- ["#liuqdoac"] = "赤髮鬼",
-- ["designer:liuqdoac"] = "設計",
-- ["cv:liuqdoac"] = "配音",
-- ["illustrator:liuqdoac"] = "畫師",
-- ["~liuqdoac"] = "如此身死,眞是委屈",
-- }


-- General:new(extension, "lihgwi", "tsiacs", 4):addSkills { "ssaetliuk" }  --22 --羅真人
-- Fk:loadTranslationTable{
-- ["lihgwi"] = "李逵",
-- ["#lihgwi"] = "黑旋風",
-- ["designer:lihgwi"] = "設計",
-- ["cv:lihgwi"] = "配音",
-- ["illustrator:lihgwi"] = "畫師",
-- ["~lihgwi"] = "生旹伏侍哥哥,死了,也是哥哥部下一个小鬼",
-- }

-- General:new(extension, "jiacqqiuc", "tsiacs", 5):addSkills{"hzaacqhzeec",}  --s2
-- Fk:loadTranslationTable{
-- ["jiacqqiuc"] = "楊雄",
-- ["#jiacqqiuc"] = "病關索",
-- ["designer:jiacqqiuc"] = "設計",
-- ["cv:jiacqqiuc"] = "配音",
-- ["illustrator:jiacqqiuc"] = "畫師",
-- ["~jiacqqiuc"] = "背瘡疼痛,恨不能戰死殺場",
-- }

-- General:new(extension, "dzzjeksius", "tsiacs", 4/6):addSkills{"brensmrecs",}  --s2 --33
-- Fk:loadTranslationTable{
-- ["dzzjeksius"] = "石秀",
-- ["#dzzjeksius"] = "拚命三郎",
-- ["designer:dzzjeksius"] = "設計",
-- ["cv:dzzjeksius"] = "配音",
-- ["illustrator:dzzjeksius"] = "畫師",
-- ["~dzzjeksius"] = "ə 拚到底lə ",
-- }
-- --djesssaet

-- General:new(extension, "hzvoacqsjins", "kvoan", 5):addSkills{"thoocshzaat"}  --38
-- Fk:loadTranslationTable{
-- ["hzvoacqsjins"] = "黃信",
-- ["#hzvoacqsjins"] = "鎮三山",
-- ["designer:hzvoacqsjins"] = "設計",
-- ["cv:hzvoacqsjins"] = "配音",
-- ["illustrator:hzvoacqsjins"] = "畫師",
-- ["~hzvoacqsjins"] = "三山崛起,力不从心",
-- }

-- General:new(extension, "syenqtsoans", "kvoan", 4):addSkills{"khiochhsaas"}  --40
-- Fk:loadTranslationTable{
-- ["syenqtsoans"] = "宣贊",
-- ["#syenqtsoans"] = "醜郡馬",
-- ["designer:syenqtsoans"] = "設計",
-- ["cv:syenqtsoans"] = "配音",
-- ["illustrator:syenqtsoans"] = "畫師",
-- ["~syenqtsoans"] = "此処便是飲馬橋",
-- }

-- General:new(extension, "baackhih", "kvoan", 5):addSkills{"seenqpuat",}  --43
-- Fk:loadTranslationTable{
-- ["baackhih"] = "彭玘",
-- ["#baackhih"] = "天目將",
-- ["designer:baackhih"] = "設計",
-- ["cv:baackhih"] = "配音",
-- ["illustrator:baackhih"] = "畫師",
-- ["~baackhih"] = "敵竟料于我先",
-- }

-- General:new(extension, "seevqnziacs", "mjin", 3):addSkills {"ljimqmoo", "ttaekseec" }  --46
-- Fk:loadTranslationTable{
-- ["seevqnziacs"] = "蕭讓",
-- ["#seevqnziacs"] = "聖手書生",
-- ["designer:seevqnziacs"] = "設計",
-- ["cv:seevqnziacs"] = "配音",
-- ["illustrator:seevqnziacs"] = "畫師",
-- ["~seevqnziacs"] = "心已无聲,生命可否仿造",
-- }

-- General:new(extension, "boeojqsyen", "kvaon", 3):addSkills {"szjimhphoans", "prachkoucq" } --47
-- Fk:loadTranslationTable{
-- ["boeojqsyen"] = "裴宣",
-- ["#boeojqsyen"] = "鐵面孔目",
-- ["designer:boeojqsyen"] = "設計",
-- ["cv:boeojqsyen"] = "配音",
-- ["illustrator:boeojqsyen"] = "畫師",
-- ["~boeojqsyen"] = "䀆是暗箱操作",
-- }

-- General:new(extension, "licqtszjins", "kvoan", 4):addSkills {"phaavshsfec"} --52
-- Fk:loadTranslationTable{
-- ["licqtszjins"] = "凌振",
-- ["#licqtszjins"] = "轟天雷",
-- ["designer:licqtszjins"] = "設計",
-- ["cv:licqtszjins"] = "配音",
-- ["illustrator:licqtszjins"] = "畫師",
-- ["~licqtszjins"] = "吾決不會倒下",
-- }







-- General:new(extension, "tsiachkrach", "pujh", 3):addSkills{"hzfektszuo","tsjecqsvoans"}  --53
-- Fk:loadTranslationTable{
-- ["tsiachkrach"] = "蔣敬",
-- ["#tsiachkrach"] = "神算子",
-- ["designer:tsiachkrach"] = "設計",
-- ["cv:tsiachkrach"] = "配音",
-- ["illustrator:tsiachkrach"] = "畫師",
-- ["~tsiachkrach"] = "人算不如天算na",
-- }

-- General:new(extension, "liohpuac", "tsiacs", 5):addSkills{"ljetkrak"}  --54
-- Fk:loadTranslationTable{
-- ["liohpuac"] = "呂方",
-- ["#liohpuac"] = "小溫矦",
-- ["designer:liohpuac"] = "設計",
-- ["cv:liohpuac"] = "配音",
-- ["illustrator:liohpuac"] = "畫師",
-- ["~liohpuac"] = "用力過猛l",
-- }


-- General:new(extension, "kvakszics", "tsiacs", 5):addSkills{"pjecskrak"}  --55
-- Fk:loadTranslationTable{
-- ["kvakszics"] = "郭勝",
-- ["#kvakszics"] = "賽仁貴",
-- ["designer:kvakszics"] = "設計",
-- ["cv:kvakszics"] = "配音",
-- ["illustrator:kvakszics"] = "畫師",
-- ["~kvakszics"] = "就昰像結束ləmə",
-- }


-- General:new(extension, "hzvoacqpuohtvoan", "mjin", 3):addSkills {"siacqmaah", "dzeensmaah","hqiqmaah"}  --57
-- Fk:loadTranslationTable{
-- ["hzvoacqpuohtvoan"] = "皇甫端",
-- ["#hzvoacqpuohtvoan"] = "紫髯伯",
-- ["designer:hzvoacqpuohtvoan"] = "設計",
-- ["cv:hzvoacqpuohtvoan"] = "配音",
-- ["illustrator:hzvoacqpuohtvoan"] = "畫師",
-- ["~hzvoacqpuohtvoan"] = "良馬贈与英雄,可惜百戰成空",
-- }

-- General:new(extension, "maahljin", "pujh", 3):addSkills{"leecqdeek", "khaavhtous"}  --67
-- Fk:loadTranslationTable{
-- ["maahljin"] = "馬麟",
-- ["#maahljin"] = "靈駒子",
-- ["designer:maahljin"] = "設計",
-- ["cv:maahljin"] = "配音",
-- ["illustrator:maahljin"] = "畫師",
-- ["~maahljin"] = "盛世不再,止餘悲歌",
-- }



-- General:new(extension, "miukzzyins", "mjin", 3):addSkills{"paasdoavh", "hzfacsdzoeoj"}  --80
-- Fk:loadTranslationTable{
-- ["miukzzyins"] = "穆順",
-- ["#miukzzyins"] = "小遮攔",
-- ["designer:koucsoonszix"] = "設計",
-- ["cv:koucsoonszix"] = "配音",
-- ["illustrator:koucsoonszix"] = "畫師",
-- ["~miukzzyins"] = "aj,兄弟離散,各奔東西",
-- }

-- General:new(extension, "szjeqhqoeon", "mjin", 3):addSkills{"louchloak", "sjevqtsoeoj"}  --85
-- Fk:loadTranslationTable{
-- ["szjeqhqoeon"] = "施恩",
-- ["#szjeqhqoeon"] = "金眼彪",
-- ["designer:szjeqhqoeon"] = "設計",
-- ["cv:szjeqhqoeon"] = "配音",
-- ["illustrator:szjeqhqoeon"] = "畫師",
-- ["~szjeqhqoeon"] = "都不是等閒之輩",
-- }

-- General:new(extension, "lihttiuc", "mjin", 5):addSkills{"khaenqljins","tsheejtsheej"}  --86
-- Fk:loadTranslationTable{
-- ["lihttiuc"] = "李忠",
-- ["#lihttiuc"] = "空空",
-- ["designer:lihttiuc"] = "設計",
-- ["cv:lihttiuc"] = "配音",
-- ["illustrator:lihttiuc"] = "畫師",
-- ["~lihttiuc"] = "止可惜l俺那祖傳t膏藥a",
-- }

-- General:new(extension, "lihlip", "pujh", 3):addSkills{"miuqdzoeoj","dvatmrecs"}  --96
-- Fk:loadTranslationTable{
-- ["lihlip"] = "李立",
-- ["#lihlip"] = "催命判官",
-- ["designer:lihlip"] = "設計",
-- ["cv:lihlip"] = "配音",
-- ["illustrator:lihlip"] = "畫師",
-- ["~lihlip"] = "生不帶來,死不帶去",
-- }

-- General:new(extension, "tsjevdeech", "mjin", 4):addSkills {"poaklioc","jyonkaap"}  --98
-- Fk:loadTranslationTable{
-- ["tsjevdeech"] = "焦挺",
-- ["#tsjevdeech"] = "沒面目",
-- ["designer:tsjevdeech"] = "設計",
-- ["cv:tsjevdeech"] = "配音",
-- ["illustrator:tsjevdeech"] = "畫師",
-- ["~tsjevdeech"] = "一身絕技竟无用武之地",
-- }

-- General:new(extension, "soonqsjin", "mjin", 5):addSkills {"kiaploav","sziuhbxis"}  --100
-- Fk:loadTranslationTable{
-- ["soonqsjin"] = "孫新",
-- ["#soonqsjin"] = "小尉遲",
-- ["designer:soonqsjin"] = "設計",
-- ["cv:soonqsjin"] = "配音",
-- ["illustrator:soonqsjin"] = "畫師",
-- ["~soonqsjin"] = "燕雀安知鴻鵠之志",
-- }

-- General:new(extension, "quacqdeecsliuk", "mjin", 3):addSkills {"dzjitboos", "khoucqhqrach", "jjenhmuoh" }  --104
-- Fk:loadTranslationTable{
-- ["quacqdeecsliuk"] = "王定六",
-- ["#quacqdeecsliuk"] = "活閃婆",
-- ["designer:quacqdeecsliuk"] = "設計",
-- ["cv:quacqdeecsliuk"] = "配音",
-- ["illustrator:quacqdeecsliuk"] = "畫師",
-- ["~quacqdeecsliuk"] = "大意了",
-- }




-- --
-- General:new(extension, "ddxevhgxit", "kvoan", 3):addSkills{"szjaqmxeh", "ljeqttjecs", "loucsguan"}  --s2
-- Fk:loadTranslationTable{
-- ["ddxevhgxit"] = "趙佶",
-- ["#ddxevhgxit"] = "宋徽宗",
-- ["designer:ddxevhgxit"] = "設計",
-- ["cv:ddxevhgxit"] = "配音",
-- ["illustrator:ddxevhgxit"] = "畫師",
-- ["~ddxevhgxit"] = "家山回首三千里,目斷天南无雁飛",
-- }

-- General:new(extension, "tshoarkrac", "kvoan", 4):addSkills {"kaaqszio","dvatguan"}
-- Fk:loadTranslationTable{
-- ["tshoarkrac"] = "蔡京",
-- ["#tshoarkrac"] = "姦相",
-- ["designer:tshoarkrac"] = "設計",
-- ["cv:tshoarkrac"] = "配音",
-- ["illustrator:tshoarkrac"] = "畫師",
-- ["~tshoarkrac"] = "旹至今日方知百姓之恨",
-- }

-- General:new(extension, "koavqgiu", "kvoan", 3):addSkills{"khiochhsaas"}  --s2
-- Fk:loadTranslationTable{
-- ["koavqgiu"] = "高俅",
-- ["#koavqgiu"] = "太尉",
-- ["designer:koavqgiu"] = "設計",
-- ["cv:koavqgiu"] = "配音",
-- ["illustrator:koavqgiu"] = "畫師",
-- ["~koavqgiu"] = "報應,都是報應",
-- }

-- General:new(extension, "doucqkvoans", "kvoan", 4):addSkills {"tszjecqbuat","hqoavhsiacs"}
-- Fk:loadTranslationTable{
-- ["doucqkvoans"] = "童貫",
-- ["#doucqkvoans"] = "廣昜郡王",
-- ["designer:doucqkvoans"] = "設計",
-- ["cv:doucqkvoans"] = "配音",
-- ["illustrator:doucqkvoans"] = "畫師",
-- ["~doucqkvoans"] = "歬有伏兵,後有追兵,似此,爲之耐何",
-- }

-- --

-- General:new(extension, "ddxecsdoo", "mjin", 5):addSkills{"maanqhzfacs"}  --市井
-- Fk:loadTranslationTable{
-- ["ddxecsdoo"] = "鄭屠",
-- ["#ddxecsdoo"] = "鎭關西",
-- ["designer:ddxecsdoo"] = "設計",
-- ["cv:ddxecsdoo"] = "配音",
-- ["illustrator:ddxecsdoo"] = "畫師",
-- ["~ddxecsdoo"] = "打得好打得好",
-- }

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
-- 33. 第三十二回　宋江夜看小鰲山　花榮大鬧清風寨
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
-- 96. 第九十五回　宋公明忠感后土　喬道清術敗宋兵
-- 97. 第九十六回　幻魔君術窘五龍山　入雲龍兵圍百谷嶺
-- 98. 第九十七回　陳　諫官升安撫　瓊英處女做先鋒
-- 99. 第九十八回　張清緣配瓊英　吳用計鴆鄔梨
-- 100. 第九十九回　花和尚解脫緣纏井　混江龍水灌太原城
-- 101. 第一百回　張清瓊英雙建功　陳　宋江同奏捷
-- 102. 第一百零一回　謀墳地陰險產逆　蹈春陽妖　生奸
-- 103. 第一百零二回　王慶因奸　官司　龔端被打師軍犯
-- 104. 第一百零三回　張管營因妾弟喪身　範節級為表兄醫臉
-- 105. 第一百零四回　段家莊重招新女婿　房山寨雙並舊強人
-- 106. 第一百零五回　宋公明避暑療軍兵　喬道清回風燒賊寇
-- 107. 第一百零六回　書生談笑卻強敵　水軍汨沒破堅城
-- 108. 第一百零七回　宋江大勝紀山軍　朱武打破六花陣
-- 109. 第一百零八回　喬道清興霧取城　小旋風藏炮擊賊
-- 110. 第一百零九回　王慶渡江被捉　宋江剿寇成功
-- 111. 第一百一十回　燕青秋林渡射　宋江東京城獻俘
-- 112. 第一百一十一回　張順夜伏金山寺　宋江智取潤州城
-- 113. 第一百一十二回　盧俊義分兵宣州道　宋公明大戰毗陵郡
-- 114. 第一百一十三回　混江龍太湖小結義　宋公明蘇州大會垓
-- 115. 第一百一十四回　寧海軍宋江吊孝　湧金門張順歸神
-- 116. 第一百一十五回　張順魂捉方天定　宋江智取寧海軍
-- 117. 第一百一十六回　盧俊義分兵歙州道　宋公明大戰烏龍嶺
-- 118. 第一百一十七回　睦州城箭射鄧元覺　烏龍嶺神助宋公明
-- 119. 第一百一十八回　盧俊義大戰昱嶺關　宋公明智取清溪洞
-- 120. 第一百一十九回　魯智深浙江坐化　宋公明衣錦還鄉
-- 121. 第一百二十回　宋公明神聚蓼兒　徽宗帝夢游梁山泊
--
return extension
