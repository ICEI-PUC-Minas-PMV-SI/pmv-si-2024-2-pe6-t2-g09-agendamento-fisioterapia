using System.Text.Json.Serialization;

namespace Domain.Models;

public sealed record AgendamentoModel
{
    [JsonPropertyName("id")]
    public long? Id { get; set; }

    [JsonPropertyName("nomePaciente")]
    public string? NomePaciente { get; set; }

    [JsonPropertyName("dataAtendimento")]
    public DateTime DataAtendimento { get; set; }

    [JsonPropertyName("email")]
    public string? Email { get; set; }

    [JsonPropertyName("emailMedicoResponsavel")]
    public string? EmailMedicoResponsavel { get; set; }

}
