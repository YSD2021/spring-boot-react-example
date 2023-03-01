#### Stage 1: Build the application
#FROM openjdk:8-jdk-alpine as build

# Set the current working directory inside the image
# WORKDIR /app

# Copy maven executable to the image
# COPY mvnw .
# COPY .mvn .mvn

# COPY THE JSON and WebPack files
# COPY package.json .
# COPY webpack.config.js .

# Copy the pom.xml file
# COPY pom.xml .

# Build all the dependencies in preparation to go offline. 
# This is a separate step so the dependencies will be cached unless 
# the pom.xml file has changed.
# RUN chmod +x mvnw
# RUN ./mvnw dependency:go-offline -B

# Copy the project source
# COPY src/main src/main

# Package the application
# RUN ./mvnw package -DskipTests
# RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

#### Stage 2: A minimal docker image with command to run the app 
FROM openjdk:8-jdk-alpine

# WORKDIR /app

ARG JAR_DEPENDENCY=target/spring-boot-react-example-0.0.1-SNAPSHOT.jar

ADD ${JAR_DEPENDENCY} application.jar

# Copy project dependencies from the build stage
# COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
# COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
# COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

EXPOSE 8080

ENTRYPOINT ["java","-jar","/application.jar"]