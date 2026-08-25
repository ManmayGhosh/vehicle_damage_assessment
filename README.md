# Vehicle Damage Assessment — Docker setup

Runs the notebook in JupyterLab, no local Python setup needed.

## Run it

```bash
docker compose up --build
```

First build takes a few minutes 
## Using your own dataset

1. Download one of the datasets from Kaggle.

## Files

```
.
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
├── notebook/
│   └── vehicle_damage_assessment.ipynb
└── data/                      # you create this — see "Using your own dataset"
```
