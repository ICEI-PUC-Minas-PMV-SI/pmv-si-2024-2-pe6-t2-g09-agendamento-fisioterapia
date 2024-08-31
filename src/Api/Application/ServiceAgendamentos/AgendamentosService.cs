using Domain;
using Domain.Interfaces.Services;
using Domain.Models;

namespace Application.ServiceAgendamentos;
internal class AgendamentosService : IAgendamentoService
{

    public Task<ValueResult<AgendamentoModel>> AdicionarAgendamentoAsync(AgendamentoModel paciente)
    {
        throw new NotImplementedException();
    }

    public Task<ValueResult> ApagarAgendamentoAsync(long id)
    {
        throw new NotImplementedException();
    }

    public Task<ValueResult<AgendamentoModel>> AtualizarAgendamentoAsync(AgendamentoModel paciente)
    {
        throw new NotImplementedException();
    }

    public Task<ValueResult<AgendamentoModel>> BuscarAgendamentosPorMedicoResponsavelAsync(long id)
    {
        throw new NotImplementedException();
    }

    public Task<ValueResult<List<AgendamentoModel>>> BuscarTodosAgendamentosAsync()
    {
        throw new NotImplementedException();
    }
}
