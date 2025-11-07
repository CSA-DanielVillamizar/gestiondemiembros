# See: https://learn.microsoft.com/aspnet/core/fundamentals/servers/kestrel/endpoints
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

# Copy csproj files and restore dependencies
COPY ["backend/src/LAMAMedellin.API/LAMAMedellin.API.csproj", "LAMAMedellin.API/"]
COPY ["backend/src/LAMAMedellin.Application/LAMAMedellin.Application.csproj", "LAMAMedellin.Application/"]
COPY ["backend/src/LAMAMedellin.Domain/LAMAMedellin.Domain.csproj", "LAMAMedellin.Domain/"]
COPY ["backend/src/LAMAMedellin.Infrastructure/LAMAMedellin.Infrastructure.csproj", "LAMAMedellin.Infrastructure/"]

RUN dotnet restore "LAMAMedellin.API/LAMAMedellin.API.csproj"

# Copy all source code
COPY backend/src/ .

# Build the application
WORKDIR "/src/LAMAMedellin.API"
RUN dotnet build "LAMAMedellin.API.csproj" -c $BUILD_CONFIGURATION -o /app/build

# Publish stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "LAMAMedellin.API.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# Final stage
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Create a non-root user
RUN adduser --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD curl --fail http://localhost:8080/health || exit 1

ENTRYPOINT ["dotnet", "LAMAMedellin.API.dll"]
