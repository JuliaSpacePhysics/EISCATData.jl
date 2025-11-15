using EISCATData
using Documenter

DocMeta.setdocmeta!(EISCATData, :DocTestSetup, :(using EISCATData); recursive=true)

makedocs(;
    modules=[EISCATData],
    authors="Beforerr <zzj956959688@gmail.com> and contributors",
    sitename="EISCATData.jl",
    format=Documenter.HTML(;
        canonical="https://JuliaSpacePhysics.github.io/EISCATData.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaSpacePhysics/EISCATData.jl",
    devbranch="main",
)
