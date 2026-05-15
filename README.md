# devops-01-cicd-docker-aws-terraform

Bitácora del proyecto: cada paso es algo que ya hice.

## Estructura

```
.
├── infra/         # repo simulado de Terraform
└── car-service/   # repo simulado de la app
```

---

## P0 — Configuré un usuario IAM en AWS

Creé un usuario IAM con MFA y le adjunté la policy `AdministratorAccess`.

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

---

## Próximos pasos

