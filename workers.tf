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
            "sudo apt-get update",
            "sudo apt-get -y install curl unzip",
            "git clone https://github.com/l4zy0n3/deno-example.git",
            "curl -fsSL https://deno.land/x/install/install.sh | sh",
            "cd deno-example",
            "/root/.deno/bin/deno run --allow-net main.ts"
        ]
    }
}

