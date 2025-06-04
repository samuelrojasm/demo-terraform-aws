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
- Terraform-only: nada de eksctl, kubectl, ni aws cli para el despliegue.
- Infraestructura mínima de EKS (Cluster + Node Group con Spot Instances).
- Instancias EC2 Spot para el nodo worker.
- Configuración para poder usar **kubectl** directamente (aws eks update-kubeconfig).
- Modular y listo para escalar con nuevas features.
- Red privada: sin exposición pública, ideal para laboratorios internos y aprendizaje.

---

## 🧪 Servicios creados
Este proyecto crea:
- VPC con subredes privadas, endpoint privado y acceso por SSM
- Clúster EKS básico
- Node Group con instancias Spot

---

## 🔐 Usar AWS SSM Session Manager con Port Forwarding
- Usar **AWS SSM Session Manager** para acceder a instancias privadas de forma segura y sin claves SSH, utilizando port forwarding. 
- Ideal para acceder a servicios internos de AWS.
- Permite administrar clústeres EKS privados sin exponer nada públicamente ni usar llaves SSH.
### Componentes:
- Acceso sin SSH
- SSM Session Manager configurado con IAM
- Port forwarding desde localhost al destino privado
- Túnel seguro para conexiones a la VPC privada
- Diagnóstico con `session-manager-plugin` y `aws ssm start-session`
### Cloud9 para acceder a cluster privado

### Ejemplo de uso:
    ```bash
    aws ssm start-session \
    --target i-xxxxxxxxxxxxxxxxx \
    --document-name AWS-StartPortForwardingSession \
    --parameters '{"portNumber":["5432"],"localPortNumber":["5432"]}'
    ```

---

## ## 🔌 Conexión al clúster con kubectl

- Después de **Terraform apply** y crear el clúster EKS, ejecutr el siguiente comando para configurar `kubectl`:

    ```bash
    aws eks update-kubeconfig --name eks-lab --region us-east-1
    ```

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
- 🔐 Habilitar soporte para OIDC e IRSA
- 📦 Integración con Helm y addons (VPC CNI, CoreDNS, kube-proxy)
- 🌐 Ingress Controller (ALB/Nginx)
- 🔒 Seguridad adicional (SGs refinadas, policies mínimas)
- 📈 Dashboards y monitoreo con Prometheus + Grafana
- 🧠 Cluster privado (subredes privadas y NAT Gateway)
- ☁️ Autoscaling avanzado-Mixed Auto Scaling: SPOT + On-Demand
- 🗂 Módulos separados por componentes (VPC, EKS, node groups)

---

## 🚀 Resultado (Outcome)
### Terraform init 


---

## 📚 Referencias



---