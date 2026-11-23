# qq 的 Claude Code 技能集

**公开仓库**：https://github.com/qq5069099/skills

**仓库根目录下的每个子文件夹就是一个技能**（不额外套 `skills/` 目录）。

| 技能文件夹 | 说明 |
|---|---|
| `game_whiteout_survival` | 无尽冬日 / Whiteout Survival 代练托管（adb 自动化、坐标地图、零氪攻略） |

以后新增技能：在根目录新建 `<前缀>_<名字>/SKILL.md` 即可，例如 `game_xxx`、`tool_xxx`。

## 目录结构
```
skills/                        # 仓库根目录
├─ game_whiteout_survival/
│  ├─ SKILL.md                 # 技能主文件（frontmatter: name/description）
│  ├─ references/              # 坐标表、操作手册、攻略
│  └─ scripts/                 # 辅助脚本
├─ <下一个技能>/
│  └─ SKILL.md
├─ install.ps1                 # Windows 一键链接脚本
├─ install.sh                  # macOS/Linux 一键链接脚本
└─ README.md
```

## 多机安装（git + 链接）
每个技能文件夹通过目录链接放进 `~/.claude/skills/`，改仓库文件立即生效。

1. 克隆仓库到任意固定路径：
   ```bash
   git clone https://github.com/qq5069099/skills.git ~/skills-repo
   ```
2. 运行安装脚本（会给每个含 `SKILL.md` 的根目录子文件夹建链接）：
   Windows PowerShell：
   ```powershell
   powershell -ExecutionPolicy Bypass -File ~/skills-repo/install.ps1
   ```
   macOS / Linux：
   ```bash
   bash ~/skills-repo/install.sh
   ```
3. 以后同步：`cd ~/skills-repo && git pull`（链接指向同一份文件，无需重装）。
4. 新增技能后，重新运行一次安装脚本即可（已存在的链接会跳过）。

## 手动链接（单技能）
Windows：
```bat
mklink /J "%USERPROFILE%\.claude\skills\game_whiteout_survival" "<仓库路径>\game_whiteout_survival"
```
macOS / Linux：
```bash
ln -s <仓库路径>/game_whiteout_survival ~/.claude/skills/game_whiteout_survival
```

## 新增技能约定
- 文件夹名：`<类别前缀>_<英文名>`，小写，如 `game_whiteout_survival`、`tool_pdf_merge`。
- `SKILL.md` frontmatter：
  ```yaml
  ---
  name: <与文件夹同名>
  description: <一句话说明 + 何时使用，写给模型看>
  ---
  ```
- 大段资料放 `references/`，可执行助手放 `scripts/`，在 SKILL.md 末尾列索引。
- commit + push；其他机器 `git pull` 即同步。

## 安全与合规
- 代练技能只做正常点击操作，不注入、不改客户端、不装第三方工具。
- 不花钻石、不充值、不点解散联盟/迁城等破坏性按钮。
- 账号风险由使用者自行承担；建议在可控账号/模拟器上使用。
