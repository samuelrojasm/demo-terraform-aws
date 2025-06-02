## 🛠️ Terraform - Módulo - Crea rol IAM con OIDC para GitHub Actions

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Módulo Terraform reutilizable que crea:
    - Un rol IAM con OIDC para GitHub Actions, 
    - Con una **trust policy** segura y 
    - Una política de permisos definida por el usuario.
- Usar GitHub OIDC (OpenID Connect) para obtener tokens temporales.
- AWS ahora soporta la federación de identidades mediante OIDC, lo que permite que GitHub Actions se autentique en AWS sin usar llaves estáticas.
- Usa plantillas con **templatefile()** para interpolación de variables en el archivo **json** de la definición de la política.

---

## ✨ Ventajas de uso de OIDC + AWS IAM
    - No se almacenan llaves en GitHub Secrets.
    - Se usan tokens temporales con duración corta.
    - Práctica de seguridad recomendada por AWS y GitHub.

---

## ⚙️ Configuración (GitHub OIDC (OpenID Connect) + AWS IAM):
1. Configuración de un **Proveedor de Identidad OIDC** en AWS IAM.
    - Esto se hace una sola vez por cada cuenta de AWS
    - [El Bootstrap en Terraform](https://github.com/samuelrojasm/demo-terraform-aws/tree/main/IAM/iam-openid-connect-github)
2. Crear un rol IAM con los permisos necesarios para Terraform.
3. Configuración de una **trust policy** para que ese rol acepte tokens emitidos por GitHub Actions (según repositorio, workflow, branch).
4. En GitHub Actions, usar la acción **aws-actions/configure-aws-credentials** con OIDC para obtener credenciales temporales.

---

## 🔐 Trust policy
-  Objetivos de **trust policy** segura:
    - Permitir solo a un repositorio específico asumir el rol.
    - Restringir a una rama específica (ej. main).
    - Evitar que otros repos puedan suplantar identidad.
    - Bloquear forks (si el repo es público).
- Recomendaciones para **trust policy**
    - Para repositorios públicos se recomienda:
        - Nunca usar **"sub": "repo:*"** ni **"Condition": null**.
    - Si se requiere es posible permitir múltiples ramas:
        ```json
        "StringLike": {
            "token.actions.githubusercontent.com:sub": [
                "repo:<OWNER>/<REPO>:ref:refs/heads/main",
                "repo:<OWNER>/<REPO>:ref:refs/heads/dev"
            ]
        }
        ```
---

## 🧩 Plantillas con templatefile()
- Interpolación de variables
- Legibilidad y dinamismo si la política necesita valores variables (como ARN o IDs)
- Separación clara entre política y lógica Terraform.
- Mejor soporte en editores para JSON (autocompletado, validación).
- Permite reutilizar políticas entre múltiples roles o módulos.
- Versionar políticas IAM más fácilmente.
- Reutilizar plantillas para múltiples configuraciones o ramas.

---

## 🔧 Variables del módulo

| Nombre                | Tipo         | Descripción                                  | Valor Default     |
|-----------------------|--------------|----------------------------------------------|-------------------|
| `role_name`           | string       | Nombre del IAM Role                          | N/A               |
| `aws_account_id   `   | string       | Id de la cuenta de AWS                       | N/A               |
| `repo_owner`          | string       | Usuario u organización de GitHub             | N/A               |
| `repo_name`           | string       | Nombre del repo de GitHub                    | N/A               |
| `repo_branch`         | string       | Rama permitida                               | main              |
| `policy_json`         | string       | Política personalizada (formato JSON).       | N/A               |

---

## 🧪 Ejemplo de uso (main.tf del root project)
- Llamada al módulo
    ```hcl
    module "github_oidc_role" {
        source          = "./modules/github_oidc_role"
        role_name       = "GitHubActionsTerraformRole"
        aws_account_id  = "123456789012"
        repo_owner      = "miusuario"
        repo_name       = "terraform-gitops"
        repo_branch     = "main"
    }
    ```

## 📌 Validación (opcional)
- Para validar cómo se renderiza el template
    ```hcl
    terraform console
    > templatefile("${path.module}/assume-role-policy.tpl", {
        federated_arn = "arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com",
        audience      = "token.actions.githubusercontent.com"
    })
    ```

---

### 🚀 Resultados


---

## 📚 Referencias

- [Configuring OpenID Connect in Amazon Web Services](https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- [template_file](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)
- [templatefile Function](https://developer.hashicorp.com/terraform/language/functions/templatefile)

---