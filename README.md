# Projeto RPG — Fantasia Sombria

RPG top-down 2D em Godot 4 (GDScript) — **Fase 0 (prova de vida)** do roadmap do documento mestre.

## Como rodar

1. Instale o **Godot 4.3+** (versão standard, não .NET).
2. Abra o Godot → `Importar` → selecione `projeto-rpg/project.godot`.
3. Aperte **F5** (Run Project). A cena inicial é `scenes/world/test_arena.tscn`.

## Controles (Fase 0)

| Ação | Tecla |
|---|---|
| Mover | WASD |
| Mirar | Mouse |
| Ataque corpo a clique esquerdo | Clique esquerdo |
| Projétil | Clique direito |
| Esquiva (i-frames) | Espaço |
| Correr (gasta fôlego) | Shift |
| Salvar / Carregar | F5 / F6 |
| Pausar | Esc |

## O que existe na Fase 0

- Movimento com aceleração, esquiva com i-frames e knockback.
- Combate tempo real: hitbox/hurtbox, telegrafia (windup) do inimigo, stagger por poise, hitstop.
- Fôlego (stamina) separado de vida, com regeneração e atraso.
- Projétil à distância.
- HUD mínimo (barras + toasts).
- Save/load JSON versionado (F5/F6).
- 1 arena de teste com 3 inimigos.

## Estrutura

Segue a árvore do documento mestre (Seção 18.2), reduzida ao necessário da Fase 0:

```
projeto-rpg/
├── project.godot
├── scenes/
│   ├── actors/player/player.tscn
│   ├── actors/enemies/enemy_grunt.tscn
│   ├── projectiles/energy_bolt.tscn
│   ├── ui/hud.tscn
│   └── world/test_arena.tscn
└── scripts/
    ├── autoload/        (EventBus, GameManager, SaveManager)
    ├── components/      (Health, Stamina, Hurtbox, Hitbox)
    ├── systems/combat/  (AttackInfo, Projectile)
    ├── actors/          (player, enemies)
    ├── ui/              (hud)
    └── world/           (test_arena)
```

## Teste de fumaça (headless)

```
RPG_SMOKE_TEST=1 godot --headless --path projeto-rpg
```

Valida: player + componentes, 3 inimigos, save → mover → load restaurando posição. Imprime `SMOKE TEST OK` e sai com código 0.

## Próximo (Fase 1)

Ver `../docs/PROJETO_RPG_MESTRE.md` — Seção 19: criação de personagem, progressão, primeira região e patrocínio divino.
