
local tszhiocqphioc_active = fk.CreateSkill{
  name = "tszhiocqphioc_active",
}

Fk:loadTranslationTable{
  ["tszhiocqphioc_active"] = "䡴鋒",
  -- [":tszhiocqphioc_active"] = "段限1.主旹,弃3異花牌或2軍器牌發動.伱令1至2脚色各抽2,其中1脚色執行1額外轉",

  ["#tszhiocqphioc-active"] = "䡴鋒  投出牌",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tszhiocqphioc_active:addEffect("active", {
  anim_type = "offensive",
  prompt = "#tszhiocqphioc-active",
  target_num = 0,
  min_card_num = 1,
  -- max_card_num = function(self,player)
  --   return player:getLostHp()>1 and player:getLostHp() or 1
  -- end,
  -- max_phase_use_time = 1,
  -- interaction = function(self, player)
  --   return UI.ComboBox {
  --     choices = {"damage","discard"},
  --   }
  -- end,
  card_filter = function(self, player, to_select, selected)
    -- if  #selected>= (player:getLostHp() >1 and player:getLostHp() or 1 )then return false end
    local c1= Fk:getCardById(to_select)
    if player:prohibitResponse(c1)  then return end
    if not selected[1] then return true end
      c2=Fk:getCardById(selected[#selected])
    return
      c1.number - c2.number ==   c2.number -  Fk:getCardById(selected[#selected-1]).number

    
    
  end,
  on_use = function(self, room, effect)
    local n =#effect.cards
    S.playCard(effect.cards,"tszhiocqphioc",effect.from)
    effect.from:drawCards(n, tszhiocqphioc_active.name)
    room:setPlayerMark(effect.from,"@@tszhiocqphioc",n)

  end,
})
return tszhiocqphioc_active
