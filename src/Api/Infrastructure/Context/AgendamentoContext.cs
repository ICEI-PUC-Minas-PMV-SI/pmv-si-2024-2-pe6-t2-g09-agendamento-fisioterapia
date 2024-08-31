using Domain.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace Infrastructure.Context;

public class AgendamentoContext : DbContext
{
    private readonly string _connectionString;
    public DbSet<AgendamentoModel> Agendamentos { get; set; }

    public AgendamentoContext(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("Agendamentos");
    }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer(_connectionString);
    }
}
