resource "google_monitoring_uptime_check_config" "api_uptime_check" {
  display_name = "API Uptime Check"
  timeout      = "10s"
  period       = "60s"

  http_check {
    path = "/time"
    port = "80"
  }

  monitored_resource {
    type   = "gce_instance"
    labels = {
      instance_id = var.instance_id
      zone        = var.instance_zone
    }
  }
}

resource "google_monitoring_alert_policy" "api_alert_policy" {
  display_name = "API Alert Policy"
  combiner     = "OR"

  conditions {
    display_name = "Uptime Check Failed"
    condition_threshold {
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND resource.type=\"uptime_url\""
      comparison      = "COMPARISON_GT"
      threshold_value = 1
      duration        = "60s"

      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_RATE"
        cross_series_reducer = "REDUCE_NONE"
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email_channel.id]
}

resource "google_monitoring_notification_channel" "email_channel" {
  display_name = "Email Notification"
  type         = "email"

  labels = {
    email_address = "edmundprecious23@gmail.com"
  }
}
