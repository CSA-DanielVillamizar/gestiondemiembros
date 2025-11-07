using LAMAMedellin.Application.Interfaces;
using LAMAMedellin.Application.Mappings;
using LAMAMedellin.Application.Services;
using LAMAMedellin.Domain.Interfaces;
using LAMAMedellin.Infrastructure.Data;
using LAMAMedellin.Infrastructure.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Web;
using Microsoft.OpenApi.Models;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

// Configurar Serilog para logging
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .Enrich.FromLogContext()
    .WriteTo.Console()
    .WriteTo.File("logs/lama-api-.txt", rollingInterval: RollingInterval.Day)
    .CreateLogger();

builder.Host.UseSerilog();

// Configurar base de datos
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<LAMADbContext>(options =>
{
    options.UseSqlServer(connectionString, sqlOptions =>
    {
        sqlOptions.EnableRetryOnFailure(
            maxRetryCount: 5,
            maxRetryDelay: TimeSpan.FromSeconds(30),
            errorNumbersToAdd: null);
    });
});

// Configurar autenticación con Azure AD B2C (habilitar solo si hay configuración válida)
var b2cSection = builder.Configuration.GetSection("AzureAdB2C");
var b2cClientId = b2cSection["ClientId"];

if (!string.IsNullOrWhiteSpace(b2cClientId) && !b2cClientId.Contains("{"))
{
    builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
        .AddMicrosoftIdentityWebApi(b2cSection);
    builder.Services.AddAuthorization();
}
else
{
    // Modo desarrollo sin autenticación: permitir todas las peticiones
    builder.Services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    })
    .AddJwtBearer(JwtBearerDefaults.AuthenticationScheme, options =>
    {
        // No validar token; permite acceso anónimo en dev
        options.Events = new JwtBearerEvents
        {
            OnMessageReceived = context =>
            {
                context.NoResult();
                return System.Threading.Tasks.Task.CompletedTask;
            }
        };
    });

    builder.Services.AddAuthorization(options =>
    {
        options.FallbackPolicy = new Microsoft.AspNetCore.Authorization.AuthorizationPolicyBuilder()
            .RequireAssertion(_ => true)
            .Build();
    });
}

// Registrar servicios de aplicación
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
builder.Services.AddScoped<IMiembroService, MiembroService>();

// Configurar AutoMapper
builder.Services.AddAutoMapper(typeof(MappingProfile));

// Configurar CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowReactApp", policy =>
    {
        policy.WithOrigins(
                builder.Configuration["Cors:AllowedOrigins"]?.Split(',') 
                ?? new[] { "http://localhost:3000", "http://localhost:5173" })
            .AllowAnyMethod()
            .AllowAnyHeader()
            .AllowCredentials();
    });
});

// Agregar controladores
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.ReferenceHandler = System.Text.Json.Serialization.ReferenceHandler.IgnoreCycles;
    });

// Configurar Swagger/OpenAPI
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "L.A.M.A. Medellín API",
        Version = "v1",
        Description = "API para gestión de miembros del capítulo L.A.M.A. Medellín",
        Contact = new OpenApiContact
        {
            Name = "Capítulo L.A.M.A. Medellín",
            Email = "contacto@lamamedellin.org"
        }
    });

    // Configurar autenticación JWT en Swagger
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Ingrese el token JWT en el formato: Bearer {token}"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

// Configurar Application Insights (opcional)
if (!string.IsNullOrEmpty(builder.Configuration["ApplicationInsights:ConnectionString"]))
{
    builder.Services.AddApplicationInsightsTelemetry();
}

var app = builder.Build();

// Aplicar migraciones automáticamente en desarrollo
if (app.Environment.IsDevelopment())
{
    try
    {
        Log.Information("Aplicando migraciones de base de datos...");
        using var scope = app.Services.CreateScope();
        var dbContext = scope.ServiceProvider.GetRequiredService<LAMADbContext>();
        await dbContext.Database.MigrateAsync();
        Log.Information("Migraciones aplicadas exitosamente");
    }
    catch (Exception ex)
    {
        Log.Warning(ex, "Error aplicando migraciones (continuando sin ellas): {Message}", ex.Message);
        // Continuar sin migraciones para permitir que la API arranque
    }
}

// Configurar pipeline HTTP
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "L.A.M.A. Medellin API v1");
        c.RoutePrefix = "swagger"; // Swagger en /swagger
    });
}

if (!app.Environment.IsDevelopment())
{
    app.UseHttpsRedirection();
}

app.UseCors("AllowReactApp");

app.UseSerilogRequestLogging();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

// Endpoint de health check
app.MapGet("/health", () => Results.Ok(new
{
    status = "Healthy",
    timestamp = DateTime.UtcNow
}))
.WithName("HealthCheck")
.WithOpenApi();

try
{
    Log.Information("Iniciando L.A.M.A. Medellín API");
    Console.WriteLine("=== API INICIADA ===");
    Console.WriteLine($"Entorno: {app.Environment.EnvironmentName}");
    Console.WriteLine($"URLs configuradas: {builder.Configuration["ASPNETCORE_URLS"] ?? "Por defecto"}");
    Console.WriteLine("Presiona Ctrl+C para detener...");
    await app.RunAsync();
}
catch (Exception ex)
{
    Log.Fatal(ex, "La aplicación falló al iniciar");
    Console.WriteLine($"ERROR FATAL: {ex.Message}");
    Console.WriteLine(ex.StackTrace);
    throw;
}
finally
{
    Log.CloseAndFlush();
}
