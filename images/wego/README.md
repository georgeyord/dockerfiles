# Docker image for [Wego](https://github.com/schachmat/wego),  a weather client for the terminal

## What is Wego

Wego is a weather client for the terminal. It uses worldweatheronline.com API to get the data.

### Features

* show forecast for 1 to 5 days
* nice ASCII art icons
* displayed info (metric or imperial units):
  * temperature
  * windspeed and direction
  * viewing distance
  * precipitation amount and probability
* ssl, so the NSA has a harder time learning where you live or plan to go
* config file for default location which can be overridden by commandline

![Screenshots](http://schachmat.github.io/wego/wego.gif)

## Usage

Wego requires an API key from worldweatheronline.com. Please register one [here](https://developer.worldweatheronline.com/auth/register).

To run the container:

```
docker run -it --rm -e API_KEY=[API KEY] georgeyord/wego [DAYS] [PLACE]
```

Where:

* `API KEY` is the key you copied from worldweatheronline.com
* `DAYS` is the number of days to forecast, 1-5. It is optional, default value is 3 days forecast.
* `PLACE` is the place you want to know the weather, example London
