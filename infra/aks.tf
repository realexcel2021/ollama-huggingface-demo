resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = var.project_name
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "ai-workload"

  identity {
    type = "SystemAssigned"
  }

  web_app_routing {
    dns_zone_ids = []
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_A4_v2"
    node_count = var.standard_node_count
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "gpu_node" {
  name                  = "ollama"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = "Standard_F4as_v6"
  node_count            = 1
  node_taints           = ["sku=gpu:NoSchedule"] 
  

  tags = {
    project_name = "AI-Workload"
  }
}