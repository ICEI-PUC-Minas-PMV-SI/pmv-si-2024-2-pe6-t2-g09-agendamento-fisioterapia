import { useState } from "react";
import { useParams, Link } from "react-router-dom";
import { Card, Button, Container } from "react-bootstrap";
import { useNavigate } from "react-router-dom";
import { useFetch } from "../../hooks/useFetch";
import styles from "./PacienteDetail.module.css";
import AddPacienteModal from "./PacienteModal"; // Modal para Adicionar ou Editar

export default function PacienteDetails() {
  const { id } = useParams();
  const url = "https://localhost:5005/usuario/" + id;
  const { data: paciente, httpConfig, loading, error } = useFetch(url);

  const [showModal, setShowModal] = useState(false); // Controle do modal
  const [editMode, setEditMode] = useState(false); // Controle do modo de edição
  const [currentPaciente, setCurrentPaciente] = useState(null); // Paciente atual para edição
  const navigate = useNavigate();

  const handleCloseModal = () => setShowModal(false); // Fecha o modal

  // Função para abrir o modal no modo de edição
  const handleOpenEditModal = (paciente) => {
    setEditMode(true); // Define modo de edição
    setCurrentPaciente(paciente); // Define o paciente a ser editado
    setShowModal(true); // Abre o modal
  };

  const handleAddOrEditPaciente = (data) => {
    if (editMode) {
      httpConfig(data, "PUT");
    } else {
      httpConfig(data, "POST");
    }
    handleCloseModal();
  };

  const handleDelete = async (id) => {
    try {
      await httpConfig(id, "DELETE"); // Aguarda a exclusão ser concluída
      // Redireciona para a lista de Pacientes
      navigate("/pacientes", { replace: true });
    } catch (error) {
      console.error("Erro ao excluir Paciente:", error);
    }
  };

  return (
    <Container className="mt-4">
      {error && <p>Ocorreu um erro...</p>}
      {loading && <p>Carregando produto...</p>}
      {paciente && (
        <Card>
          <Card.Body>
            <Card.Title>Detalhes do Paciente</Card.Title>
            <Card.Text>
              <br />
              <strong>Nome:</strong> {paciente.nomeUsuario}
              <br />
              <strong>Email:</strong> {paciente.email}
              <br />
              <strong>Telefone:</strong> {paciente.telefone}
              <br />
              <strong>Tipo:</strong> {paciente.tipo === 1 ? "Ativo" : "Inativo"}
              <br />
              <strong>Perfil:</strong>{" "}
              {paciente.perfil === 0 ? "Admin" : "Usuário"}
            </Card.Text>
            <div className="d-flex justify-content-center">
              <Link to="/pacientes" className={styles.pac_det_cont_bot}>
                <Button variant="secondary">Voltar</Button>
              </Link>
              <Link className={styles.pac_det_cont_bot}>
                <Button
                  variant="warning"
                  onClick={() => handleOpenEditModal(paciente)} // Abre o modal para edição
                >
                  Editar
                </Button>
              </Link>
              <Link className={styles.pac_det_cont_bot}>
                <Button
                  variant="danger"
                  onClick={() => handleDelete(paciente.id)}
                >
                  Excluir
                </Button>
              </Link>
            </div>
          </Card.Body>
        </Card>
      )}
      <AddPacienteModal
        show={showModal} // Passa o estado do modal
        handleClose={handleCloseModal} // Função para fechar o modal
        handleAddPaciente={handleAddOrEditPaciente} // Função para adicionar/editar Paciente
        paciente={currentPaciente} // Passa o Paciente atual para edição
      />
    </Container>
  );
}
