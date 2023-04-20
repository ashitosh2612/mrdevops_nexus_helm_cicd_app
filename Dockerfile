FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk
WORKDIR /app
copy --from=build /app/target/devops-integration.jar  /app/
EXPOSE 8080
CMD [ "java", "-jar", "devops-integration.jar"] 