# Запросы

## Запрос 1:
### Условие: Получить список фамилий всех игроков, чья позиция "Forward".
### π last_name σ (position = 'Forward') Player

## Запрос 2: 
### Условие: Найти всех игроков с зарплатой больше 5 000 000, и вывести их фамилии. 
### π Player.last_name σ ( Contract.salary > 5000000 ) (Player ⋈ player_id Contract)
