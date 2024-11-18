FROM eclipse-temurin:17-jre-focal

ARG JAR_FILE="/opt/jar"
ARG FILE_NAME="jrebel-0.0.1-SNAPSHOT.jar"

WORKDIR /app

# 将 JAR 文件复制到镜像中
COPY $FILE_NAME $JAR_FILE/$FILE_NAME 

# 设置环境变量
ENV ENTRYPOINT="nohup java -Dfile.encoding=UTF-8 -Xmx300m -Xms100m -Duser.timezone=GMT+8 -jar $JAR_FILE/$FILE_NAME"


# 创建启动脚本
RUN set -xe \
    && echo "#!/bin/bash" > /opt/bootstrap.sh \
    && echo "source /etc/profile" >> /opt/bootstrap.sh \
    && echo "export LANG=en_US.UTF-8" >> /opt/bootstrap.sh \
    && echo "echo \${ENTRYPOINT}|awk '{run=\$0;system(run)}'" >> /opt/bootstrap.sh 

# 启动项
ENTRYPOINT sh /opt/bootstrap.sh

# 暴露端口 (根据您的应用实际情况修改)
EXPOSE 8080
