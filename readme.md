# Azure CAF add-on template

## Conventions

### File types, names and its purposes

**backend.azurerm** - required for system to function property.

**local.remote_tfstates.tf** - makes possible to reference resources from other landing zones located on the same or upper level.

**main.tf** - holds a list of Terraform providers with versions to be used withing this add-on. **azurerm** provider must be kept for system to function property.

**outputs.tf** - required if you plan to reference execution results from other landing zones. Can be safely deleted if your add-on doesn't produce any outputs.

**providers.tf** - contains provider configurations.

**variables.tf** - defines a list of variables that will be used to configure add-on behavior

**<resource_type>.tf** - contains resources that defines resource you plan to produce with your addon. E.g. helm_release, azure_devops_project etc.

## Running your add-on

Here's a sample command to run your add-on:

```
rover -lz /base/path/caf_solution/add-ons/add_on_name \
  -tfstate azure_devops-contoso_demo.tfstate \
  -var-folder /base/path/configuration/ \
  -level level4 \
  -env sandbox \
  -a apply
```
