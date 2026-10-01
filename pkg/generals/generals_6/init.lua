local extension = Package:new("generals_6")
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/generals/generals_6/skills")

Fk:loadTranslationTable{
["generals_6"] = "51~60",
-- ["pujh"] = "匪",
-- ["kvoan"] = "官",
-- ["mjin"] = "民",
-- ["tsiacs"] = "將",
}

--52. 第五十一回　李逵打死殷天賜　柴進失陷高唐州

General:new(extension, "hqin_theen_seek", "kvoan", 4):addSkills { "hqxehkvoan", "giacqtszjems"}
Fk:loadTranslationTable{
["hqin_theen_seek"] = "殷天賜",
["#hqin_theen_seek"] = "殷直閣",
["designer:hqin_theen_seek"] = "設計",
["cv:hqin_theen_seek"] = "配音",
["illustrator:hqin_theen_seek"] = "畫師",
["~hqin_theen_seek"] = "黑爺爺饒命 黑爺爺饒命",
}

General:new(extension, "koav_ljem", "kvoan", 3):addSkills { "kujhprac", "pjertheen","muoshqinh"}
Fk:loadTranslationTable{
["koav_ljem"] = "高廉",
["#koav_ljem"] = "高唐魔君",
["designer:koav_ljem"] = "設計",
["cv:koav_ljem"] = "配音",
["illustrator:koav_ljem"] = "畫師",
["~koav_ljem"] = "是誰破已陣法",
}
--53. 第五十二回　戴宗二取公孫勝　李逵獨劈羅真人

General:new(extension, "loa_tszjin_nzjin", "pujh", 3):addSkills { "pouktheen", "quohhsfas","toeocqsjen"}
Fk:loadTranslationTable{
["loa_tszjin_nzjin"] = "羅眞人",
["#loa_tszjin_nzjin"] = "半仙",
["designer:loa_tszjin_nzjin"] = "設計",
["cv:loa_tszjin_nzjin"] = "配音",
["illustrator:loa_tszjin_nzjin"] = "畫師",
["~loa_tszjin_nzjin"] = "吉凶㑥卜災禍難逃",
}
--54. 第五十三回　入雲龍鬥法破高廉　黑旋風下井救柴進
--55. 第五十四回　高太尉大興三路兵　呼延灼擺布連環馬

-- General:new(extension, "hsoo_jjen_tsziak", "kvoan", 5):addSkills { "leenqmaah", "theetgxes"}
-- Fk:loadTranslationTable{
-- ["hsoo_jjen_tsziak"] = "呼延灼",
-- ["#hsoo_jjen_tsziak"] = "雙鞭",
-- ["designer:hsoo_jjen_tsziak"] = "設計",
-- ["cv:hsoo_jjen_tsziak"] = "配音",
-- ["illustrator:hsoo_jjen_tsziak"] = "畫師",
-- ["~hsoo_jjen_tsziak"] = "老當益壯報國家",
-- }

General:new(extension, "pjen__hsoo_jjen_tsziak", "kvoan", 5):addSkills { "qiucqljet","jiakmaah"}
Fk:loadTranslationTable{
["pjen__hsoo_jjen_tsziak"] = "呼延灼",
["#pjen__hsoo_jjen_tsziak"] = "雙鞭",
["designer:pjen__hsoo_jjen_tsziak"] = "設計",
["cv:pjen__hsoo_jjen_tsziak"] = "配音",
["illustrator:pjen__hsoo_jjen_tsziak"] = "畫師",
["~pjen__hsoo_jjen_tsziak"] = "老當益壯報國家",
}

General:new(extension, "baac_khih", "kvoan", 5):addSkills{"siacqdeek"}
Fk:loadTranslationTable{
["baac_khih"] = "彭玘",
["#baac_khih"] = "天目將",
["designer:baac_khih"] = "設計",
["cv:baac_khih"] = "配音",
["illustrator:baac_khih"] = "畫師",
["~baac_khih"] = "敵竟料于我先",
}

General:new(extension, "hzoan_thoav", "kvoan", 5):addSkills{"thoavqliak","dzziacqszics"}--
Fk:loadTranslationTable{
["hzoan_thoav"] = "韓滔",
["#hzoan_thoav"] = "天目將",
["designer:hzoan_thoav"] = "設計",
["cv:hzoan_thoav"] = "配音",
["illustrator:hzoan_thoav"] = "畫師",
["~hzoan_thoav"] = "終究還是敗已",
}

General:new(extension, "lic_tszjins", "kvoan", 4):addSkills{"phaavshsfec","ceenqjiak"}
Fk:loadTranslationTable{
["lic_tszjins"] = "凌振",
["#lic_tszjins"] = "轟天雷",
["designer:lic_tszjins"] = "設計",
["cv:lic_tszjins"] = "配音",
["illustrator:lic_tszjins"] = "畫師",
["~lic_tszjins"] = "我絕不會倒下",
}
--56. 第五十五回　吳用使時遷偷甲　湯隆賺徐寧上山

General:new(extension, "thoac_liuc", "mjin", 4):addSkills { "dvoansdzoavh", "jiucqleens"}
Fk:loadTranslationTable{
["thoac_liuc"] = "湯隆",
["#thoac_liuc"] = "金錢豹子",
["designer:thoac_liuc"] = "設計",
["cv:thoac_liuc"] = "配音",
["illustrator:thoac_liuc"] = "畫師",
["~thoac_liuc"] = "舞不動若家伙已",
}

General:new(extension, "zio_neec", "tsiacs", 5):addSkills {"kouqljem", "kximqkaap" }
Fk:loadTranslationTable{
["zio_neec"] = "徐寧",
["#zio_neec"] = "金槍手",
["designer:zio_neec"] = "設計",
["cv:zio_neec"] = "配音",
["illustrator:zio_neec"] = "畫師",
["~zio_neec"] = "刀槍入庫,馬放南山",
}

--57. 第五十六回　徐寧教使鉤鐮槍　宋江大破連環馬

--魯智深

--58. 第五十七回　三山聚義打青州　眾虎同心歸水泊
General:new(extension, "moos_jioc_cxens_doat", "kvoan", 3):addSkills { "nzjevhdvoat", "tsoakszjer"}
Fk:loadTranslationTable{
["moos_jioc_cxens_doat"] = "慕容彥達",
["#moos_jioc_cxens_doat"] = "靑州知府",
["designer:moos_jioc_cxens_doat"] = "設計",
["cv:moos_jioc_cxens_doat"] = "配音",
["illustrator:moos_jioc_cxens_doat"] = "畫師",
["~moos_jioc_cxens_doat"] = "秦統制饒命",
}
--59. 第五十八回　吳用賺金鈴吊掛　宋江鬧西嶽華山

--史進 老相好

--60 公孫勝芒碭山降魔　晁天王曾頭市中箭

General:new(extension, "buan_dzzyes", "pujh", 5):addSkills{"hzoonscuan","coosdoavh"}
Fk:loadTranslationTable{
["buan_dzzyes"] = "樊瑞",
["#buan_dzzyes"] = "混世魔王",
["designer:buan_dzzyes"] = "設計",
["cv:buan_dzzyes"] = "配音",
["illustrator:buan_dzzyes"] = "畫師",
["~buan_dzzyes"] = "吉凶自有天數",
}

General:new(extension, "lih_koonh", "tsiacs", 4):addSkills{"hzoanskaak"}  --"hzoanscioh","pujqddxek"
Fk:loadTranslationTable{
["lih_koonh"] = "李袞",
["#lih_koonh"] = "飛天大聖",
["designer:lih_koonh"] = "設計",
["cv:lih_koonh"] = "配音",
["illustrator:lih_koonh"] = "畫師",
["~lih_koonh"] = "䡴不出去已",
}

General:new(extension, "gaoch_tszhiuc", "tsiacs", 5):addSkills{"pujqtoav","zyenqtoav"}
Fk:loadTranslationTable{
["gaoch_tszhiuc"] = "項充",
["#gaoch_tszhiuc"] = "八臂哪吒",
["designer:gaoch_tszhiuc"] = "設計",
["cv:gaoch_tszhiuc"] = "配音",
["illustrator:gaoch_tszhiuc"] = "畫師",
["~gaoch_tszhiuc"] = "命絕睦州城",
}

--曾家 曾弄 曾涂、曾密、曾索、曾魁、曾升
--蘇定
General:new(extension, "ssih_mun_kioc", "tsiacs", 4):addSkills{"hqoeomstsjens","dookszjih"}
Fk:loadTranslationTable{
["ssih_mun_kioc"] = "史文恭",
["#ssih_mun_kioc"] = "大敎師",
["designer:ssih_mun_kioc"] = "設計",
["cv:ssih_mun_kioc"] = "配音",
["illustrator:ssih_mun_kioc"] = "畫師",
["~ssih_mun_kioc"] = "動不了已",
}

--61 吳用智賺玉麒麟　張順夜鬧金沙渡  ,變版本
--賈氏 李固

General:new(extension, "loo_tsyins_cxes", "tsiacs", 4):addSkills{"poavskvoeok","hzaavscxes"}
Fk:loadTranslationTable{
["loo_tsyins_cxes"] = "盧俊義",
["#loo_tsyins_cxes"] = "玉麒麟",
["designer:loo_tsyins_cxes"] = "設計",
["cv:loo_tsyins_cxes"] = "配音",
["illustrator:loo_tsyins_cxes"] = "畫師",
["~loo_tsyins_cxes"] = "生爲大宋人 死爲大宋鬼",
}

General:new(extension, "muoh__loo_tsyins_cxes", "tsiacs", 5):addSkills{"muoqtoojs"}
Fk:loadTranslationTable{
["muoh__loo_tsyins_cxes"] = "盧俊義",
["#muoh__loo_tsyins_cxes"] = "槍棒无敵",
["designer:muoh__loo_tsyins_cxes"] = "設計",
["cv:muoh__loo_tsyins_cxes"] = "配音",
["illustrator:muoh__loo_tsyins_cxes"] = "畫師",
["~muoh__loo_tsyins_cxes"] = "生爲大宋人 死爲大宋鬼",
}

General:new(extension, "kaah_dzzjeh", "mjin", 3,3, General.Female):addSkills{"hzoaqnoar","tszuoqhqaec"}
Fk:loadTranslationTable{
["kaah_dzzjeh"] = "賈氏",
["#kaah_dzzjeh"] = "毒薔薇",
["designer:kaah_dzzjeh"] = "設計",
["cv:kaah_dzzjeh"] = "配音",
["illustrator:kaah_dzzjeh"] = "畫師",
["~kaah_dzzjeh"] = "員外 饒了奴家",
}

General:new(extension, "hqeen_tsheec", "mjin", 3):addSkills{"phuohgxim","koucqloojs"}  --角觝  
Fk:loadTranslationTable{
["hqeen_tsheec"] = "燕靑",
["#hqeen_tsheec"] = "浪子",
["designer:hqeen_tsheec"] = "設計",
["cv:hqeen_tsheec"] = "配音",
["illustrator:hqeen_tsheec"] = "畫師",
["~hqeen_tsheec"] = "旹人苦把功名念止怕功名不到頭",
}

return extension
