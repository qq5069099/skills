# qq 的 Claude Code 技能集

**公开仓库**：https://github.com/qq5069099/skills

一个仓库装多个技能，**每个技能是 `skills/` 下的一个子文件夹**。目前包含：

| 技能 | 说明 |
|---|---|
| `winter-survival-autoplay` | 无尽冬日 / Whiteout Survival 代练托管（adb 自动化、坐标地图、零氪攻略） |

以后新增技能直接加子文件夹即可，无需改仓库结构。

## 目录结构
```
skills/
├─ winter-survival-autoplay/
│  ├─ SKILL.md            # 技能主文件（frontmatter + 流程）
│  ├─ references/         # 坐标表、操作手册、攻略
│  └─ scripts/            # 辅助脚本
└─ <下一个技能>/
   └─ SKILL.md
.claude-plugin/
├─ plugin.json            # 插件清单：qq-skills
└─ marketplace.json       # 市场清单：qq-skills
README.md
```

## 安装（推荐：插件市场）
在 Claude Code 中：
```
/plugin marketplace add qq5069099/skills
```
```
/plugin install qq-skills@qq-skills
```
装一次即包含仓库内全部技能；以后新增技能也会随插件更新。

## 多机同步（一处修改，多处生效）
1. 任意一台机器修改 `skills/<技能>/` 里的文件；
2. `git add -A && git commit -m "..." && git push`；
3. 其他机器 `/plugin update qq-skills@qq-skills`（或在 /plugin 界面开启自动更新）。

## 新增技能
1. 新建 `skills/<技能名>/SKILL.md`，frontmatter 至少写 `name` 和 `description`；
2. 需要的话加 `references/`、`scripts/`；
3. commit + push；
4. 其他机器 `/plugin update qq-skills@qq-skills`。

## 本机免插件方式（调试用）
Windows（cmd）：
```bat
mklink /J "%USERPROFILE%\.claude\skills\winter-survival-autoplay" "<仓库路径>\skills\winter-survival-autoplay"
```
macOS / Linux：
```bash
ln -s <仓库路径>/skills/winter-survival-autoplay ~/.claude/skills/winter-survival-autoplay
```
改仓库文件立即生效。

## 各技能说明
见对应子文件夹的 `SKILL.md` 与 `references/`。

## 安全与合规
- 代练技能只做正常点击操作，不注入、不改客户端、不装第三方工具。
- 不花钻石、不充值、不点解散联盟/迁城等破坏性按钮。
- 账号风险由使用者自行承担；建议在可控账号/模拟器上使用。
