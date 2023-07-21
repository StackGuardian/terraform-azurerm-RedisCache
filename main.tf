resource "azurerm_redis_cache" "redis-cache" {
  name                          = var.cache_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  capacity                      = var.capacity
  family                        = var.family
  sku_name                      = var.sku
  enable_non_ssl_port           = var.enable_non_ssl_port
  minimum_tls_version           = var.minimum_tls_version
  shard_count                   = var.sku_name == "Premium" ? var.cluster_shard_count : 0
  private_static_ip_address = var.private_static_ip_address
  subnet_id = var.subnet_id
  public_network_access_enabled = var.public_network_access_enabled
  redis_version                 = var.redis_version
  zones                         = var.zones
}