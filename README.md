# prepWBpengyu

The package contains a function for preprocessing World Bank mortality data.

## Main function

The main function is:

`prepare_mortality()`

It:

- reads a World Bank mortality CSV file,
- cleans variable names,
- renames `country_code` to `iso`,
- reshapes year columns from wide to long format,
- keeps observations from 2000 to 2019,
- returns a data frame with `iso`, `year`, and the selected mortality outcome.

## Example data

The package includes the `maternal_mortality` data set as an example data set.
