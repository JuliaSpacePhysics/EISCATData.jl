module EISCATData
using Madrigal
using HDF5: h5open
using FieldViews: FieldViewable
using Dates: unix2datetime
using Match: @match

const EISCAT_SERVER = "http://madrigal.eiscat.se"

export get_data

default_vars() = (:gdalt, :ne, :ti, :tr)

_kindat(i) = i
_kindat(s::Symbol) = @match s begin
    :GUISDAP => 6400
    _ => throw(ArgumentError("Unknown kindat: $s"))
end

"""
    get_data(tstart, tend, kinst, kindat, mod, vars = nothing; tvars = (:ut1_unix, :ut2_unix), clip = false, kw...)

Download and process EISCAT data from the Madrigal database, given the time range, instrument code `kinst`, kind of data file code `kindat`, and modulation `mod`.

Set `clip = true` to clip data to the exact time range. Additional keyword arguments are passed to `download_file`.
"""
function get_data(tstart, tend, kinst, kindat, mod, vars = nothing; tvars = (:ut1_unix, :ut2_unix), clip = false, kw...)
    vars = @something vars default_vars()
    exp_files = filter!(get_instrument_files(kinst, _kindat(kindat), tstart, tend)) do file
        contains(file.name, mod)
    end
    paths = download_file.(exp_files; kw...)
    out = load(sort!(paths), (vars..., tvars...))
    return process_data(out, times(out, tvars), tstart, tend; clip)
end

function times(out, tvars)
    tstarts = out[tvars[1]] |> unique
    tendinds = out[tvars[2]] |> unique
    x = @. tstarts + (tendinds - tstarts) / 2
    eltype(x) <: AbstractFloat && return unix2datetime.(x)
    return x
end

function process_data(out, times, tstart, tend; clip = false)
    Nt = length(times)
    new_out = map(out) do var
        reshape(var, :, Nt)
    end
    new_out = (new_out..., times = times)
    return if clip
        tind = findfirst(t -> t >= tstart, times)
        tendind = findlast(t -> t < tend, times)
        map(new_out) do var
            selectdim(var, ndims(var), tind:tendind)
        end
    else
        new_out
    end
end

function load(paths, vars)
    fids = h5open.(paths)
    tbls = read.(fids, "Data/Table Layout")
    dfvs = FieldViewable.(tbls)
    out = read_table_columns(dfvs, vars)
    close.(fids)
    return out
end

function read_table_columns(dfvs, columns)
    nt = NamedTuple{Tuple(columns)}
    data = map(columns) do col
        mapreduce(vcat, dfvs) do dfv
            getproperty(dfv, col)
        end
    end
    return nt(data)
end

end
