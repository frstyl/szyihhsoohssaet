local meejqdzoeoj = fk.CreateSkill{
  name = "meejqdzoeoj",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["meejqdzoeoj"] = "迷財",
  [":meejqdzoeoj"] = "鎖定.轉終,若伱手牌數全場冣小,伱選一角色手牌數全場至多且大于1者發動.其予伱1傷,伱獲取其2牌",

  ["#meejqdzoeoj-choose"] = "迷財 選擇目幖",

  ["$meejqdzoeoj1"] = "我欲行夏禹旧事，为天下人。",

}
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

meejqdzoeoj:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    if not ( target==player and player:hasSkill(meejqdzoeoj.name) )then return end
      local n =#player:getCardIds("h")
      local m=2
      local tos={}
      for _, p in ipairs(player.room.alive_players) do
        if p ~=player then
         local i = #p:getCardIds("h")
         if i <=n then return end
         if i==m then
          table.insert(tos,p)
         elseif i>m then
          tos={p}
          m=i
         end
        end 
      end
    if tos[2] then
      tos=player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = tos,
      skill_name = meejqdzoeoj.name,
      prompt = "#meejqdzoeoj-choose",
      cancelable = false,
    })
    end

    if #tos>0 then
      event:setCostData(self,{tos=tos})
      return true
    end
  end,
  -- on_cost = function (self, event, target, player, data)
  --   return player.room:askToSkillInvoke(player, {
  --     skill_name = meejqdzoeoj.name,
  --     prompt = "#meejqdzoeoj-invoke:"..target.id,
  --   })
  -- end,
  on_use = function (self, event, target, player, data)
          if player.dead then return end
    local room=player.room
    local tos = event:getCostData(self).tos
  --   if tos[2] then
  --     tos=room:askToChoosePlayers(player, {
  --     min_num = 1,
  --     max_num = 1,
  --     targets = tos,
  --     skill_name = meejqdzoeoj.name,
  --     prompt = "#meejqdzoeoj-choose",
  --     cancelable = false,
  --   })
  -- end
      room:damage{
        to = player,
        damage = 1,
        from=tos[1],
        skillName = meejqdzoeoj.name,
      }
      if player.dead then return end
      local cards=room:askToChooseCards(player, {
        target = tos[1],
        min = 2,
        max = 2,
        flag = "he",
        skill_name = meejqdzoeoj.name,
      })
      room:moveCardTo(cards, Player.Hand, player, fk.ReasonPrey, meejqdzoeoj.name,nil,false,player)
  end,
})



return meejqdzoeoj
