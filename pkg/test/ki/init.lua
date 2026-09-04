local extension = Package:new("szyih")
extension.extensionName = "szyihtheen"

extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/test/ki/skills")

-- General:new(extension, "khouc", "pujh", 4):addSkills{"ttxisquanh","tszjinstoamh"}


local test0 = General(extension, "bb", "pujh", 4)
test0:addSkills {"pracqkaap"}
-- test0:addSkills {"seenqtszjis"}
--------------------印牌 
General:new(extension, "hqjinsbae", "kvoan", 3):addSkills{"hzfenskhouc","hzfenshsfas","tszhiocqhzaems"}  --㕕空 印牌旹機限制 
General:new(extension, "086", "kvoan", 3):addSkills{"ljimqkij","kiamsquoh","kijqphioc","muohtshiac"}  --印牌襍合
General:new(extension, "087", "kvoan", 3):addSkills{"pujqtoav","pujqddxek"}
General:new(extension, "063", "kvoan", 3):addSkills{"noojskaens"}
General:new(extension, "078", "kvoan", 3):addSkills{"biuhkiams"}--虛擬装僃
General:new(extension, "112", "kvoan", 3):addSkills{"ljerprac"}--殺
--------------------菜刀 增彊牌
General:new(extension, "tshoeojstoav__000", "kvoan", 3):addSkills{"kracqhzoon"}
General:new(extension, "tshoeojstoav__001", "kvoan", 3):addSkills{"tszyiqphioc", "hzeethzoac",} --二選一 秒
General:new(extension, "tshoeojstoav__003", "kvoan", 3):addSkills{"tssaamhbuat"}--謀黃忠烈弓
General:new(extension, "tshoeojstoav__004", "kvoan", 3):addSkills{"hzeenqkrac"}  --轉馬超 韓存保

General:new(extension, "033", "kvoan", 3):addSkills{"kiaplooh",}  -- 搶一半
General:new(extension, "023", "kvoan", 3):addSkills{"phunhtthxet","khuacqtseejs"} --任何旹可用 --對它用桃 未成
General:new(extension, "056", "kvoan", 3):addSkills{"kiamsmrac"} --能用殺則殺
General:new(extension, "062", "kvoan", 3):addSkills{"doachddio"} --潒除
General:new(extension, "064", "kvoan", 3):addSkills{"toavqprac","kiamsquoh"}  --衍生
General:new(extension, "079", "kvoan", 3):addSkills{"tsziochprac"}
General:new(extension, "074", "kvoan", 3):addSkills{"ex__bjevsgxes"}
General:new(extension, "097", "kvoan", 3):addSkills{"lyehkeek","dzjitkeek"}--不計入次數限制教學 无次數限制教學 相對于无視次數限制...區別 上限无窮大  迻除上限 繞過上限
General:new(extension, "109", "kvoan", 3):addSkills{"phiuskun",}

General:new(extension, "108", "kvoan", 3):addSkills{"khoeojqloos"}
-- General:new(extension, "073", "kvoan", 3):addSkills{"kwehssih"}--詭使 未作
General:new(extension, "111", "kvoan", 3):addSkills{"keekjyer",}  --技能甚至无牌
--------------------控
General:new(extension, "015", "kvoan", 3):addSkills{"jiacqcian","kijqcian"}  --預測 雞肋
General:new(extension, "080", "kvoan", 3):addSkills{"deevhtszjens"}  --預測 雞肋
General:new(extension, "053", "kvoan", 3):addSkills{ "kijqphioc","keekpoak"}  --賤 "nziokcoavs",
General:new(extension, "017", "kvoan", 3):addSkills{"hqujqtszjins","khuoqthoot"} --封牌 --中止回合
General:new(extension, "019", "kvoan", 3):addSkills{"dvoattoamh","kxevqgxes"}  --公共 --反抵消 弃閃 封技能 視爲閃
General:new(extension, "083", "kvoan", 3):addSkills{"kheemqsziuh"}  --雞肋止息
General:new(extension, "060", "kvoan", 3):addSkills{"muoqtoojs"}  --无雙无對

General:new(extension, "026", "kvoan", 3):addSkills{"krachbuac"}  --視爲閃 刻摸弃 
-- General:new(extension, "052", "kvoan", 3):addSkills{"nzjisdouch"}  --未作  --tousmuoh
General:new(extension, "088", "kvoan", 3):addSkills{"tousmuoh"}  --單挑

General:new(extension, "115", "kvoan", 3):addSkills{"tszihkvoa", "hzoojqbjes", "deephzoon"}  --止戈
--------------------全場
General:new(extension, "004", "kvoan", 3):addSkills{"hsuanqkooh","tssikkeek"}--hsuanqkooh 弃殺閃 --廢閃 封印皇甫 
General:new(extension, "022", "kvoan", 3):addSkills{"kujsssaac","tsheejqtsheej", "tszjevqtsziac"}  --償罰  "kveetciok",
General:new(extension, "065", "kvoan", 3):addSkills{"quandzsios",}  --援
General:new(extension, "024", "kvoan", 3):addSkills{"kiapbxin","muohtshiac"}  --對神龐統
General:new(extension, "031", "kvoan", 3):addSkills{"biushqoans",}  --改牌效
General:new(extension, "038", "kvoan", 3):addSkills{"touktszjens"}  -- 牢大 --快過死亾
General:new(extension, "051", "kvoan", 3):addSkills{"kaaktszjer"} --偷牌
General:new(extension, "067", "kvoan", 3):addSkills{"ex__zzjinqthou"} --偷牌
General:new(extension, "054", "kvoan", 3):addSkills{"kaamqprac"} --殺次數
General:new(extension, "085", "kvoan", 3):addSkills{"hzoanskaak", "tszjipzzyinh", "hzoanscioh","tszjipkrak"} --盾矛 hsxestszjens
General:new(extension, "059", "kvoan", 3):addSkills{"sziuhhaes"} --合趙云 
-- General:new(extension, "061", "kvoan", 3):addSkills{""} --防殺 
General:new(extension, "069", "kvoan", 3):addSkills{"lvoansddxins"} --潛龍
General:new(extension, "091", "kvoan", 3):addSkills{"jiospouk","kaehkfes",} --算卦 不改判
General:new(extension, "120", "kvoan", 3):addSkills{"dzoacqkij","tssaemqtssaem"}  --暗牌 改判 拼點
General:new(extension, "095", "kvoan", 3):addSkills{"zzyinspiuc",}  --火攻
General:new(extension, "096", "kvoan", 3):addSkills{"keejskwih","kxipkius"}  --周泰

General:new(extension, "114", "kvoan", 3):addSkills{"teemhmoeok",}  --无效并抽牌
General:new(extension, "116", "kvoan", 3):addSkills{"keenqsziuh", "tszjechljet" }  --无限閃 --整列節命
General:new(extension, "119", "kvoan", 3):addSkills{"sziktsshaek",}  --退虜

General:new(extension, "034", "kvoan", 3):addSkills{"hzoojsddxins",}  -- 潰陳 自殺  --攻輔

--------------------用牌 
General:new(extension, "027", "kvoan", 3):addSkills{"moanslouch","tsziuqzyen","jiacqtshjes"} --用弃牌堆
General:new(extension, "037", "kvoan", 3):addSkills{"hsipsyeh"}  -- 離䰟
General:new(extension, "042", "kvoan", 3):addSkills{"thoaqtoav", }  --用被弃之牌 
General:new(extension, "044", "kvoan", 3):addSkills{"dzjemqhqveen"}  --用牌堆底 就成大腹作礙
General:new(extension, "047", "kvoan", 3):addSkills{"zyeqhzeec","tsjasthoeojs"}  --用它人牌  
General:new(extension, "106", "kvoan", 3):addSkills{"lihkhoos"}--用牌堆 
--------------------技能
General:new(extension, "025", "kvoan", 3):addSkills{"khoucqhsiach"}  --用技能就抽 无效之 控
General:new(extension, "048", "kvoan", 3):addSkills{"kxesssaac"}  --增殖G hzfekkujh 抽牌
General:new(extension, "050", "kvoan", 3):addSkills{"hzfekkujh","ssxiqtsziucs","siukdzjech", "noaqmjens"}  --李鬼 

--------------------抽牌
General:new(extension, "018", "kvoan", 3):addSkills{"lyithzoeoc"}   --延旹失1抽1
General:new(extension, "028", "kvoan", 3):addSkills{"hqrachliak","sziacqtsoeoc"}   --失1弃1 -- 失1抽1
General:new(extension, "030", "kvoan", 3):addSkills{"giacqthoeojs",}  --抽1還2
General:new(extension, "032", "kvoan", 3):addSkills{"tshoavqzzyen",}  --補牌至等量
General:new(extension, "035", "kvoan", 3):addSkills{"pracqbxis"}  -- 遺計
General:new(extension, "036", "kvoan", 3):addSkills{"tshjecqsziac"}  -- 幸運占卜 抽復抽 
General:new(extension, "084", "kvoan", 3):addSkills{"hzvoanstssaenh"}  -- 失1用1
General:new(extension, "040", "kvoan", 3):addSkills{"jiuqlioc"}  -- 奮音
General:new(extension, "041", "kvoan", 3):addSkills{"tszjevqloeoj"}  --點數檢𡩡
General:new(extension, "043", "kvoan", 3):addSkills{"thoeomqjiok"}  --用1抽2弃牌
General:new(extension, "045", "kvoan", 3):addSkills{"dzjishsioh"}  --抽牌用牌
General:new(extension, "055", "kvoan", 3):addSkills{"gyihdoos"}  --能用牌則抽牌
General:new(extension, "068", "kvoan", 3):addSkills{"nzjitsjin","piucqcxim"}  --打出 --風吟 不可用
General:new(extension, "075", "kvoan", 3):addSkills{"khoacsljer"}  --賣血抽牌 回血抽牌
General:new(extension, "071", "kvoan", 3):addSkills{"kxenhgi","ljenqdzjep","bvoattszhis","dvoatkhijs"}  --一起 未作
General:new(extension, "090", "kvoan", 3):addSkills{"quanhszuos"}  --武陸
General:new(extension, "092", "kvoan", 3):addSkills{""}  --
General:new(extension, "100", "kvoan", 3):addSkills{"jiuhpaar"}  --

General:new(extension, "105", "kvoan", 3):addSkills{"tsoeojssi"}  --雙牌名
--------------------庸
General:new(extension, "001", "kvoan", 3):addSkills{"ttxisquanh","tszjinstoamh","muoqquanh"}  --攻程
General:new(extension, "002", "kvoan", 3):addSkills{"khioktshuoh"}  --A抽偷A
General:new(extension, "003", "kvoan", 3):addSkills{"ddiqtszjecs","siuqmiuk"}--抽弃 比色
General:new(extension, "005", "kvoan", 3):addSkills{"hzoojqkracs"}  --刺蝟
General:new(extension, "008", "kvoan", 3):addSkills{"khyecqphiuk"} --傾覆
General:new(extension, "012", "kvoan", 3):addSkills{"jiuqtous",}  --游擊
General:new(extension, "013", "kvoan", 3):addSkills{"liuqhzveec","jjevsjjas"}--隨機砸人😄️
General:new(extension, "014", "kvoan", 3):addSkills{"soamqpuoh",}--三
General:new(extension, "016", "kvoan", 3):addSkills{"ddiuktsjins",} --逐進
General:new(extension, "020", "kvoan", 3):addSkills{"kijqtvoans",} --額外段
General:new(extension, "049", "kvoan", 3):addSkills{"siacqsoos","ssuoszzyit","zziycqszjer"}  --素數

General:new(extension, "021", "kvoan", 3):addSkills{"tszjechbxis",}--段煨hzooj
General:new(extension, "039", "kvoan", 3):addSkills{"ljimqcwe", "muacssjih","buoqcwe",}    --超越死亡
General:new(extension, "057", "kvoan", 3):addSkills{"tszjeqttwit" ,"tthaakpooh"}  --存牌抽牌
General:new(extension, "058", "kvoan", 3):addSkills{"siqliak"}  --洗牌
General:new(extension, "081", "kvoan", 3):addSkills{"gintszjecs"}  --駱統
General:new(extension, "082", "kvoan", 3):addSkills{"peejskfan"}  --閉關 未作
General:new(extension, "070", "kvoan", 3):addSkills{"dzoakhzaamh"}  --閉關 未作
General:new(extension, "072", "kvoan", 3):addSkills{"hqoavqtszjens"}  --
General:new(extension, "076", "kvoan", 3):addSkills{"ttwiqhqrach","muoqhzoeon"}  --神速
General:new(extension, "066", "kvoan", 3):addSkills{"ex__ljetkrak"}--pork牌


General:new(extension, "ddxins__hsooqjjenqtsziak", "kvoan", 3):addSkills{"theetgxes"}  --呼延
General:new(extension, "ddxins__cootcaankvoac", "kvoan", 3):addSkills{"liakddxins"}
General:new(extension, "ttxes__ddjeksius", "tsiacs", 5):addSkills{"seenqtszjis","seenqkaok"} --機智石秀
General:new(extension, "dzoeoj__tshoarkrac", "kvoan", 4):addSkills{"puosljemh"}  --鴿 --超發
General:new(extension, "089", "kvoan", 3):addSkills{"thoavqdoav","thoaqtoav"}--水軍 踏浪

General:new(extension, "093", "kvoan", 3):addSkills{"kheejhpuj","leecqtsjens"}--歐鵬

General:new(extension, "077", "kvoan", 3):addSkills{"kujqhqinh","dzuohcxes"}  --特殊勝

General:new(extension, "094", "kvoan", 3):addSkills{"kwehhsvoah","qxemqddiach","zzyinspiuc"}  --火攻
General:new(extension, "101", "kvoan", 3):addSkills{"sziuhhqaes",}  --曹仁趙佶
General:new(extension, "104", "kvoan", 3):addSkills{"kijqpuat",}  --肘 
General:new(extension, "107", "kvoan", 3):addSkills{"hqoatqun","jioqqwins"}  --樂和 連招技轉換技

General:new(extension, "110", "kvoan", 3):addSkills{"dzyetkeejs","jyecqhzooj"}  --奇策連營
General:new(extension, "113", "kvoan", 3):addSkills{"szissik"}  --拼點 議事

General:new(extension, "117", "kvoan", 3):addSkills{"kiamsmoac","ljerphioc","tsyiscuat"}  --噄殺 劍仙 酒劍仙
General:new(extension, "118", "kvoan", 3):addSkills{"kximhkaap",}  --裝僃 
General:new(extension, "122", "kvoan", 3):addSkills{"kujqdzeek",}  --褈置次數 

--------------------自保 單保 賣血 不動白 負面  
General:new(extension, "098", "kvoan", 3):addSkills{"cweqdoeojh"}  --褈鑄4
General:new(extension, "099", "kvoan", 3):addSkills{"dzjiskik"}
General:new(extension, "102", "kvoan", 3):addSkills{"jikpjis"}

General:new(extension, "103", "kvoan", 3):addSkills{"jjeqhzvah","dzoacqhzeep","kwehssih"} --轉迻目幖 起動旹轉迻
General:new(extension, "121", "kvoan", 3):addSkills{"kwiqsik"}

--------------------

General:new(extension, "999", "kvoan", 1):addSkills{"dzjitddxe"}

General:new(extension, "4", "kunqkaavs", 1):addSkills{"hsxestszjens","thoaqtoav"}  --雙向發動 指定/成爲目幖 致/受傷  ?橫衝直撞

  

------------------------------------------------------------------------------------------------
--潘鴆殺 未作
--宴戲 趙佶
--衝鋒 索超
--旗 
--船
--炮
--牽線
--阿里奇
--牌數冣多 kaaktszjer
--放貸蔡京
-- 拏判定 拏拼點
--演謀
---------
-- 酒下藥
-- 暗將勢力

-----------f..k
-- 雙龍-橫掃
-- 固縱 不難 受改動
-- 暗謀
-- NotAcitve
-------------------------------------------------------------------------------------------------------------------------

local test1 = General(extension, "bp", "pujh", 4)
-- test1.shield = 1
test1:addSkills {
  -- "gwisliac",
  -- "kujqdzeek",

  -- "kwiqsik",
  -- "deephzoon",
  -- "tsyiscuat",

  -- "maanqhzfacs",
  -- "dzeetliac",
-- "ex__coohtsziu",

-- "soansdzoejs",

  -- "pjecskrak",
  -- "khaavhkouc",
  -- "szuoqquns",
  -- "thoocshzaat",

  -- "gxeqmoon",
  -- "jiuqlioc",
  -- "jiacqhqik",
  -- "hzveoktsziacs",
  -- "tssaemqtssaem",
  -- "tooshzeen",
  -- "sziktsshaek",
  -- "kximhkaap",
  -- "kiamsmoac",
  -- "ljerphioc",

  -- "thoocsprac",
  -- "lyehkeek",  --tobe
  -- "deepkeejs",
  -- "cracqkeek",
  -- "tsziuqzyen",
  -- "keenqsziuh",

  -- "pxemqkoot",
  -- "hqximhquoh",

  -- "kfaqbiuk",
  -- "dzoeocsdoo",
  -- "gwisliac",
  -- "thoeomqdzoeoj",

  -- "tszjipkrak",
  -- "tszjipzzyinh",
  -- "hzeepkoot",

  -- "tszihkvoa",
  -- "hzoojqbjes",
  -- "teemhmoeok",

  -- "likbvoat",
  -- "muoqtoojs",
  -- "boavsgwen",
  -- "keetjyen",
  -- "doucqsjim",
  -- "ex__kaavqprac",
  -- "bjevsgxes",
  -- "szissik",
  -- "hzaahszyih",
  -- "hzeethzoac",
  -- "ljerprac",
  -- "keekjyer",

  -- "cooqkou",
  -- "jjeqdzius",
  -- "kaaktszjer",
  -- "hsicqloan",
  -- "doavqthoav",
  -- "ttiachloak",
  -- "hzaeksvoans",

  -- "khaenqljins",
  -- "zjimqhsfa",
  -- "hqujqtszjins",
  -- "touktszjens",
  -- "hzeethzoac",
  -- "dzyetkeejs",
  -- "tsoaktthiac",
  -- "ljenqtsziuq",
  -- "tszjipmaach",
  -- "thoocsprac",
  -- "likgxim",
  -- "poavskvoeok",
  -- "kiappoavh",
  -- "hzaavscxes",
  -- "khoeojqloos",  --樂 文
  -- "phiuskun",  --tobe general
  -- "liuqsziuh",
  -- "ssiuqkfat",
  -- "ljimqmoo",--可以禁單skill
  -- "jiacqpoa", --bug
  -- "zzjinqthou",
  -- "ttiucqliu",
  -- "paakmoach",
  -- "thoucqdoat",
  -- "tssaamhbuat",
  -- "ttxinsphuoh",
  -- "koucqbuat",  --tobe
  -- "ljephzfak",
  -- "thoojsdeek",
  -- "dzoacqkij",
  -- "kyinqszjer",
  -- "jjenhmiu",  --tobe
  -- "hsxestszjens",

  -- "jiacqhqik",
  -- "hzvoanstssaenh",
  -- "thoavqliak",
  -- "hqoeomsmiu",
  -- "tsjecqmuoh",
  -- "kaaktszjer",  --未畢
  -- "szioqnoans",
  -- "lvoansddxins",
  -- "liocqdzjem",
  -- "liocqhquj",
  -- "bunqzjins",
  -- "piktssaes",
  -- "tszjinshzaek",
  -- "koostsiocs",
  -- "zyenqtoav",
  -- "soavhdzjinh",
  -- "paakmoach",
  -- "zzikkoot",
  -- "cxesszjek",
  -- "ssxiqtsziucs",  --tobe
  -- "gxeqmoon",
  -- "noaqmjens",
  -- "khuacqtseejs",
  -- "tthaakpooh",
  -- "thoojsdeek",
  -- "ddwenqtsjens",
  -- "gracqgi_gi_skill",
  -- "gracqgi",
  -- "#phaavshsfec_phaavs_skill",
  -- "phaavshsfec",
  -- "kouqljem",
  -- "ljetkrak",
  -- "ssxiqtsziucs",
  -- "hzoonqtsiuh",
  -- "hzfekdzis",  --未畢
  -- "hzvoaqcaok",
  -- "kximqthoac",
  -- "kxipkius",
  -- "toeocqsjen",
  -- "quohhsfas",
  -- "tsjasthoeojs",  --bug

  -- "tszjecsprac",
  -- "tsoeojssi",
  -- "thoocshzaat",
  -- "siacqdeek",
  -- "lihkhoos",
  -- "ljetkrak",
  -- "dzoacqhzeep",
  -- "kwehssih",
  -- "kijqpuat",
  -- "jjeqhzvah",
  -- "kiamsmrac",
  -- "hzfenshsfas",
  -- "gyihdoos",
  -- "jiuhpaar",
  -- "ssxiqtsziucs",
  -- "hzfekkujh",
  -- "muoqtssioh",  --狀態技
  -- "hzoonqtsiuh",
  -- "hzoonqtsiuh_active",
  -- "meejqguac",
  -- "sjihcxes",
  -- "ddwenqtsjens",
  -- "ddiacqszics",
  -- "thoavqliak",
  -- "ttaekseec",
  -- "hqoeomsmiu",
  -- "dzjiskik",
  -- "kiamsmrac",
  -- "test__hzoojqmaah",

  -- "jikpjis",
  -- "ljetkrak",
  -- "ddiqhzaac",
  -- "ssaetliuk",
  -- "theenqhzeec",
  -- "tszjecqbuat",
  -- "sziuhhqaes",
  -- "biukkeek",
  -- "hqximhquoh",
  -- "tooshzeen",
  -- "jiuhpaar",
  -- "dzjiskik",
  -- "thoocsprac",
  -- "dzjitkeek",
  -- "lyehkeek",
  -- "khiochhsaak",
  -- "biukkeek",
  -- "keejskwih",
  -- "cweqdoeojh",
  -- "kwehhsvoah",
  -- "qxemqddiach",
  -- "zzyinspiuc",
  -- "hsuohhsvah",
  -- "tszhiocqhzaems",
  -- "ssaocqhsooh",
  -- "siuqdzjecs",
  -- "ljeqhzoon",
  -- "jiospouk",
  -- "kaehkfes",
  -- "loavqtszih",
  -- "dzoeonqsyit",
  -- "jiuqnzjins",
  -- "ttwiqhqrach",
  -- "dvoatkhijs",

  -- "paaktszhyit",
  -- "tszjecsprac",
  -- "quanhszuos",
  -- "siacqquan",

  -- "giocstseejs",
  -- "dzoeocqloan",
  -- "tsiocsmoa",
  -- "ljenqtszuo",
  -- "dzoanqciak",
  -- "keetjyen",
  -- "hzfenshsfas",
  -- "ddikddaocs",
  -- "hzfacqtszhioc",
  -- "tsziochprac",
  -- "kracqhzoon",
  -- "poaqdoav",
  -- "thoavqdoav",
  -- "ddikddaocs",
  -- "ssaocqlioc",
  -- "noosssaet",
  -- "ddiacqszics",
  -- "thoavqliak",
  -- "doachddio",

  -- "tousmuoh",
  -- "tsziochprac",
  -- "gintszjecs",
  -- "tsoaktthiac",
  -- "gwisliac",
  -- "tszjeqttwit",
  -- "tszjechljet",
  -- "moucqtszhioc",
  -- "jiakmaah",
  -- "liuqhzveec",
  -- "qiucqljet",
  -- "ttwiqhqrach",
  -- "muoqhzoeon",
  -- "hzfekkujh",
  -- "hzoonqbuos",
  -- "butjyen",
  -- "kiamsmrac",
  -- "nzjisdouch",
  -- "kaamqprac",
  -- "tshjesthoeoms",
  -- "zziycqszjer",
  -- "ssuoszzyit",
  -- "khitdzjec",

  -- "tszjeqkeejs",
  -- "kxesssaac",
  -- "tszjecsprac",
  -- "ljimqmoo",
  -- "gyihdoos",
  -- "zyeqhzeec",
  -- "kaaktszjer",
  -- "tsziuqzyen",
  -- "hzoanskaak",  --李袞
  -- "kheemqsziuh",
  -- "craktszjens",
  -- "phoukkeek",
  -- "hsxestszjens",
  -- "jiacqtshjes",
  -- "sjisziach",
  -- "muoqtoojs",
  -- "chenzhi",
  -- "jiktsoans",
  -- "ljimqkij",

  -- "neemsneems",
  -- "hzvoanstssaenh",
  -- "tszjevqtsziac",
  -- "hzeethzoac",
  -- "hzeenqkrac",
  -- "teejhlik",
  -- "gianskoot",

  -- "zzikkoot",
  -- "krachbuac",
  -- "khuoqthoot",
  -- "dzjishsioh",
  -- "hzoanscioh",
  -- "jiuhdeek",
  -- "khyeqtheen",
  -- "pxiqdzyet",
  -- "tszuohtszjens",

  -- "doachddio",
  -- "pujqnzjins",
  -- "tszjevqseejs",
  -- "thoeomqdzoeoj",
  -- "toojskveet",
  -- "tszuoqhqaec",
  -- "doachddio",  --董平?
  -- "muoqhqujs",
  -- "ciosmaah",
  -- "tshjitjjevs",
  -- "kximqkaap",
  -- "muohbxis",
  -- "phuachtszjer",
  -- "tszuoqmoon",
  -- "gongqiao",
  -- "dzjemqhqveen",
  -- "thoeomqjiok",
  -- "tszjevloeoj",
  -- "thoaqtoav",
  -- "gianskoot",
  -- "tsjecqmuoh",
  -- "hzfacqtszhioc",
  -- "jiacqmuoh",
  -- -- "phunhtthxet",
  -- "kijqphioc",
  -- "noojskaens",
  -- "cooqkou",
  -- "dziacstsoak",

  -- "toacqseen",
  -- "tsiocsmoa",
  -- "dzjitddxe",
  -- "paaskeecs",
  -- "deevhtszjens",
  -- "ljeqhzoon",
  -- "hsipsyeh",
    -- "moanslouch",
  -- "touktszjens",
  -- "kijqcian",
  -- "tsziochprac",
  -- "gintszjecs",
  -- "muoqtssioh",
  -- "kxevqgxes",
  -- "zzjinqthou",
  -- "pujqjjem",
  -- "hsipsyeh",
  -- "miuqdzoeoj",
  -- "giocstseejs",
  -- "pujqkiams",
  -- "quandzsios",

  -- "tshjecqsziac",
  -- "sziacqtsoeoc",
  -- "thoavqliak",
  -- "dzoeojqgiu",
  -- "muohbaoch",
  -- "hzeepkoot",
  -- "kveetsjih",
  -- "dzzjenqhqyen",
  -- "tshjitjjevs",

  -- "peejskfan",
  -- "biuhkiams",

  -- "crakljin",
  -- "siacqsoos",
  -- "phoasddxins",

  -- "siacqsoos",
  -- "poavskvoeok",

  -- "lyithzoeoc",

-- "kaasssik",

--   "bjevsgxes",
-- "muoqtssioh",

  -- "likgxim",
  -- "tvoanspjes",

  -- "ddxenqtous",

  -- "dooqtsoeojh",
  -- "hzoojsddxins",
  -- "zyenqnzjins",

  -- "khuoqmoa", 
  -- "ddxevhhsioc",
  -- "gijqnziac",

  -- "pracqbxis",
  -- "jiaktsjins",
-- "puacsteev",
  -- "kiaplooh",

  -- "kxippoavs",
  -- "pxisthoeoms",
  -- "thoocshzaat",


  -- "kiamsmuoh",
  -- "tszhyitsjevs",

    -- "dzuohcxes",
  -- "kujqhqinh",
  -- "tssaasbracs",
  -- "ddiuqmiuk",
  -- "biuqdzsaa",
  -- "khuacqtseejs",
  -- "cxestseet",

  -- "khoacsljer",
  -- "muoqtssioh",
  -- "bjevsgxes",
-- "ex__ljetkrak",

  -- "kximqthoac",
  -- "ddaocqkeek",

  -- "phoasddxins",
  -- "kvoanqddxins",

  -- "pujqjjem",
  -- "ex__zzjinqthou",

  -- "biushqoans",
  -- "koostsiocs",
  -- "dvoattoamh",
  -- "dzzjecqpuoh",

  -- "khaavhtous",
  -- "leecqdeek",
  -- "siacqdeek",
  -- "giacqkhoeojs",
  -- "pikhzaoc",

  -- "kaaqszio",

  -- "tszjevqhqoan",
  -- "phuohsyit",
  -- "tooshzeen",

  -- "punsmuoh",
  -- "kijqphioc",
  -- "keekpoak",

  -- "piucqcxim",
  -- "nzjitsjin",

  -- "hsuanqkooh",

  -- "hqrachliak",

  -- "lvoanskun",
  -- "ttiacqszjer",
  -- "hzfacshzaac",
  -- "hsfaqdeen",

  -- "jiuhdeek",
  -- "ceenqjiak",
  -- "kaenskeejs",
  -- "phoasmuacs",
  -- "guacqdzzjen",

  -- "phuohgxim",
  -- "poavskvoeok",
  -- "tszjetnziok",

  -- "krachbuac",
  -- "deecstsshaek",

  -- "khoucqhsiach",
  -- "hsoanstszhis",
  -- "cioshsvah",
  -- "bunqzjins",


  -- "phunhtthxet",
  -- "ddiuktsjins",
  -- "thoocshzaat", 
  -- "pouktheen", 
  -- "ttiucqhsaavs",
  -- "siacqdeek",
  -- "thoucqdoat",
  -- "khaenqljins",
  -- "tsheejqtsheej",
  -- "kujsssaac",
  -- "coohtsziu",
  -- "ex__coohtsziu",
  -- "ssaacqmaach",
  -- "gianqkouc",
  -- "kaamqkouc",
  -- "pujqtszjim",
  -- "test__hzoojqmaah",
  -- "dvoattoamh",
  -- "ciosmaah",
  -- "tshjitjjevs",
  -- "muoqtssioh",
  -- "guacqdzzjen",
  -- "phoasmuacs",

  -- "hzoavqhqximh",
  -- "biukhsooh",

  -- "hsuohhsvah",
  -- "pouktheen",
  -- "lvoansddxins",
  -- "pjertheen",
  -- "ljerkun",
  -- "hqjemstsiok",
  -- "hzoonqtsiuh",

  -- "phuohsyit",
  -- "tszhyeqpoa",
  -- "tshoavqzzyen",
  -- "tssaasbracs",

  -- "sziohtoamh",

  -- "seenqkaok",

  -- "yingzi",
  -- "siqliak",

  -- "tszyiqphioc",
  -- "hzfektsshaek",  
  -- "qunsddiu",

  -- "yingzi",
  -- "zhiheng",
  -- "hzouhpuat",

  -- "khioktshuohz",

  -- "szioqnoans",
  -- "gracqthoeop",

  -- "liocqdzjem",
  -- "kxev"
  -- "tssikkeek",
  -- "bjevsgxes",
  -- "kxevqgxes",
  -- "tszhiocqhzaems",
  -- "jinhkeens",
  -- "gxeqmoon",
  -- "jjeqseec",
  -- "kvoanqddxins",
  -- "khiakdeek",
  -- "pouktheen",
  -- "ttaekseec",
  -- "hzoonscuan",
  -- "seenqtszjis",
  -- "tszhiocqhzaems",
  -- "jiokhsoak",
  -- "puanhmiuk",
  -- "giacqpaas",

  -- "leecqpheec",
  -- "tsheejqdzyet",
  -- "sooshseec",

-- "hseekdziac",
-- "liuqhzfa",
-- "hsfaqtsoacs",

  -- "deejqprac",
  -- "hzoavhkhis",
  -- "bjesphioc",

  -- "tthiuqtoav",
  -- "doucqsjim",
  -- "hzaocqdzioc",

  -- "dzyetjyen",
  -- "dzjecqdook",
  -- "dooqmxe",
  -- "theevqloucs",
  -- "koushzaems",
  -- "nzjipkous",
  -- "meejqdzoeoj",
  -- "deecssjim", --
  -- "piucshsiap",
  -- "khitdzjec",
  -- "tsziukmoan",
  -- "maekmaek",
  -- "dzziuqhquans",
  -- "muoqtseejs",
  -- "szyihloav",
  -- "hsoonqhsoojs",
  -- "seenhkiap",
  -- "tszjetnziok", --待
  
  -- "leecqkveet",
  -- "meecqqwer",
  -- "hzfenszzyit",
  -- "moaqtsziacs",
  -- "kooqtsjins",
  -- "seenqtoeoc",
  -- "dzoakhzaamh",
  -- "dzjemqszyih",
  -- "khutdzioc",
  -- "nzjinhnziok",
  -- "hzoeomqhzoeons",
  -- "buamshqxim",
  -- "ljeqddxin",
  -- "lunqhzooj",

  -- "dzzjerdzziu",
  -- "siacqhzvoa",
  -- "lihcaok",
  -- "punsmuoh",
  -- "tszhyeqpoa",
  -- "kiappoavh",
  -- "ttiachloak",
  --  "deeploacs",
  -- "hqjitphouk",
  -- "nzjishsian",
  -- "soamqtsjenh",
  
  -- "jiaktsjins",

  -- "kijqtvoans",
  -- "test__keektszjens",
  -- "keektszjens",

  -- "kaavqprac",  --目幖旹不能改extral_data
  -- "maanqhzfacs",
  -- "kiamsquoh",
  -- "tszhiocqhzaams",
  -- "pracqkaap",
  -- "ddiuktsjins",
  -- "seenqtszjis",
  -- "thoucqdoat",
  -- "ttaekseec",
  -- "ljimqmoo",

  -- "nzjevhdvoat",
  -- "tsoakszjer",

  -- "dvoattoamh",
  -- "hzfacqtszhioc",

  -- "gwisleejh",
  -- "thoucqdoat",
  -- "hqujqtszjins",
  -- "jiocsbiuk&",
  -- "jjenhmuoh",
  -- "khoucqhqrach",
  -- "ljephzfak",
  -- "kvoanqddxins",  
  -- "sjinstsjens",  
  -- "khuoqmoa",  
  
  -- "biussjins",  
  -- "thouqhsiac",
  -- "mvoanqkoa",  
  -- "lihcaok",

  -- -- "piktssaes", --結算終改tos
  -- "tszjipmaach", --結算終改tos
  -- "siuqmuoh", --結算終改tos

  -- "hqoavqtszjens",
  -- "kiaploav",
  -- "tszjechbxis",

  -- "sziuhbxis",
  -- "dzzjenqhqyen",
  -- "ddiqtszjecs",
  -- "pouktheen",
  -- "qwerkiams",
  -- "boacqthouc",
-- "khiakdeek",
  -- "keektszjens",
  -- "tseejsnoans",
  -- "punskeek",
  -- "toojskveet",
  -- "kujhprac",
  -- "hzoojqmaah",

  -- "phaavshsfec",
  -- "ceenqjiak",

  -- "gwisleejh",  
  -- "leecqdeek",

  -- "jinjing",
  -- "paoxiao",
  "seenhliak",

  "test_rende",
  "cheat",
  "control",
  "damage_maker",
  "tssaecqkouc",
  "change_hero",
  "test_zhijian",

}

local test2 = General(extension, "wtf", "pujh", 4, 4, General.Female)
test2:addSkills {
  "test_rende",
  "cheat",
  "control",
  "damage_maker",
  "tssaecqkouc",
  "change_hero",
  "test_zhijian",
  "jinjing",

  -- "test__pujqtszjim",
-- "xiaoyan",
  -- "test__shouli",
  -- "eqian",

  "pracqkaap",
  -- "jiacqcian",
  -- "soamqpuoh",
  -- "liuqhzveec",
  -- "doucqtsziu",
  -- "tssaamhbuat",
  -- "biuqdzsaa",
  -- "ljephzfak",
  "biussjins",
  -- "hzaeksvoans",
  -- "tszhyeqpoa",
  -- "poattszuo",
  -- "hqoatqun",
  -- "jioqqwins",
  "ddwenqszio",
  -- "liuksyer",
  -- "gracqgi",
  "keetddxins",
  -- "hzfenskhouc",
  "muoqquanh",
  "ttxisquanh",
  "tszjinstoamh",
  -- "hzoonscuan",
  -- "tssaacqljis",
  -- "szjetloojs",
  -- "tszjecsprac",
  -- "gxeqprac",
  -- "tsjevqkeet",
  -- "hsuohhsvah",
  -- "ljemhthoojs",
  "loonsszjer",
  -- "kracqhzoon",
  -- "koostsiocs",
  -- "tszjinshzaek",  --振翮
  -- "maestoav",
  -- "phiocqmoac",
  -- "phoasmuacs",
  -- "soakdzoeoj",
  -- "peejshzooh",
  -- "hqoeomsmiu",
  -- "nziokcoavs",
  -- "tsjasthoeojs",
  -- "hsoohseevs",
  -- "crakliu",  --7.22創
  -- "kiapliak",  --7.22創
  -- "tszuoqmoon",
  -- "jjimqjjit",
  -- "hqxehkvoan",
  -- "giacqtszjems",
  -- "phuachtszjer",
  -- "dziacssjim",
  -- "siacqhzvoa",  --設計
  -- "gianskoot", --8.6 忘測
  -- "tshjitjjevs",  --S.addVirtualEquip
  -- "hzouhpuat",  --8.19 今8.31
  -- "pveojsszyih",
  -- "hzfacqdzoeoj",
  -- "maanqlik",
  -- "khaavhkouc",
  -- "khiakdeek",
  -- "sjissiacs",
  -- "keevsddxins",
  -- "keevsddxins_active&",
  -- "kaanqteev",
  -- "biukkeek",
  -- "kaenskeejs",
  -- "noeojshqics",
  -- "kuujhmjens",
  -- "zyinqljep",
  -- "ssiuqkfat",
  -- "liuqsziuh",
  -- "koamqljim",
  "gwisliac",
  -- "pujqtoav",
  -- "szuoqquns",
  -- "hzoavqtooh",
  -- "pujqtshiac",
  -- "khuoqmoa",
  -- "ddxevhhsioc",
  -- "gijqnziac",
  -- "szjethqeens",
  -- "phximhmur",
  -- "zjimqkhrak",
  -- "jiuhdeek",
  -- "keektszjens",
  -- "khyecqphiuk",
  -- "ciosmaah",
  -- "doavsmaah",
  -- "punsmuoh",
  -- "khyeqtheen",
  -- "thouqhsiac",
  -- "tszjipsziuh",
  -- "kheenqsjens",
  -- "ddiachszjer",
  -- "ssaacqmaach",
  -- "thoocsprac",
  -- "maestthiacs",
  -- "tszjetnziok",
  -- "ljenqtszuo",
  -- "bvoattsjens",
  -- "toeocqsjen",
  -- "pouktheen",  --看不見?
  -- "tvoansdzoavh",
  -- "craktszjens",
  -- "jiucqleens",
  -- "muohbxis",
  -- "laachtsjens",
  "thoohsjins",
  -- "ttxenhszjes",
  -- "moojqddaa",
  -- "cxestseet",
  -- "kaasssik",
  -- "noeophzeen",
  -- "szyihloav",
  -- "gxeqprac",
  -- "cooqkou",
  -- "koucqkhaavh",
  -- "hzaepdoos",
  -- "dzzjecqpuoh",
  -- "zzicqloacs",
  -- "doarloacs",
  -- "ljeqhzoon",
  -- "zzyinsszyih",
  -- "hzoaqnoar",
  -- "puanhmuo",
  -- "deecstsshaek",
  -- "hzvoanqkhoos",
  -- "noosssaet",
  -- "zyinqssaavs",
  -- "khoonstous",
  -- "kxeqlvoan",
  -- "tthiqhquans",
  -- "hqoeomshsiac",  --tsyisnzjit
  -- "tshjesthoeoms",
  -- "giucqdoo",
  -- "dzoanqciak",
  -- "tshiuqssaet",
  -- "puohquat_active&",
  -- "puohquat",
  -- "kveetsjih",
  -- "nzjevhdvoat",
  -- "tsoakszjer",
  -- "phjenqtheec",
  -- "tshjechkeens",
  -- "muohbaoch",
  -- "doeojsbaav",
  -- "tszjeqkeejs",
  -- "zzjinqthou",
  -- "pujqjjem",
  -- "piucqhzaac",
  -- "lvoansqun",
  -- "tszjettszhioc",
  -- "muoqtssioh",
  -- "pikhzaoc",
  -- "tszuohtszjens",
  -- "tsjecqmuoh",
  -- "puosljemh",
  -- "tshiukkiuk",
  -- "dookszjih",
  -- "hqoeomstsjens",
  -- "toahloojs",
  -- "phuohgxim",
  -- "phuohgxim_active",
  -- "tthiocqphioc",
  -- "punsjioch",
  -- "maescjer",
  "hzoonqtsiuh",
  -- "kuujhthoeojh",
  -- "sziohtoamh",
  -- "hzaahjiak",
  -- "loavhleens",
  -- "ddwenqtsjens",
  -- "hqximqqwer",
  -- "doeocqjioch",
  -- "hqeenqmjet",
  -- "hsoanstszhis",
  -- "cioshsvah",
  -- "bunqzjins",
  -- "kxevqgxes",
  -- "hzfacqtszhioc",
  -- "thoavqliak",
  -- "guacqdzzjen",
  -- "hqximhquoh",
  -- "jjinhkiuc",
  -- "mxishzveok",
  -- "szjimqkveej",
  -- "dzzjenqhqyen",
  -- "zyenqtoav",
  -- "poosddxins",
  -- "kvoanqddxins",
  -- "phoasddxins",
  -- "sziuhmuacs",
  -- "geepkoot",
  -- "kveetmracs",
  -- "cxesljet",
  -- "phoukkeek",
  -- "test__hzoojqmaah",
  -- "hzoojqmaah",
  -- "tsheejqtsheej",
  -- "nzjinqnziuk",
  -- "kaavssvoa",
  -- "tooshzeen",
  -- "piucqcuat",
  -- "jjenqdzziuh",
  -- "hzoojqtszhyin",
  -- "siuqmuoh",
  -- "tszjipmaach",
  -- "kiamsmuoh",
  -- "tszhyitsjevs",
  -- "thoucqdoat",
  -- "prachkouc",
  -- "hsoeokteems",
  -- "seenqtoeoc",
  -- "hsfaqdeen",  --??
  -- "jyenqmjet",
  -- "lvoanskun",
  -- "liocqhsfas",
  -- "liocqcoavs",
  -- "thoeomqdzoeoj",
  -- "tsoaktszhiac",
  -- "kxippoavs",
  -- "sjiqkius",
  -- "cxesszjek",
  -- "bxensmracs",
  -- "likbvoat",
  -- "mxenhlik",
  -- "ssaetliuk",
  -- "kiaploav",
  -- "sziuhbxis",
  -- "biukhsooh",
  -- "tshjimssjim",
  -- "pujqtszjim_active", 
  -- "pujqtszjim",
  -- "hqeensjiu",
  -- "hzoavqszjin",
  -- "toanqszio",
  -- "coohtsziu",
  -- "giocstseejs",
  -- "khihprac",
  -- "hzfenszzyit",
  -- "crakljin",
  -- "leecqkveet",
  -- "jyenqkaap",
-- "meej_prohibit",
  -- "hzaacqhzeec",
  -- "koostsiocs",
  -- "hqiqmaah",
  -- "siacqmaah",
  -- "kximqkaap",  --改迻動 
  -- "ssaocqlioc",
  -- "ddikddaocs",
  -- "kuujhprac",
  -- "pjertheen",
  -- "jjenhmuoh",
  -- "khoucqhqrach",  --??
  -- "dzjitboos",
  -- "paaskeecs",
  -- "jiaktsjins",
  -- "toojskveet",

  -- "gximqlioc",
  -- "moottsouk",
  -- "szjimhphoans",
  -- "hqoavhsiacs",

  -- "tszjecqbuat",
  -- "quacqhzvaans",
  "pujqkiams",  --奇門弃牌觸發 --轉外
  -- "ljimqmoo",
  -- "khaenqljins",
  -- "poavskvoeok",
  -- "ttjevqhqoan",
  -- "phuohsyit",
  -- "hsoohgxes",
  -- "thoucqmuoh",
  -- "maanqhzfacs",
  "pjecskrak",
  -- "ljetkrak",
  -- "miuqdzoeoj",
  -- "dvatmrecs",
  -- "sjevqtsoeoj",
  -- "sjevqtsoeoj",
  -- "louchloak",
  -- "boavsnoos",
  -- "khiochhsaas",
  -- "leecqdeek",
  -- "khaavhtous",
  "test__ttaekseec",
  -- "gxeqmoon",
  -- "leevsdeek",
  -- "ddxenqtous",
  -- "thoocshzaat",
}
Fk:loadTranslationTable{ 
  ["szyih"] = "水" ,
  ["szyihtheen"] = "水天" ,
  ["wtf"] = "koaz" ,

}

return extension
