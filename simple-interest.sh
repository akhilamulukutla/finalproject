#!/usr/bin/env bash
# simple-interest.sh
# Usage: ./simple-interest.sh PRINCIPAL RATE TIME
#        RATE is annual percentage (e.g., 7 for 7%), TIME in years.
# Example: ./simple-interest.sh 1000 7 2  ->  140.00

set -euo pipefail

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  echo "Usage: $0 PRINCIPAL RATE TIME"
  exit 0
fi

if [ $# -lt 3 ]; then
  echo "Error: provide PRINCIPAL RATE TIME" >&2
  echo "Usage: $0 1000 7 2" >&2
  exit 1
fi

P="$1"; R="$2"; T="$3"

# Basic numeric validation (integers or decimals)
num_re='^-?[0-9]+([.][0-9]+)?$'
for v in "$P" "$R" "$T"; do
  if ! [[ $v =~ $num_re ]]; then
    echo "Error: all inputs must be numbers. Got '$v'." >&2
    exit 1
  fi
done

# Compute Simple Interest: (P * R * T) / 100
SI=$(echo "scale=2; ($P * $R * $T) / 100" | bc -l)
printf "%0.2f\n" "$SI"
