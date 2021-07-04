# Step 1: BUILD
FROM deividopscba/dotnet-sdk3.1-stretch AS build
COPY ApiPrueba/*.csproj ./app/ApiPrueba
WORKDIR /app/ApiPrueba
RUN dotnet restore

# Step 2: PUBLISH
COPY ApiPrueba/../
RUN dotnet publish -o out /p:PublishWithAspNetCoreTargetManifest="false"

# Step 3: RUN
FROM deividopscba/dotnet-runtime AS runtime
ENV ASPNETCORE_URLS http://+:80 
WORKDIR /appCOPY --from=build /app/ApiPrueba/out ./
ENTRYPOINT ["dotnet", "ApiPrueba.dll"]