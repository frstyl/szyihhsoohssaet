local hqeenshsxes = fk.CreateSkill({
  name = "hqeenshsxes",
  tags = {Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["hqeenshsxes"] = "宴戲",
  [":hqeenshsxes"] = "弃牌階段歬,必發.全體脚色同時選1項肰後逐个執行➀抽1,當輪自守➁弃2手牌,起動虛擬｢酒｣.執行後,伱抽x(x爲選➁數).伱因此技能所抽牌无視額定手牌數",

  ["hqeenshsxes-draw"] = "宴戲：抽1 自守",
  ["hqeenshsxes-discard"] = "宴戲：弃2 起動酒",


  -- ["$hqeenshsxes1"] = "皓月如晝共椉歡爭忍歸來",
  -- ["$hqeenshsxes2"] = "瓊林玉殿朝喧弦管暮列笙琶",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

hqeenshsxes:addEffect(fk.EventPhaseChanging, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hqeenshsxes.name) and data.phase == Player.Discard 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local drawers = {}
    local discarders = {}
    local players=room:getAlivePlayers()  --排序
    local result = room:askToJointChoice(player, {
      players = players,
      choices = {"hqeenshsxes-draw", "hqeenshsxes-discard"},
      skill_name = hqeenshsxes.name,
      -- prompt = "#guhuo-ask",
      send_log = true,
    })
    for _, p in ipairs(players) do
        if result[p] == "hqeenshsxes-draw" then
          table.insert(drawers, p)
          p:drawCards(1,hqeenshsxes.name, nil, "@@hqeenshsxes-inhand")
          room:addPlayerMark(p,"@@dzjissziuh-round",1)
        else 
          table.insert(discarders, p)
          room:askToDiscard(p, {
            min_num = 2,
            max_num = 2,
            include_equip = false,
            skill_name = hqeenshsxes.name,
            cancelable = false,
          })
         room:useVirtualCard("tsiuh", nil, player, {player}, hqeenshsxes.name, true)
        end
      end

    player:drawCards(#drawers, hqeenshsxes.name, nil, "@@hqeenshsxes-inhand")

    data.phase_end = true

  end,
})

hqeenshsxes:addEffect("maxcards", {
  exclude_from = function(self, player, card)
    return card:getMark("@@hqeenshsxes-inhand") > 0
  end,
})
return hqeenshsxes
