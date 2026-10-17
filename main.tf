resource "aws_instance" "instance" {
    count = 5
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-04dce564af1818b33"]
    tags = {
        name = var.components[count.index]
    }   
}

variable "components"{
    type = list
    default = ["frontend","postgresql","auth-service","portfolio-service","analytics-service"]
}

resource "aws_route53_record" "recondinfo" {
    count = 5
    zone_id = "Z06825681EGC79XN2OESW"
    name = "${var.components[count.index]}-dev"
    type = "A"
    ttl = 30
    records = [aws_instance.instance[count.index].private_ip]
}