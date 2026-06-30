# 🚀 Kubernetes Multi-Environment Deployment for Playwright

## 📌 Project Information

**Project Name:** `k8s-playwright-multi-env`

### Description

This project demonstrates how to manage **multiple Kubernetes environments** for a Playwright-based testing workflow using **Namespaces**, **ConfigMaps**, **Secrets**, **Labels & Selectors**, and **Resource Quotas**.

The same application is deployed into three isolated environments (**Development, Staging, and Production**) while Kubernetes injects different configuration and credentials into each namespace.

Although this project is part of a Playwright learning series, **Nginx is used as the sample application** to provide a stable application endpoint. In a real-world CI/CD pipeline, Playwright test suites would target these environments and would typically be executed using **Kubernetes Jobs** instead of Deployments.

---

# 🎯 Project Objectives

The objective of this project is to understand how Kubernetes manages multiple environments without changing the application image.

By the end of this project, you will understand how to:

* Create isolated Kubernetes namespaces
* Deploy the same application into multiple environments
* Store configuration outside the application image
* Store sensitive credentials securely
* Inject environment variables into containers
* Organize Kubernetes resources using labels
* Limit resource consumption using Resource Quotas
* Automate deployments using shell scripts

---

# 📋 What This Project Builds

This project implements the following Kubernetes resources:

✅ Separate namespaces

* Development (`dev`)
* Staging (`staging`)
* Production (`prod`)

✅ Environment-specific ConfigMaps

Each environment contains its own configuration.

Example:

| Environment | Base URL            | Timeout |
| ----------- | ------------------- | ------- |
| Development | dev.example.com     | 30000   |
| Staging     | staging.example.com | 45000   |
| Production  | example.com         | 60000   |

---

✅ Environment-specific Secrets

Each namespace stores its own credentials.

Example:

Development

```text
API_KEY=devapikey
AUTH_TOKEN=devtoken
```

Staging

```text
API_KEY=stagingapikey
AUTH_TOKEN=stagingtoken
```

Production

```text
API_KEY=prodapikey
AUTH_TOKEN=prodtoken
```

---

✅ Deployments

Each namespace has its own Deployment.

Each Deployment:

* Runs inside its own namespace
* Uses the same container image
* Loads ConfigMaps
* Loads Secrets
* Uses labels for identification

---

✅ Labels

Every deployment includes labels.

```yaml
labels:
  app: playwright-demo
  env: dev
```

Labels make it easy to:

* Filter Pods
* Manage Deployments
* Identify environments
* Simplify troubleshooting

---

✅ Resource Quotas

Each namespace has its own ResourceQuota.

Example:

| Environment | Pods | CPU   | Memory |
| ----------- | ---- | ----- | ------ |
| Development | 5    | 1 CPU | 1Gi    |
| Staging     | 10   | 2 CPU | 2Gi    |
| Production  | 20   | 4 CPU | 4Gi    |

Resource Quotas ensure that one environment cannot consume excessive cluster resources.

---

# 📚 Kubernetes Concepts Practiced

This project provides hands-on experience with the following Kubernetes concepts:

### Namespace Isolation

Each environment runs inside an independent namespace.

Benefits:

* Resource isolation
* Configuration isolation
* Secret isolation
* Easier administration

---

### ConfigMaps

Configuration is stored outside the container image.

Benefits:

* No Docker image rebuilds
* Easy environment customization
* Reusable application image

---

### Secrets Management

Sensitive values are stored separately from application configuration.

Examples:

* API Keys
* Authentication Tokens

Benefits:

* Improved security
* Better credential management
* Environment-specific secrets

---

### Environment Variable Injection

Both ConfigMaps and Secrets are injected into containers using:

```yaml
envFrom:
- configMapRef:
- secretRef:
```

This allows the same application image to behave differently depending on the namespace.

---

### Labels and Selectors

Labels identify resources.

Example:

```text
app=playwright-demo
env=dev
```

Selectors use these labels to identify Pods and Deployments.

---

### Resource Quotas

ResourceQuotas help control:

* Number of Pods
* CPU Requests
* CPU Limits
* Memory Requests
* Memory Limits

This prevents one namespace from exhausting cluster resources.

---

# 📦 Deliverables

The completed project includes:

```text
k8s-playwright-multi-env/

├── namespaces/
├── configmaps/
├── secrets/
├── deployments/
├── resourcequotas/
├── scripts/
└── README.md
```

### Included Components

* Environment-specific namespace configurations
* Environment-specific ConfigMaps
* Environment-specific Secrets
* Environment-specific Deployments
* ResourceQuota configurations
* Deployment scripts
* Cleanup script
* Environment strategy documentation

---

# 🌍 Environment Strategy

The project follows a standard three-environment deployment model.

## Development

Purpose

* Developer testing
* Feature validation
* Quick iteration

Characteristics

* Smallest resource allocation
* Development configuration
* Development credentials

---

## Staging

Purpose

* Integration testing
* Regression testing
* User Acceptance Testing (UAT)

Characteristics

* Mirrors production
* Medium resource allocation
* Independent configuration

---

## Production

Purpose

* Represents the live production environment

Characteristics

* Highest resource allocation
* Production configuration
* Production credentials
* Independent namespace

---

# 💡 Design Decision

Although the project is titled **"Run Playwright tests across dev/staging/prod environments"**, this implementation intentionally deploys **Nginx** instead of running Playwright inside a Kubernetes Deployment.

This decision reflects a production-oriented Kubernetes practice.

A Kubernetes **Deployment** is designed for applications that remain running continuously.

Playwright, however, is a **batch workload**:

1. Starts
2. Executes the test suite
3. Exits successfully

When executed inside a Deployment, Kubernetes continuously restarts the completed container because Deployments expect Pods to remain running. This eventually results in a **CrashLoopBackOff** state.

For this reason, this project focuses on building the infrastructure required for multi-environment deployments while using Nginx as the application under test.

In a real-world production environment:

* **Deployment** → Web Applications, APIs, Nginx
* **Job** → Playwright Test Execution
* **CronJob** → Scheduled Smoke or Regression Tests

This approach keeps the project aligned with Kubernetes best practices while preparing the environments that Playwright can target in future projects.
