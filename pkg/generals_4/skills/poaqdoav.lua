local poaqdoav = fk.CreateSkill{
  name = "poaqdoav",
}


Fk:loadTranslationTable{
["poaqdoav"] = "波濤",
[":poaqdoav"] = "伱預段始旹伱可發動,若全體角色伏區皆无牌,伱抽2,否則伱弃置場上1牌",

["#poaqdoav-nojudge"] = "波濤 場上伏區无牌 伱可令全體角色抽1",
["#poaqdoav-judge"] = "波濤 場上伏區有牌 是否弃",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

poaqdoav:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(poaqdoav.name)  and player.phase==Player.Start
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local nojudge=true
    for _, p in ipairs(room.alive_players) do
      if #p:getCardIds("j")>0 then
        nojudge=false
        break
      end
    end
    local prompt=""
    if nojudge then
      prompt="#poaqdoav-nojudge"
    else
      prompt="#poaqdoav-judge"
    end
    
    if room:askToSkillInvoke(player, {
      skill_name = poaqdoav.name,
      prompt = prompt,
    }) 
    then
      
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local nojudge=true
    for _, p in ipairs(room.alive_players) do
      if #p:getCardIds("j")>0 then
        nojudge=false
        break
      end
    end
    if nojudge then
      player:drawCards(2,poaqdoav.name)
    else
      local tos = player.room:askToChoosePlayers(player, {
        min_num = 1,
        max_num = 1,
        targets = table.filter(player.room.alive_players,function(p)
          return #p:getCardIds("je")>0 
        end),
        -- targets = player.room:getOtherPlayers(player),
        skill_name = poaqdoav.name,
        prompt = "#poaqdoav-choose",
        cancelable = false,
      })
    -- if #tos==0 then return end end  --多餘
      local id = room:askToChooseCard(player, {
        target = tos[1],
        skill_name = poaqdoav.name,
        flag = "ej",
      })
    room:throwCard(id, poaqdoav.name, tos[1], player)
    end
  end,
})


return poaqdoav
