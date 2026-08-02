
local dzoacqhzeep = fk.CreateSkill {
  name = "dzoacqhzeep",
}

Fk:loadTranslationTable{
["dzoacqhzeep"] = "藏挾",
[":dzoacqhzeep"] = "其它腳色A末段始旹,伱可發動｡伱隱祕排敘3虛擬牌(｢殺｣｢糧草先行｣｢因敵爲資｣),對其按敘起動,起動前,A可自弃x牌迻除x牌",

["#dzoacqhzeep-discard"] = "藏挾 是否弃牌 越過%src",
["#dzoacqhzeep-choose"] = "藏挾 選擇牌敘號",

["$dzoacqhzeep1"] = "來一个,殺一个.來一對,殺一雙",
["$dzoacqhzeep2"] = "絳霞影裏,卷一道凍地仌霜",
}





dzoacqhzeep:addEffect(fk.EventPhaseEnd, {
  can_trigger= function (self, event, target, player, data)
    return target ~= player
    and target.phase==Player.Finish
    and player:hasSkill(dzoacqhzeep.name)
  end,
  on_use = function (self, event, target, player, data)
    local all={ "ssaet", "hqjin_deek_qwe_tsji","liac_tshoavh_seen_hzaac",}
    local order ={}
    local room=player.room
    for i=1,3,1 do
      table.insert(order,    room:askToChoice(player,{
    choices=table.filter(all,function(p) return not table.contains(order,p) end),
    skill_name=dzoacqhzeep.name,
    all_choices=all,
    }) )
    end
    local to =target

    local cards=room:askToDiscard(to, {
      min_num = 1,
      max_num = 3,
      include_equip = true,
      skill_name = dzoacqhzeep.name,
      cancelable = true,
      prompt = "#dzoacqhzeep-discard:"..player.id,
      skip=false,
    })
    if #cards==3 then return end
    if #cards~=0 then
      local choices={"1","2","3"}
      local t={"1","2","3"}
      for i=1,#cards,1 do
        local n =  room:askToChoice(to,{
        choices=t,
        skill_name=dzoacqhzeep.name,
        all_choices=choices,
        prompt = "#dzoacqhzeep-choose",
        }) 
        order[tonumber(n)]=nil
        table.removeOne(t,n)
      end
    end
    
    for _, name in pairs(order) do
      if player.dead or to.dead then return end
      if name then
      room:useVirtualCard(name, nil,player, {to}, dzoacqhzeep.name,false )
      end
    end

  end,
})



return dzoacqhzeep

