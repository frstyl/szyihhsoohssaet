local maestoav_attached = fk.CreateSkill({
  name = "maestoav_attached&",
})


Fk:loadTranslationTable{
  ["maestoav_attached&"] = "買刀",
  [":maestoav_attached"] = "主旹,伱可交予賣刀者1~3牌獲取其1刀.其可拒絕",

  ["#maestoav_attached"] = "買刀",

  ["#maestoav_log"] = " %from 以 %arg 牌自%to 買 %arg2",
  ["#maestoav-ask"] = "買刀 %src 以 %arg 牌 買伱%arg2",
  ["#maestoav_dead"] = " 銀貨兩訖",

  ["#maestoav-choose"] = "買刀 選刀",


  ["maestoav_yes"] = "賣賣賣",
  ["maestoav_no"] = "不賣",
  -- ["$maestoav_attached1"] = "何人能識此刀",
  -- ["$maestoav_attached2"] = "伱止給足銀子明日自來与它收屍",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

maestoav_attached:addEffect("active", {
  min_card_num = 1,
  max_card_num = 3,
  target_num = 1,
  max_phase_use_time=1,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).sub_type==Card.SubtypeWeapon
  -- end,
  target_filter = function(self, player, to_select, selected)
    return #to_select:getPile("maestoav_toav")>0
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
      
    room:notifySkillInvoked(target, "maestoav")
    target:broadcastSkillInvoke("maestoav")
    room:doIndicate(player.id, { target.id })
    local ids = room:askToChooseCards( player, {
        target = target,
        min = 1,
        max = 1,
        flag = { card_data = {{ "maestoav_toav", target:getPile("maestoav_toav") }} },  --可見
        skill_name = "maestoav",
        prompt = "#maestoav-choose",
      })
    local cards= effect.cards
    local arg1=#cards
    local arg2= Fk:getCardById(ids[1]):toLogString()
    room:sendLog{
        type = "#maestoav_log",
        from = player.id,
        to = {target.id},
        arg = arg1,
        arg2 = arg2,
      }
      if   room:askToChoice(target, {
        choices = {"maestoav_yes", "maestoav_no"},
        skill_name = "maestoav",
        prompt = "#maestoav-ask:".. player.id.."::"..arg1..":"..arg2,
      }) == "maestoav_no" then  return end
      if player.dead then return end
      player.room:moveCardTo(cards, Card.PlayerHand, target, fk.ReasonGive, maestoav_attached.name, nil, true, player)
      if target.dead then 
        room:sendLog{
          type = "#maestoav_dead",
          -- from = player.id,
          -- to = {target.id},
          -- arg = arg1,
          -- arg2 = arg2,
        }
      end
      player.room:moveCardTo(ids, Card.PlayerHand, player, fk.ReasonPrey, maestoav_attached.name, nil, true, player)
      
  end,
})
return maestoav_attached
