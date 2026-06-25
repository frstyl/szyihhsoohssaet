local poaqdoav = fk.CreateSkill{
  name = "poaqdoav",
}


Fk:loadTranslationTable{
["poaqdoav"] = "波濤",
[":poaqdoav"] = "每輪始旹,",

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

    return room:askToSkillInvoke(player, {
      skill_name = poaqdoav.name,
      prompt = prompt,
    }) 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:setBanner("poaqdoav-round",1)
    for _, p in ipairs(room.alive_players) do
      if not p:isNude() then
        local card = room:askToCards(p, {
          skill_name = poaqdoav.name,
          include_equip = true,
          min_num = 1,
          max_num = 1,
          prompt = "#poaqdoav-ask",
          cancelable = false,
        })
        p:addToPile("poaqdoav_ddxev", card, true, poaqdoav.name)
      end
    end
  end,
})


return poaqdoav
