Terminal > Settings... > Profiles > Import `setting/terminal/*`

```bash
ln -s $(pwd)/setting/zshrc.sh ~/.zshrc

mkdir -p ~/.config/nvim

ln -s $(pwd)/setting/init.lua ~/.config/nvim

mkdir -p ~/.julia/config

ln -s $(pwd)/setting/startup.jl ~/.julia/config

ln -s $(pwd)/setting/JuliaFormatter.toml ~/.JuliaFormatter.toml
```

```bash
brew install watch tree rename neovide luarocks ripgrep screen shfmt node yarn exiftool imagemagick
```

```bash
npm --global uninstall corepack

npm --global install http-server prettier prettier-plugin-tailwindcss prettier-plugin-toml prettier-plugin-sh @prettier/plugin-lua
```

```bash
git config --global user.name "KwatMDPhD"

git config --global user.email "kwat.me@icloud.com"

git config --global credential.helper osxkeychain

git config --global fetch.prune true

git config --global pull.rebase true

git config --global status.submoduleSummary true

git config --global diff.submodule log

git config --global diff.colorMoved zebra

git config --global http.postBuffer 524288000
```

```julia
using Pkg: add

for pa in ("BenchmarkTools", "Logging", "Revise")

    add(pa)

end
```

```bash
brew install pyenv

pyenv install 3.13.2

pyenv global 3.13.2

pip install ipython virtualenv
```

```bash
brew update

brew upgrade

brew doctor

brew cleanup

npm --global upgrade

julia --eval "using Pkg: update; update()"
```
