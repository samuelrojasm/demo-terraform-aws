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
- El proveedor de OIDC de GitHub es global y compartido: [https://token.actions.githubusercontent.com](#)
- Lo recomendable es que ese proveedor se cree fuera de otros módulos de Terraform, una vez, como parte de la infraestructura base (bootstrap).

---

## 🔐 Thumbprint
- Ese parámetro utiliza el thumbprint oficial de GitHub
- Anteriormente era obligatorio, pero a partir de **12/julio/2024** AWS usa su lista de Providers ID, por lo que para algunos providers ID usados ampliamnete como Git Hub, ya no es obligatorio especificar este parámetro.
- Este cambio es con la finalida de evitar tener que actualizar los **Thumbprint** de los certificados al rotar los certificados SSL/TLS.
- La publicación de AWS con el aviso se localiza en la siguiente liga:
    - [AWS IAM simplifies management of OpenID Connect identity providers](https://aws.amazon.com/about-aws/whats-new/2024/07/aws-identity-access-management-open-id-connect-identity-providers/?utm_source=chatgpt.com)
- Si se quiere especificar (no obigatorio) el **Thumbprint de Git Hub** se localiza en la siguiente liga:
    - [GitHub Actions – Update on OIDC integration with AWS](https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/)
    - En la configuración del OIDC la definición del thumbprint de Git Hub:
        ```hcl
        thumbprint_list = [
            "6938fd4d98bab03faadb97b34396831e3780aea1",
            "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
        ]
        ```
- Como dato adicional es posible obtener el thumbprint del certificado de Git Hub con los siguientes comandos:
```hcl 
    % curl https://token.actions.githubusercontent.com/.well-known/openid-configuration
{"issuer":"https://token.actions.githubusercontent.com","jwks_uri":"https://token.actions.githubusercontent.com/.well-known/jwks","subject_types_supported":["public","pairwise"],"response_types_supported":["id_token"],"claims_supported":["sub","aud","exp","iat","iss","jti","nbf","ref","repository","repository_owner","run_id","run_number","run_attempt","actor","workflow","head_ref","base_ref","event_name","ref_type","environment","job_workflow_ref"],"id_token_signing_alg_values_supported":["RS256"],"scopes_supported":["openid"]}%

% openssl s_client -servername token.actions.githubusercontent.com -showcerts -connect token.actions.githubusercontent.com:443
CONNECTED(00000005)
...
 1 s:/C=US/O=DigiCert Inc/CN=DigiCert TLS RSA SHA256 2020 CA1
   i:/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert Global Root CA
-----BEGIN CERTIFICATE-----
MIIE6jCCA9KgAwIBAgIQCjUI1VwpKwF9+K1lwA/35DANBgkqhkiG9w0BAQsFADBh
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBD
QTAeFw0yMDA5MjQwMDAwMDBaFw0zMDA5MjMyMzU5NTlaME8xCzAJBgNVBAYTAlVT
MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxKTAnBgNVBAMTIERpZ2lDZXJ0IFRMUyBS
U0EgU0hBMjU2IDIwMjAgQ0ExMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAwUuzZUdwvN1PWNvsnO3DZuUfMRNUrUpmRh8sCuxkB+Uu3Ny5CiDt3+PE0J6a
qXodgojlEVbbHp9YwlHnLDQNLtKS4VbL8Xlfs7uHyiUDe5pSQWYQYE9XE0nw6Ddn
g9/n00tnTCJRpt8OmRDtV1F0JuJ9x8piLhMbfyOIJVNvwTRYAIuE//i+p1hJInuW
raKImxW8oHzf6VGo1bDtN+I2tIJLYrVJmuzHZ9bjPvXj1hJeRPG/cUJ9WIQDgLGB
Afr5yjK7tI4nhyfFK3TUqNaX3sNk+crOU6JWvHgXjkkDKa77SU+kFbnO8lwZV21r
eacroicgE7XQPUDTITAHk+qZ9QIDAQABo4IBrjCCAaowHQYDVR0OBBYEFLdrouqo
qoSMeeq02g+YssWVdrn0MB8GA1UdIwQYMBaAFAPeUDVW0Uy7ZvCj4hsbw5eyPdFV
MA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIw
EgYDVR0TAQH/BAgwBgEB/wIBADB2BggrBgEFBQcBAQRqMGgwJAYIKwYBBQUHMAGG
GGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0aHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0R2xvYmFsUm9vdENBLmNydDB7BgNV
HR8EdDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRH
bG9iYWxSb290Q0EuY3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20v
RGlnaUNlcnRHbG9iYWxSb290Q0EuY3JsMDAGA1UdIAQpMCcwBwYFZ4EMAQEwCAYG
Z4EMAQIBMAgGBmeBDAECAjAIBgZngQwBAgMwDQYJKoZIhvcNAQELBQADggEBAHer
t3onPa679n/gWlbJhKrKW3EX3SJH/E6f7tDBpATho+vFScH90cnfjK+URSxGKqNj
OSD5nkoklEHIqdninFQFBstcHL4AGw+oWv8Zu2XHFq8hVt1hBcnpj5h232sb0HIM
ULkwKXq/YFkQZhM6LawVEWwtIwwCPgU7/uWhnOKK24fXSuhe50gG66sSmvKvhMNb
g0qZgYOrAKHKCjxMoiWJKiKnpPMzTFuMLhoClw+dj20tlQj7T9rxkTgl4ZxuYRiH
as6xuwAwapu3r9rxxZf+ingkquqTgLozZXq8oXfpf2kUCwA/d5KxTVtzhwoT0JzI
8ks5T1KESaZMkE4f97Q=
-----END CERTIFICATE-----
...

# saved the root certificate as cert.crt

% openssl x509 -in cert.crt -fingerprint -noout | sed -e 's/://g'
SHA1 Fingerprint=6938FD4D98BAB03FAADB97B34396831E3780AEA1

% openssl x509 -in Downloads/cert.crt -fingerprint -noout | sed -e 's/://g' | tr '[:upper:]' '[:lower:]'
sha1 fingerprint=6938fd4d98bab03faadb97b34396831e3780aea1
```

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
- [About security hardening with OpenID Connect](https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/about-security-hardening-with-openid-connect)
- []()
- []()
- []()
- []()
- []()
- []()
- [AWS IAM simplifies management of OpenID Connect identity providers](https://aws.amazon.com/about-aws/whats-new/2024/07/aws-identity-access-management-open-id-connect-identity-providers/?utm_source=chatgpt.com)
 - [GitHub Actions – Update on OIDC integration with AWS](https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/)

---