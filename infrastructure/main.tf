# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "vpc"
  public_key = "${file("${var.key_path}")}"
}

# Define webserver inside the public subnet1
resource "aws_instance" "MSR-test-Instance-1" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   associate_public_ip_address = true
   user_data = <<USER_DATA
#!/bin/bash
sudo apt-get update
sudo hostname MSR-test-Instance-1
sudo echo "MSR-test-Instance-1" > /etc/hostname
sudo echo "127.0.0.1 MSR-test-Instance-1" >> /etc/hosts 
   USER_DATA
   source_dest_check = false
   
  tags {
    Name = "MSR-test-Instance-1"
  }
}


# Define webserver inside the public subnet2
resource "aws_instance" "MSR-test-Instance-2" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet2.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   associate_public_ip_address = true
   user_data = <<USER_DATA
#!/bin/bash
sudo apt-get update
sudo hostname MSR-test-Instance-2
sudo echo "MSR-test-Instance-2" > /etc/hostname
sudo echo "127.0.0.1 MSR-test-Instance-2" >> /etc/hosts
   USER_DATA
   source_dest_check = false

  tags {
    Name = "MSR-test-Instance-2"
  }
}

