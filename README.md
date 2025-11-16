# EISCATData

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://JuliaSpacePhysics.github.io/EISCATData.jl/dev/)
[![Build Status](https://github.com/JuliaSpacePhysics/EISCATData.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaSpacePhysics/EISCATData.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/JuliaSpacePhysics/EISCATData.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/JuliaSpacePhysics/EISCATData.jl)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

Access and process [EISCAT](https://www.wikipedia.org/wiki/EISCAT) incoherent scatter radar data from the [Madrigal database](https://cedar.openmadrigal.org/).

## Quick Start

```julia
using EISCATData
using Dates

# Download GUISDAP data from Tromsø
t0 = DateTime(2020, 12, 9, 18)
t1 = DateTime(2020, 12, 10, 6)
data = get_data(t0, t1, :tro, :GUISDAP, "60"; clip = true)

# Access variables
data.ne          # Electron density
data.ti          # Ion temperature
data.gdalt       # Altitude
data.ut1_unix    # Unix timestamps
```

## Features and Roadmap

- [x] Download and load EISCAT data from Madrigal servers

## Elsewhere

- [GeospaceLAB](https://github.com/JouleCai/geospacelab): A Python-based framework for data access, analysis, and visualization.