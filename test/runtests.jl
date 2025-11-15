using EISCATData
using Test
using Aqua

@testset "EISCATData.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(EISCATData)
    end
    # Write your tests here.
end
