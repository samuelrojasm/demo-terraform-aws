# Terraform para AWS
- Terraform es una herramienta de Infraestructura como Código (IaC) que permite definir, gestionar y automatizar la infraestructura a través de archivos de configuración declarativa. 
- Terraform utiliza un lenguaje llamado HCL (HashiCorp Configuration Language) para definir la infraestructura.

## Requisitos
### 1. Instalar AWS CLI
- Instalación en macOS:
    ```
    brew install awscli
    ```
### 2. Configurar el acceso por AWS IAM Identity Center 
En mi caso uso un usuario AWS SSO.
- Crear un nuevo profile:
    ```
    aws configure sso
    ```
- Autenticación de perfil:
    ```
    aws sso login --profile <nombre-del-perfil>
    ```
- Terminar la sesión:
    ```
    aws sso logout
    ```

## Pasos básicos de Terraform
Pasos básicos para usar Terraform de manera eficiente en cualquier proyecto.
### 1. Instalar Terraform
#### Instalación en macOS:
- Instalar de HashiCorp tap, un repositorio de todos los paquetes de Homebrew
    ```
    brew tap hashicorp/tap
    ```
- Instalar Terraform 
    ```
    brew install hashicorp/tap/terraform
    ```
- Una vez instalado, puedes verificar la instalación ejecutando:
    ```
    terraform -v
    ```
    ```
    terraform -help
    ```
    ```
    terraform -help plan
    ```
- To update to the latest version of Terraform, first update Homebrew:
    ```
    brew update
    ```
- Command to download and use the latest Terraform version:
    ```
    brew upgrade hashicorp/tap/terraform
    ```

### 2. Inicializar el Directorio del Proyecto
Antes de trabajar con Terraform, se debe crear un directorio donde se guarden los archivos de configuración de **Terraform** y luego inicializarlo.
- Crea un nuevo directorio en la máquina local para tu proyecto de Terraform.
```
mkdir my-terraform-project
cd my-terraform-project
```
- Inicializa Terraform:
Esto descarga los proveedores necesarios y prepara el entorno de trabajo.
```
terraform init
```
### 3. Escribir Archivos de Configuración
- Terraform utiliza archivos de configuración escritos en **HCL (HashiCorp Configuration Language)**. 
- Estos archivos definen la infraestructura que se deseas crear o gestionar.
- Un archivo básico de configuración en Terraform tiene la extensión **`.tf.`** 
- Ejemplo básico de un archivo de configuración **`main.tf`** (crear una instancia EC2 en AWS):
    - Este archivo declara lo siguiente:
        - **Proveedor**: AWS (con la región **us-west-2**).
        - **Recurso**: Una instancia EC2 con tipo **t2.micro** y una imagen de Amazon Machine Image (AMI).
```
provider "aws" {
  region = "us-west-2"
}
resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # AMI de ejemplo
  instance_type = "t2.micro"

  tags = {
    Name = "MyInstance"
  }
}
```
### 4. Previsualizar los Cambios con **`terraform plan`**
- Antes de aplicar los cambios a la infraestructura real, es importante hacer una previsualización de los cambios que Terraform realizará.
- Este comando muestra lo que Terraform hará (crear, modificar, eliminar recursos) sin aplicar realmente los cambios. 
- Es una revisión de seguridad para asegurarte de que lo que vas a crear o modificar es correcto.
```
terraform plan
```
### 5. Aplicar la Configuración con **`terraform apply`**
Si el plan es correcto y quieres aplicar los cambios, se ejecuta:
```
terraform apply
```
Terraform pedirá confirmación antes de aplicar los cambios. Confirmar escribiendo **`yes`**.
### 6. Gestionar el Estado con **`terraform state`**
- Terraform mantiene el estado de los recursos que gestiona en un archivo llamado **terraform.tfstate**. 
- Este archivo de estado almacena la configuración actual de la infraestructura. 
- No se debe modificar manualmente, pero puedes interactuar con él para realizar diversas acciones.
#### Algunos comandos útiles:
| Comando                                     | Descripción                                                 |
|---------------------------------------------|-------------------------------------------------------------|
| **`terraform show `**                       | Muestra el estado actual de la infraestructura.             |
| **`terraform state list`**                  | Muestra una lista de recursos en el estado actual.          |
| **`terraform state show <resource_name>`**  | Ver detalles de un recurso.                                 |

### 7. Modificar la Infraestructura
- Terraform se encargará de calcular las diferencias entre el estado actual y la configuración deseada, y hará los cambios necesarios en la infraestructura.
- Para hacer cambios en la infraestructura, simplemente editar el archivo **`.tf`**  para agregar, modificar o eliminar recursos. Luego, seguir estos pasos:
    1. Previsualiza los cambios con **`terraform plan`**.
    2. Aplica los cambios con **`terraform apply`**.

### 8. Destruir la Infraestructura con **`terraform destroy`**
Para eliminar todos los recursos gestionados por Terraform (por ejemplo, en un entorno de prueba), se puede usar el siguiente comando:
```
terraform destroy
```
- Este comando eliminará todos los recursos definidos en los archivos **`.tf.`**  del proyecto y también actualizará el archivo de estado.
- Terraform pedirá confirmación antes de destruir los recursos. Confirmar escribiendo **`yesc.

### 9. Mantener la Infraestructura y el Estado
- Cuando se trabaja con Terraform en un equipo o en proyectos a gran escala, es importante mantener el archivo de estado (**`terraform.tfstate`**) en un almacenamiento remoto para que todos los miembros del equipo puedan acceder al mismo estado.
- Soluciones de almacenamiento remoto comunes:
    - Amazon S3 + DynamoDB (para bloqueo de estado) para AWS.
    - Azure Storage Account para Azure.
    - Google Cloud Storage para Google Cloud.
Para configurar el almacenamiento remoto, añadir un bloque **`backend`** en el archivo de configuración **`main.tf`**:
```
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "path/to/my/key"
    region = "us-west-2"
  }
}
```
### 10. Versionar Configuraciones con Git
- Es una buena práctica versionar los archivos de configuración de Terraform en un sistema de control de versiones como Git. 
- Esto permite que puedas realizar un seguimiento de los cambios a lo largo del tiempo y facilitar la colaboración en equipos.

## Comandos Básicos de Terraform:
| Comando                    | Descripción                                                 |
|----------------------------|-------------------------------------------------------------|
| **`terraform init`**       | Inicializa el proyecto y descarga los proveedores.          |
| **`terraform plan`**       | Muestra un plan de los cambios que se van a realizar.       |
| **`terraform apply`**      | Aplica los cambios a la infraestructura.                    |
| **`terraform show`**       | Muestra el estado actual de la infraestructura.             |
| **`terraform state list`** | Muestra una lista de recursos en el estado actual.          |
| **`terraform destroy`**    | Elimina todos los recursos gestionados por Terraform.       |

## Buenas Prácticas:
1. **Mantener los archivos de estado seguros**: Los archivos de estado (**`terraform.tfstate`**) contienen información sensible (como credenciales o configuraciones internas). Usa almacenamiento remoto y habilita el cifrado.
2. **Uso de módulos**: Organizar el código de infraestructura en módulos para reutilizar configuraciones y hacer el código más modular.
3. **Revisar siempre el **`plan`** antes de aplicar cambios**: Usar siempre **`terraform plan`** antes de **`terraform apply`** para evitar cambios no deseados.
4. **Automatización**: Integrar Terraform en un pipeline de CI/CD para automatizar la provisión de infraestructura.

## Estructura del proyecto
```bash
├── proyecto1/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── modules
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── security-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   └── s3/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
```
### Archivos del proyecto
| Archivo                    | Descripción                                                                         |
|----------------------------|-------------------------------------------------------------------------------------|
| **`main.tf`**              | Contains the core resource declarations and configurations for the module.          |
| **`variables.tf`**         | Defines input variables that allow users to customize the module’s behavior.        |
| **`output.tf`**            | Provides information about the created resources.                                   |
| **`provider.tf`**          | Defines the versions used for the providers and terraform.                          |
| **`README.md`**            | Documentation on how to use the module, including descriptions of input variables and outputs.  |

## Data Source en Terraform
- En Terraform, un ***Data Source*** se usa para leer datos externos o recursos existentes que ya están creados fuera de Terraform, o para consultar información dinámica de tu infraestructura que no necesariamente es gestionada directamente por Terraform.
- Un ***Data Source*** permite obtener información de recursos ya existentes para utilizarla en la creación o configuración de nuevos recursos en tu infraestructura.
- Cuando Terraform ejecuta la infraestructura, lo primero que hace es obtener la información del ***Data Source***. Terraform realiza la consulta a la API del proveedor (en este caso, AWS) utilizando los parámetros definidos en el bloque del Data Source. 
- Posteriormente, Terraform utiliza los datos obtenidos para configurar o crear los recursos en tu infraestructura.
### Ejemplo de definición de Data Source
- Ejemplo:
    ```
    data "aws_ami" "ubuntu" {
        most_recent = true
        filter {
            name   = "name"
            values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
        }
        filter {
            name   = "virtualization-type"
            values = ["hvm"]
        }
        owners = ["099720109477"]  # Canonical
    }
    ```
- Cuando se ejecuta el plan de Terraform, el ID de la AMI más reciente que coincida con esos filtros será devuelto, y se puede usar en otros recursos.
- En este caso, **data.aws_ami.ubuntu.id** obtiene el id de la AMI más reciente que cumple con los filtros proporcionados en el Data Source.
    ```
    ami = data.aws_ami.ubuntu.id
    ```
### Otros datos puedes obtener del Data Source
- Un Data Source puede devolver varios atributos, no solo el id. 
- Estos atributos dependen del tipo de Data Source que estés utilizando. 
- Algunos ejemplos adicionales de lo que puedes obtener de un Data Source, y específicamente para el caso de **aws_ami**:
#### Atributos comunes de un Data Source ***aws_ami***:
- **`id`**: El ID de la AMI seleccionada.
- **`name`**: El nombre de la AMI.
- **`owner_id`**: El ID del propietario de la AMI (en este caso, Canonical).
- **`virtualization_type`**: El tipo de virtualización de la AMI (por ejemplo, hvm).
- **`architecture`**: La arquitectura de la AMI (por ejemplo, x86_64 o arm64).
- **`root_device_name`**: El nombre del dispositivo de arranque (root).
- **`block_device_mappings`**: Detalles sobre los volúmenes de bloque que se adjuntan a la AMI.
- **`image_location`**: La ubicación de la AMI en el sistema de AWS (si está en un marketplace o en una región específica).
- **`tags`**: Las etiquetas asociadas con la AMI (si están disponibles).

### Ejemplo de uso de otros atributos del Data Source ***aws_ami***:
```
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]  # Canonical
}

output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "ami_name" {
  value = data.aws_ami.ubuntu.name
}

output "ami_architecture" {
  value = data.aws_ami.ubuntu.architecture
}
```

## Referencias
- [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Lifecycle management of AWS resources](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [Resource: aws_instance](https://registry.terraform.io/providers/hashicorp/aws/5.84.0/docs/resources/instance)
- [Terraform Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)
- [Data Source: aws_ami](https://registry.terraform.io/providers/hashicorp/aws/5.84.0/docs/data-sources/ami)