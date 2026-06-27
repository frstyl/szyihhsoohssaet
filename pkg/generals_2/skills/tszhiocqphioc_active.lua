
local tszhiocqphioc_active = fk.CreateSkill{
  name = "tszhiocqphioc_active",
}

Fk:loadTranslationTable{
  ["tszhiocqphioc_active"] = "䡴鋒",
  -- [":tszhiocqphioc_active"] = "每段限1.主動,弃3異花牌或2裝僃牌發動.伱令1至2角色各抽2,其中1角色執行1額外轉",

  ["#tszhiocqphioc-active"] = "䡴鋒  弃牌",

}


tszhiocqphioc_active:addEffect("active", {
  anim_type = "offensive",
  prompt = "#tszhiocqphioc-active",
  target_num = 0,
  min_card_num = 1,
  max_card_num = function(self,player)
    return player:getLostHp()>1 and player:getLostHp() or 1
  end,
  -- max_phase_use_time = 1,
  -- interaction = function(self, player)
  --   return UI.ComboBox {
  --     choices = {"damage","discard"},
  --   }
  -- end,
  card_filter = function(self, player, to_select, selected)
    if  #selected>= (player:getLostHp() >1 and player:getLostHp() or 1 )then return false end
    if #selected<2 then 
      return not player:prohibitDiscard(selected) 
    else
      return not player:prohibitDiscard(selected) 
      and
      Fk:getCardById(to_select).number - Fk:getCardById(selected[#selected]).number
     ==
        Fk:getCardById(selected[2]).number -  Fk:getCardById(selected[1]).number
    end
    
  end,
  on_use = function(self, room, effect)
    local n =#effect.cards
    room:throwCard(effect.cards, tszhiocqphioc_active.name, effect.from, effect.from)
    effect.from:drawCards(n, tszhiocqphioc_active.name)
    room:setPlayerMark(effect.from,"@@tszhiocqphioc",n)

  end,
})
return tszhiocqphioc_active
