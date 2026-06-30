Fk:loadTranslationTable{
  ["hsoeokteems"] = "黑店",
  [":hsoeokteems"] = "鎖➀當一其它角色失去冣後手牌旹,必發,其選1項➀交与伱1裝僃區牌➁流失1體力.➁當伱受到其它角色傷害後,傷害來源須弃x手牌(x爲傷害值)",

  ["#hsoeokteems-choose"] = "%src 黑店 生效",
  ["#hsoeokteems-discard"] = "黑店：伱須弃%arg手牌",
  -- ["#hsoeokteems-give"] = "給牌",

  ["$hsoeokteems1"] = "總得畱下些物件再走",

}

local hsoeokteems = fk.CreateSkill{
  name = "hsoeokteems",
  tags = { Skill.Compulsory },
}

hsoeokteems:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(hsoeokteems.name)  then return false end
    local tos={}
    for _, move in ipairs(data) do
      if move.from  and #move.from:getCardIds("h")==0 then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea == Card.PlayerHand then
            table.insert(tos,move.from )--player[]
          end
        end
      end
    end
    if #tos>0 then
      event:setCostData(self, {tos=tos})
      return true
    end
  end,

  on_use = function(self, event, target, player, data)
    local room=player.room
    for _, p in ipairs(event:getCostData(self).tos) do
            local choice="loseHp"
      if #p:getCardIds("e")==0 then
         choice="loseHp"
      else
        choice = player.room:askToChoice(p, {
          choices = {"loseHp","give"},
          skill_name = hsoeokteems.name,
          prompt = "#hsoeokteems-choose:"..player.id,
        })
      end
      if choice=="loseHp" then
        room:loseHp(p,1,hsoeokteems.name,player)
      else
        local card = room:askToChooseCard(p, {
          target = p,
          flag = "e",
          skill_name = hsoeokteems.name,
          })
        room:moveCardTo(card, Player.Hand, player, fk.ReasonGive, hsoeokteems.name, nil, false, p)
      end
    end
  end,
})

hsoeokteems:addEffect(fk.Damaged, {
  can_trigger = function(self, event, target, player, data)
      return target==player and data.from~=player  and player:hasSkill(hsoeokteems.name)
    end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local cards = room:askToDiscard(data.from, {
      min_num = data.damage,
      max_num = data.damage,
      include_equip = false,
      skill_name = hsoeokteems.name,
      cancelable = true,
      prompt = "#hsoeokteems-discard:"..data.damage,
      skip = false,
    })
  end,
})
return hsoeokteems
