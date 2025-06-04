###############################
# AWS Cloud9 Environment EC2 #
###############################

# Objetivo:
# Este recurso crea un entorno de desarrollo Cloud9 en AWS dentro de una subnet privada,
# comúnmente en la misma VPC/subnet que un clúster de EKS. El propósito es proporcionar
# un punto de acceso seguro para administrar recursos como clústeres privados sin exponer
# puertos SSH ni usar claves externas. Este módulo puede ser reutilizado en distintos
# entornos de laboratorio o producción.

module "cloud9_lab" {
  source    = "../../"
  name      = "cloud9-lab-example"
  subnet_id = module.vpc.private_subnets[0]
  tags = {
    Environment = "lab"
    Owner       = "cloud-team"
  }
}