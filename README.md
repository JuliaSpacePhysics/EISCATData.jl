# EISCATData

[![DOI](https://zenodo.org/badge/1097475817.svg)](https://doi.org/10.5281/zenodo.17654030)
[![version](https://juliahub.com/docs/General/EISCATData/stable/version.svg)](https://juliahub.com/ui/Packages/General/EISCATData)

Access and process [EISCAT](https://www.wikipedia.org/wiki/EISCAT) incoherent scatter radar data from the [Madrigal database](https://cedar.openmadrigal.org/) (based on [Madrigal.jl](https://github.com/JuliaSpacePhysics/Madrigal.jl)).

## Quick Start

```julia
using Pkg; Pkg.add("EISCATData")
using EISCATData
using Dates

# Download GUISDAP data from Tromsø
site = TRO # or LYR
t0 = DateTime(2020, 12, 9, 18)
t1 = DateTime(2020, 12, 10, 6)
data = get_data(t0, t1, site, :GUISDAP, "60"; clip = true)

# Access variables
data.ne          # Electron density
data.ti          # Ion temperature
data.gdalt       # Altitude
data.ut1_unix    # Unix timestamps
```

## Elsewhere

- [GeospaceLAB](https://github.com/JouleCai/geospacelab): A Python-based framework for data access, analysis, and visualization.