#!/usr/bin/env bash
set -e

SYSFS_PATH="/sys/module/amdgpu/parameters/cwsr_enable"

echo "[disable-cwsr] Checking AMDGPU CWSR parameter..."

if [ -e "$SYSFS_PATH" ]; then
  CURRENT=$(cat "$SYSFS_PATH")
  if [ "$CURRENT" = "0" ]; then
    echo "[disable-cwsr] CWSR already disabled (amdgpu.cwsr_enable=0)"
  else
    echo "[disable-cwsr] Disabling CWSR (amdgpu.cwsr_enable=0)..."
    if echo 0 > "$SYSFS_PATH" 2>/dev/null; then
      echo "[disable-cwsr] Successfully disabled CWSR."
    else
      echo "[disable-cwsr] ⚠️  Could not write to $SYSFS_PATH (needs privileged mode)."
    fi
  fi
else
  echo "[disable-cwsr] ⚠️  AMDGPU parameter not found: $SYSFS_PATH"
  echo "[disable-cwsr] You may need to load the amdgpu module first."
fi

echo "[disable-cwsr] Continuing startup..."
exec "$@"
