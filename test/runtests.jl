using EISCATData
using Test

using TestItems, TestItemRunner
@run_package_tests

@testitem "Code quality (Aqua.jl)" begin
    using Aqua
    Aqua.test_all(EISCATData)
end

@testitem "get_data" begin
    using Dates

    affiliation = name = "EISCATData.jl"

    t0 = DateTime(2020, 12, 9, 18)
    t1 = DateTime(2020, 12, 9, 23)
    data = get_data(t0, t1, 72, :GUISDAP, "60"; clip = true, affiliation, name)
    @test length(data) > 0
end

@testitem "Tromsø Site" begin
    using Dates
    using EISCATData: TRO
    t0 = DateTime(2020, 12, 9, 18)
    t1 = DateTime(2020, 12, 9, 23)
    exps = get_experiments(TRO, t0, t1)
    @test exps[1].id == 100235463
end

@testitem "Longyearbyen Site" begin
    using Dates
    using EISCATData: LYR
    t0 = DateTime(2020, 12, 9, 18)
    t1 = DateTime(2020, 12, 9, 23)
    @test get_experiments(LYR, t0, t1)[1].name == "2020-12-09_ipy@42m"
end
