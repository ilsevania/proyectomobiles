using System.Globalization;
using Microsoft.EntityFrameworkCore;
using RegistroAPI.Data;

var builder = WebApplication.CreateBuilder(args);

// Set globalization invariant to false
AppContext.SetSwitch("System.Globalization.Invariant", false);

// Set the default culture to en-US
var cultureInfo = new CultureInfo("en-US");
CultureInfo.DefaultThreadCurrentCulture = cultureInfo;
CultureInfo.DefaultThreadCurrentUICulture = cultureInfo;

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Add CORS service
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigin",
        builder =>
        {
            builder.WithOrigins("http://localhost:65464") // Añade la URL de tu aplicación Flutter
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseRouting();

app.UseAuthorization();

// Use CORS policy
app.UseCors("AllowSpecificOrigin");

app.MapControllers();

app.Run();
