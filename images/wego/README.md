# Docker image for [Wego](https://github.com/schachmat/wego),  a weather client for the terminal

## Usage
 
Wego requires an API key from worldweatheronline.com. Please register one [here](https://developer.worldweatheronline.com/auth/register).

Run the container
```
docker run -it --rm -e API_KEY=[API KEY] georgeyord/wego [DAYS] [PLACE]
```

Where:
- `API KEY` is the key you copied from worldweatheronline.com
- `DAYS` is the number of days to forecast, 1-5
- `PLACE` is the place you want to know the weather, example London
