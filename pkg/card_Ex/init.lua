local extension = Package:new("card_Ex", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
-- extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/card_Ex/skills")

--補全
extension:addCardSpec("ssaet", Card.Spade, 1)  --6
extension:addCardSpec("ssaet", Card.Spade, 2)
extension:addCardSpec("ssaet",Card.Spade, 4)
extension:addCardSpec("ssaet",Card.Spade, 10)
extension:addCardSpec("ssaet",Card.Spade, 12)
extension:addCardSpec("ssaet",Card.Spade, 13)


extension:addCardSpec("ssaet",Card.Club, 1)  --7
extension:addCardSpec("ssaet",Card.Club, 2)
extension:addCardSpec("ssaet",Card.Club, 5)
extension:addCardSpec("ssaet",Card.Club, 8)
extension:addCardSpec("ssaet",Card.Heart, 9)
extension:addCardSpec("ssaet",Card.Club, 10)
extension:addCardSpec("ssaet", Card.Heart, 12)


extension:addCardSpec("szjemh", Card.Diamond, 2)  --7
extension:addCardSpec("szjemh", Card.Diamond, 3)
extension:addCardSpec("szjemh", Card.Diamond, 4)
extension:addCardSpec("szjemh", Card.Diamond, 7)
extension:addCardSpec("szjemh", Card.Diamond, 9)
extension:addCardSpec("szjemh", Card.Diamond, 10)
extension:addCardSpec("szjemh", Card.Diamond, 11)

extension:addCardSpec("nziuk", Card.Heart, 2)
extension:addCardSpec("nziuk", Card.Heart, 3)
extension:addCardSpec("nziuk", Card.Heart, 6)
extension:addCardSpec("nziuk", Card.Heart, 11)

extension:addCardSpec("tsiuh",Card.Spade, 6)
extension:addCardSpec("tsiuh",Card.Spade, 9)
--

--

--


-- extension:addCardSpec("bioc_hsioc_hsfas_kjit",Card.Spade, 4) --止1  法術?

-- -- extension:addCardSpec("nioh_shield", Card.Club, 2)  --元Ex
-- -- extension:addCardSpec("tshjit_seec_kiams", Card.Spade, 2)  --元Ex
-- -- extension:addCardSpec("hsoeojh_tshjev", Card.Club, 5)  --v1海鰍

extension:addCardSpec("ssaen_hsvoah", Card.Heart, 7)  --元Ex
extension:addCardSpec("djis_douch", Card.Club, 7)  --元Ex
extension:addCardSpec("hsoeojh_seevs", Card.Diamond, 1)  --
extension:addCardSpec("theen_looj", Card.Heart, 12)  --元Ex

-- extension:addCardSpec("khxes_kheet_sis_tssaas", Card.Spade, 10)  --已有3 supply_shortage加彊 
extension:addCardSpec("tvoans_liac_dzyet_quan", Card.Club, 6) --改 
extension:addCardSpec("tsjek_tshoavh_doon_liac", Card.Club, 11)



-- -- extension:addCardSpec("hsiap_paak", Card.Club, 7)  --v1 Ex
extension:addCardSpec("buoh_teejh_tthiu_sjin", Card.Club, 3)  --v3酒
extension:addCardSpec("hqjin_deek_qwe_tsji", Card.Spade, 3)  ----v3酒
extension:addCardSpec("liac_tshoavh_seen_hzaac", Card.Heart, 9)  --轉爲殺
extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Diamond, 12)  --轉爲nziuk

extension:addCardSpec("hsiu_jiach_ssaac_sik", Card.Heart, 13)  --ssaac
extension:addCardSpec("kiuc_szjih_sje_ttiac", Card.Heart, 10)

--增
extension:addCardSpec("buoh_teejh_tthiu_sjin", Card.Spade, 7)  --v3酒
extension:addCardSpec("hqjin_deek_qwe_tsji", Card.Spade, 8)  ----v3酒

extension:addCardSpec("tsiac_keejs_dzius_keejs", Card.Heart, 1)
extension:addCardSpec("buac_hzfan_mujs_nzjen", Card.Diamond, 13)

extension:addCardSpec("thooms_theec", Card.Club, 4)

extension:addCardSpec("hqjin_szjer_ljis_doavs", Card.Spade, 11)
extension:addCardSpec("hqjin_szjer_ljis_doavs", Card.Club, 10)  --?殺

extension:addCardSpec("sjevs_lih_dzoac_toav", Card.Spade, 5)
extension:addCardSpec("sjevs_lih_dzoac_toav", Card.Heart, 5)

extension:addCardSpec("tshoak_hsvoah_tsjek_sjin", Card.Diamond, 12)  --v0boav

extension:addCardSpec("khxes_kheet_sis_tssaas", Card.Heart, 4)  --已有3 supply_shortage加彊 

Fk:loadTranslationTable{
  ["card_Ex"] = "水滸牌Ex",


}

return extension

