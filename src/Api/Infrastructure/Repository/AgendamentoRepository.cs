using Domain;
using Domain.Interfaces.Repositorys;
using Domain.Models;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Repository;

public class AgendamentoRepository(AgendamentoContext context) : IAgendamentoRepository
{
    private readonly AgendamentoContext _context = context;

    public async Task<ValueResult<List<AgendamentoModel>>> BuscarTodosAgendamentosAsync()
    {
        try
        {
            return ValueResult<List<AgendamentoModel>>.Success(
                await _context.Agendamentos
                .ToListAsync());
        }
        catch
        {
            return ValueResult<List<AgendamentoModel>>.Failure("Falha ao acessar base de dados");
        }
    }

    public async Task<ValueResult<List<AgendamentoModel>>> BuscarTodosAgendamentosPorEmailPacienteAsync(string email)
    {
        try
        {
            return ValueResult<List<AgendamentoModel>>.Success(
                await _context.Agendamentos
                .Where(x => x.Email == email)
                .ToListAsync());
        }
        catch
        {
            return ValueResult<List<AgendamentoModel>>.Failure("Falha ao acessar base de dados");
        }
    }

    public async Task<ValueResult<List<AgendamentoModel>>> BuscarAgendamentosPorMedicoResponsavelAsync(string email)
    {
        try
        {
            return ValueResult<List<AgendamentoModel>>.Success(
                await _context.Agendamentos
                .Where(x => x.EmailMedicoResponsavel == email)
                .OrderBy(x => x.DataAtendimento)
                .ToListAsync());
        }
        catch
        {
            return ValueResult<List<AgendamentoModel>>.Failure("Falha ao acessar base de dados");
        }
    }

    public async Task<ValueResult<AgendamentoModel>> BuscarAgendamentoPorIdAsync(long id)
    {
        try
        {
            return ValueResult<AgendamentoModel>.Success(
                await _context.Agendamentos
                .Where(x => x.Id == id)
                .FirstOrDefaultAsync());
        }
        catch
        {
            return ValueResult<AgendamentoModel>.Failure("Falha ao acessar base de dados");
        }
    }

    public async Task<ValueResult> AdicionarAgendamentoAsync(AgendamentoModel agendamento)
    {
        try
        {
            await _context.Agendamentos.AddAsync(agendamento);
            await _context.SaveChangesAsync();
            return ValueResult.Success();
        }
        catch
        {
            return ValueResult.Failure("Falha ao acessar base de dados");
        }
    }

    public async Task<ValueResult> AtualizarAgendamentoAsync(AgendamentoModel agendamento)
    {
        try
        {
            _context.Agendamentos.Update(agendamento);
            await _context.SaveChangesAsync();
            return ValueResult.Success();
        }
        catch
        {
            return ValueResult.Failure("Falha ao acessar base de dados");
        }
    }

    public async Task<ValueResult> ApagarAgendamentoAsync(AgendamentoModel agendamento)
    {
        try
        {
            _context.Agendamentos.Remove(agendamento);
            await _context.SaveChangesAsync();
            return ValueResult.Success();
        }
        catch
        {
            return ValueResult.Failure("Falha ao acessar base de dados");
        }
    }
}
