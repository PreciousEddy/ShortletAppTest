resource "kubernetes_namespace" "app" {
  metadata {
    name = "flask-api"
  }
}

resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name      = "flask-api"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "flask-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "flask-api"
        }
      }

      spec {
        container {
          name  = "flask-api"
          image = "gcr.io/assessment-434523/flask-api:latest"  # Corrected the image reference
          
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "api_service" {
  metadata {
    name      = "flask-api"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    selector = {
      app = "flask-api"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 5000
    }
  }
}

