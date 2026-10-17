resource "aws_instance" "instance" {
    for_each = var.components
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-04dce564af1818b33"]
    tags = {
        Name = each.key
    }   
}

variable "components"{
    type = map
    default = {
        "frontend" = "",
        "postgresql" =" " ,
        "auth-service" = " ",
        "portfolio-service" = " ",
        "analytics-service" = " "
    }
}

resource "aws_route53_record" "recordinfo" {
    for_each = var.components
    zone_id = "Z06825681EGC79XN2OESW"
    name = "${each.key}-dev"
    type = "A"
    ttl = 30
    records = [aws_instance.instance[each.key].private_ip]
}