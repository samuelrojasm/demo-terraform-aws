## 🛠️ Terraform - Módulo - Crea rol IAM con OIDC para GitHub Actions

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
Módulo Terraform reutilizable que crea un rol IAM con OIDC para GitHub Actions, con una trust policy segura y una política de permisos definida por el usuario.


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