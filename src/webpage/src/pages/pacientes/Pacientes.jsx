import { useState, useEffect } from "react";
import { useFetch } from "../../hooks/useFetch";
import { Link } from "react-router-dom";
import { Card, Button, Container, Row, Col } from "react-bootstrap";
import AddPacienteModal from "./PacienteModal"; // Modal para Adicionar ou Editar


const Pacientes = () => {
  const url = "https://localhost:5005/usuario/";
  const { data: pacientes, httpConfig, loading, error } = useFetch(url);

  const [showModal, setShowModal] = useState(false); // Controle do modal
  const [editMode, setEditMode] = useState(false); // Controle do modo de edição
  const [currentPaciente, setCurrentPaciente] = useState(null); // Paciente atual para edição

  // Recarrega a lista de Pacientes sempre que o componente for montado
  useEffect(() => {
    httpConfig(null, "GET");
  }, []); // Executa uma vez ao montar


  const handleOpenModal = () => {
    setEditMode(false);
    setCurrentPaciente(null);
    setShowModal(true);
  };

  const handleCloseModal = () => setShowModal(false);

  const handleAddOrEditPaciente = (data) => {
    if (editMode) {      
      httpConfig(data, "PUT");
    } else {           
      httpConfig(data, "POST");
    }
    handleCloseModal();
  };

  return (
    <Container className="mt-4">
      <h1 className="text-center mb-4">Pacientes</h1>

      <Button
        variant="primary"
        onClick={handleOpenModal} // Abre o modal ao clicar
        className="mb-3"
      >
        Adicionar Paciente
      </Button>

      {error && <p className="text-danger text-center">Ocorreu um erro...</p>}
      {loading && <p className="text-center">Carregando pacientes...</p>}

      <Row>
        {pacientes &&
          pacientes.map((paciente) => (
            <Col key={paciente.id} sm={12} md={6} lg={4} className="mb-4">
              <Card className="shadow-lg border-0">
                <Card.Body>
                  <Card.Title className="mb-2">{paciente.nomeUsuario}</Card.Title>
                  <Card.Text>
                    <strong>Email:</strong> {paciente.email}
                  </Card.Text>
                  <div className="text-center mt-3">
                    <Link to={`/paciente/${paciente.id}`}>
                      <Button variant="primary">Ver Detalhes</Button>
                    </Link>
                    </div>
                    {/* <Button variant="outline-primary">Editar</Button>
                    <Button
                      variant="outline-danger"
                      onClick={() => handleDelete(paciente.id)}
                    >
                      Excluir
                    </Button> */}                  
                </Card.Body>
              </Card>
            </Col>
          ))}
      </Row>

      <AddPacienteModal
        show={showModal}
        handleClose={handleCloseModal}
        handleAddPaciente={handleAddOrEditPaciente}
        paciente={currentPaciente}
      />
    </Container>
  );
};

export default Pacientes;
