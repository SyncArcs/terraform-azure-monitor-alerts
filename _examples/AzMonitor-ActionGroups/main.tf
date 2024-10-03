provider "azurerm" {
  features {
  }
}

module "resource_group" {
  source      = "git::https://github.com/SyncArcs/terraform-azure-resource-group.git?ref=v1.0.0"
  name        = "app11"
  environment = "tested"
  location    = "North Europe"
}

module "azmonitor-action-groups" {
  source      = "./../.."
  name        = "app"
  environment = "test"
  location    = "North Europe"
  actionGroups = {
    "group1" = {
      actionGroupName      = "AlertEscalationGroup"
      actionGroupShortName = "alertesc"
      actionGroupRGName    = module.resource_group.resource_group_name
      actionGroupEnabled   = "true"
      actionGroupEmailReceiver = [
        {
          name                    = "example"
          email_address           = "therohityadav7@gmail.com"
          use_common_alert_schema = "true"
        },
        {
          name                    = "test"
          email_address           = "rohit9950518156@gmail.com"
          use_common_alert_schema = "true"
        }
      ]
    }
  }
}
