# Ports (Interfaces)

In this Shell Script implementation of Hexagonal Architecture, "Ports" are defined by convention rather than strict interface files.

The expected functions (Ports) that Adapters must implement are:

## DiskUsageProvider
- `os_get_disk_usage()`
- `os_get_dir_size(path)`

## SystemCleaner
- `os_delete_path(path, simulate)`
- `os_empty_trash(simulate)`
- `get_system_cache_paths()`

## ContainerEngine
- `docker_get_usage()`
- `docker_prune_system(simulate)`
