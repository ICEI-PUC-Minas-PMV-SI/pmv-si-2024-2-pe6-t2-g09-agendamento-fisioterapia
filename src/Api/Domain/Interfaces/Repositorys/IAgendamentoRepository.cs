using Domain.Models;

namespace Domain.Interfaces.Repositorys;

public interface IAgendamentoRepository
{
    Task<ValueResult<List<AgendamentoModel>>> BuscarTodosAgendamentosAsync();
    Task<ValueResult<List<AgendamentoModel>>> BuscarTodosAgendamentosPorEmailPacienteAsync(string email);
    Task<ValueResult<List<AgendamentoModel>>> BuscarAgendamentosPorMedicoResponsavelAsync(string emailMedico);
    Task<ValueResult<AgendamentoModel>> BuscarAgendamentoPorIdAsync(long id);
    Task<ValueResult> AdicionarAgendamentoAsync(AgendamentoModel agendamento);
    Task<ValueResult> AtualizarAgendamentoAsync(AgendamentoModel agendamento);
    Task<ValueResult> ApagarAgendamentoAsync(AgendamentoModel agendamento);
}
