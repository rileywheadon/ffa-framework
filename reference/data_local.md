# Fetch Local Package Data

Fetch annual maximum series data for a hydrological monitoring station
from the package data directory.

## Usage

``` r
data_local(csv_file)
```

## Arguments

- csv_file:

  A character scalar containing the file name of a local dataset in
  `/inst/extdata`. Must be one of:

  - `"CAN-05BA001.csv"`: BOW RIVER AT LAKE LOUISE

  - `"CAN-05BB001.csv"`: BOW RIVER AT BANFF

  - `"CAN-07BE001.csv"`: ATHABASCA RIVER AT ATHABASCA

  - `"CAN-08MH016.csv"`: CHILLIWACK RIVER AT CHILLIWACK LAKE

  - `"CAN-08NH021.csv"`: KOOTENAI RIVER AT PORTHILL

  - `"CAN-08NM050.csv"`: OKANAGAN RIVER AT PENTICTON

  - `"CAN-08NM116.csv"`: MISSION CREEK NEAR EAST KELOWNA

## Value

A dataframe with two columns:

- `max`: A float, the annual maximum series observation, in m\\^3\\/s.

- `year`: An integer, the corresponding year.

## See also

[`data_geomet()`](https://rileywheadon.github.io/ffa-framework/reference/data_geomet.md)

## Examples

``` r
# Get data for the BOW RIVER AT BANFF (05BB001)
df <- data_local("CAN-05BB001.csv")
```
