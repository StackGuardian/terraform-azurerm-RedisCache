variable "cache_name" {
  description = "(Required) The name of the Redis instance. Changing this forces a new resource to be created."
}

variable "location" {
  description = "(Required) The location of the resource group. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Redis instance. Changing this forces a new resource to be created."
}

variable "capacity" {
  description = "(Required) The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4, 5"
}

variable "family" {
  description = "(Required) The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium)"
}

variable "sku" {
  description = "(Required) The SKU of Redis to use. Possible values are Basic, Standard and Premium"
}

variable "enable_non_ssl_port" {
  description = "Enable the non-SSL port (6379) ?"
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "(Optional) The minimum TLS version. Possible values are 1.0, 1.1 and 1.2."
  default     = 1.0

}

variable "cluster_shard_count" {
  description = "Number of cluster shards desired.Only available when using the Premium SKU."
  type        = number
  default     = 3
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this Redis Cache. true means this resource could be accessed by both public and private endpoint. false means only private endpoint access is allowed."
  type        = bool
  default     = true
}

variable "redis_version" {
  description = "Redis version. Only major version needed. Valid values: 4, 6"
  type        = number
  default     = 6

}

variable "private_static_ip_address" {
  description = "The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. This argument implies the use of subnet_id. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Only available when using the Premium SKU The ID of the Subnet within which the Redis Cache should be deployed. This Subnet must only contain Azure Cache for Redis instances without any other type of resources. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "zones" {
  description = "(Optional) Specifies a list of Availability Zones in which this Redis Cache should be located. Changing this forces a new Redis Cache to be created."
  default     = null
  type        = list(number)
}
variable "redis_configuration" {
  description = "Additional configuration for the Redis instance. Some of the keys are set automatically. See https://www.terraform.io/docs/providers/azurerm/r/redis_cache.html#redis_configuration for full reference."
  type = object({
    aof_backup_enabled              = optional(bool)
    aof_storage_connection_string_0 = optional(string)
    aof_storage_connection_string_1 = optional(string)
    enable_authentication           = optional(bool)
    maxmemory_reserved              = optional(number)
    maxmemory_delta                 = optional(number)
    maxmemory_policy                = optional(string)
    maxfragmentationmemory_reserved = optional(number)
    rdb_backup_enabled              = optional(bool)
    rdb_backup_frequency            = optional(number)
    rdb_backup_max_snapshot_count   = optional(number)
    rdb_storage_connection_string   = optional(string)
    notify_keyspace_events          = optional(string)
  })
  default = {}
}

variable "patch_schedule" {
  description = "A list of Patch Schedule, Azure Cache for Redis patch schedule is used to install important software updates in specified time window."
  default     = []
  nullable    = false
  type = list(object({
    day_of_week        = string
    start_hour_utc     = optional(string)
    maintenance_window = optional(string)
  }))
}

variable "storage_name" {
  description = "Specifies the name of the Storage Account"
  type        = string
  default     = ""
}
variable "data_persistence_storage_account_tier" {
  description = "Replication type for the Storage Account used for data persistence."
  type        = string
  default     = "Premium"
}

variable "data_persistence_storage_account_replication" {
  description = "Replication type for the Storage Account used for data persistence."
  type        = string
  default     = "LRS"
}