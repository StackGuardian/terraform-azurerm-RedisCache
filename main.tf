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
  private_static_ip_address     = var.private_static_ip_address
  subnet_id                     = var.subnet_id
  public_network_access_enabled = var.public_network_access_enabled
  redis_version                 = var.redis_version
  zones                         = var.zones
  redis_configuration {
    aof_backup_enabled              = var.redis_configuration.aof_backup_enabled
    aof_storage_connection_string_0 = var.redis_configuration.aof_storage_connection_string_0
    aof_storage_connection_string_1 = var.redis_configuration.aof_storage_connection_string_1
    enable_authentication           = var.redis_configuration.enable_authentication
    maxmemory_reserved              = var.redis_configuration.maxmemory_reserved
    maxmemory_delta                 = var.redis_configuration.maxmemory_delta
    maxmemory_policy                = var.redis_configuration.maxmemory_policy
    maxfragmentationmemory_reserved = var.redis_configuration.maxfragmentationmemory_reserved
    rdb_backup_enabled              = var.redis_configuration.rdb_backup_enabled
    rdb_backup_frequency            = var.redis_configuration.rdb_backup_frequency
    rdb_backup_max_snapshot_count   = var.redis_configuration.rdb_backup_max_snapshot_count
    rdb_storage_connection_string   = var.redis_configuration.rdb_storage_connection_string
  }
  lifecycle {
    ignore_changes = [redis_configuration[0].rdb_storage_connection_string]
  }
  patch_schedule {
    days_of_week       = var.patch_schedule.days_of_week
    start_hour_utc     = var.patch_schedule.start_hour_utc
    maintenance_window = var.patch_schedule.maintenance_window
  }
}

resource "azurerm_storage_account" "redis_storage" {
  name                     = var.storage_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.data_persistence_storage_account_tier
  account_replication_type = var.data_persistence_storage_account_replication
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
}