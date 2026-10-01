
local ddxecqtszyinh = fk.CreateSkill {
  name = "ddxecqtszyinh",
}

Fk:loadTranslationTable{
  ["ddxecqtszyinh"] = "程準",
  [":ddxecqtszyinh"] = "主旹,伱可將一腳色1區域置入除其外腳色對應區域(或裝僃欄),若迻動後二區域牌數相同,褈置此技能｡",

  ["#ddxecqtszyinh"] = "程準： 迻動1牌",


  ["@@ddxecqtszyinh"] = "程準",

  ["$ddxecqtszyinh1"] = "昰細巧手段如何。",
  ["$ddxecqtszyinh2"] = "粗中有細",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


ddxecqtszyinh:addEffect("active", {
  anim_type = "control",
  prompt = function(self, player)
    return "#ddxecqtszyinh"
  end,
  card_num = 0,
  target_num = 2,
  max_phase_use_time=1,
  interaction = UI.ComboBox {choices = {
    "HandSlot",
    "JudgeSlot",
    "WeaponSlot",
    "ArmorSlot",
    "OffensiveRideSlot",
    "DefensiveRideSlot",
    "TreasureSlot",},
   },
  target_filter = function(self, player, to_select, selected)
    return ( self.interaction.data=="HandSlot" and 
    (#to_select:getCardIds("h")>0 or (#selected==1 and not to_select:isHandAreaSealed() )))

      or 
      (self.interaction.data=="JudgeSlot" and (#to_select:getCardIds("j")>0 or (#selected==1 and not to_select:isJudgeAreaSealed() )))
      or ( S.hasEquip(to_select, Util.convertSubtypeAndEquipSlot(self.interaction.data) ) or (#selected==1 and  #to_select:getAvailableEquipSlots( Util.convertSubtypeAndEquipSlot(self.interaction.data) )>0 ))


  end,
  card_filter = Util.FalseFunc,
  on_cost =function(self, player, data,extra_data)
    local target=data.tos[1]
    local card
    if self.interaction.data==     "HandSlot" then
        card=player.room:askToChooseCard(player,{
      target = target,
      flag= "h",
      skill_name=ddxecqtszyinh.name,
      })
    elseif self.interaction.data==     "JudgeSlot" then
      card=player.room:askToChooseCard(player,{
      target = target,
      flag= "j",
      skill_name=ddxecqtszyinh.name,
      })
    else
      local ty=Util.convertSubtypeAndEquipSlot(self.interaction.data)
      local cards=table.filter(target:getCardIds("e"), function(id) local card=target:getVirtualEquip(id) or Fk:getCardById(id) return card.sub_type==ty end)
      card =player.room:askToChooseCard(player,{
      target = target,
      flag= {card_data={{self.interaction.data,cards}}},
      skill_name=ddxecqtszyinh.name,
      })
    end
    -- local card=player.room:askToChooseCard(player,{
    --   target = target,
      
    -- -- flag= self.interaction.data=="HandSlot" and "h" or  self.interaction.data=="JudgeSlot" and "j" or  
    -- -- {card_data={{"$Equip",table.map(S.getEquips(target, Util.convertSubtypeAndEquipSlot(self.interaction.data)), function(card) return Card:getEffectiveId(card) end)}}},
    --   skill_name=ddxecqtszyinh.name,
    --   })
    data.card=card
  end,
  on_use = function(self, room, effect)
    local player=effect.from
    local cid=effect.card
    if  cid   then
      local area=room:getCardArea(cid)
      room:moveCardTo(cid, area, effect.tos[2], fk.ReasonPut,ddxecqtszyinh.name)

      area = self.interaction.data=="HandSlot" and "h" or  self.interaction.data=="JudgeSlot" and "j" or  "e"
      if #effect.tos[1]:getCardIds(area)== #effect.tos[2]:getCardIds(area) then
        player:setSkillUseHistory(ddxecqtszyinh.name,0,Player.HistoryPhase)
      end
  
    end
    

  end,
})

return ddxecqtszyinh
