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

### 🚀 Resultados


---

## 🔧 Variables principales

- `role_name`:      nombre del rol.
- `aws_account_id`: tu cuenta AWS.
- `repo_owner`:     usuario u organización de GitHub.
- `repo_name`:      nombre del repo.
- `repo_branch`: rama permitida.
- `policy_json`: política personalizada (formato JSON).

---

## 📚 Referencias

- [Configuring OpenID Connect in Amazon Web Services](https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- []()

---