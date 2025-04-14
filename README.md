# 📦 Prometheus Operator CRDs minified

This repository provides a **temporary workaround** for merging all Prometheus Operator CRDs into a single file.

We also generate a **minified version** of the merged CRDs, which removes `.description` and `.metadata.creationTimestamp` fields to reduce size. While this breaks compatibility with tools like `kubectl explain`, it serves as an effective workaround for [this known Helm chart issue](https://github.com/prometheus-community/helm-charts/issues/1500#issuecomment-1065572519).

---

## 🛠️ Why This Exists

The upstream [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) Helm chart expects CRDs to be applied in a certain way, but doesn't provide a slimmed-down single file for all of them. This utility helps:

- Merge CRDs from a specific Prometheus Operator release
- Minify them for Helm chart compatibility
- Track and version these CRDs in Git

---

## 🚀 Usage

### 🔧 Prerequisites

- `yq` installed (`v4.x`)
- `git` installed
- `make` (optional but recommended)

---

### ✅ One-Line Command

Use `make` to generate and commit CRDs:

```bash
make generate-crds VERSION=v0.81.0
```
---

### 🧰 Manual Steps

If you'd rather run it manually:

```bash
# Clone the repo and run the helper script manually
./generate-crds.sh v0.81.0
```

---

## 📁 Output

After running the script, you'll get:

- `prometheus-operator-crds-v0.81.0.yaml`: full merged CRDs
- `prometheus-operator-crds-v0.81.0-minified.yaml`: minified CRDs (safe for use in Helm)

These are committed on a new Git branch named after the Prometheus Operator version.

---

## 📎 Related

- [Prometheus Operator CRDs](https://github.com/prometheus-operator/prometheus-operator)
- [Helm Chart Issue #1500](https://github.com/prometheus-community/helm-charts/issues/1500)