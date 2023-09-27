locals {
  n_num = -5
  c_num = 5.3
  f_num = 5.8
}

output "abs_num" {
  value = abs(local.n_num) # Returns 5
}

output "ceil_num" {
  value = ceil(local.c_num) # Returns 6
}

output "floor_num" {
  value = floor(local.f_num) # Returns 5
}

