FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY src/futureapp/futureapp.csproj src/futureapp/
RUN dotnet restore src/futureapp/futureapp.csproj

COPY src/futureapp/ src/futureapp/
RUN dotnet publish src/futureapp/futureapp.csproj \
    --configuration Release \
    --output /app/publish \
    --no-restore \
    /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app

ENV ASPNETCORE_HTTP_PORTS=8080
EXPOSE 8080

COPY --from=build /app/publish .
USER $APP_UID

ENTRYPOINT ["dotnet", "futureapp.dll"]