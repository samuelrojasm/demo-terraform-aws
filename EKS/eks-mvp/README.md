## 🛠️ Demo: Amazon EKS

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Minimum Viable Product (MVP) de un clúster **Amazon Elastic Kubernetes Service**, creado únicamente con Terraform, enfocado en:
    - Ser funcional y gestionable con kubectl.
    - Usar instancias Spot para reducir costos.
    - Crear solo la infraestructura base (EKS + nodo Spot) sin herramientas adicionales como Helm, ALB, Ingress, etc.
    - Permitir agregar mejoras/módulos en el futuro (escalabilidad, seguridad, observabilidad, etc.).
- Infraestructura base lista para producción ligera y expandible en el tiempo. Ideal para entornos de desarrollo, testeo y aprendizaje.

---

## 💡 Alcance
Un repositorio básico con:
- Infraestructura mínima de EKS (Cluster + Node Group con Spot Instances).
- Configuración para poder usar **kubectl** directamente (aws eks update-kubeconfig).
- Modular y listo para escalar con nuevas features.

---

## 🧪 Servicios creados
Este proyecto crea:
- VPC con subredes públicas.
- Clúster EKS básico.
- Node Group con instancias Spot.

---

## 📌 Notas importantes
- Este MVP no incluye Ingress, Helm, IRSA, VPC CNI personalizado ni OIDC.
- Está listo para mejorar con módulos adicionales o ajustes como:
    - Autenticación con IAM.
    - Módulo de seguridad (SGs más finos, IRSA).
    - Clúster privado (con NAT Gateway).
    - Spot + On-Demand mixed autoscaling.
- El cluster es administrable directamente con kubectl.

---

## 🧩 Mejoras futuras sugeridas
- Soporte para IRSA / OIDC
- Ingress Controller (ALB/Nginx)
- Dashboards y monitoreo (Prometheus, Grafana)
- Cluster privado (subredes privadas y NAT Gateway)
- Autoscaling avanzado con Spot + OnDemand

---

## 🚀 Resultado (Outcome)
### Terraform init 


---

## 📚 Referencias



---