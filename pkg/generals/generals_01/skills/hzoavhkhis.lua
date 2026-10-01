Fk:loadTranslationTable{
  ["hzoavhkhis"] = "浩气",
  [":hzoavhkhis"] = "伱致傷或受傷後,伱可發動:伱展示手牌,抽x(x爲伱手牌不含牌花數)",


  ["$hzoavhkhis1"] = "哈哈哈哈哈哈哈哈！",
  ["$hzoavhkhis2"] = "伯符，且看我这一手！",
}

local hzoavhkhis = fk.CreateSkill{
  name = "hzoavhkhis",
  -- tags = { Skill.Compulsory,Skill.Permanent },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzoavhkhis:addEffect(fk.Damaged, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return (data.from==player or data.to==player)
    and player:hasSkill(hzoavhkhis.name) 
    --and data.to~=player 
    --and data.damage>0
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- local n =data.damage
    local cards=player:getCardIds("h") 
    player:showCards(cards)
    local suits={}
    for _,id in ipairs(cards) do
      local suit = Fk:getCardById(id).suit
      if suit~=Card.NoSuit and not table.contains(suits,suit) then
      table.insert(suits, suit)
      end
    end
    local n = 4-#suits
    player:drawCards(n,hzoavhkhis.name)
    -- room:askToDiscard(data.to, {
    --   min_num = n,
    --   max_num = n,
    --   include_equip = true,
    --   skill_name = hzoavhkhis.name,
    --   cancelable = false,
    --   prompt = "#hzoavhkhis-discard",
    --   skip = false,
    -- })
  end,
})


return hzoavhkhis
