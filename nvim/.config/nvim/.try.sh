:!exa --icons --tree -la | grep -v "│ *[│├└]"
drwxr-xr-x    - vinicius 19 Feb 07:22 .
.rw-r--r--  140 vinicius 30 Oct  2024 ├── .stylua.toml
.rw-r--r--  141 vinicius 19 Feb 07:22 ├── .try.sh
.rw-r--r-- 5.4k vinicius 14 Feb 19:53 ├── init.lua
.rw-r--r-- 4.6k vinicius 19 Jan 13:32 ├── installed.md
.rwxr-xr-x  272 vinicius 14 Feb 19:46 ├── latex_watch.sh
.rw-r--r-- 7.3k vinicius 19 Feb 06:54 ├── lazy-lock.json
drwxr-xr-x    - vinicius 12 Feb 11:59 ├── lua
.rw-r--r--    7 vinicius 30 Oct  2024 ├── nvim.version
.rw-r--r-- 3.1k vinicius 30 Oct  2024 ├── Ollama.md
.rw-r--r-- 6.7k vinicius 30 Oct  2024 ├── README.md
.rw-r--r--  12k vinicius 19 Feb 07:23 └── typescript

:!stdbuf --help
:!unbuffer --help

:!printf '%b\n' "$(script -qc 'exa --icons --tree -la')" 
