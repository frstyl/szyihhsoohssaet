local hzoavqtooh = fk.CreateSkill{
  name = "hzoavqtooh",
}

Fk:loadTranslationTable{
  ["hzoavqtooh"] = "𠢕賭",
  [":hzoavqtooh"] = "預段末段始旹,伱可預弃1黑桃牌發動.伱預測牌堆頂5牌點數分布爲大(8~13點至多)或小(1~6點至多),亮出牌堆頂5牌.若伱測對,伱獲得對應點數之牌.冣後將餘牌廢置.其它角色可于聲明旹參与,伱執行檢譣後,對者抽1,錯者弃1",

  ["#hzoavqtooh-invoke"] = "𠢕賭 弃1黑桃牌發動",
  ["#hzoavqtooh-choose"] = "𠢕賭 選擇大(8~13點多)小(1~6點多)",
  ["#hzoavqtooh-Cancel"] = "𠢕賭 不賭",
  ["#hzoavqtooh-discard"] = "𠢕賭 失敗 弃1牌",
  ["hzoavqtooh-sjevh"] = "小",
  ["hzoavqtooh-doar"] = "大",

  ["#hzoavqtooh-choose"] = "%from 𠢕賭選擇 %arg2",
  ["#hzoavqtooh-result"] = "%from 𠢕賭結果爲 %arg2",

  ["hzoavqtooh-win"] = "天牌通殺",
  ["hzoavqtooh-failed"] = "通賠",

  ["$hzoavqtooh"] = "買定離手買定離手已嗚",
}

hzoavqtooh:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hzoavqtooh.name) and (player.phase == Player.Finish or player.phase == Player.Start )
  end,
  on_cost = function(self, event, target, player, data)
    local cards = player.room:askToDiscard(player, {
      min_num = 1,
      max_num = 1,
      include_equip = true,
      skill_name = hzoavqtooh.name,
      prompt = "#hzoavqtooh-invoke",
      pattern=".|.|heart,spade",
      cancelable = true,
      skip = true,
    })
    if #cards == 1 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:throwCard(event:getCostData(self).cards, hzoavqtooh.name, player, player)

    local playerchoice=room:askToChoice(player, {
      choices = {"hzoavqtooh-doar","hzoavqtooh-sjevh"},
      skill_name = hzoavqtooh.name,
      prompt="#hzoavqtooh-choose",
    })
    room:sendLog{ type = "#hzoavqtooh-choose", from = player.id, arg = hzoavqtooh.name ,arg2= playerchoice}
    local params = {
      players = room:getOtherPlayers(player),
      choices = {"hzoavqtooh-doar","hzoavqtooh-sjevh","hzoavqtooh-Cancel"},
      prompt = "#hzoavqtooh-choose",
      skillName = hzoavqtooh.name,
      send_log = true,
    }
   
    local req = player.room:askToJointChoice(player,params)

    local cards=room:getNCards(5)
    room:moveCards({
      ids = cards,
      toArea = Card.Processing,
      moveReason = fk.ReasonJustMove,
      skillName = hzoavqtooh.name,
      proposer = player.id,
    })    
    -- room:showCards(cards)

    -- local sjevh={}
    -- local doar={}
    local get={}
    get["hzoavqtooh-sjevh"]={}
    get["hzoavqtooh-doar"]={}
    get["hzoavqtooh-other"]={}
    for _, id in ipairs(cards) do
      local n=Fk:getCardById(id).number
      if 0<n and n<7 then
        room:setCardEmotion(id, "judgebad")
        table.insert(get["hzoavqtooh-sjevh"],id)
      elseif 7<n and n<14 then
        room:setCardEmotion(id, "judgegood")
        table.insert(get["hzoavqtooh-doar"],id)
      else
        table.insert(get["hzoavqtooh-other"],id)
      end
        room:delay(200)
    end
    local x,y,z =#get["hzoavqtooh-sjevh"],#get["hzoavqtooh-other"],#get["hzoavqtooh-doar"]
    local result={}
    if y>x and  y>z then
      result={}  --thouc booj
    elseif x==z and x>=z then
      result={"hzoavqtooh-sjevh","hzoavqtooh-doar"}  --thouc ssaet
    elseif x>y and x>=z then
      result={"hzoavqtooh-sjevh"}
    elseif z>x and z>=y then
      result={"hzoavqtooh-doar"}
    end
    
    local arg2=""
    if #result==1 then 
      arg2=result[1]
    elseif  #result==2 then
      arg2="hzoavqtooh-win"
    elseif  #result==0 then
      arg2="hzoavqtooh-failed"
    end
    player.room:sendLog{ type = "#hzoavqtooh-result", from = player.id, arg = hzoavqtooh.name ,arg2= arg2}


    -- player:drawCards(x,hzoavqtooh.name)
    -- player:drawCards(y,hzoavqtooh.name) 
    --  player:drawCards(z,hzoavqtooh.name)
    if not player.dead and table.contains(result,playerchoice) then
      room:obtainCard(player, get[playerchoice], true, fk.ReasonPrey, player, hzoavqtooh.name)
    end

    for _, p in ipairs(room:getOtherPlayers(player)) do
      if not p.dead and req[p]~="hzoavqtooh-Cancel" then 
        if table.contains(result,req[p])then
          p:drawCards(1,hzoavqtooh.name)
        else
          room:askToDiscard(p, {
            min_num = 1,
            max_num = 1,
            include_equip = true,
            skill_name = hzoavqtooh.name,
            prompt = "#hzoavqtooh-discard",
            cancelable = false,
            skip = false,
          })
        end
      end
    end

    room:cleanProcessingArea(cards)

  end,
})



return hzoavqtooh
