import { useState } from "react";
import { useParams, Link } from "react-router-dom";
import { Card, Button, Container } from "react-bootstrap";
import { useNavigate } from "react-router-dom";
import { useFetchAgendamento } from "../../hooks/useFetchAgendamento";
import styles from "./AgendamentoDetails.module.css";
import AddAgendamentoModal from "./AgendamentoModal"; // Modal para Adicionar ou Editar

export default function AgendamentoDetails() {
  const { id } = useParams();

  const url = "https://localhost:5005/agendamentos/" + id;
  const {
    data: agendamento,
    httpConfig,
    loading,
    error,
  } = useFetchAgendamento(url);

  const [showModal, setShowModal] = useState(false); // Controle do modal
  const [editMode, setEditMode] = useState(false); // Controle do modo de edição
  const [currentAgendamento, setCurrentAgendamento] = useState(null); // Agendamento atual para edição
  const navigate = useNavigate();


  // Função para abrir o modal no modo de edição
  const handleOpenEditModal = (agendamento) => {
    setEditMode(true); // Define modo de edição
    setCurrentAgendamento(agendamento); // Define o agendamento a ser editado
    setShowModal(true); // Abre o modal
  };

  const handleCloseModal = () => setShowModal(false); // Fecha o modal

  const handleAddOrEditAgendamento = (data) => {
    if (editMode) {
      const urlEdicao = `https://localhost:5005/agendamentos/AtualizarData/${id}?data=${data.dataAtendimento}`;      
      httpConfig(data, "PUT", urlEdicao);
    } else {
      httpConfig(data, "POST");
    }
    handleCloseModal();
  };

  const handleDelete = async (id) => {
    try {
      await httpConfig(id, "DELETE"); // Aguarda a exclusão ser concluída
  
      // Redireciona para a lista de agendamentos
      navigate("/agendamentos", { replace: true });
    } catch (error) {
      console.error("Erro ao excluir agendamento:", error);
    }
  };
  
  

  return (
    <Container className="mt-4">
      {error && <p>Ocorreu um erro...</p>}
      {loading && <p>Carregando produto...</p>}
      {agendamento && (
        <Card>
          <Card.Body>
            <Card.Title>Detalhes do agendamento</Card.Title>
            <Card.Text>
              <br />
              <strong>Nome:</strong> {agendamento.nomePaciente}
              <br />
              <strong>Email:</strong> {agendamento.email}
              <br />
              <strong>Data:</strong> {agendamento.dataAtendimento}
              <br />
              <br />
              {/*
              <strong>Email Medico:</strong>{" "}
              {agendamento.emailMedicoResponsavel}
              <br />
              */}
            </Card.Text>
            <div className="d-flex justify-content-center">
              <Link to="/agendamentos" className={styles.agen_det_cont_bot}>
                <Button variant="secondary">Voltar</Button>
              </Link>
              <Link className={styles.agen_det_cont_bot}>
                <Button
                  variant="warning"
                  onClick={() => handleOpenEditModal(agendamento)} // Abre o modal para edição
                >
                  Editar
                </Button>
              </Link>
              <Link className={styles.agen_det_cont_bot}>
                <Button
                  variant="danger"
                  onClick={() => handleDelete(agendamento.id)}
                >
                  Excluir
                </Button>
              </Link>
            </div>
          </Card.Body>
        </Card>
      )}
      <AddAgendamentoModal
        show={showModal} // Passa o estado do modal
        handleClose={handleCloseModal} // Função para fechar o modal
        handleAddAgendamento={handleAddOrEditAgendamento} // Função para adicionar/editar agendamento
        agendamento={currentAgendamento} // Passa o agendamento atual para edição
      />
    </Container>
  );
}
