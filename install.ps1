# 把仓库根目录下每个含 SKILL.md 的子文件夹链接到 ~/.claude/skills
# 用法：powershell -ExecutionPolicy Bypass -File install.ps1
$ErrorActionPreference = "Stop"
$repo = $PSScriptRoot
$dest = Join-Path $env:USERPROFILE ".claude\skills"
New-Item -ItemType Directory -Force -Path $dest | Out-Null

Get-ChildItem -Directory $repo | Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") } | ForEach-Object {
    $src = $_.FullName
    $link = Join-Path $dest $_.Name
    if (Test-Path $link) {
        $item = Get-Item $link -Force
        if ($item.LinkType) {
            # 只删除链接本身，不动源目录
            cmd /c rmdir "`"$link`"" | Out-Null
        } else {
            Write-Warning "已存在非链接目录，跳过：$link"
            return
        }
    }
    New-Item -ItemType Junction -Path $link -Target $src | Out-Null
    Write-Host "已链接：$($_.Name)  ->  $src"
}
Write-Host "完成。技能目录：$dest"
