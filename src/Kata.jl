module Kata

using Comonicon: @cast, @main

using UUIDs: uuid4

using BioLab

function transplant(st1, st2, de, id_)

    sp1_ = split(st1, de)

    sp2_ = split(st2, de)

    if length(sp1_) != length(sp2_)

        error("Split lengths differ.")

    end

    join((ifelse(id == 1, sp1, sp2) for (id, sp1, sp2) in zip(id_, sp1_, sp2_)), de)

end


const TE = joinpath(dirname(@__DIR__), "TEMPLATE")

function _get_extension(pa)

    splitext(pa)[2]

end

function _get_git_config(ke)

    readchomp(`git config user.$ke`)

end

function _plan_replacement(pa)

    "TEMPLATE" => splitext(basename(pa))[1],
    "GIT_USER_NAME" => _get_git_config("name"),
    "GIT_USER_EMAIL" => _get_git_config("email"),
    "033e1703-1880-4940-9ddc-745bff01a2ac" => uuid4()

end

function _read_kata_json()

    BioLab.Dict.read(joinpath(pwd(), "kata.json"))

end

function rename(di, beaf_)

    for (be, af) in beaf_

        run(pipeline(`find $di -print0`, `xargs -0 rename --subst-all $be $af`))

    end

end

function sed(di, beaf_)

    for (be, af) in beaf_

        run(pipeline(`find $di -type f -print0`, `xargs -0 sed -i "" "s/$be/$af/g"`))

    end

end

"""
Copy from the template and recursively `rename` and `sed`.

# Arguments

  - `name`:
"""
@cast function make(name)

    pa = joinpath(pwd(), name)

    cp("$TE$(_get_extension(pa))", pa)

    re_ = _plan_replacement(pa)

    rename(pa, re_)

    sed(pa, re_)

end

"""
Error if there is any missing path.
And (if necessary) transplant the default texts from the template files.
"""
@cast function format()

    wo = pwd()

    ex = _get_extension(wo)

    te = "$TE$ex"

    re_ = _plan_replacement(wo)

    mi_ = Vector{String}()

    for (ro, di_, fi_) in walkdir(te)

        for na in vcat(di_, fi_)

            ch = joinpath(replace(ro, te => wo), replace(na, re_...))

            if !ispath(ch)

                push!(mi_, ch)

            end

        end

    end

    if !isempty(mi_)

        error(mi_)

    end

    lo = "# $('-' ^ 95) #"

    ho_ = [
        ("LICENSE", "", ()),
        ("kata.json", "", ()),
        ("README.md", "---", (2, 1)),
        (".gitignore", lo, (1, 2)),
    ]

    if ex == ".jl"

        push!(ho_, (joinpath("test", "runtests.jl"), lo, (1, 2)))

    elseif ex == ".pro"

        append!(
            ho_,
            [
                (joinpath("code", "environment.jl"), lo, (1, 2)),
                (joinpath("code", "run.jl"), lo, (1, 2, 1)),
            ],
        )

    end

    for (rl, de, id_) in ho_

        st1 = replace(read(joinpath(te, rl), String), re_...)

        pa2 = joinpath(wo, rl)

        st2 = read(pa2, String)

        if de == ""

            st3 = st1

        else

            st3 = BioLab.String.transplant(st1, st2, de, id_)

        end

        if st2 != st3

            println("Transplanting $pa2")

            write(pa2, st3)

        end

    end

end

"""
Download `kata.json.download`.
"""
@cast function download()

    for (ke, va) in _read_kata_json()["download"]

        pa = joinpath(pwd(), ke)

        if isempty(_get_extension(va))

            run(`aws s3 sync $va $pa`)

        else

            run(`aws s3 cp $va $pa`)

        end

    end

end

"""
Call `kata.json.call` command.

# Arguments

  - `command`:
"""
@cast function call(command)

    run(`sh -c $(_read_kata_json()["call"][command])`)

end

"""
Command-line program for working with GitHub-, Amazon-S3-backed julia packages (.jl) and projects (.pro). Learn more at https://github.com/KwatMDPhD/Kata.jl.
"""
@main

end
