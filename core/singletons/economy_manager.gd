extends Node

signal balance_updated(currency_type: int, on_hand_amount: int, stashed_amount: int)
signal max_currency_reached(currency_type: int)

enum Currency { GOLD, SECONDARY, TERT }

# Currency at hand
var balances: Dictionary = {
	Currency.GOLD: 0,
	Currency.SECONDARY: 0,
	Currency.TERT: 0
}

# Currency which will NOT be effected with death whatsoever (Bank)
var stashed_balances: Dictionary = {
	Currency.GOLD: 0,
	Currency.SECONDARY: 0,
	Currency.TERT: 0
}

# Portion of currency thats still left after death
var death_retention: Dictionary = {
	Currency.GOLD: 0.5,      
	Currency.SECONDARY: 1.0,  
	Currency.TERT: 0.0 
}

# Max possible currency thats possible to store in hand(normal balances)
var max_currency: Dictionary = {
	Currency.GOLD: 99999,      
	Currency.SECONDARY: 999,  
	Currency.TERT: 99 
}

func add_currency(type: Currency, amount: int) -> void:
	if balances[type] + amount > max_currency[type]:
		balances[type] = max_currency[type]
		max_currency_reached.emit(type)
	else:
		balances[type] += amount
	balance_updated.emit(type, balances[type], stashed_balances[type])

func spend_currency(type: Currency, amount: int) -> bool:
	if balances[type] - amount >= 0:
		balances[type] -= amount
		balance_updated.emit(type, balances[type], stashed_balances[type])
		return true
	else: # Maybe add auto withdraw from bank in future using else if balances[type] + stashed_balances[type] - amount >= 0:
		return false
	

func deposit(type: Currency, amount: int) -> bool:
	if balances[type] - amount >= 0:
		balances[type] -= amount
		stashed_balances[type] += amount
		balance_updated.emit(type, balances[type], stashed_balances[type])
		return true
	else:
		return false

# Returns true if withdraw possible even if reaches max
# Returns false if amount is greater than max withdraw possible (Maybe still withdraw the max possible in future)
func withdraw(type: Currency, amount: int) -> bool:
	if stashed_balances[type] - amount >= 0:
		if balances[type] + amount > max_currency[type]:
			var to_add = max_currency[type] - balances[type]
			stashed_balances[type]-= to_add
			balances[type] = max_currency[type]
			max_currency_reached.emit(type)
		else:
			balances[type] += amount
			stashed_balances[type] -= amount
		balance_updated.emit(type, balances[type], stashed_balances[type])
		return true
	else:
		return false

func handle_player_death() -> void:
	for type in balances:
		balances[type] = int(balances[type] * death_retention[type])
		balance_updated.emit(type, balances[type], stashed_balances[type])
	pass
