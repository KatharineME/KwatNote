Command-line program for working with GitHub-, Amazon-S3-backed julia packages (.jl) and projects (.pro) 🥋.

## Install

```bash
git clone https://github.com/KwatMDPhD/Kata.jl &&

cd Kata.jl &&

julia --project --eval "using Pkg; Pkg.instantiate()" &&

julia --project deps/build.jl
```

☝️ commands install `kata` into `~/.julia/bin`. If not already, add it to the path

```bash
PATH=~/.julia/bin:$PATH
```

Test installation

```bash
kata --version
```

🎉

## Use

```bash
kata --help
```

---

Powered by https://github.com/KwatMDPhD/Kata.jl 🥋.
