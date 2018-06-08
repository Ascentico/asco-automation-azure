# Create the network security group
resource "azurerm_network_security_group" "network_security_group" {
  name                = "${var.nsg_name}"
  location 			  = "${var.location_name}"
  resource_group_name 		    = "${azurerm_resource_group.resource_group.name}"

  # Inbound Rules

  # Allow HTTP connections to the GitLab server from anywhere
  security_rule {
    name                       = "Allow-HTTP-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "${var.allowed_ip}"
    destination_address_prefix = "${azurerm_public_ip.gitlab_public_ip.ip_address}"
  }

  # Allow 8080 connections to the servers from anywhere
  security_rule {
    name                       = "Allow-8080-Inbound"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "${var.allowed_ip}"
    destination_address_prefix = "*"
  }

  # Allow HTTP connections to the servers from anywhere
  security_rule {
    name                       = "Allow-HTTPS-Inbound"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "${var.allowed_ip}"
    destination_address_prefix = "*"
  }

  # Allow SSH connections to the servers from anywhere
  security_rule {
    name                       = "Allow-SSH-Inbound"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${var.allowed_ip}"
    destination_address_prefix = "*"
  }

  # Allow RDP connections to the servers from anywhere
  security_rule {
    name                       = "Allow-RDP-Inbound"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "${var.allowed_ip}"
    destination_address_prefix = "*"
  }

  # Allow WinRM connections to the servers from anywhere
  security_rule {
    name                       = "Allow-WinRM-Inbound"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "${var.allowed_ip}"
    destination_address_prefix = "*"
  }

  # Allow secure WinRM connections to the servers from anywhere
  security_rule {
    name                       = "Allow-SecureWinRM-Inbound"
    priority                   = 106
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "${var.winrm_secure_port}"
    source_address_prefix      = "${var.allowed_ip}"
    destination_address_prefix = "*"
  }

  # Deny all other connections from the servers
  security_rule {
    name                       = "Deny-All-Inbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Outbound Rules

  # Allow outbound DNS access to Azure's DNS
  security_rule {
    name                       = "Allow-DNS-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "*"
    destination_address_prefix = "168.63.129.16"
  }

  # Allow outbound HTTP access
  security_rule {
    name                       = "Allow-HTTP-Outbound"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow outbound HTTPS access
  security_rule {
    name                       = "Allow-HTTPS-Outbound"
    priority                   = 102
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow outbound HTTPS access
  security_rule {
    name                       = "Deny-All-Outbound"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags {
    environment   = "${var.environment_name}"
    owner         = "${var.owner_name}"
    create_method = "${var.create_method}"
  }
}