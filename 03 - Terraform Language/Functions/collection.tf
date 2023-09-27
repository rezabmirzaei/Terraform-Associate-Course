locals {
  list1      = [1, 2, 3]
  list2      = [4, 5, 6]
  duplicates = [1, 2, 2, 3, 4, 4, 5]
  fruits     = ["apple", "banana", "cherry"]
}

output "concatenated_list" {
  value = concat(local.list1, local.list2) # Returns [1, 2, 3, 4, 5, 6]
}

output "unique_numbers" {
  value = distinct(local.duplicates) # Returns [1, 2, 3, 4, 5]
}

output "num_fruits" {
  value = length(local.fruits) # Returns 3
}
