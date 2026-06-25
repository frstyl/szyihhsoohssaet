local sjisziach = fk.CreateSkill{
  name = "sjisziach",
}


Fk:loadTranslationTable{
  ["sjisziach"] = "四像",
  [":sjisziach"] = "預段始旹,伱可預褈鑄不同色a(至少1)牌選擇1至多a名角色發動｡所選角色將手牌抽或弃至a",

  ["#sjisziach_active"] = "四像 褈鑄不同花牌指定至多等量角色",
  ["#sjisziach-discard"] = "四像 弃 %arg",
  ["$sjisziach1"] = "朱雀神鳥爲我先導",
  ["$sjisziach2"] = "",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

sjisziach:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(sjisziach.name) and player.phase == Player.Start
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local yes, dat = room:askToUseActiveSkill(player, {  --askToChooseCardsAndPlayers 等實調用此 askToUseActiveSkill
      skill_name = "sjisziach_active",
      prompt = "#sjisziach_active",
      cancelable = true,
      skip = true,  --不執行
    })
    if yes then
      event:setCostData(self, { cards=dat.cards, tos = dat.targets})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards= event:getCostData(self).cards
    local n=#cards
    local count=0
    local tos =event:getCostData(self).tos
    -- S.playCard(player,cards,sjisziach.name)
    room:recastCard(cards,player,sjisziach.name)
    for _,p in ipairs(tos) do
      if not p.dead then
        local m=n-p:getHandcardNum()
        count=count+m
        if m>0 then
          p:drawCards(m,sjisziach.name)
        elseif m<0 then
          m=-m
        room:askToDiscard(p,{
            min_num = m,
            max_num = m,
            include_equip = false,
            skill_name = sjisziach.name,
            prompt = "#sjisziach-discard:::"..m,
            cancelable = false,
            skip = false,
          })
      end
    end
  end
  if player.dead then return end
  end,
})


return sjisziach
