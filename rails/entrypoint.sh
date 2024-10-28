#!/bin/bash
set -e

# railsのサーバーファイルtmp/pids/server.pidの削除を行うコマンド
rm -f /app/tmp/pids/server.pid

exec "$@"
