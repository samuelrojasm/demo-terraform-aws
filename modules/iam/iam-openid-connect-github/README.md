# 🛠️ Terraform - Bootstrap - Crea Proveedor de identidad OIDC de GitHub
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Terraform crea el proveedor OIDC de GitHub en una cuenta AWS una única vez.
- En todos los demás proyectos que creen roles IAM para GitHub Actions, no necesitan volver a crear el OIDC provider. - Para usar el Provider oidc solo se hacen referencia al arn usando el patrón:
    ```hcl
    Federated = "arn:aws:iam::<account_id>:oidc-provider/token.actions.githubusercontent.com"
    ```
---

## 🔍 Detalles importantes
- AWS no permite múltiples instancias del mismo **oidc-provider** por cuenta.
- El proveedor de OIDC de GitHub es global y compartido: https://token.actions.githubusercontent.com
- Lo recomendable es que ese proveedor se cree fuera de otros módulos de Terraform, una vez, como parte de la infraestructura base (bootstrap).

---

## 🚀 Ventajas de separar el bootstrap
| Beneficio                                   | Descripción                                                 |
|---------------------------------------------|-------------------------------------------------------------|
| Seguridad                                   | Evita errores de creación múltiple del mismo proveedor OIDC |
| Reutilización                               | Otros módulos solo crean roles, no duplican OIDC            |
| Modularidad y mantenimiento claro           | Bootstrap se mantiene separado de otros pipelines GitOps    |
| Escalabilidad                               | Añadir aquí S3 state backend, roles base, políticas comunes etc. |

## 📚 Referencias

- []()
- []()

---