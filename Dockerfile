FROM ubuntu:22.04 AS build
RUN apt-get update && apt-get install -y dotnet6 ca-certificates
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet publish -c Debug -o /app/publish

FROM ubuntu/dotnet-aspnet:6.0-22.04_beta as runtime
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
COPY --from=build /app/publish .
ENTRYPOINT [ "dotnet", "Zadanie DevProd-MB.dll", "--environment=Development" ]