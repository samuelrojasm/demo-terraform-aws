## 🛠️ Terraform - Módulo - Crea rol IAM con OIDC para GitHub Actions

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Módulo Terraform reutilizable que crea un rol IAM con OIDC para GitHub Actions, con una **trust policy** segura y una política de permisos definida por el usuario.
- Usar GitHub OIDC (OpenID Connect) para obtener tokens temporales.
- AWS ahora soporta la federación de identidades mediante OIDC, lo que permite que GitHub Actions se autentique en AWS sin usar llaves estáticas.
- Configuración (GitHub OIDC (OpenID Connect) + AWS IAM)
    1. Configuración de un **Proveedor de Identidad OIDC** en AWS IAM.
    1. Crear un rol IAM con los permisos necesarios para Terraform.
    1. Configuración de una **trust policy** para que ese rol acepte tokens emitidos por GitHub Actions (según repositorio, workflow, branch).
    1. En GitHub Actions, usar la acción **aws-actions/configure-aws-credentials** con OIDC para obtener credenciales temporales.
- Ventajas:
    - No se almacenan llaves en GitHub Secrets.
    - Se usan tokens temporales con duración corta.
    - Práctica de seguridad recomendada por AWS y GitHub.

---

## Variables principales

- `role_name`:      nombre del rol.
- `aws_account_id`: tu cuenta AWS.
- `repo_owner`:     usuario u organización de GitHub.
- `repo_name`:      nombre del repo.
- `repo_branch`: rama permitida.
- `policy_json`: política personalizada (formato JSON).

---

## 📚 Referencias

- []()
- []()

---