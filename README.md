# devops-01-cicd-docker-postgres-aws-terraform

Bitácora del proyecto: cada paso es algo que ya hice.

## Estructura

```
.
├── infra/         # repo simulado de Terraform
└── car-service/   # repo simulado de la app
```

---

## P0 — Configuré un usuario IAM en AWS

Creé un usuario IAM con MFA y le adjunté la policy `AdministratorAccess`. Le generé un **Access Key** (Access Key ID + Secret Access Key) para autenticar la Mac y Terraform contra AWS.

En la Mac corrí:

```bash
aws configure
```

y pegué el Access Key ID y el Secret Access Key. Con eso quedó autenticada la Mac (CLI y Terraform usan esas credenciales).

## P1 — Generé el par de llaves SSH en la Mac

```bash
ssh-keygen -t ed25519 -f ~/.ssh/awskey -C "aws key"
```

Le puse passphrase a la llave privada.

## P2 — Subí la llave pública a AWS

En la consola: **EC2 → Key Pairs → Import key pair**. Pegué `~/.ssh/awskey.pub` y la nombré `awskey`.

## P3 — Armé dos carpetas para simular dos repos

`infra/` y `car-service/`, cada una para llevarse a su propio repositorio cuando toque.

## P4 — Creé `infra/main.tf` con el provider de AWS

## P5 — Definí las variables en `infra/variables.tf`

Saqué a variables el AMI de Ubuntu y el nombre de la llave.

## P6 — Agregué el Security Group en `infra/security_group.tf`

Abrí los puertos **22** (SSH), **80** (HTTP) y **3000** (app Node).

## P7 — Agregué el módulo de EC2 en `infra/main.tf`

Lo enlacé al Security Group y le pasé el AMI y la key desde las variables.

## P8 — Configuré la subnet en `infra/main.tf`

Referencié la VPC `default`, listé sus subnets filtrando por `vpc-id` y le pasé la primera al `subnet_id` del módulo EC2.

## P9 — Agregué `infra/outputs.tf`

Output `public_ip_ec2_instance` para imprimir la IP pública de la instancia.

## P10 — Levanté la infra

```bash
terraform init
terraform plan
terraform apply
```

La instancia EC2 quedó creada en AWS.

## P11 — Configuré el atajo SSH en `~/.ssh/config`

Agregué un host para entrar a la EC2 con `ssh aws-vm` en vez de la IP completa. Al conectar, pide la passphrase de la llave privada.

## P12 — Instalé nginx, Docker y Postgres en el servidor

Entré a la EC2 por SSH e instalé `nginx`, `docker` y `postgres`.

## P13 — Agregué el bucket S3 en `infra/s3.tf`

Bucket `devops-amir-s3-bucket` con `force_destroy = true`.

## P14 — Le di permisos a la EC2 sobre el S3 con `infra/iam.tf`

Creé un Role para EC2, una Policy que permite `GetObject`, `PutObject` y `DeleteObject` sobre el bucket, y un Instance Profile que ata el Role a la EC2. Lo enlacé en el módulo con `iam_instance_profile`.

## P15 — Agregué el pipeline de GitHub Actions

`.github/workflows/ci-cd.yaml` con 3 etapas:

1. **test** — instala dependencias y corre `npm test`.
2. **build** — buildea la imagen de Docker y la sube a `ghcr.io`.
3. **deploy** — entra por SSH a la EC2, hace `docker pull` y levanta el contenedor.

Los stages `build` y `deploy` solo corren en `main`.

## P16 — Generé una llave SSH dedicada para el deploy

La llave `awskey` tiene passphrase, así que GitHub Actions no la podía usar en el job de deploy. Generé una nueva llave `ed25519` **sin passphrase**, agregué la pública al `~/.ssh/authorized_keys` de la EC2 y puse la privada como secret `AWS_SSH_KEY` en el repo. También agregué `AWS_HOST` con la IP pública de la EC2.

## P17 — Desplegué el car-service en la EC2

El pipeline corrió end-to-end y dejó el contenedor `car-api` corriendo en el servidor en el puerto 3000.

## P18 — Creé el archivo `.env` en la EC2

Creé `/home/ubuntu/.env` con la **BASE_URL** de la base de datos y el **PORT** en `3000`. Hice pruebas llamando a la base de datos desde el contenedor y funcionó correctamente.

---



