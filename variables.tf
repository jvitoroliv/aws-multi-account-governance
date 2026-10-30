# variables.tf
# Manages input variable declarations resources.

# Documented in the module README with accepted ranges.
variable "environment" {
  default     = "staging"
  type        = string
  description = "This variable define which environment we are using" 
 }