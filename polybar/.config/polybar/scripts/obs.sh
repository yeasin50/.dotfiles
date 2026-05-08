#!/bin/bash

if obs-cli recording status | grep -q "true"; then
  echo "%{F#9ece6a} REC%{F-}"
else
  echo ""
fi
