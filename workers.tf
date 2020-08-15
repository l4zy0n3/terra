resource "digitalocean_droplet" "workers" {                                    
    image = var.server_image
    count = var.server_count
    name = "server-${var.region}-${count.index + 1}"
    region = var.region
    size = var.server_size
    private_networking = true
    ssh_keys = [
        var.ssh_fingerprint
    ]
    connection {
        host = self.ipv4_address
        user = "root"
        type = "ssh"
        private_key = file(var.pvt_key)
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
            "export PATH=$PATH:/usr/bin",
            # install deno and run server
            "curl -fsSL https://get.docker.com -o get-docker.sh",
            "sudo sh get-docker.sh",
            "sudo usermod -aG docker root",
            "docker run -d -p8000:8000 l4zy/notes:dev"
        ]
    }
}

