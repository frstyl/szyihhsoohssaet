-- local aux_skills = require "packages/szyihhsoohssaet/aux_skills"

local mechanism = require "packages/szyihhsoohssaet/pkg/hiden/szyih_mechanism"
local tsziukzzyit = require "packages/szyihhsoohssaet/pkg/hiden/szyih_tsziukzzyit"
-- local hiden = require "packages/szyihhsoohssaet/pkg/hiden"

-- local rule = require "packages/szyihhsoohssaet/pkg/rule"
-- local card_times_round = require "packages/szyihhsoohssaet/pkg/rule/card_times_round"
-- local skill_times_round = require "packages/szyihhsoohssaet/pkg/rule/skill_times_round"
-- local draw_cards_number = require "packages/szyihhsoohssaet/pkg/rule/draw_cards_number"


local card_ki = require "packages/szyihhsoohssaet/pkg/cards/card_ki"

local card_allusion = require "packages/szyihhsoohssaet/pkg/cards/card_allusion"
local card_festive = require "packages/szyihhsoohssaet/pkg/cards/card_festive"
local card_derive = require "packages/szyihhsoohssaet/pkg/cards/card_derive"

local card_djis = require "packages/szyihhsoohssaet/pkg/cards/card_djis"
local card_theen = require "packages/szyihhsoohssaet/pkg/cards/card_theen"
local card_ssaac = require "packages/szyihhsoohssaet/pkg/cards/card_ssaac"
local card_Ex = require "packages/szyihhsoohssaet/pkg/cards/card_Ex"


-- local generals = require "packages/szyihhsoohssaet/pkg/generals/generals"

local generals_01 = require "packages/szyihhsoohssaet/pkg/generals/generals_01"
local generals_1 = require "packages/szyihhsoohssaet/pkg/generals/generals_1"
local generals_2 = require "packages/szyihhsoohssaet/pkg/generals/generals_2"
local generals_3 = require "packages/szyihhsoohssaet/pkg/generals/generals_3"
local generals_4 = require "packages/szyihhsoohssaet/pkg/generals/generals_4"
local generals_5 = require "packages/szyihhsoohssaet/pkg/generals/generals_5"
local generals_6 = require "packages/szyihhsoohssaet/pkg/generals/generals_6"
local generals_7 = require "packages/szyihhsoohssaet/pkg/generals/generals_7"
local generals_8 = require "packages/szyihhsoohssaet/pkg/generals/generals_8"
local generals_9 = require "packages/szyihhsoohssaet/pkg/generals/generals_9"
local generals_10 = require "packages/szyihhsoohssaet/pkg/generals/generals_10"
local generals_11 = require "packages/szyihhsoohssaet/pkg/generals/generals_11"
local generals_12 = require "packages/szyihhsoohssaet/pkg/generals/generals_12"


local test2= require "packages/szyihhsoohssaet/pkg/test/ki"

-- local gamemode = require "packages/szyihhsoohssaet/pkg/gamemodes"

-- local S_utility = require "packages/szyihhsoohssaet/S_utility"


local extension = Package:new("szyihhsoohssaet_gamemode", Package.SpecialPack)
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/gamemodes/rule_skills")
extension:addGameMode(require ("packages.szyihhsoohssaet.pkg.gamemodes.1v2"))
Fk:loadTranslationTable{ ["szyihhsoohssaet_gamemode"] = "水滸殺模式" }  --


Fk:loadTranslationTable{ 
  ["szyihhsoohssaet"] = "水滸殺" ,
  -- ["card_ki"] = "水滸殺" ,
}


return {

  generals_01,
  generals_1,
  generals_2,
  generals_3,
  generals_4,
  generals_5,
  generals_6,
  generals_7,
  generals_8,
  generals_9,
  generals_10,
  generals_11,
  generals_12,

  -- generals,
-- gamemode,
  -- rule,
  -- hiden,
  -- S_utility,
  -- card_times_round,
  -- skill_times_round,
  -- draw_cards_number,

  mechanism,
  tsziukzzyit,


  card_ki,

  card_allusion,
  card_festive,
  card_derive,

  card_djis,
  card_theen,
  card_ssaac,

  card_Ex,

  test2,
  extension,

}


