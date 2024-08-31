using Domain.Models;
using FluentValidation;

namespace Domain.Models.Controller.Validators
{
    public class AgendamentoValidator : AbstractValidator<AgendamentoModel>
    {
        public AgendamentoValidator()
        {
            RuleFor(a => a.NomePaciente)
                .NotEmpty().WithMessage("O nome do paciente é obrigatório.")
                .MaximumLength(100).WithMessage("O nome do paciente deve ter no máximo 100 caracteres.");

            RuleFor(a => a.DataAtendimento)
                .GreaterThanOrEqualTo(DateTime.Now).WithMessage("A data do agendamento deve ser uma data futura ou a data de hoje.");

            RuleFor(a => a.Email)
                .NotEmpty().WithMessage("O e-mail é obrigatório.")
                .EmailAddress().WithMessage("O e-mail deve ser válido.");

        }
    }
}
