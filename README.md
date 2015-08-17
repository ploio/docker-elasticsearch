# Portefaix Elasticsearch

![logo](http://pkgs.alpinelinux.org/assets/alpinelinux-logo.svg)

[Alpine Linux][] is a Linux distribution built around musl libc and BusyBox.
This image is based on the official Alpine Linux.

The following [Elasticsearch][] plugins are installed :

Some [Elasticsearch][] plugins are available:
* [ElasticSearchHead][]: `http://xxx:9200/_plugin/head/`
* [ElasticHQ][]: `http://xxx:9200/_plugin/HQ/`
* [Kopf][]: `http://xxx:9200/_plugin/kopf/`

Ports exported are : `9200` and `9300`
Volumes exported are : `/var/lib/elasticsearch`

## Usage

    $ docker run -it -p 9200:9200 -p 9300:9300 portefaix/elasticsearch:1.7.1

## Supported tags

- `1.5.2`
- `1.6.0`
- `1.7.1`

## License

See [LICENSE][] for the complete license.


## Changelog

A [ChangeLog.md][] is available.


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>


[Alpine Linux]: http://www.alpinelinux.org

[Elasticsearch]: https://www.elastic.co/products/elasticsearch
[ElasticSearchHead]: http://mobz.github.io/elasticsearch-head
[ElasticHQ]: http://www.elastichq.org
[Kopf]: https://github.com/lmenezes/elasticsearch-kopf
