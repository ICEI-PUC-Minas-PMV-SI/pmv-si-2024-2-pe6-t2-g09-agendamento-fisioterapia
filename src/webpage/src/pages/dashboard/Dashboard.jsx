import { useEffect, useState } from "react";
import { Container, Card, Row, Col } from "react-bootstrap";
import { useFetchAgendamento } from "../../hooks/useFetchAgendamento";
import styles from "./Dashboard.module.css";

export default function Dashboard() {
  const [agendamentos, setAgendamentos] = useState([]);
  const [agendamentosSemana, setAgendamentosSemana] = useState(0);
  const [horariosRequisitados, setHorariosRequisitados] = useState({});
  const [diasPopulares, setDiasPopulares] = useState({});
  const [pacientesFrequentes, setPacientesFrequentes] = useState({});

  const url = "https://localhost:5005/agendamentos";
  const { data, loading, error } = useFetchAgendamento(url);

  const isThisWeek = (date) => {
    const agendamentoDate = new Date(date);
    const today = new Date();
    const startOfWeek = new Date(today);
    startOfWeek.setDate(today.getDate() - today.getDay());
    const endOfWeek = new Date(startOfWeek);
    endOfWeek.setDate(startOfWeek.getDate() + 6);
    return agendamentoDate >= startOfWeek && agendamentoDate <= endOfWeek;
  };

  useEffect(() => {
    if (data) {
      setAgendamentos(data);

      // Contar agendamentos da semana
      const agendamentosDaSemana = data.filter((agendamento) =>
        isThisWeek(agendamento.dataAtendimento)
      );
      setAgendamentosSemana(agendamentosDaSemana.length);

      // Calcular horários mais requisitados
      const horarios = {};
      agendamentosDaSemana.forEach((agendamento) => {
        const horario = agendamento.dataAtendimento.split("T")[1];
        horarios[horario] = (horarios[horario] || 0) + 1;
      });
      setHorariosRequisitados(horarios);

      // Calcular dias da semana com mais agendamentos
      const dias = {};
      agendamentosDaSemana.forEach((agendamento) => {
        const diaSemana = new Date(agendamento.dataAtendimento).toLocaleDateString("pt-BR", { weekday: 'long' });
        dias[diaSemana] = (dias[diaSemana] || 0) + 1;
      });
      setDiasPopulares(dias);

      // Calcular pacientes mais frequentes
      const pacientes = {};
      agendamentosDaSemana.forEach((agendamento) => {
        const paciente = agendamento.nomePaciente;
        pacientes[paciente] = (pacientes[paciente] || 0) + 1;
      });
      setPacientesFrequentes(pacientes);
    }
  }, [data]);

  return (
    <Container className="mt-4">
      <h2 className="mb-4">Dashboard de Agendamentos</h2>
      {loading && <p>Carregando dados...</p>}
      {error && <p>Erro ao carregar dados.</p>}

      <Row>
        <Col>
          <Card className={styles.dashboardCard}>
            <Card.Body>
              <img src="https://img.icons8.com/ios-filled/50/386bc0/calendar-2.png" alt="Total de Agendamentos da Semana" />
              <Card.Title>Total de Agendamentos da Semana</Card.Title>
              <Card.Text>{agendamentosSemana}</Card.Text>
            </Card.Body>
          </Card>
        </Col>
        <Col>
          <Card className={styles.dashboardCard}>
            <Card.Body>
              <img src="https://img.icons8.com/ios-filled/50/386bc0/list.png" alt="Total de Agendamentos" />
              <Card.Title>Total de Agendamentos</Card.Title>
              <Card.Text>{agendamentos.length}</Card.Text>
            </Card.Body>
          </Card>
        </Col>
      </Row>

      <Row className="mt-4">

        <Col>
          <Card className={styles.dashboardCard}>
            <Card.Body>
              <img src="https://img.icons8.com/ios-filled/50/386bc0/clock.png" alt="Horários Mais Requisitados" />
              <Card.Title>Horários Mais Requisitados</Card.Title>
              <ul>
                {Object.entries(horariosRequisitados)
                  .sort((a, b) => b[1] - a[1])
                  .map(([horario, count]) => (
                    <li key={horario}>{horario} - {count} agendamentos</li>
                  ))}
              </ul>
            </Card.Body>
          </Card>
        </Col>

        <Col>
          <Card className={styles.dashboardCard}>
            <Card.Body>
              <img src="https://img.icons8.com/ios-filled/50/386bc0/calendar.png" alt="Dias Mais Populares" />
              <Card.Title>Dias Mais Populares</Card.Title>
              <ul>
                {Object.entries(diasPopulares)
                  .sort((a, b) => b[1] - a[1])
                  .map(([dia, count]) => (
                    <li key={dia}>{dia} - {count} agendamentos</li>
                  ))}
              </ul>
            </Card.Body>
          </Card>
        </Col>

        <Col>
          <Card className={styles.dashboardCard}>
            <Card.Body>
              <img src="https://img.icons8.com/ios-filled/50/386bc0/hospital-room.png" alt="Pacientes Mais Frequentes" />
              <Card.Title>Pacientes Mais Frequentes</Card.Title>
              <ul>
                {Object.entries(pacientesFrequentes)
                  .sort((a, b) => b[1] - a[1])
                  .map(([paciente, count]) => (
                    <li key={paciente}>{paciente} - {count} agendamentos</li>
                  ))}
              </ul>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
}
