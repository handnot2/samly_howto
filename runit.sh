#!/bin/sh

HOST="${HOST:-samly.howto}" \
PORT="${PORT:-4003}" \
MIX_ENV=dev \
  iex -S mix phx.server
