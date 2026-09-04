local phoasmuacs = fk.CreateSkill {
  name = "phoasmuacs",
}
Fk:loadTranslationTable{
  ["phoasmuacs"] = "破妄",
  [":phoasmuacs"] = "印牌:起動虛擬｢防患未肰抵消｣｡若伱手牌數不等于體力數(不小于0)伱可打出x手牌或流失x發動(x爲伱手牌數體力數之差)",

  ["#phoasmuacs"] = "破妄 視爲起動防患未肰旹",
  ["#phoasmuacs-discard"] = "破妄 打出%arg手牌",

  ["$phoasmuacs1"] = "不破不立破而後立",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

phoasmuacs:addEffect("viewas", {
  anim_type = "defensive",
  pattern = ".|0|nosuit|none||buac_hzfan_mujs_nzjen",
  prompt = "#phoasmuacs",
  mute_card = true,
  -- handly_pile = true,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    -- if #cards ~= 1 then return end
    local c = Fk:cloneCard("buac_hzfan_mujs_nzjen")
    c.skillName = phoasmuacs.name
    return c
  end,
  before_use = function(self, player, use)
    local n =player:getHandcardNum()-math.max(0, player.hp)
    if n>0 then
       S.askToPlayCard(player, {
        min_num = n,
        max_num = n,
        include_equip = false,
        skill_name = phoasmuacs.name,
        cancelable = false,
        prompt = "#phoasmuacs-discard:::".. n,
        skip = false
      })
    else
      player.room:loseHp(player,-n,phoasmuacs.name,player)
    end
  end,
  -- enabled_at_play =  function(self, player)
  --   return player:getHandcardNum()~=player.hp
  -- end,
  enabled_at_response = function(self, player, response)
    return  not response 
    and  
    player:getHandcardNum()~=player.hp
	and player.hp>=0

  end,
  -- enabled_at_nullification = function (self, player, data)  --data 加入holder
  --   return data and data.to == player
  --    and
  --     -- player:getHandcardNum()~=player.hp 
  --     -- and data.card:isInstantTrick() 
  -- end,
})



return phoasmuacs
