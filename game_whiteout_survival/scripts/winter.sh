#!/usr/bin/env bash
# 无尽冬日 adb 助手（跨机器通用）
# 用法：
#   export ADB="/path/to/adb"      # 或 "adb"
#   export SERIAL=emulator-5554    # 可省略（只有一台设备时）
#   ./winter.sh shot out.png       # 截图
#   ./winter.sh tap 375 1050 2     # 按 750x1334 坐标连点2次（自动缩放）
#   ./winter.sh hold 375 1230 1500 # 长按1500ms
#   ./winter.sh sw 100 800 600 800 300  # 滑动
#   ./winter.sh key 4              # 按键（4=BACK）
#   ./winter.sh text hello         # 输入文本
#   ./winter.sh batch "input keyevent 4; sleep 1"  # 原生命令
#   ./winter.sh size               # 打印分辨率
#   ./winter.sh connect 127.0.0.1:16384
# 坐标基准 750x1334；其他分辨率自动按 wm size 缩放。
set -e

ADB_BIN="${ADB:-adb}"
SERIAL="${SERIAL:-}"
ADB=("$ADB_BIN")
[ -n "$SERIAL" ] && ADB+=(-s "$SERIAL")

get_size() {
  if [ -z "${SIZE:-}" ]; then
    SIZE=$("${ADB[@]}" shell wm size 2>/dev/null | sed -n 's/.*: *//p' | tail -1)
  fi
  W="${SIZE%%x*}"
  H="${SIZE##*x}"
  if ! [[ "$W" =~ ^[0-9]+$ && "$H" =~ ^[0-9]+$ ]]; then
    W=750; H=1334
  fi
}

sx() { awk -v v="$1" -v W="$W" 'BEGIN{printf "%d", (v*W/750)+0.5}'; }
sy() { awk -v v="$1" -v H="$H" 'BEGIN{printf "%d", (v*H/1334)+0.5}'; }

cmd="${1:-help}"; shift || true

case "$cmd" in
  connect) "$ADB_BIN" connect "$1" ;;
  size)    get_size; echo "${W}x${H}" ;;
  shot|pull)
    get_size
    f="${1:-latest.png}"
    "${ADB[@]}" exec-out screencap -p > "$f"
    echo "saved $f (${W}x${H})" ;;
  tap)
    get_size
    x=$(sx "$1"); y=$(sy "$2"); n="${3:-1}"
    s=""
    for i in $(seq 1 "$n"); do s="$s input touchscreen swipe $x $y $x $y 80; sleep 0.4;"; done
    "${ADB[@]}" shell "$s" ;;
  hold)
    get_size
    x=$(sx "$1"); y=$(sy "$2"); ms="${3:-1000}"
    "${ADB[@]}" shell input touchscreen swipe "$x" "$y" "$x" "$y" "$ms" ;;
  sw)
    get_size
    x1=$(sx "$1"); y1=$(sy "$2"); x2=$(sx "$3"); y2=$(sy "$4"); ms="${5:-300}"
    "${ADB[@]}" shell input touchscreen swipe "$x1" "$y1" "$x2" "$y2" "$ms" ;;
  key)  "${ADB[@]}" shell input keyevent "$1" ;;
  text) "${ADB[@]}" shell input text "$1" ;;
  batch) "${ADB[@]}" shell "$1" ;;
  *)
    sed -n '2,30p' "$0" ;;
esac
