# Satisfactory Dedicated Server ARM Docker container

## Usage

```bash
docker run --privileged --rm tonistiigi/binfmt --install amd64
export DOCKER_DEFAULT_PLATFORM=linux/amd64
```

See the guide at the bottom of the [Dockerfile](Dockerfile) for more information.

## License

This project is licensed under the MIT license, see the [LICENSE](LICENSE) file for more information.

## Attribution

Thanks to DJMalachite for figuring this out, writing the guide, and helping set up the [Dockerfile](Dockerfile).
