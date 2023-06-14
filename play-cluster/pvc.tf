resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_elasticsearch_data" {
  metadata {
    # don't change the name elasticsearch-data
    name      = "elasticsearch-data"
    namespace = "matt-sandbox"
    labels = {
      "io.kompose.service" = "elasticsearch-data"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_grafana_data" {
  metadata {
    name      = "grafana-data"
    namespace = "matt-sandbox"
    labels = {
      "io.kompose.service" = "grafana-data"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_influx_data" {
  metadata {
    name      = "influx-data"
    namespace = "matt-sandbox"
    labels = {
      "io.kompose.service" = "influx-data"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_opentsdb_data" {
  metadata {
    name      = "opentsdb-data"
    namespace = "matt-sandbox"
    labels = {
      "io.kompose.service" = "opentsdb-data"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_mysql_data" {
  metadata {
    name      = "mysql-data"
    namespace = "matt-sandbox"
    labels = {
      "io.kompose.service" = "mysql-data"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_postgres_data" {
  metadata {
    name      = "postgres-data"
    namespace = "matt-sandbox"
    labels = {
      "io.kompose.service" = "postgres-data"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_redis_data" {
  metadata {
    name      = "redis-data"
    namespace = "matt-sandbox"
    labels = {
      "io.kompose.service" = "redis-data"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "standard"
  }
}