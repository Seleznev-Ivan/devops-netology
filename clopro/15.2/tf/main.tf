resource "yandex_iam_service_account" "sa-ig" {
  name = "sa-for-ig"
}

resource "yandex_resourcemanager_folder_iam_member" "ig-aditor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-ig.id}"
}

resource "yandex_compute_instance_group" "group1" {
  name                = "netology-ig"
  folder_id           = var.folder_id
  service_account_id  = yandex_iam_service_account.sa-ig.id
  deletion_protection = false
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 4
      }
    }

    network_interface {
      network_id = yandex_vpc_network.network-1.id
      subnet_ids = [yandex_vpc_subnet.public-subnet.id]
      nat        = true
    }
    scheduling_policy {
      preemptible = true
    }

    metadata = {
      serial-port-enable = 1
      ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH2VIf95p/dXoynEMlUCEd74TM0AY/SC07/Q4iT+UzNm eddsa-key-20230830"
      user-data          = <<EOF
#!/bin/bash
cd /var/www/html
echo '<html><head><title>Picture of my cat</title></head> <body><h1>Netology picture</h1><p><img src="http://${yandex_storage_bucket.netology-bucket.bucket_domain_name}/mypicture.jpg"/></body></html>' > index.html
EOF 
    }


    network_settings {
      type = "STANDARD"
    }
  }


  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_creating    = 3
    max_expansion   = 1
    max_deleting    = 1
  }

  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Целевая группа Network Load Balancer"
  }

  health_check {
    interval = 60
    http_options {
      port = 80
      path = "/"
    }
  }
  depends_on = [yandex_storage_bucket.netology-bucket]
}
