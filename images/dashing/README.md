# Dashing
Run [Dashing](http://dashing.io/) in a [Docker](http://docker.io/) container.

Link: [georgeyord/dashing](https://registry.hub.docker.com/u/georgeyord/dashing/)

## Run sample dashing application
```
docker run -d -p 3030:3030 georgeyord/dashing
```

And point your browser to [http://localhost:3030/](http://localhost:3030/).

## Run custom dashing application and start tweeking
```
mkdir -p data
docker run -d -p 3030:3030 -v `pwd`/data:/dashing georgeyord/dashing
```

## Run custom existing dashing application
```
docker run -d -p 3030:3030 -v [PATH TO EXISTING DASHING APPLICATION]:/dashing georgeyord/dashing
```

## Install additional Widgets
To install custom widgets supply the gist IDs of the widgets as an environment variable:
```
docker run -d -e WIDGETS=5641535 -p 3030:3030 georgeyord/dashing
```

This example will install the [Random Aww](https://gist.github.com/chelsea/5641535) widget before starting dashing. Multiple widgets can be supplied.


## Install additional Gems
To install gems, supply the gem name(s) as an environment variable:
```
docker run -d -e GEMS="instagram" -e WIDGETS=5278790 -p 3030:3030 georgeyord/dashing
```

This example installs the [Instagram photos by location](https://gist.github.com/mjamieson/5278790) widget, which depends on the instagram gem.

> Multiple gems and widgets can be supplied like so:

## Hints and tips

###Public (favicon, 404)
To provide custom 404 and favicon, use **[DASHING APPLICATION]/public** folder.

### Configuration File
The configuration file `config.ru` is available on **[DASHING APPLICATION]** folder.
Edit this file to change your API key, to add authentication and more.

### Thanks
- [@frvi](https://github.com/frvi), [dockerfile-dashing](https://www.github.com/frvi/dockerfile-dashing)

and all the references he uses:
- [@mattgruter](https://github.com/mattgruter)
- [@rowanu](https://github.com/rowanu), [Hotness Widget](https://gist.github.com/rowanu/6246149)
- [@munkius](https://github.com/munkius), [fork](https://gist.github.com/munkius/9209839) of Hotness Widget.
- [@chelsea](https://github.com/chelsea), [Random Aww](https://gist.github.com/chelsea/5641535)
