# 镜像源
FROM golang:1.18-alpine as build

# 设定时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#为我们的镜像设置必要的环境变量
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
    GOPROXY="https://goproxy.cn,direct"
#创建工作目录
RUN mkdir /app
#切换工作目录
WORKDIR /app
#添加项目文件
ADD main.go /app
#下载依赖并编译程序
RUN go mod init multi-build && go mod tidy && go build -o main ./main.go

# 二段构建
FROM alpine:latest
COPY --from=build /app/main ./
EXPOSE 8080
#最终运行docker的命令
CMD ./main