local tszjinshzaek = fk.CreateSkill {
  name = "tszjinshzaek",
}

Fk:loadTranslationTable{
["tszjinshzaek"] = "振翮",
[":tszjinshzaek"] = "印牌:打出1非基本牌虛擬起動演練｢閃｣",
["#tszjinshzaek"] = "振翮: 代替 打出1非基本牌 視爲起動演練閃",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tszjinshzaek:addEffect("viewas", {--視爲起動? 起動虛牌?
  anim_type = "defensive",
  pattern = "szjemh",  --
  prompt = "#tszjinshzaek",
  mute_card = true,
  -- handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and S.getCardTypeByName(Fk:getCardById(to_select).trueName)~= 1 and not player:prohibitResponse(to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then
      return nil
    end
    local c = Fk:cloneCard("szjemh")
    c.skillName = tszjinshzaek.name
    c:addFakeSubcards(cards)
    return c
  end,
  before_use = function (self, player, use)
    local room = player.room
    -- room:responseCard({
    --   card=Fk:getCardById(use.card.fake_subcards[1]),
    --   from=player,
    --   attachedSkillAndUser={muteCard=true},
    -- })
    S.playCard(player,use.card.fake_subcards,tszjinshzaek.name) 
    -- room:throwCard(use.card.fake_subcards, tszjinshzaek.name, player, player)
  end,
})

return tszjinshzaek
