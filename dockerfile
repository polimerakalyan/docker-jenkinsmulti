FROM maven AS builder
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/polimerakalyan/docker-jenkinsmulti.git
RUN cd docker-jenkinsmulti
WORKDIR /BUILD
COPY pom.xml .
COPY src /BUILD
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /BUILD/target/*.jar app.jar
EXPOSE 8080
CMD ["java","-jar","app.jar"]
