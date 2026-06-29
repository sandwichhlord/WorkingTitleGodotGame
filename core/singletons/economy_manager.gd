extends Node

signal balance_updated(currency_type: int, on_hand_amount: int, stashed_amount: int)
signal max_currency_reached(currency_type: int)

enum Currency { GOLD, SECONDARY, TERT }

# Currency at hand
var _balances: Dictionary = {
	Currency.GOLD: 0,
	Currency.SECONDARY: 0,
	Currency.TERT: 0
}

# Currency which will NOT be effected with death whatsoever (Bank)
var _stashed_balances: Dictionary = {
	Currency.GOLD: 0,
	Currency.SECONDARY: 0,
	Currency.TERT: 0
}

# Portion of currency thats still left after death
var _death_retention: Dictionary = {
	Currency.GOLD: 0.5,      
	Currency.SECONDARY: 1.0,  
	Currency.TERT: 0.0 
}

# Max possible currency thats possible to store in hand(normal balances)
var _max_currency: Dictionary = {
	Currency.GOLD: 99999,      
	Currency.SECONDARY: 999,  
	Currency.TERT: 99 
}

func add_currency(type: Currency, amount: int) -> void:
	if _balances[type] + amount > _max_currency[type]:
		_balances[type] = _max_currency[type]
		max_currency_reached.emit(type)
	else:
		_balances[type] += amount
	balance_updated.emit(type, _balances[type], _stashed_balances[type])

func can_afford(type: Currency, amount: int) -> bool:
	return _balances[type] >= amount


func spend_currency(type: Currency, amount: int) -> bool:
	if _balances[type] >= amount:
		_balances[type] -= amount
		balance_updated.emit(type, _balances[type], _stashed_balances[type])
		return true
	else: # Maybe add auto withdraw from bank in future using else if balances[type] + stashed_balances[type] - amount >= 0:
		return false
	

func deposit(type: Currency, amount: int) -> bool:
	if _balances[type] >= amount:
		_balances[type] -= amount
		_stashed_balances[type] += amount
		balance_updated.emit(type, _balances[type], _stashed_balances[type])
		return true
	else:
		return false

# Returns true if withdraw possible even if reaches max
# Returns false if amount is greater than max withdraw possible (Maybe still withdraw the max possible in future)
func withdraw(type: Currency, amount: int) -> bool:
	if _stashed_balances[type] >= amount:
		if _balances[type] + amount > _max_currency[type]:
			var to_add = _max_currency[type] - _balances[type]
			_stashed_balances[type]-= to_add
			_balances[type] = _max_currency[type]
			max_currency_reached.emit(type)
		else:
			_balances[type] += amount
			_stashed_balances[type] -= amount
		balance_updated.emit(type, _balances[type], _stashed_balances[type])
		return true
	else:
		return false

func handle_player_death() -> void:
	for type in _balances:
		_balances[type] = int(_balances[type] * _death_retention[type])
		balance_updated.emit(type, _balances[type], _stashed_balances[type])


func serialize() -> Dictionary:
	return _balances
	pass
func deserialize(data: Dictionary) -> void:
	pass
