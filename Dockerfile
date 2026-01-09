# Build (Dùng Maven để đóng gói code thành file .jar)
FROM maven:3.9-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Run (Dùng JDK siêu nhẹ để chạy file .jar vừa build)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Mở cổng 8080 để bên ngoài truy cập được
EXPOSE 8080

# Lệnh chạy ứng dụng khi container khởi động
ENTRYPOINT ["java", "-jar", "app.jar"]