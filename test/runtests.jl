using EISCATData
using Test
using Aqua

@testset "EISCATData.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(EISCATData)
    end
    # Write your tests here.
end

@testset "get_data" begin
    using EISCATData
    using Dates

    affiliation = name = "EISCATData.jl"
    
    t0 = DateTime(2020, 12, 9, 18)
    t1 = DateTime(2020, 12, 9, 23)
    data = get_data(t0, t1, 72, :GUISDAP, "60"; clip = true, affiliation, name)
    @test length(data) > 0
end
