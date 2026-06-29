extends Area2D

# This creates a drop-down in the editor using the Enum from your Autoload!
@export var currency_type: EconomyManager.Currency = EconomyManager.Currency.GOLD
@export var amount: int = 1

func _on_area_entered(area: Area2D) -> void:
	# Check if the colliding area belongs to the Player
	# (Assuming your player node/script is named or attached to the root of the player scene)
	if area.get_parent().is_in_group("player"):
		# Add to the global vault
		EconomyManager.add_currency(currency_type, amount)
		
		# Destroy the physical coin so it cannot be collected twice
		queue_free()
