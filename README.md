# 无尽冬日代练技能（winter-survival-autoplay）

一个 Claude Code 技能 + 插件仓库：把「用 adb 代练无尽冬日 / Whiteout Survival」的完整方法沉淀下来——
操作节奏、750×1334 坐标地图、每日优先级、零氪攻略、故障恢复，以及**多机同步**方案。

## 目录结构
```
.claude-plugin/
  plugin.json          # 插件清单
  marketplace.json     # 市场清单（仓库本身即市场）
skills/winter-survival-autoplay/
  SKILL.md             # 技能主文件
  references/
    coordinates.md     # 坐标表（750x1334 基准，自动缩放）
    ops-playbook.md    # 详细操作流程/校准/恢复
    game-meta.md       # 网络高赞攻略整合（含出处）
  scripts/winter.sh    # adb 助手（自动缩放坐标）
```

## 本机安装（免插件，最快）
把技能目录链接进 Claude Code 的技能目录：

Windows（cmd，管理员不必要）：
```bat
mklink /J "%USERPROFILE%\.claude\skills\winter-survival-autoplay" "<本仓库路径>\skills\winter-survival-autoplay"
```
macOS / Linux：
```bash
ln -s <本仓库路径>/skills/winter-survival-autoplay ~/.claude/skills/winter-survival-autoplay
```
之后在本仓库 `git pull`，技能即更新（链接指向同一份文件）。

## 多台机器共享（推荐：插件市场）
1. 把本仓库推到 GitHub（私有仓库即可）：
   ```bash
   git init && git add -A && git commit -m "init winter-survival-autoplay skill"
   gh repo create winter-survival-skill --private --source . --push
   ```
2. 每台机器的 Claude Code 里：
   ```
   /plugin marketplace add <你的GitHub用户名>/winter-survival-skill
   /plugin install winter-survival-autoplay@winter-survival-skills
   ```
3. **一处修改，多处同步**：在任意一台改文件 → `git commit && git push`；
   其他机器 `/plugin update winter-survival-autoplay@winter-survival-skills`
   （或在 /plugin 界面开启自动更新）。

## 备选同步方案
- **私有 Git + 手动 pull**：每台机器 clone 到固定路径，`git pull` 即同步（适合不想用插件市场）。
- **云盘/同步盘**（OneDrive/iCloud/Syncthing）：把仓库放同步目录，各机器用软链指向。
- 不推荐直接复制：多份副本会漂移，失去「一处修改」。

## 使用
在 Claude Code 里说：「用无尽冬日技能代练，先把每日任务清了」。
技能会：
1. 读 `SKILL.md` 的安全红线与优先级；
2. 用 `scripts/winter.sh` 截图 → 点击 → 验证；
3. 按 `references/` 的坐标与攻略推进；
4. 每轮结束记录进度。

## 换机器/换分辨率
1. 改 `ADB` 与 `SERIAL`（见 SKILL.md §2）。
2. 首次运行做校准（ops-playbook.md §0）：`./winter.sh size` + 截图核对锚点。
3. 非 750×1334 分辨率由脚本自动换算；若 UI 布局变化，更新 `references/coordinates.md` 后 push。

## 安全与合规
- 只做正常点击操作，不注入、不改客户端、不装第三方工具。
- 不花钻石、不充值、不点解散联盟/迁城等破坏性按钮。
- 账号风险由使用者自行承担；建议在模拟器小号/可控账号上使用。
