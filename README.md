# Roblox Admin Commands

🚀 **Полезная система админ-команд для Roblox** — как мод для любой игры.

Лёгкая, чистая и расширяемая система админ-команд. Подходит для новичков и опытных разработчиков.

## Особенности

- ✅ Простая установка (копировал и готово)
- ✅ Система прав по UserId и рангу в группе
- ✅ Готовые команды: fly, noclip, tp, kick, ban, speed, jump, invis, respawn, god и др.
- ✅ Лёгко добавлять свои команды
- ✅ Работает через чат (prefix `;`)
- ✅ Без внешних зависимостей

## Установка

1. Скачай репозиторий
2. В Roblox Studio:
   - Положи `src/Config.lua` в **ReplicatedStorage** (как ModuleScript с именем `Config`)
   - Положи `src/AdminServer.server.lua` в **ServerScriptService** (как Script)
   - Положи папку `src/Commands` в **ServerScriptService** (как Folder)
3. Открой `Config` и добавь свой UserId в таблицу `Admins`
4. Готово! Пиши в чат `;help`

## Команды

| Команда | Описание |
|---------|----------|
| `;help` / `;cmds` | Список всех команд |
| `;fly [player]` | Включить/выключить полёт |
| `;noclip [player]` | Включить/выключить noclip |
| `;tp <player>` | Телепорт к игроку |
| `;bring <player>` | Притянуть игрока к себе |
| `;kick <player> [reason]` | Кикнуть игрока |
| `;ban <player> [reason]` | Забанить (через DataStore) |
| `;unban <userId>` | Разбан |
| `;speed <player> <number>` | Установить WalkSpeed |
| `;jump <player> <number>` | Установить JumpPower |
| `;invis [player]` | Невидимость |
| `;respawn [player]` | Респавн |
| `;god [player]` | Бессмертие |
| `;ungod [player]` | Убрать бессмертие |
| `;heal [player]` | Вылечить |
| `;kill <player>` | Убить |
| `;freeze <player>` | Заморозить |
| `;thaw <player>` | Разморозить |
| `;announce <text>` | Объявление всем |

## Как добавить свою команду

Создай новый ModuleScript в папке `Commands`:

```lua
return {
	Name = "mycommand",
	Aliases = {"mc"},
	Description = "Моя кастомная команда",
	Permission = 1,
	Execute = function(executor, args, targets)
		print(executor.Name .. " выполнил команду")
	end
}
```

## Конфигурация (`Config.lua`)

```lua
return {
	Prefix = ";",
	Admins = {
		[123456789] = 1, -- твой UserId = уровень прав
	},
	GroupId = 0,
	GroupRanks = {
		[255] = 1,
	},
	BanDataStoreName = "AdminBans_v1",
}
```

## Лицензия

MIT License

---

**Made with ❤️ for Roblox developers**

Нашёл баг или хочешь улучшить? Открывай Issue или Pull Request!
