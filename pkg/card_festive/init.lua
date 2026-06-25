local extension = Package:new("card_festive", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/card_festive/skills")

local gij = fk.CreateCard{
  name = "gij",
  type = Card.TypeTrick,  --act
  is_damage_card = false,
  skill = "gij_skill",
  is_passive = true,
}

local tsoucs = fk.CreateCard{
  name = "tsoucs",
  type = Card.TypeTrick,
  is_damage_card = false,
  skill = "tsoucs_skill",
  is_passive = false,
}

local cuat_pjech = fk.CreateCard{
  name = "cuat_pjech",
  type = Card.TypeTrick,
  is_damage_card = false,
  skill = "cuat_pjech_skill",
  is_passive = false,
}
local thoac_qwen = fk.CreateCard{
  name = "thoac_qwen",
  type = Card.TypeTrick,
  is_damage_card = false,
  skill = "thoac_qwen_skill",
  is_passive = false,
}

local hzouc_paav = fk.CreateCard{
  name = "hzouc_paav",
  type = Card.TypeTrick,
  is_damage_card = false,
  skill = "hzouc_paav_skill",
  is_passive = false,
}

local ssaac_dzzjin_koac = fk.CreateCard{
  name = "ssaac_dzzjin_koac",
  type = Card.TypeTrick,  --基本-物資
  sub_type = Card.SubtypeDelayedTrick,
  skill = "ssaac_dzzjin_koac_skill",
}
extension:loadCardSkels {
ssaac_dzzjin_koac,
}

extension:loadCardSkels {
  gij,
  thoac_qwen,
  tsoucs,
  hzouc_paav,
  cuat_pjech,
}

extension:addCardSpec("tsoucs",Card.Heart, 5)
extension:addCardSpec("tsoucs",Card.Diamond, 5)
extension:addCardSpec("cuat_pjech",Card.Heart, 8)
extension:addCardSpec("cuat_pjech",Card.Spade, 8)
extension:addCardSpec("thoac_qwen",Card.Heart, 1)
extension:addCardSpec("thoac_qwen",Card.Spade, 5)
extension:addCardSpec("hzouc_paav",Card.Club, 6)
extension:addCardSpec("hzouc_paav",Card.Diamond, 6)

extension:addCardSpec("gij",Card.Club, 4)
extension:addCardSpec("gij",Card.Heart, 4)

extension:addCardSpec("ssaac_dzzjin_koac",Card.Diamond, 8)



Fk:loadTranslationTable{
  ["card_festive"] = "水滸牌-節日禮包 ",

  ["thoac_qwen"]= "湯圓",
  [":thoac_qwen"] = "基本牌-物資<br /><b>旹機</b>：主旹<br /><b>目幖</b>：1其它角色  <br /><b>次數</b>：輪限1  <br /><b>效果</b>：伱隨機迻至目幖上家或下家。",
  ["thoac_qwen_skill"]= "湯圓",
  [":thoac_qwen_skill"]= "隨機迻至其它角色上家或下家",

  ["tsoucs"]= "糭",
  [":tsoucs"]= "基本牌-物資<br /><b>旹機</b>：主旹<br /><b>目幖</b>：伱  <br /><b>次數</b>：輪限1 <br /><b>效果</b>：伱體力上限+1,回1",
  ["#tsoucs_skill"]= "糭",

  ["cuat_pjech"]= "月餅",
  [":cuat_pjech"]= "基本牌-物資<br /><b>旹機</b>：主旹<br /><b>目幖</b>: 伱  <br /><b>次數</b>：輪限1 <br /><b>效果</b>：伱存牌上限+1",
  [":cuat_pjech_skill"]= "月餅",
  
  ["gij"]= "祈",
  [":gij"]= "基本牌-動作<br /><b>旹機</b>：一判定牌生效前<br /><b>目幖</b>: 无<br /><b>效果</b>：伱抽1,中止元旹機",
  [":gij_skill"]= "祈",

  ["hzouc_paav"]= "紅勹",
  [":hzouc_paav"]= "基本牌-物資<br /><b>旹機</b>：主旹<br /><b>目幖</b>: 伱<br /><b>效果</b>：伱聲明1牌類,伱探取1該類牌,25%槪率改爲探取2",
  [":hzouc_paav_skill"]= "紅勹",
 
  ["ssaac_dzzjin_koac"] = "生辰綱",
  [":ssaac_dzzjin_koac"] = "基本牌-物資-延旹<br /><b>旹機</b>: 主旹<br /><b>目幖</b>：伱<br /><b>延旹</b>: 將此牌置于目幖角色伏區,目幖受到火傷旹生效。<br /><b>生效</b>：目幖判定,若結果爲紅色A/J/Q/K,A抽5,否則將此牌置入A下家伏區額外</b>：此牌被抵消後至入目幖下家伏區",

  ["ssaac_dzzjin_koac_skill"] = "生辰綱",
  [":ssaac_dzzjin_koac_skill"] = "生辰綱",
  ["#ssaac_dzzjin_koac_skill"] = "生辰綱",

  -- ["hqjevqcuat"]= "邀月",
  -- ["ljeqsoav"]= "離騷",
  
}

return extension

