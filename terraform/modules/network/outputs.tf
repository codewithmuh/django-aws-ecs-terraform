output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.gw[*].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
