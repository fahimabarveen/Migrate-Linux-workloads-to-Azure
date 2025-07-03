resource "azurerm_route_table" "rt" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
 
}
 
resource "azurerm_route" "routes" {
  for_each = var.routes
 
  name                    = each.key
  resource_group_name     = var.resource_group_name
  route_table_name        = azurerm_route_table.rt.name
  address_prefix          = each.value.address_prefix
  next_hop_type           = each.value.next_hop_type
  next_hop_in_ip_address  = lookup(each.value, "next_hop_in_ip_address", null)
}