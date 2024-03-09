variable "vault_url" {
  default = "https://releases.hashicorp.com/vault/1.8.1/vault_1.8.1_linux_amd64.zip"
}

variable "project" {
  default = "vinid-playground"
}

variable "region" {
  default = "asia-east1"
}

variable "zone" {
  default = "asia-east1-b"
}

# variable "key_ring" {
#   description = "Cloud KMS key ring name to create"
#   default     = "test"
# }

# variable "crypto_key" {
#   default     = "vault-test"
#   description = "Crypto key name to create under the key ring"
# }

# variable "keyring_location" {
#   default = "global"
# }