# 🛠️ Terraform - Bootstrap - Crea Proveedor de identidad OIDC de GitHub
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Terraform crea el proveedor OIDC de GitHub en una cuenta AWS una única vez.
- Este proyecto es parte del flujo de GitOps en AWS. 
- Permite crear el recurso **`aws_iam_openid_connect_provider`** requerido por los roles de GitHub Actions.
- En todos los demás proyectos que creen roles IAM para GitHub Actions, no necesitan volver a crear el OIDC provider.
- Es posible reutilizar el ARN del OIDC en todos los módulos de GitHub Actions que creen roles IAM.
- Para usar el Provider OIDC solo se hace referencia al ARN usando el patrón:
    ```hcl
    Federated = "arn:aws:iam::<account_id>:oidc-provider/token.actions.githubusercontent.com"
    ```
---

## 🔍 Detalles importantes
- AWS no permite múltiples instancias del mismo **oidc-provider** por cuenta.
- El proveedor de OIDC de GitHub es global y compartido: https://token.actions.githubusercontent.com
- Lo recomendable es que ese proveedor se cree fuera de otros módulos de Terraform, una vez, como parte de la infraestructura base (bootstrap).

---

## 🔐 Thumbprint
- Ese parámetro utiliza el thumbprint oficial de GitHub
- Anteriormente era obligatorio, pero a partir de FECHA AWS usa su lIsta de Providers ID, por lo que para algunos providers ID usados ampliamnete como Git Hub, ya no es obligatorio especificar este parámetro.
- 
- Si se quiere especificar (no obigatorio) el **Thumbprint de Git Hub** se localiza en la siguiente liga:
    - [GitHub Actions – Update on OIDC integration with AWS](https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/)
---

## 🚀 Ventajas de separar el bootstrap
| Beneficio                                   | Descripción                                                 |
|---------------------------------------------|-------------------------------------------------------------|
| Seguridad                                   | Evita errores de creación múltiple del mismo proveedor OIDC |
| Reutilización                               | Otros módulos solo crean roles, no duplican OIDC            |
| Modularidad y mantenimiento claro           | Bootstrap se mantiene separado de otros pipelines GitOps    |
| Escalabilidad                               | Añadir aquí S3 state backend, roles base, políticas comunes etc. |

---

## 📋 Requisitos
- Terraform >= 1.11.0
- AWS CLI configurado
- Permisos para crear recursos IAM

---

## Alternativa
- Es posible crear el Provider OIDC usando AWS CLI
    ```bash
    
    ```


## 📚 Referencias

- [Obtain the thumbprint for an OpenID Connect identity provider](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html)
- []()
- []()
- []()
- []()
- []()
- []()
- []()

---