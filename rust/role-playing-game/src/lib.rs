use std::cmp;

pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

impl Player {
    fn new(level: u32) -> Player {
        Self {
            health: 100,
            mana: if level < 10 { None } else { Some(100) },
            level: level,
        }
    }

    pub fn revive(&self) -> Option<Player> {
        match self.health {
            0 => Some(Player::new(self.level)),
            _ => None,
        }
    }

    pub fn cast_spell(&mut self, mana_cost: u32) -> u32 {
        let damage = self.damage(self.mana, mana_cost);

        match self.mana {
            None => self.health = self.reduced_health(self.health, mana_cost),
            Some(mana) => self.mana = self.reduced_mana(mana, mana_cost),
        };

        damage
    }

    fn damage(&self, mana: Option<u32>, mana_cost: u32) -> u32 {
        match mana {
            None => 0,
            Some(mana) => {
                if mana > mana_cost {
                    mana_cost * 2
                } else {
                    0
                }
            }
        }
    }

    fn reduced_health(&mut self, health: u32, cost: u32) -> u32 {
        health - cmp::min(health, cost)
    }

    fn reduced_mana(&mut self, mana: u32, cost: u32) -> Option<u32> {
        if mana > cost {
            Some(mana - cost)
        } else {
            Some(mana)
        }
    }
}
