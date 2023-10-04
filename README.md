# docker-multi-build
docker多阶段构建demo，主要用于演示通过多阶段构建减少镜像大小

# build命令参考
```shell
docker build . -t multi-build
```

# 运行命令参考
```shell
docker run --name=docker-multi-build -d -it -p 8080:8080 multi-build
```