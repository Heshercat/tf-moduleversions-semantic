provider "null" {}

resource "null_resource" "color_message_semantic_version_error2" {
  count = 6

  provisioner "local-exec" {
    command = <<EOT
    case ${count.index} in
      0)
        color="31"  # Red
        ;;
      1)
        color="32"  # Green
        ;;
      2)
        color="33"  # Yellow
        ;;
      3)
        color="34"  # Blue
        ;;
      4)
        color="35"  # Magenta
        ;;
      5)
        color="36"  # Cyan
        ;;
    esac
    echo -e "\\e[${color}mThis is \\e[${color}m message\\e[0m"
    EOT
  }
}
