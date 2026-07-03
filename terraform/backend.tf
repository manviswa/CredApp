# =====================================================================
# CredPay - Remote state backend (Azure Storage)
# =====================================================================
# These backend resources are BOOTSTRAP resources, created manually ONCE
# (they are NOT managed by this Terraform project):
#   Resource Group   : CredProj
#   Storage Account  : credprojstate
#   Blob Container   : statefile
# Terraform simply uses them to store its state file.
# =====================================================================
terraform {
  backend "azurerm" {
    resource_group_name  = "CredProj"
    storage_account_name = "credprojstate"
    container_name       = "statefile"
    key                  = "credpay.terraform.tfstate"
  }
}
