local extension = Package:new("card_festive", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/cards/card_festive/skills")

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
local biu_qwen_tsih = fk.CreateCard{
  name = "biu_qwen_tsih",
  type = Card.TypeTrick,
  is_damage_card = false,
  skill = "biu_qwen_tsih_skill",
  is_passive = false,
}

local hzouc_paav = fk.CreateCard{
  name = "hzouc_paav",
  type = Card.TypeTrick,
  is_damage_card = false,
  skill = "hzouc_paav_skill",
  is_passive = false,
}


extension:loadCardSkels {
  gij,
  biu_qwen_tsih,
  tsoucs,
  hzouc_paav,
  cuat_pjech,
}

extension:addCardSpec("tsoucs",Card.Heart, 5)
extension:addCardSpec("tsoucs",Card.Diamond, 5)
extension:addCardSpec("cuat_pjech",Card.Heart, 8)
extension:addCardSpec("cuat_pjech",Card.Spade, 8)
extension:addCardSpec("biu_qwen_tsih",Card.Heart, 1)
extension:addCardSpec("biu_qwen_tsih",Card.Spade, 5)
extension:addCardSpec("hzouc_paav",Card.Club, 6)
extension:addCardSpec("hzouc_paav",Card.Diamond, 6)

extension:addCardSpec("gij",Card.Club, 4)
extension:addCardSpec("gij",Card.Heart, 4)



Fk:loadTranslationTable{
  ["card_festive"] = "水滸牌-節日禮包 ",

  ["biu_qwen_tsih"]= "浮圓子",
  [":biu_qwen_tsih"] = "物資<br /><b>旹機</b>：主段執行旹<br /><b>目幖</b>：1其它脚色  <br /><b>次數</b>：輪限1  <br /><b>效果</b>：伱隨機迻至目幖上家或下家。",
  ["biu_qwen_tsih_skill"]= "浮圓子",
  [":biu_qwen_tsih_skill"]= "隨機迻至其它脚色上家或下家",

  ["tsoucs"]= "糉",  --糭
  [":tsoucs"]= "物資<br /><b>旹機</b>：主段執行旹<br /><b>目幖</b>：伱  <br /><b>次數</b>：輪限1 <br /><b>效果</b>：伱體力上限+1,回1",
  ["#tsoucs_skill"]= "糉",

  ["cuat_pjech"]= "月餅",
  [":cuat_pjech"]= "物資<br /><b>旹機</b>：主段執行旹<br /><b>目幖</b>: 伱  <br /><b>次數</b>：輪限1 <br /><b>效果</b>：伱存牌上限+1",
  [":cuat_pjech_skill"]= "月餅",
  
  ["gij"]= "祈",
  [":gij"]= "動作   <br /><b>旹機</b>：一占卜牌生效前    <br /><b>目幖</b>: 无    <br /><b>目幖數</b>: 0  <br /><b>效果</b>：伱抽1,中止元旹機  <br /><b>額外</b>：應動",
  [":gij_skill"]= "祈",

  ["hzouc_paav"]= "紅勹",
  [":hzouc_paav"]= "物資<br /><b>旹機</b>：主段執行旹<br /><b>目幖</b>: 伱<br /><b>效果</b>：伱聲明1牌類,伱探取1該類牌,25%槪率改爲探取2",
  [":hzouc_paav_skill"]= "紅勹",
 
  ["ssaac_dzzjin_koac"] = "生辰綱",
  [":ssaac_dzzjin_koac"] = "物資-延旹<br /><b>旹機</b>: 主段執行旹<br /><b>目幖</b>：伱<br /><b>延旹</b>: 將此牌置于目幖脚色伏區,目幖受到火傷旹生效。<br /><b>生效</b>：目幖占卜,若結果爲紅色A/J/Q/K,A抽5,否則將此牌置入A下家伏區額外</b>：此牌被抵消後至入目幖下家伏區",

  ["ssaac_dzzjin_koac_skill"] = "生辰綱",
  [":ssaac_dzzjin_koac_skill"] = "生辰綱",
  ["#ssaac_dzzjin_koac_skill"] = "生辰綱",

  -- ["hqjevqcuat"]= "邀月",
  -- ["ljeqsoav"]= "離騷",
  
}

return extension

