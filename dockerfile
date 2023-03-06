#### Stage 1: Build the application
FROM openjdk:8-jdk as build

# Set the current working directory inside the image
WORKDIR /app


# Copy maven executable to the image
COPY mvnw .
COPY .mvn .mvn

# COPY THE JSON and WebPack files
COPY package.json .
COPY webpack.config.js .

# Copy the pom.xml file
COPY pom.xml .

# Build all the dependencies in preparation to go offline. 
# This is a separate step so the dependencies will be cached unless 
# the pom.xml file has changed.
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

# Copy the project source
COPY src/main src/main

# Package the application
RUN ./mvnw package -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

#### Stage 2: A minimal docker image with command to run the app 
FROM openjdk:11

# WORKDIR /app
EXPOSE 8080
ARG DEPENDENCY=/app/target/dependency/*.jar

ADD ${JAR_DEPENDENCY} application.jar

# Copy project dependencies from the build stage
# COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
# COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
# COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app


ENTRYPOINT ["java","-jar","/application.jar"]
