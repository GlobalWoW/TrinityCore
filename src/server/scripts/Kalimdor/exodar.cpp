/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */
 
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"

/*#####
# npc_prohet_velen
######*/

enum ProphetVelen
{
    SPELL_HOLY_BLAST        = 59700,
    SPELL_HOLY_NOVA         = 59701,
    SPELL_HOLY_SMITE        = 59703,
    SPELL_PRAYER_OF_HEALING = 59698, // on friendly targets in range
    SPELL_STAFF_STRIKE      = 33542,

    QUEST_DEFENDING_ALLIANCE = 60000,

    NOTIFY_COOLDOWN    = 600000,

    SCALING_5          = 73762,
    SCALING_10         = 73824,
    SCALING_15         = 73825,
    SCALING_20         = 73826,
    SCALING_25         = 73827,
    SCALING_30         = 73828,
};

class npc_prophet_velen : public CreatureScript
{
public:
    npc_prophet_velen() : CreatureScript("npc_prophet_velen") { }

    struct npc_prophet_velenAI : public ScriptedAI
    {
        npc_prophet_velenAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        bool defenderCredit;
        uint32 appliedScaling;
        uint32 rescaleTimer;
        uint32 notifyCooldown;

        void Reset()
        {
            defenderCredit = false;
            appliedScaling = 0;
            rescaleTimer = 5000;
            notifyCooldown = 0;

            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true);

            events.Reset();
            events.ScheduleEvent(SPELL_HOLY_BLAST, 7000);
            events.ScheduleEvent(SPELL_HOLY_NOVA, 12000);
            events.ScheduleEvent(SPELL_HOLY_SMITE, 9000);
            events.ScheduleEvent(SPELL_PRAYER_OF_HEALING, 10000);
            events.ScheduleEvent(SPELL_STAFF_STRIKE, 5000);
        }

        void EnterEvadeMode()
        {
            if (defenderCredit)
            {
                std::list<Player*> playerList;
                Trinity::AnyPlayerInObjectRangeCheck checker(me, me->GetMap()->GetVisibilityRange(), false);
                Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(me, playerList, checker);
                me->VisitNearbyWorldObject(me->GetMap()->GetVisibilityRange(), searcher);
                sLog->outInfo(LOG_FILTER_TSCR, "PvP Boss %s (%d) was protected and Players in Range for Defender Credit are:", me->GetName(), me->GetEntry());
                for (std::list<Player*>::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
                {
                    Player* player = (*itr);
                    if (player->GetTeamId() != TEAM_ALLIANCE)
                        continue; // only same faction

                    if (!player->IsPvP())
                    {
                        sLog->outInfo(LOG_FILTER_TSCR, "[ ] %s (not flagged for PvP)", player->GetName());
                        continue; // Do not reward players who are not flagged for pvp ("no pain, no gain")
                    }

                    if (player->GetQuestStatus(QUEST_DEFENDING_ALLIANCE) == QUEST_STATUS_INCOMPLETE)
                    {
                        sLog->outInfo(LOG_FILTER_TSCR, "[x] %s (rewarded)", player->GetName());
                        player->CompleteQuest(QUEST_DEFENDING_ALLIANCE);
                    } else
                        sLog->outInfo(LOG_FILTER_TSCR, "[ ] %s (did not have quest %d at evade)", player->GetName(), QUEST_DEFENDING_ALLIANCE);
                }
            } else
                sLog->outInfo(LOG_FILTER_TSCR, "PvP Boss %s (%d) was protected but did not qualify for Defender Credit (Anti-Farm Rule)", me->GetName(), me->GetEntry());

            if (appliedScaling)
                if (me->HasAura(appliedScaling))
                    me->RemoveAura(appliedScaling);

            ScriptedAI::EnterEvadeMode();
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (notifyCooldown == 0)
            {
                sWorld->SendWorldText(11002, "|TInterface\\Icons\\achievement_leader_prophet_velen.blp:24|t Prohpet Velen: Schützt die Exodar!", 0, 0);
                notifyCooldown = NOTIFY_COOLDOWN;
            }
            Talk(0);
            me->CallForHelp(100.0f);
        }

        void HandleScaling()
        {
            // make the fight more attractive and less grinding when more players are around
            uint32 enemyCount = 0;
            ThreatContainer::StorageType const &threatList = me->getThreatManager().getThreatList();
            ThreatContainer::StorageType::const_iterator itr;
            for (itr = threatList.begin(); itr != threatList.end(); ++itr)
            {
                Unit* unit = (*itr)->getTarget();
                if (unit && unit->ToPlayer())
                    enemyCount++;
            }

            uint32 newScaling = 0;
            if (enemyCount >= 17)
                newScaling = SCALING_30;
            else if (enemyCount >= 15)
                newScaling = SCALING_25;
            else if (enemyCount >= 13)
                newScaling = SCALING_20;
            else if (enemyCount >= 10)
                newScaling = SCALING_15;
            else if (enemyCount >= 7)
                newScaling = SCALING_10;
            else if (enemyCount >= 5)
                newScaling = SCALING_5;

            if (newScaling == appliedScaling)
                return; // if current scaling equals new scaling stop here
            else
            {
                if (appliedScaling > 0 && me->HasAura(appliedScaling))
                    me->RemoveAura(appliedScaling);
                if (newScaling > 0)
                    me->AddAura(newScaling, me);
                appliedScaling = newScaling;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            // World Notify Cooldown
            if (notifyCooldown >= diff)
                notifyCooldown -= diff;
            else
                notifyCooldown = 0;

            if (!UpdateVictim())
                return;

            // Defender Quest Credit
            if (!defenderCredit)
                if (me->getThreatManager().getThreatList().size() >= 5 && me->GetHealthPct() < 90.f) // Anti-Farming Conditions
                    defenderCredit = true;

            // Boss rescaling
            if (rescaleTimer <= diff)
            {
                HandleScaling();
                rescaleTimer = 10000;
            } else rescaleTimer -= diff;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case SPELL_HOLY_BLAST:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                            DoCast(target, SPELL_HOLY_BLAST);
                        events.ScheduleEvent(SPELL_HOLY_BLAST, urand(7000, 11000));
                        break;
                    case SPELL_HOLY_NOVA:
                        DoCast(me, SPELL_HOLY_NOVA);
                        events.ScheduleEvent(SPELL_HOLY_NOVA, urand(12000, 17000));
                        break;
                    case SPELL_HOLY_SMITE:
                        DoCastVictim(SPELL_HOLY_SMITE);
                        events.ScheduleEvent(SPELL_HOLY_SMITE, urand(8000, 12000));
                        break;
                    case SPELL_PRAYER_OF_HEALING:
                        DoCast(me, SPELL_PRAYER_OF_HEALING);
                        events.ScheduleEvent(SPELL_PRAYER_OF_HEALING, urand(15000, 22000));
                        break;
                    case SPELL_STAFF_STRIKE:
                        DoCastVictim(SPELL_STAFF_STRIKE);
                        events.ScheduleEvent(SPELL_STAFF_STRIKE, urand(5000, 8000));
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_prophet_velenAI(creature);
    }

};

void AddSC_exodar()
{
    new npc_prophet_velen();
}
