# variables.tf

variable "role_bindings" {
  description = "List of RoleBinding configurations"
  type        = list(object({
    username     = string
    access_level = string
    namespace    = string
  }))
}

