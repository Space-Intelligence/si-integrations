# Global Harmonised Layers (GHL)

Space Intelligence's Global Harmonised Layers provide a consistent, analysis-ready suite of 30 m resolution maps covering land cover, historical deforestation, and aboveground forest carbon storage. The layers are harmonised in the sense that they are on a common grid, target a common year, and are thematically consistent e.g., only forest land cover classes have forest carbon greater than zero, and recently deforested areas are not classified as forest.

Global terrestrial coverage at (EPSG:4326, ~30 m resolution), and is updated annually.

## Data Variables

### `land_cover` (categorical, uint8)
A 10-class land cover map for 2024. Pixel values identify the dominant land cover type within each 30 m pixel.

| Value | Class | Description |
|-------|-------|-------------|
| 1 | Tree cover | Land with tree canopy cover >10%, not mangrove or plantation |
| 2 | Mangrove | Areas of mangrove |
| 3 | Plantation | Tree crop and timber/lumber plantations |
| 4 | Grassland/shrubland | Shrubland or grassland; tree canopy cover <10% if present |
| 5 | Cropland | Herbaceous crops |
| 6 | Built-up | Bare urban or built surfaces; roads |
| 7 | Bare/sparse vegetation | Vegetation covering <10% of pixel; not snow or ice |
| 8 | Snow/ice | Land permanently covered in snow or ice |
| 9 | Water | Permanent water bodies — rivers, lakes, and seas |
| 10 | Flooded non-forest vegetation | Permanently or near-permanently flooded vegetation, <10% tree canopy cover |
| 255 | Nodata | Outside mapped extent |

### `deforestation` (year of loss, uint8)
A record of historical deforestation since 2011. Pixel values indicate the two-digit year in which forest loss occurred. A value of 0 means no deforestation has been observed since 2011.

| Value | Description |
|-------|-------------|
| 0 | No deforestation observed since 2011 |
| 11–24 | Year of deforestation (e.g. 23 = deforested in 2023) |
| 255 | Nodata — outside mapped extent |

### `forest_carbon` (tC/ha, uint16)
Per-pixel estimated forest aboveground carbon (AGC) for 2024, in tonnes of carbon per hectare. Values range from 0 to ~660 tC/ha.

| Value | Description                               |
|-------|-------------------------------------------|
| 0 | No aboveground forest carbon (<0.5 tC/ha) |
| 1–660 | Carbon density in tC/ha (integer-rounded) |
| 65535 | Nodata — outside mapped extent            |

## Use Cases

**Appropriate uses:**
- Orienting and contextualising nature-based solutions projects (REDD+, ARR, IFM, agriculture) within their landscape
- Confirming broad land cover, land cover history, and carbon storage of a project area
- Targeting suitable areas for new projects — e.g. non-forest areas with no recent deforestation (suitable for ARR)
- Assessing deforestation rates and trends at district or regional scale

**Not appropriate for:**
- Precise carbon storage numbers for comparison against issued carbon credits
- Precise forest area figures to compare against project documents — these layers do not follow country- or project-specific forest definitions
- Creating alternative baselines to those from a project (e.g. assessing overcrediting in a REDD+ project)

## Reading the Data

The data is distributed as an IceChunk store on Azure Blob Storage, accessible as a Zarr-backed xarray Dataset.

```python
import icechunk as ic
import xarray as xr

repo = ic.Repository.open(storage)
ds = xr.open_dataset(
    repo.readonly_session("main").store,
    engine="zarr",
    consolidated=False,
)

# Subset to an area of interest and a specific year
aoi = ds.sel(x=slice(-80, -70), y=slice(10, 0), year=2024)
aoi["land_cover"].plot.imshow()
```

## Licence

CC-BY-NC-4.0
## Acknowledgements

This dataset is built upon open datasets that carry attribution requirements. When redistributing or publishing results derived from this product, the following attribution text must be included:

> This product contains modified data from the following datasets:
>
> - **ESA WorldCover** (https://esa-worldcover.org/) — Contains modified Copernicus Sentinel data (2021) processed by ESA WorldCover consortium. Licensed under CC BY 4.0.
> - **Dynamic World** (https://dynamicworld.app) — Produced for the Dynamic World Project by Google in partnership with National Geographic Society and the World Resources Institute. Licensed under CC BY 4.0.
> - **Impact Observatory LULC Maps for Good** (https://docs.impactobservatory.com/lulc-maps/maps-for-good.html) — By Impact Observatory and Esri. Licensed under CC BY 4.0.
> - **Global Forest Watch Spatial Database of Planted Trees (SDPT) v2.0** — Harris, N., E. Goldman and S. Gibbes. Accessed through Global Forest Watch (www.globalforestwatch.org) in 2024. Licensed under CC BY 4.0.
> - **Hansen Forest Loss** — Hansen/UMD/Google/USGS/NASA (https://data.globalforestwatch.org/documents/941f17325a494ed78c4817f9bb20f33a/explore). Licensed under CC BY 4.0.
> - **JRC Tropical Moist Forest Loss** — European Commission Joint Research Centre. Openly available under the Copernicus regulation of the European Union.
> - **Global Mangrove Watch Mangrove Extent** — ALOS Science Project, JAXA (https://www.eorc.jaxa.jp/ALOS/en/dataset/gmw_e.htm). Licensed under CC BY 4.0.
> - **ESA Biomass CCI v4 (2020)** — ESA Biomass Climate Change Initiative: Global datasets of forest above-ground biomass for the years 2010, 2017, 2018, 2019 and 2020. Licensed under https://artefacts.ceda.ac.uk/licences/specific_licences/esacci_biomass_terms_and_conditions_v2.pdf.
> - **Carbon Pools across CONUS using the MaxEnt Model** — Yu, Y., et al. 2021. ORNL DAAC, Oak Ridge, Tennessee, USA. Attribution: NASA. Used under the NASA ESDIS free and open data terms (https://www.earthdata.nasa.gov/learn/use-data/data-use-policy).
> - **Canada Forest Total Aboveground Biomass 2015** — Matasci et al., 2018. *Remote Sensing of Environment* 216, 697–714. Used under the Open Government Licence – Canada.
> - **Avitabile et al. Forest Biomass** — Used with permission (https://www.wur.nl/en/research-results/chair-groups/environmental-sciences/laboratory-of-geo-information-science-and-remote-sensing/research/integrated-land-monitoring/forest_biomass.htm).
> - **African Savannahs and Woodlands Biomass Map** — Bouvet et al. *Remote Sensing of Environment* (https://www.sciencedirect.com/science/article/pii/S0034425717306053). Used with permission.
> - **Global Mangrove Distribution, Aboveground Biomass, and Canopy Height** — Simard et al. 2019. ORNL DAAC, Oak Ridge, Tennessee, USA. Used in accordance with the EOSDIS Data Use Policy (https://daac.ornl.gov/cgi-bin/dsviewer.pl?ds_id=1665).
> - **Global Oil Palm Extent and Planting Year 1990–2021** — Descals, Adrià. Zenodo (https://zenodo.org/records/13379129). Licensed under CC BY 4.0.
> - **High-Resolution Global Map of Closed-Canopy Coconut Palm** — Descals et al. Licensed under CC BY 4.0.
