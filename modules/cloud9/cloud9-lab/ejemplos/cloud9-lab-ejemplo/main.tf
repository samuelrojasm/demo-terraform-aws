# Manda llamar al módulo que crea la instancia Cloud9
module "cloud9_lab" {
    source  = "../../"
    name    = "cloud9-lab-example"
    subnet_id = "subnet-0abc123456789def0"
    tags = {
        Environment = "lab"
        Owner       = "cloud-team"
    }
}