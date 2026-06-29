# Global Harmonised Layers (GHL)

Global Harmonised Layers is a "Screening Grade" suite of 30 m resolution land cover, deforestation, and aboveground forest carbon maps. The layers are harmonised in the sense that they are on a common grid, target a common year, and are thematically consistent i.e. only forest land cover classes have forest carbon greater than zero, and recently deforested areas are not classified as forest.

This product is derived from multiple open datasets.

## Spatial Coverage
Global terrestrial coverage at (EPSG:4326, ~30 m pixels). 

![Spatial Coverage](https://spaceintelliexternal.blob.core.windows.net/public/static/earthmover/ghl/spatial_extent.png)

## Temporal Coverage

Maps are available from 2024 onwards. Historical deforestation is included from 2011. 
The 2024 maps nominally target 1st January 2024. There was a method change for 2025 and later maps which instead target year end e.g. the 2025 data nominally targets 31st December 2025.

The "current year-2" maps are available here. Please contact Space Intelligence if you are interested in licensing more recent data.

## Updates

Annual updates are published around June. Each update prioritizes fit-for-purpose maps for that year and depends on what is available in the wider data ecosystem at that time. These updates will involve changes to input sources and processing methods. Older years will not be systematically reprocessed therefore there should be no expectation of a stable time series.

## Data Variables

### `land_cover` (categorical, uint8)

A 10-class land cover map. Pixel values identify the dominant land cover type within each 30 m pixel.

![Land Cover](https://spaceintelliexternal.blob.core.windows.net/public/static/earthmover/ghl/land_cover.png)


| Value | Class | Description |
|-------|-------|-------------|
| 1 | Tree cover | Land with tree canopy cover >10%, not mangrove or plantation |
| 2 | Mangrove | Areas of mangrove |
| 3 | Plantation | Tree crop and timber plantations |
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

![Deforestation](https://spaceintelliexternal.blob.core.windows.net/public/static/earthmover/ghl/deforestation.png)

| Value | Description |
|-------|-------------|
| 0     | No deforestation observed since 2011 |
| 11+   | Year of deforestation (e.g. 23 = deforested in 2023) |
| 255   | Nodata — outside mapped extent |

### `forest_carbon` (tC/ha, uint16)

Estimated aboveground forest carbon (AGC), in tonnes of carbon per hectare. Values range from 0 to ~660 tC/ha.

![Forest Carbon](https://spaceintelliexternal.blob.core.windows.net/public/static/earthmover/ghl/forest_carbon.png)

| Value | Description                               |
|-------|-------------------------------------------|
| 0 | No aboveground forest carbon (<0.5 tC/ha) |
| 1–660 | Carbon density in tC/ha (integer-rounded) |
| 65535 | Nodata — outside mapped extent            |

## Use Cases

**Appropriate uses:**
- Orienting and contextualising nature-based solutions projects (REDD+, ARR, IFM, agriculture) within their landscape
- Confirming broad land cover and carbon storage of a project area
- Targeting suitable areas for new projects — e.g. non-forest areas with no recent deforestation (suitable for ARR)
- Assessing deforestation rates and trends at district or regional scale

**Not appropriate for:**
- Precise carbon storage numbers for comparison against issued carbon credits
- Precise forest area figures to compare against project documents — these layers do not follow country- or project-specific forest definitions
- Creating alternative baselines to those from a project (e.g. assessing overcrediting in a REDD+ project)

## Data access

```python
from arraylake import Client
import xarray as xr

client = Client()
repo = client.get_repo("space-intelligence/ghl")
session = repo.readonly_session("main")
store = session.store
ds = xr.open_dataset(store, engine="zarr")
ds
```

## Licence

Licensed under CC-BY-NC-SA-4.0

## Acknowledgements

Please cite Space Intelligence:

> Global Harmonised Layers (GHL), Space Intelligence (https://www.space-intelligence.com), Licensed under CC-BY-NC-SA-4.0

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
