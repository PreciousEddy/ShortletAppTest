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
    replicas = 2

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
          image = "gcr.io/ecstatic-device-434214-c6/flask-time-api:latest"  # Corrected the image reference
          
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

resource "kubernetes_ingress" "api_ingress" {
  metadata {
    name      = "flask-api-ingress"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    rule {
      http {
        path {
          backend {
            service_name = kubernetes_service.api_service.metadata[0].name
            service_port = 80
          }
        }
      }
    }
  }
}
