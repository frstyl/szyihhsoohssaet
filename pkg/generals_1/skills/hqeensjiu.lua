local hqeensjiu = fk.CreateSkill({
  name = "hqeensjiu",
  tags = {Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["hqeensjiu"] = "宴游",
  [":hqeensjiu"] = "鎖定.弃牌階段歬,必發.全體角色同時選1項肰後逐个執行➀抽1➁弃1手牌.執行後,若x>y,本輪內選➀者擁有戲幖記(伱不可使用<a href='AttackCard'>進攻牌</a>);x<y,本輪內,選➁者擁有諫幖記(其它角色至伱基礎距離爲1);x=y,伱抽x終止此轉(x y分別爲選➀➁之角色數).伱因此技能所抽牌无視額定手牌數",

  ["hqeensjiu-draw"] = "宴游：抽1",
  ["hqeensjiu-discard"] = "宴游：弃1",

  ["@@hqeensjiu-draw"] = "宴游 戲",
  ["@@hqeensjiu-discard"] = "宴游 諫",

  -- ["$hqeensjiu1"] = "皓月如晝共椉歡爭忍歸來",
  -- ["$hqeensjiu2"] = "瓊林玉殿朝喧弦管暮列笙琶",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

hqeensjiu:addEffect(fk.EventPhaseChanging, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hqeensjiu.name) and data.phase == Player.Discard 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local drawers = {}
    local discarders = {}
    local players=room:getAlivePlayers()  --排序
    local result = room:askToJointChoice(player, {
      players = players,
      choices = {"hqeensjiu-draw", "hqeensjiu-discard"},
      skill_name = hqeensjiu.name,
      -- prompt = "#guhuo-ask",
      send_log = true,
    })
    for _, p in ipairs(players) do
        if result[p] == "hqeensjiu-draw" then
          p:drawCards(1,hqeensjiu.name, nil, "@@hqeensjiu-inhand")
          table.insert(drawers, p)
        else 
        room:askToDiscard(p, {
          min_num = 1,
          max_num = 1,
          include_equip = false,
          skill_name = hqeensjiu.name,
          cancelable = false,
        })
          table.insert(discarders, p)
        end
      end
    if #drawers>#discarders then
      for _, p  in ipairs(drawers) do
        room:setPlayerMark(p,"@@hqeensjiu-draw",1)
      end
    elseif #drawers<#discarders then
      for _, p  in ipairs(discarders) do
        room:setPlayerMark(p,"@@hqeensjiu-discard",1)
      end
    else 
      player:drawCards(#drawers, hqeensjiu.name, nil, "@@hqeensjiu-inhand")
      -- player.room.logic:breakTurn()
      room:endTurn()
    end
  end,
})

hqeensjiu:addEffect("distance", {
  fixed_func = function(self, from, to)
    if to:getMark("@@hqeensjiu-discard")>0  then
      return 1
    end
  end,
})

hqeensjiu:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player:getMark("@@hqeensjiu-draw")>0 and  S.isAttackCard(card) then

      return true
    end
  end,

})

hqeensjiu:addEffect("maxcards", {
  exclude_from = function(self, player, card)
    return card:getMark("@@hqeensjiu-inhand") > 0
  end,
})
return hqeensjiu
