# 选择一个带有Node.js的轻量级基础镜像，使用 as 多阶段构建
FROM instrumentisto/flutter as build-stage

# 设置工作目录
WORKDIR /app

# 代码复制到容器中
ADD . /app

# 构建应用
RUN flutter pub get

RUN flutter build web --web-renderer canvaskit

# 阶段2：运行
# 使用 Nginx 镜像作为基础来提供前端静态文件服务
FROM nginx:stable-alpine as production-stage

WORKDIR /app

# 从构建阶段拷贝构建出的文件到Nginx目录
COPY --from=build-stage /app/build/web /usr/share/nginx/html

# 配置nginx，如果有自定义的nginx配置可以取消注释并修改下面的行
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露80端口
EXPOSE 80

# 启动Nginx服务器
CMD ["nginx", "-g", "daemon off;"]


# docker build -t dockerfile-copyui-app:v1.0.1 .
# docker run -d -p 8089:80 dockerfile-copyui-app:v1.0.1