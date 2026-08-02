local tszjevqtsziac = fk.CreateSkill {
  name = "tszjevqtsziac",
  targs={Skill.Compulsory},
}

Fk:loadTranslationTable{
  ["tszjevqtsziac"] = "昭彰",  --賞罰
  [":tszjevqtsziac"] = "脚色A對除其外脚色致{傷/療}後,必發｡伱令A{弃己x/抽1}｡x爲A當輪致傷點數合",


}

tszjevqtsziac:addEffect(fk.Damage, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return 
    player:hasSkill(tszjevqtsziac.name) 
    and data.from and not data.from.dead
    and data.to~=data.from
  end,
  on_cost = function(self, event, target, player, data)
    event:setCostData(self,{tos={data.from}})
    return true
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local n=0

    room.logic:getEventsOfScope(GameEvent.Damage, 1, function (e)
        local dat=e.data
          if dat.from == data.from then
            n=n + dat.damage
          end
      end, Player.HistoryRound)

    room:askToDiscard(data.from, {
      min_num = n,
      max_num = n,
      include_equip = true,
      skill_name = tszjevqtsziac.name,
      cancelable = false,
    })
  end,
})


tszjevqtsziac:addEffect(fk.HpRecover, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return
    player:hasSkill(tszjevqtsziac.name) 
    and data.recoverBy and not data.recoverBy.dead
    and data.who~=data.recoverBy
  end,
  on_cost = function(self, event, target, player, data)
    event:setCostData(self,{tos={data.recoverBy}})
    return true
  end,
  on_use = function(self, event, target, player, data)
    data.recoverBy:drawCards(1,tszjevqtsziac.name)
  end,
})
return tszjevqtsziac
