# ---- Build Stage ----
# Build aplikacji przy użyciu Mavena i Javy 11
FROM maven:3.9.6-eclipse-temurin-11 AS build

# Katalog roboczy w kontenerze
WORKDIR /app

# Kopiujemy pliki projektu
COPY pom.xml .
COPY src ./src

# Budujemy JAR (bez testów)
RUN mvn clean package -DskipTests

# ---- Runtime Stage ----
# Lekki obraz do uruchomienia aplikacji
FROM eclipse-temurin:11-jre-jammy

# Katalog roboczy
WORKDIR /app

# Kopiujemy JAR z etapu build
COPY --from=build /app/target/thymeleaf-0.0.1-SNAPSHOT.jar app.jar

# Uruchomienie aplikacji
ENTRYPOINT ["java", "-jar", "app.jar"]
