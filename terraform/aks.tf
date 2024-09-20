module "aks" {
  source     = "./modules/aks"
  name       = "wp06cluster"
  dns_prefix = "wp06"
}
