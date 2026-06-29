extends Node

signal balance_updated(currency_type: int, on_hand_amount: int, stashed_amount: int)
signal max_currency_reached(currency_type: int)
signal insufficient_funds(currency_type: int)

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

func get_balance(type: Currency) -> int:
	return _balances[type]

func get_stashed(type: Currency) -> int:
	return _stashed_balances[type]

func spend_currency(type: Currency, amount: int) -> bool:
	if _balances[type] >= amount:
		_balances[type] -= amount
		balance_updated.emit(type, _balances[type], _stashed_balances[type])
		return true
	else: # Maybe add auto withdraw from bank in future using else if balances[type] + stashed_balances[type] - amount >= 0:
		insufficient_funds.emit(type)
		return false
	

func deposit(type: Currency, amount: int) -> bool:
	if _balances[type] >= amount:
		_balances[type] -= amount
		_stashed_balances[type] += amount
		balance_updated.emit(type, _balances[type], _stashed_balances[type])
		return true
	else:
		insufficient_funds.emit(type)
		return false

# Returns how much currency has been withdrew
# If _balances[type] is already at _max_currency[type], then to_add computes to 0, 
# The caller can't distinguish "stash was empty" from "wallet was already full."
func withdraw(type: Currency, amount: int) -> int :
	var to_add = 0
	if _stashed_balances[type] >= amount:
		if _balances[type] + amount > _max_currency[type]:
			to_add = _max_currency[type] - _balances[type]
			max_currency_reached.emit(type)
		else:
			to_add = amount
		_balances[type] += to_add
		_stashed_balances[type] -= to_add
		balance_updated.emit(type, _balances[type], _stashed_balances[type])
	return to_add

func handle_player_death() -> void:
	for type in _balances:
		_balances[type] = int(_balances[type] * _death_retention[type])
		balance_updated.emit(type, _balances[type], _stashed_balances[type])


func serialize() -> Dictionary:
	return {
		"balances": _balances.duplicate(),
		"stashed": _stashed_balances.duplicate()
	}

func deserialize(data: Dictionary) -> void:
	pass
