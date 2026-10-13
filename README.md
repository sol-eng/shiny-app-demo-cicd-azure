# Deploy to Posit Connect from Azure Pipelines

An example of programmatic deployment: an Azure Pipeline that builds and deploys a Shiny application
to [Posit Connect](https://posit.co/products/enterprise/connect/).

The pipeline (`azure-pipelines.yml`) installs the app's R package dependencies from
[Posit Package Manager](https://packagemanager.posit.co/), runs a fast unit-test gate over the
app's data functions (`run-tests.R` — a failing test aborts the pipeline before any deploy), writes
a `manifest.json` with `rsconnect::writeManifest()`, and deploys the bundle through the Connect
Server API with `deploy-to-connect.sh`.

> **Why this example lives on GitHub.** Azure DevOps public projects are retired, so a public Azure
> DevOps project can no longer host a customer-facing example. This public example therefore lives on
> GitHub; the pipeline is validated by a private Azure DevOps project that builds against this repo.

## Setup

In Azure DevOps, create a variable group named **`RSC`** (**Pipelines > Library**) and add
(mark `CONNECT_API_KEY` as a secret so it is never printed or stored in the repo):

| Variable | Value |
|----------|-------|
| `CONNECT_SERVER` | Your Connect base URL, with a trailing slash (e.g. `https://connect.example.com/`) |
| `CONNECT_API_KEY` | A Connect API key owned by a publisher account (secret) |

Point a pipeline at `azure-pipelines.yml`. The content item is created automatically on the first run
and updated on subsequent runs.

> Part of the Posit Connect CI/CD examples. Companion repositories cover GitLab CI/CD, Jenkins,
> Bitbucket Pipelines, and GitHub Actions.
