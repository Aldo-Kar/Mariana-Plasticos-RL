# Etapa 1: Compilar el proyecto
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copiar archivos del backend
COPY Backend/pom.xml .
RUN mvn dependency:go-offline -B

COPY Backend/src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Ejecutar la aplicación
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", \
  "-Dspring.datasource.url=${DB_URL}", \
  "-Dspring.datasource.username=${DB_USER}", \
  "-Dspring.datasource.password=${DB_PASSWORD}", \
  "-Dcors.allowed.origins=${CORS_ALLOWED_ORIGINS}", \
  "app.jar"]


