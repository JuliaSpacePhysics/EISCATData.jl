using EISCATData
using Documenter

DocMeta.setdocmeta!(EISCATData, :DocTestSetup, :(using EISCATData); recursive=true)

makedocs(;
    modules=[EISCATData],
    authors="Zijin Zhang <zijin@ucla.edu> and contributors",
    sitename="EISCATData.jl",
    format=Documenter.HTML(;
        canonical="https://JuliaSpacePhysics.github.io/EISCATData.jl",
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaSpacePhysics/EISCATData.jl",
    push_preview = true
)
