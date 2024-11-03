import { useState, useEffect } from "react";
import { useFetchAgendamento } from "../../hooks/useFetchAgendamento";
import { Link } from "react-router-dom";
import { Card, Button, Container, Row, Col, Badge } from "react-bootstrap";
import AddAgendamentoModal from "./AgendamentoModal"; // Modal para Adicionar ou Editar
import styles from "./Agendamento.module.css";

const Agendamentos = () => {
  const url = "https://localhost:5005/agendamentos/";
  const { data: agendamentos, httpConfig, loading, error } = useFetchAgendamento(url);

  const [showModal, setShowModal] = useState(false); // Controle do modal
  const [editMode, setEditMode] = useState(false); // Controle do modo de edição
  const [currentAgendamento, setCurrentAgendamento] = useState(null); // Agendamento atual para edição

  // Recarrega a lista de agendamentos sempre que o componente for montado
  useEffect(() => {
    httpConfig(null, "GET");
  }, []); // Executa uma vez ao montar

  const handleOpenModal = () => {
    setEditMode(false);
    setCurrentAgendamento(null);
    setShowModal(true);
  };

  const handleOpenEditModal = (agendamento) => {
    setEditMode(true);
    setCurrentAgendamento(agendamento);
    setShowModal(true);
  };

  const handleCloseModal = () => setShowModal(false);

  const formatarDataAtendimento = (data, horario) => {
    const [ano, mes, dia] = data.split("-"); // 'yyyy-MM-dd'
    const [horas, minutos] = horario.split(":"); // 'HH:mm'
    return `${dia}-${mes}-${ano}-${horas}-${minutos}`; // 'dd-MM-yyyy-HH-mm'
  };
  

  const handleAddOrEditAgendamento = (data) => {
    if (editMode) {
      const dataAgendamento = formatarDataAtendimento(data.data, data.horario);
      const urlEdicao = `${url}AtualizarData/${data.id}?data=${dataAtendimento}`;
      httpConfig(data, "PUT", urlEdicao);
    } else { 
      httpConfig(data, "POST");
    }
    handleCloseModal();
  };

  // const handleDelete = (id) => {
  //   httpConfig(id, "DELETE");
  // };

  return (
    <Container className="mt-4">
      <h1 className="text-center mb-4">Agendamentos</h1>

      <Button
        variant="primary"
        onClick={handleOpenModal} // Abre o modal no modo de adição
        className="mb-3"
      >
        Adicionar Agendamento
      </Button>

      {error && <p className="text-danger text-center">Ocorreu um erro ao carregar os agendamentos.</p>}
      {loading && <p className="text-center">Carregando agendamentos...</p>}

      <Row>
        {agendamentos &&
          agendamentos.map((agendamento) => (
            <Col key={agendamento.id} sm={12} md={6} lg={4} className="mb-4">
              <Card className="shadow-lg border-0">
                <Card.Body>
                  <div className="d-flex justify-content-between align-items-center">
                    <Card.Title className="mb-0">{agendamento.nomePaciente}</Card.Title>
                    <Badge variant="primary" pill>
                      {agendamento.status}
                    </Badge>
                  </div>
                  <Card.Text className="mt-2">
                    <strong>Email:</strong> {agendamento.email}
                  </Card.Text>
                  <Card.Text>
                    <strong>Data:</strong> {new Date(agendamento.dataAtendimento).toLocaleDateString()}
                  </Card.Text>
                  {/* <div className="d-flex justify-content-around">
                    <Button variant="primary" onClick={() => handleOpenEditModal(agendamento)}>
                      Editar
                    </Button>
                    <Button variant="outline-primary" onClick={() => handleDelete(agendamento.id)}>
                      Excluir
                    </Button>
                  </div> */}
                  <div className="text-center mt-3">
                    <Link to={`/agendamento/${agendamento.id}`}>
                      <Button variant="outline-primary">Ver Detalhes</Button>
                    </Link>
                  </div>
                </Card.Body>
              </Card>
            </Col>
          ))}
      </Row>

      <AddAgendamentoModal
        show={showModal}
        handleClose={handleCloseModal}
        handleAddAgendamento={handleAddOrEditAgendamento}
        agendamento={currentAgendamento}
      />
    </Container>
  );
};

export default Agendamentos;
