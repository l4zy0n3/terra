variable "lb_image" {
    type = string
    default = "ubuntu-18-04-x64"
}

variable "lb_size" {
    type = string
    default = "s-1vcpu-1gb"
}

variable "server_image" {
    type = string
    default = "ubuntu-18-04-x64"
}

variable "server_size" {
    type = string
    default = "s-1vcpu-1gb"
}

variable "server_count" {
    type = string
    default = "1"
}
 
variable "region" {
    type = string
    default = "nyc1"
}
