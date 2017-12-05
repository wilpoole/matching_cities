matching_geos Version 0.1 13-11-2017

Description
  Script to match cities across DCM and Adwords based on names and impression
  counts from previous campaign delivery

Getting Started
  The matching_geos.r script runs the code to process the data.
  Data must be stored in the 'data' directory, and must contain both DCM and
  Adwords data for a single DCM campaign that includes city, city_ids, and
  impressions.
  R functions are in the R directory, which is split into unique functions here
  and externally created functions.
  The results are placed into the 'output' directory.

Prerequisites
  R - Statistical computing and graphics
    package
  Adwords Data - city, city_ids, impressions
  DCM Data - city, city_ids, impressions

Installing
  None

Running Tests
  None

Deployment
  None

Built with
  R - Statistical computing and graphics
  Atom - Code editor
  GitHub - Versioning control

Versioning
  Current version doesn't do anything

Future Development
  Output matching counties, BARB regions, and postcode/ZIP code

Authors
  Wil Poole
