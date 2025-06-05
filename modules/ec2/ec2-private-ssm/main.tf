###############################
# AWS EC2 SSM                 #
###############################

# Objetivo:
# Este recurso crea una AWS EC2 dentro de una subnet privada,
# comúnmente en la misma VPC/subnet que un clúster de EKS. El propósito es proporcionar
# un punto de acceso seguro para administrar recursos como clústeres privados sin exponer
# puertos SSH ni usar claves externas. Este módulo puede ser reutilizado en distintos
# entornos de laboratorio o producción.

module "bastion_ssm_node" {
  source = "../../"

  depends_on = [module.vpc]

  name      = "cloud9-lab-example"
  subnet_id = module.vpc.private_subnets[0]
  tags = {
    Environment = "lab"
    Owner       = "cloud-team"
  }
}