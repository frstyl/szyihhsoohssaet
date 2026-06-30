local siacqhzvoa = fk.CreateSkill{
  name = "siacqhzvoa",
}


Fk:loadTranslationTable{
["siacqhzvoa"] = "相咊",
[":siacqhzvoa"] = "末段始旹,伱可發動.伱選擇任意數量其它角色与伱成爲參與者,執行流程:伱判定,參與者同旹選擇是否打出牌x大于0者.若无響應者,中止流程,否則響應者抽x+1且不再響應本次流程,若參與者皆已響應,停止流程參與者各抽1.",
-- [":siacqhzvoa"] = "末段始旹,伱可發動.伱判定,若与此流程內上次判定牌類別不同,伱可再次判定.流程終止旹,伱選擇令1角色抽x或回x/2",

["#siacqhzvoa-choose"] = "相咊 選擇任意角色入樂",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

siacqhzvoa:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(siacqhzvoa.name) and target == player and player.phase == Player.Finish
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local tos = room:askToChoosePlayers(player, {
  --         targets = targets,
  --         min_num = 0,
  --         max_num = 999,
  --         prompt = "#siacqhzvoa-choose",
  --         skill_name = siacqhzvoa.name,
  --         cancelable = true,
  --       })
  --   if #tos > 0 then
  --     event:setCostData(self, {tos = tos})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local tos = room:askToChoosePlayers(player, {
          targets = room:getOtherPlayers(player),
          min_num = 0,
          max_num = 999,
          prompt = "#siacqhzvoa-choose",
          skill_name = siacqhzvoa.name,
          cancelable = true,
        })
    table.insert(tos,player)
    room:sortByAction(tos)
    local current=table.simpleClone(tos)
    -- local current=tos
    local param={
      players=current,
      min_num=1,
      max_num=1,
      include_equip=false,
      skill_name=siacqhzvoa.name,
      cancelable=true,
      pattern=".",
      prompt="#siacqhzvoa-response"
    }
    while true do
      if #current==0 then
        for _, p in ipairs(tos ) do
          if not p.dead then p:drawCards(1,siacqhzvoa.name) end
        end
        room:cleanProcessingArea()
        return
      end
      local judge = {
        who = player,
        reason = siacqhzvoa.name,
        pattern = ".|.|.",
      }
      room:judge(judge)
      
      local pattern=function()
      end

      local pattern={".|.|"..judge.card:getSuitString(),
        tostring(Exppattern{ number = {judge.card.number} }),
          tostring(Exppattern{ name=S.getCardTypeByName(S.getCardTypeByName(judge.card.name),true)}) 
        }

      param.pattern=table.concat(pattern,";")

      local p,cids =S.askToChooseCardExclusively(player,param,fk.ReasonResponse)
      if #cids>0 then
          local card=Fk:getCardById(cids[1])
          room:responseCard({
            from=p,
            card=card,
            skipDrop=true,
            attachedSkillAndUser={muteCard=true},
          })
        local i=0

        for  _, pa in ipairs(pattern ) do
          if card:matchPattern(pa)  then i=i+1 end
        end
        p:drawCards(2*i,siacqhzvoa.name)
        table.removeOne(current,p)
      else
        room:cleanProcessingArea()
        return
      end
    end
  end,
})

return siacqhzvoa
