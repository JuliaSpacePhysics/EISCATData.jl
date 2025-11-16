# http://supermag.jhuapl.edu/mag/?tab=stationinfo
# https://github.com/JouleCai/geospacelab/blob/master/geospacelab/datahub/sources/supermag/SuperMAG_stations.dat

struct EISCATSite
    kinst::Int
    name::String
    category::String
    lat::Float64
    lon::Float64
    alt::Float64
    contact::String
    email::String
    mnemonic::Symbol
end

const TRO = EISCATSite(72, "EISCAT Tromsø UHF IS radar", "Incoherent Scatter Radars", 69.583, 19.21, 0.03, "Ingemar Häggström", "ingemar@eiscat.se", :tro)
const LYR = EISCATSite(95, "EISCAT Svalbard IS Radar Longyearbyen", "Incoherent Scatter Radars", 78.09, 16.02, 0.434, "Ingemar Häggström", "ingemar@eiscat.se", :lyr)

Madrigal.kinst(s::EISCATSite) = s.kinst
