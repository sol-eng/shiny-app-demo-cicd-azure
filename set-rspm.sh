#!/usr/bin/env sh
# Point R at Posit Public Package Manager binaries for Ubuntu noble so package
# installs pull prebuilt binaries (fast) instead of compiling from source.
#
# The HTTPUserAgent line is required: Posit Package Manager serves binary
# packages only when the request advertises the R version and platform.

RSPM="https://packagemanager.posit.co/cran/__linux__/noble/latest"

cat >> "$(R RHOME)/etc/Rprofile.site" <<'EOF'
local({
  options(repos = c(RSPM = "https://packagemanager.posit.co/cran/__linux__/noble/latest"))
  options(HTTPUserAgent = sprintf(
    "R/%s R (%s)",
    getRversion(),
    paste(getRversion(), R.version[["platform"]], R.version[["arch"]], R.version[["os"]])
  ))
})
EOF

echo "Configured RSPM binary repo: ${RSPM}"
