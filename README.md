## Image

Docker image of [Jackett](https://github.com/Jackett/Jackett)

Jackett is listening to port 9117.

## Environment variables

* `PUID` - UID of the process (default: 1000)
* `PGID` - GID of the process (default: 1000)

## Usage

```
docker run -itd --name jackett -p 9117:9117 \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -v /path/to/config:/config \
    wicadmin/jackett
```
