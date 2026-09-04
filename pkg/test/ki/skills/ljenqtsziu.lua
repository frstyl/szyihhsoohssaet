local ljenqtsziuq = fk.CreateSkill {
  name = "ljenqtsziuq",
  tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["ljenqtsziuq"] = "連舟",
  [":ljenqtsziuq"] = "輪始旹,伱可選擇1至多腳色(位次相連),輪內其相聯結｡一聯結腳色A因傷害/流失減少體力前,若有聯結腳色或變成元因爲聯結,令變化絕對值-x,且體力變化後,其下一聯結腳色(非A)體力減x｡ x:=max{ floor(abs(變化值)), abs(變化值)-A體力值+1 }",

  ["#ljenqtsziuq-invoke"] = "連舟 選擇目幖",
  ["@@ljenqtsziuq-round"] = "連舟",

  ["#ljenqtsziuq-trig"] = "連舟 %from  %arg  %arg2",
  ["#ljenqtsziuq-delay"] = "連舟 %from %arg  %arg2",

  ["$ljenqtsziuq1"] = "帥其卽軍心",--大旗在此軍心不亂
  ["$ljenqtsziuq2"] = "大其飄揚軍威雄壯",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

ljenqtsziuq:addEffect(fk.RoundStart, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ljenqtsziuq.name)
  end,
  on_cost= function(self, event, target, player, data)
    local room = player.room

    local yes, dat = room:askToUseActiveSkill(player, {  
      skill_name = "askToChooseQueue",
      prompt = "#ljenqtsziuq-invoke",
      cancelable = true,
      skip = true,  --不執行
      extra_data = {
        -- origin=player,
        min=1,
        max = math.max(1, player.hp),
      },
    })

    if yes and #dat.targets > 0 then
      room:sortByAction(dat.targets)
      event:setCostData(self, { tos = dat.targets })
      return true
    end
  end,
  on_use= function(self, event, target, player, data)
    local room = player.room
    for _, p in ipairs(event:getCostData(self).tos) do
      room:addPlayerMark(p, "@@ljenqtsziuq-round",1)
    end
  end,
})

ljenqtsziuq:addEffect(fk.BeforeHpChanged, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    if data.num<-1  -- 減傷? 擋致命傷
    and
     data.who == player  --seat==1
    and data.who:hasMark("@@ljenqtsziuq-round")
    -- and data.reason=="damage"
    -- and data.damageEvent 
    and not data.prevented
    then
      if data.skillName=="ljenqtsziuq" then return true end 
      -- data.damageEvent.ljenqtsziuq=data.damageEvent.ljenqtsziuq or {} 
      -- if table.contais(data.damageEvent.ljenqtsziuq, p.id) then return end
      local room=player.room
      for _, p in ipairs (S.getSeats(data.who)) do
        if p:hasMark("@@ljenqtsziuq-round") then
          event:setCostData(self, { tos = {p} })
          return true
        end
      end
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local n = -data.num//2
    if n >= data.who.hp and data.who.hp >0 then
      n = -data.num -data.who.hp+1 
      room:removePlayerMark(data.who, "@@ljenqtsziuq-round", 1) 
    end
    room:sendLog{ type = "#ljenqtsziuq-trig", from = data.who.id, arg = data.reason, arg2=-n, }
    data.num=data.num + n
    -- table.insert(data.damageEvent.ljenqtsziuq, p.id)
    if event:getCostData(self) then  --呑傷
      data.extra_data = data.extra_data or {}
      data.extra_data.ljenqtsziuq=n
    end
  end,
})

ljenqtsziuq:addEffect(fk.HpChanged, {  --減傷設于此?
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    if data.extra_data and data.extra_data.ljenqtsziuq
    then
    -- data.damageEvent.ljenqtsziuq=data.damageEvent.ljenqtsziuq or {} 
      local room=player.room
      for _, p in ipairs (S.getSeats(data.who)) do  --呑傷
        if p~=data.who and p:hasMark("@@ljenqtsziuq-round")  then
          event:setCostData(self, { tos = {p} })
          return true
        end
      end
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local to=event:getCostData(self).tos[1]
    local n = data.extra_data.ljenqtsziuq
    room:sendLog{ type = "#ljenqtsziuq-delay", from = to.id, arg = data.reason, arg2=n, }
    room:changeHp(to, -n, data.reason, ljenqtsziuq.name, data.damageEvent, data.hpLostEvent)
    -- room:damage({
    --   from = nil,
    --   to = to,
    --   card = nil,
    --   damage = n,
    --   damageType = data.damageEvent and data.damageEvent.damageType or fk.NormalDamage,
    --   skillName = ljenqtsziuq.name,
    -- })
    data.extra_data.ljenqtsziuq=nil
  end,
})

return ljenqtsziuq
