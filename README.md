# Vehicle Damage Assessment — Docker setup

Runs the notebook in JupyterLab, no local Python setup needed.

## Run it

```bash
docker compose up --build
```

First build takes a few minutes (installing opencv + torch/torchvision).
Then open:

```
http://localhost:8888/lab/tree/vehicle_damage_assessment.ipynb
```

No token/password is set, since this is meant for local dev on `localhost`.
Run cells top to bottom — Part A (heuristic demo) works immediately with the
included synthetic test images; Part B (training scaffold) is ready once you
drop a real dataset into `./data` (see the dataset table at the bottom of
the notebook).

## Using your own dataset

1. Download one of the datasets linked at the bottom of the notebook
   (Kaggle requires you to be logged in, so this step is manual).
2. Unzip it into `./data` on your host machine — it's already mounted into
   the container at `/workspace/notebook/data`, so no rebuild needed.
3. In the notebook, uncomment `DATA_ROOT = "data"` in Part B and re-run
   those cells.

## Stopping / cleaning up

```bash
docker compose down          # stop
docker compose up --build    # rebuild after editing requirements.txt or Dockerfile
```

## GPU training (optional)

The image installs CPU-only torch by default. If you have an NVIDIA GPU:

1. Install the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) on your host.
2. In `Dockerfile`, swap the CPU torch install line for the CUDA wheel index
   matching your driver (see https://pytorch.org/get-started/locally/).
3. Uncomment the `deploy.resources.reservations.devices` block in
   `docker-compose.yml`.
4. `docker compose up --build`.

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
