local liuqsziac = fk.CreateSkill{
  name = "liuqsziac",
  tags={Skill.Contract },
}

Fk:loadTranslationTable{
  ["liuqsziac"] = "流觴",
  [":liuqsziac"] = "伱起動/演練/賭鬥牌亮出旹,伱可發動,記錄牌,若与上1記錄相比:同名,此技能失效1轉,改爲選發;x>0,伱抽x,此技能改爲必發(x爲二牌名末字同項數:平仄,韻尾,元音)",  --

  ["@liuqsziac"] = "流觴",

  ["#liuqsziac_draw"] = "流觴 選擇1腳色令其抽1",
  ["#liuqsziac_discard"] = "流觴 選擇1腳色令其弃1",


}


-- local S = require "packages/szyihhsoohssaet/szyih_guos" 
local U = require "packages/utility/utility"

local spec ={
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(liuqsziac.name)
    -- and player:getMark("@liuqsziac_")~=0
  end,
  on_cost = function(self, event, target, player, data)
    if table.contains(player:getTableMark("contracted_skills"), liuqsziac.name) or
      player.room:askToSkillInvoke(player, {
      skill_name = liuqsziac.name,
      -- prompt = "#liuqsziacz-invoke",
    }) then
      event:setCostData(self,{name=data.card.data.card.trueName})

    end
  end,
  on_use = function(self, event, target, player, data)

    table.contains(player:getTableMark("contracted_skills"), liuqsziac.name)
    local old =player:getMark("@liuqsziac_")
    local name=event:getCostData(self).name
    local new=name:split("_")
    new=new[#new]
    player.room:setPlayerMark(player,"@liuqsziac_",new)  --末字韻尾
    local s=Fk:translate(name, "zh_CN")
    player.room:setPlayerMark(player,"@liuqsziac",s[s:len()])

    if old ==0 then return end
    local new=new
    if old==new then 
      player.room:invalidateSkill(player, liuqsziac.name, "-turn")
      room.removeTableMark(player, "contracted_skills", liuqsziac.name)
      return
    end

    player.room:addTableMarkIfNeed(player, "contracted_skills", liuqsziac.name)

    local fill=function(st)
      local t={}
      local c=st
      -- for i=1, st:len(),1 do
      --   table.insert(c, string.sub(st,i,i))
      -- end 
      local n =c:len()
      if  table.contains({"j","v","m","n","c",}, c[n]) then
        t[1]=1
        t[2]=c[n]
      elseif table.contains({"a","e","i","o","u","y",}, c[n]) then
        t[1]=1
        t[2]="q"  --空尾
        n=n+1
      elseif c[n]=="h" then
        t[1]=2
        t[2]=c[n-1]
      elseif c[n]=="s" then
        t[1]=3
        t[2]=c[n-1]
      elseif c[n] =="r" then
        t[1]=3
        t[2]="j" --?
      else  --入聲
        t[1]=4
        t[2]=c[n]=="k" and "c" or (c[n]=="t" and "n" or "m")
      end

      n=n-1
      t[3]=c[n] 
      if c[n]=="o" and c[n-1]=="e" then t[3]="y" end
      if (c[n]=="i" or c[n] == "u" ) and not table.contains({"j","x","i","o"},c[n-1]) then t[3]="y" end
      return t
    end

     old =fill(old) 
     new=fill(new)
    local n=0
    if (old[1]=="q")  ==  (new[1]=="q")  then n=1 end
    for i=2,3,1 do
      if old[i]==new[i] then n=n+1 end
    end

    player:drawCards(n,liuqsziac.name)

    -- player.room:setPlayerMark(player,"@liuqsziac1",old)
    -- player.room:setPlayerMark(player,"@liuqsziac2",new)

  end,
  -- late_refresh=true,
  -- can_refresh = function(self, event, target, player, data)
  --   return target==player and player:hasSkill(liuqsziac.name,true)
  -- end,
  -- on_refresh = function(self, event, target, player, data)

  --   local s=Fk:translate(data.card.trueName, "zh_CN")
  --   player.room:setPlayerMark(player,"@liuqsziac",s[s:len()])

  --   s=data.card.trueName:split("_")
  --   player.room:setPlayerMark(player,"@liuqsziac_",s[#s])  --末字韻尾

  -- end,
}

liuqsziac:addEffect(fk.CardUsing, spec)
liuqsziac:addEffect(fk.CardResponding, spec)
liuqsziac:addEffect(fk.PindianCardsDisplaying, {
  can_trigger = function(self, event, target, player, data)
    if  player:hasSkill(liuqsziac.name) 
      and (data.from==player and data.fromCard or (data.results[player] and data.results[player].toCard)) 
    then
      event:setCostData(self,{name = data.from==player and data.fromCard.trueName or data.results[player].toCard.trueName})
      return true
    end
  end,

  on_use = spec.on_use,
  late_refresh=true,

})
return liuqsziac
