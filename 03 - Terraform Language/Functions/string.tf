locals {
  name = "Reza"
  age  = 46
  text = "HELLO world"
}

output "lowercase_text" {
  value = lower(local.text) # Returns "hello world"
}

output "uppercase_text" {
  value = upper(local.text) # Returns "HELLO WORLD"
}

# Notice string interpolation
output "formatted_string" {
  value = format("Name: %s, Age: %d", local.name, local.age) # Returns "Name: Reza, Age: 46"
}
