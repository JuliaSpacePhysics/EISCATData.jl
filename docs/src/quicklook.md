# Quicklook Example

This example demonstrates downloading and visualizing EISCAT data from the Madrigal database.

## Load Data

Download GUISDAP data from Tromsø for December 9-10, 2020:

```@example quicklook
using EISCATData
using Dates
t0 = DateTime(2020, 12, 9, 18)
t1 = DateTime(2020, 12, 10, 6)
kinst = :tro              # Tromsø radar
kindat = :GUISDAP         # Analysis method
modulation = "60"         # Pulse code
vars = (:ne, :ti, :tr, :vo, :gdalt)
res = get_data(t0, t1, kinst, kindat, modulation, vars; clip = true)
te = res.ti .* res.tr     # Electron temperature
```

The returned data contains:

- `res.times`: Time axis (UTC)
- `res.gdalt`: Geodetic altitude (height, km)
- `res.ne`: Electron density (cm⁻³)
- `res.ti`: Ion temperature (K)
- `res.tr`: Temperature ratio (Te/Ti)
- `res.vo`: Line of sight ion velocity (pos = away, km/s)

## Visualize with Makie

Create altitude-time plots for density, temperatures, and velocity:

```@example quicklook
using CairoMakie

const x = unix2datetime.(res.ut1_unix)
const y = res.gdalt
const colorranges = (
    (9.0e9, 1.1e12),
    (0, 3200),
    (0, 2600),
    (-420, 420),
)
const names = (L"n_e \, (cm^{-3})", L"T_e \, (K)", L"T_i \, (K)", L"v_i \, (m/s)")
let vars = (res.ne, te, res.ti, res.vo), colormap = :rainbow_bgyrm_35_85_c69_n256
    z = zeros(size(x))
    f = CairoMakie.Figure(; size = (600, 600))
    shading = NoShading
    for (i, var) in enumerate(vars)
        colorrange = colorranges[i]
        colorscale = colorrange[1] > 0 ? log10 : identity
        ax = Axis(f[i, 1], ylabel = "Altitude (km)")
        plot = Makie.surface!(ax, x, y, z; color = var, colorrange, colorscale, shading, colormap)
        Makie.Colorbar(f[i, 2], plot; label = names[i])
        ylims!(70, 500)
        i != length(vars) && Makie.hidexdecorations!(ax; grid = false)
    end
    rowgap!(f.layout, 8)
    f
end
```

## Alternative: PythonPlot

You can also use [`PythonPlot`](https://github.com/JuliaPy/PythonPlot.jl) for visualization:

```@example quicklook
using PythonPlot
using PythonCall
@py import cmap: Colormap

let vars = (res.ne, te, res.ti, res.vo), colors = PythonPlot.colorsm, cmap = Colormap("colorcet:CET_R1").to_mpl()
    fig, axs = PythonPlot.subplots(length(vars), 1, figsize = (10, 10))
    # plot the electron density, temperature, and velocity in three subplots
    norms = (
        colors.LogNorm(1.0e10, 1.0e12),
        colors.Normalize(0, 3200),
        colors.Normalize(0, 2500),
        colors.Normalize(-400, 400),
    )
    for (i, var) in enumerate(vars)
        ax = axs[i - 1]
        p = ax.pcolormesh(x, y, var; cmap, norm = norms[i])
        cbar = fig.colorbar(p, ax = ax)
        ax.set_ylim(nothing, 500)
    end
    gcf()
end
```