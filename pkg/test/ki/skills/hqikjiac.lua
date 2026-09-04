local jiacqhqik = fk.CreateSkill{
  name = "jiacqhqik",
  tags={Skill.Rhyme }, --Skill.Switch
}

Fk:loadTranslationTable{
  ["jiacqhqik"] = "揚抑",  --獨奏 合奏 閒奏
  [":jiacqhqik"] = "伱起動或演練牌旹,若此牌較伱(1轉內且有此技能期)上一起動或演練牌點數(无牌无點視爲0點){➀高/➁低},伱可選擇1腳色發動,其{抽/自弃}1｡否則改爲別一項",  --

  ["@jiacqhqik-turn"] = "揚抑",

  ["#jiacqhqik_draw"] = "揚抑 選擇1腳色令其抽1",
  ["#jiacqhqik_discard"] = "揚抑 選擇1腳色令其弃1",


}


-- local S = require "packages/szyihhsoohssaet/szyih_guos" 
local U = require "packages/utility/utility"

local spec ={
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(jiacqhqik.name)
    and 
    
    ((data.card.number>player:getMark("@jiacqhqik-turn") and player:getSwitchSkillState(jiacqhqik.name)==0)
  or (data.card.number<player:getMark("@jiacqhqik-turn") and player:getSwitchSkillState(jiacqhqik.name)==1)
)
  end,
  on_cost = function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      targets = player.room.alive_players,
      min_num = 1,
      max_num = 1,
      prompt =player:getSwitchSkillState(jiacqhqik.name)==1 and  "#jiacqhqik_discard" or "#jiacqhqik_draw" ,
      skill_name = jiacqhqik.name,
      cancelable = true,
    })
    if  #tos==1 then
      event:setCostData(self,{tos=tos,switch_state=player:getSwitchSkillState(jiacqhqik.name)})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    if event:getCostData(self).switch_state==0 then
      event:getCostData(self).tos[1]:drawCards(1,jiacqhqik.name)
    else
      player.room:askToDiscard( event:getCostData(self).tos[1], {
        min_num = 1,
        max_num = 1,
        include_equip = true,
        skill_name = jiacqhqik.name,
        cancelable = false,
      })
    end
  end,
  late_refresh=true,
  can_refresh = function(self, event, target, player, data)
    return target==player and player:hasSkill(jiacqhqik.name,true)
  end,
  on_refresh = function(self, event, target, player, data)
    -- if data.card.number == player:getMark("@jiacqhqik-turn") then
    if not ((data.card.number>player:getMark("@jiacqhqik-turn") and player:getSwitchSkillState(jiacqhqik.name)==0)
  or (data.card.number<player:getMark("@jiacqhqik-turn") and player:getSwitchSkillState(jiacqhqik.name)==1)) then
        U.SetSwitchSkillState(player, jiacqhqik.name, player:getSwitchSkillState(jiacqhqik.name, true))

    -- player.room:setPlayerMark(
    --     player,
    --     MarkEnum.SwithSkillPreName .. jiacqhqik.name,
    --     player:getSwitchSkillState(jiacqhqik.name, true)
    --   )
    end
    player.room:setPlayerMark(player,"@jiacqhqik-turn",data.card.number)

  end,
}

jiacqhqik:addEffect(fk.CardUsing, spec)
jiacqhqik:addEffect(fk.CardResponding, spec)

return jiacqhqik
