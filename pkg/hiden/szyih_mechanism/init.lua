local extension = Package:new("szyih_mechanism", Package.SpecialPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/hiden/szyih_mechanism/skills")

Fk:loadTranslationTable{ 
  ["szyih_mechanism"] = "水滸輔" ,
}
local play = fk.CreateCard{
  name = "&play",
  type = Card.TypeBasic,
  skill = "khouc_skill",  --否 不可用
  -- is_passive = true,
}
extension:loadCardSkels{play}
extension:addCardSpec("play")


local khouc = fk.CreateCard{
  name = "&khouc",
  type = Card.TypeBasic,
  skill = "khouc_skill",  --否 不可用
  -- is_passive = true,
}
extension:loadCardSkels{khouc}
extension:addCardSpec("khouc")

local hqrach = fk.CreateCard{
  name = "&hqrach",
  type = Card.TypeBasic,
  skill = "hqrach_skill",  --1至多目幖
  is_passive = false,
}
extension:loadCardSkels{hqrach}
extension:addCardSpec("hqrach")


local hzfens = fk.CreateCard{
  name = "&hzfens",
  type = Card.TypeBasic,
  skill = "hzfens_skill",  --1至多目幖
  is_passive = false,
}
extension:loadCardSkels{hzfens}
extension:addCardSpec("hzfens")


local hsio = fk.CreateCard{
  name = "&hsio",
  type = Card.TypeBasic,
  skill = "hsio_skill",  --无目幖
  -- is_passive = true,
}
extension:loadCardSkels{hsio}
extension:addCardSpec("hsio")

Fk:loadTranslationTable{
  ["khouc"] = "空",
  ["hsio"] = "虛",
  ["hzfens"] = "㕕",
}
-- local khouc__koarbiuk_card = fk.CreateCard{  --區別葢伏態与可葢伏?
  -- name = "&khouc__koarbiuk_card",  --koarbiuk_card
  -- type = Card.TypeTrick,  --无類
  -- is_passive=true,
  -- skill = "piuh_skill",
  -- special_skills = { "koarbiuk_cardskill" },
-- }
-- Fk:loadTranslationTable{
  -- ["&khouc__koarbiuk_card"] = "葢伏",  --不需譯
-- }

-- extension:loadCardSkels{khouc__koarbiuk_card}
-- extension:addCardSpec("khouc__koarbiuk_card")

local koarbiuk_card = fk.CreateCard{  --skill card operate
  name = "&koarbiuk_card",  --koarbiuk_card
  type = Card.TypeTrick,
  sub_type = Card.SubtypeDelayedTrick,
  skill = "default_card_skill",
  -- special_skills = { "koarbiuk_cardskill" },
  stackable_delayed = true,
}

Fk:loadTranslationTable{
  ["&koarbiuk_card"] = "葢伏",
  ["koarbiuk_card"] = "伏牌",
  [":koarbiuk_card"] = "暗置不可察看",
}

extension:loadCardSkels{koarbiuk_card}
extension:addCardSpec("koarbiuk_card")


local khouc__ssaet = fk.CreateCard{
  name = "&khouc__ssaet",
  type = Card.TypeBasic,
  skill = "khouc_skill",
}

local khouc__szjemh = fk.CreateCard{
  name = "&khouc__szjemh",
  -- trueName="szjemh",
  type = 1,  --
  skill = "khouc_skill",
}

extension:loadCardSkels {
  khouc__ssaet,   khouc__szjemh,
-- koarbiuk_card,
}

extension:addCardSpec("khouc__ssaet")
extension:addCardSpec("khouc__szjemh")

Fk:loadTranslationTable{
  ["not_equip_filter_skill"] = "非裝僃",
  ["khouc_skill"] = "空",

  ["weapon__not_equip"] = "武器",
  [":weapon__not_equip"] = "空",

  ["armor__not_equip"] = "防具",
  [":armor__not_equip"] = "空",

  ["offensive_horse__not_equip"] = "攻馬",
  [":offensive_horse__not_equip"] = "空",

  ["defensive_horse__not_equip"] = "防馬",
  [":defensive_horse__not_equip"] = "空",

  ["treasure__not_equip"] = "寶物",
  [":treasure__not_equip"] = "空",
}
local weapon__not_equip = fk.CreateCard{  --非裝僃置入裝僃區 --moveCardIntoEquip 應指定裝所入僃欄
  name = "&weapon__not_equip",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeWeapon,
}
extension:loadCardSkels{weapon__not_equip}
extension:addCardSpec("weapon__not_equip")

local armor__not_equip = fk.CreateCard{
  name = "&armor__not_equip",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeArmor,
}
extension:loadCardSkels{armor__not_equip}
extension:addCardSpec("armor__not_equip")

local offensive_horse__not_equip = fk.CreateCard{
  name = "&offensive_horse__not_equip",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeOffensiveRide,
}
extension:loadCardSkels{offensive_horse__not_equip}
extension:addCardSpec("offensive_horse__not_equip")

local defensive_horse__not_equip = fk.CreateCard{
  name = "&defensive_horse__not_equip",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeDefensiveRide,
}
extension:loadCardSkels{defensive_horse__not_equip}
extension:addCardSpec("defensive_horse__not_equip")

local treasure__not_equip = fk.CreateCard{
  name = "&treasure__not_equip",
  type = Card.TypeEquip,
  sub_type = Card.SubtypeTreasure,
}
extension:loadCardSkels{treasure__not_equip}
extension:addCardSpec("treasure__not_equip")




return extension
