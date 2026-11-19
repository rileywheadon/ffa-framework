# Fetch Data from MSC GeoMet API

Gets annual maximum series data for a hydrological monitoring station
from the MSC GeoMet API.

## Usage

``` r
data_geomet(station_id)
```

## Arguments

- station_id:

  A character scalar containing the ID of a hydrological monitoring
  station. You can search for station IDs by name, province, drainage
  basin, and location
  [here](https://wateroffice.ec.gc.ca/search/real_time_e.html).

## Value

A dataframe with two columns:

- `max`: A float, the annual maximum series observation, in m\\^3\\/s.

- `year`: An integer, the corresponding year.

## See also

[`data_local()`](https://rileywheadon.github.io/ffa-framework/reference/data_local.md)

## Examples

``` r
# Get data for the BOW RIVER AT BANFF (05BB001)
df <- data_geomet("05BB001")
```
