resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  
}

resource "azurerm_network_security_rule" "rules" {
  for_each = { for rule in csvdecode(file(var.rules_file)) : rule.name => rule }

  name                        = each.value.name
  priority                    = tonumber(each.value.priority)
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  network_security_group_name = azurerm_network_security_group.this.name
  resource_group_name         = var.resource_group_name
}

