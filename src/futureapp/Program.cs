var builder = WebApplication.CreateBuilder(args);

builder.Services.AddHealthChecks();

var app = builder.Build();

app.MapGet("/", () => Results.Ok(new
{
    application = "futureapp",
    message = "futureapp CI/CD update confirmed!"
}));

app.MapHealthChecks("/health");

app.Run();

public partial class Program { }