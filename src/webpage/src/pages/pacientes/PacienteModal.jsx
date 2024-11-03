import { useState, useEffect } from "react";
import { Modal, Button, Form } from "react-bootstrap";

const AddPacienteModal = ({ 
  show,
  handleClose,
  handleAddPaciente,
  paciente, }) => {
  const [formData, setFormData] = useState({
    nomeUsuario: "",
    password: "",
    email: "",
    telefone: "",
    tipo: "",
    perfil: "",
  });

 // Preenche o formulário com os dados do agendamento para edição
 useEffect(() => {
  if (paciente) {
    setFormData({
      nomeUsuario: paciente.nomeUsuario,
      password: paciente.password,
      email: paciente.email,
      telefone: paciente.telefone,
      tipo: paciente.tipo,
      perfil: paciente.perfil,
    
    });
  } else {
    // Reseta o formulário se não houver paciente
    setFormData({
      nomeUsuario: "",
      password: "",
      email: "",
      telefone: "",
      tipo: "",
      perfil: "",
    });
  }
}, [paciente]);



  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    const paciente = {
      ...formData,
      tipo: parseInt(formData.tipo, 10), // Converte para inteiro
      perfil: parseInt(formData.perfil, 10), // Converte para inteiro
    };

    // Passa o objeto atualizado para a função de adicionar paciente
    console.log("Pacinte cadastrado:", paciente)
    handleAddPaciente(paciente);
    handleClose();
    setFormData({
      // Reseta o formulário
      nomeUsuario: "",
      password: "",
      email: "",
      telefone: "",
      tipo: "",
      perfil: "",
    });
  };

  return (
    <Modal show={show} onHide={handleClose}>
      <Modal.Header closeButton>
        <Modal.Title>Adicionar Usuario</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form onSubmit={handleSubmit}>
          <Form.Group className="mb-3" controlId="formNome">
            <Form.Label>Nome do Usuario</Form.Label>
            <Form.Control
              type="text"
              name="nomeUsuario"
              value={formData.nomeUsuario}
              onChange={handleChange}
              placeholder="nome"
              required
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="formData">
            {paciente ?  <Form.Label>Nova Senha</Form.Label> :  <Form.Label>Password</Form.Label>}
            <Form.Control
              type="password"
              name="password"
              value={formData.password}
              onChange={handleChange}
              required
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="formEmail">
            <Form.Label>Email</Form.Label>
            <Form.Control
              type="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              placeholder="Digite o email do paciente"
              required
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="formHorario">
            <Form.Label>Telefone</Form.Label>
            <Form.Control
              name="telefone"
              value={formData.telefone}
              onChange={handleChange}
              required
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="formTipo">
            <Form.Label>Tipo</Form.Label>
            <Form.Select
              name="tipo" // Nome da propriedade no estado
              value={formData.tipo} // Valor do estado
              onChange={handleChange} // Função que atualiza o estado
              required
            >
              <option value="">Selecione o Tipo</option>
              <option value="0">Profissional</option>
              <option value="1">Cliente</option>
            </Form.Select>
          </Form.Group>

          <Form.Group className="mb-3" controlId="formPerfil">
            <Form.Label>Perfil</Form.Label>
            <Form.Select
              name="perfil" // Nome da propriedade no estado
              value={formData.perfil} // Valor do estado
              onChange={handleChange} // Função que atualiza o estado
              required
            >
              <option value="">Selecione o Perfil</option>
              <option value="0">Administrador</option>
              <option value="1">Usuário</option>
            </Form.Select>
          </Form.Group>

          <Button variant="primary" type="submit">
            {paciente ? "Salvar Alterações" : "Adicionar"}
          </Button>
        </Form>
      </Modal.Body>
    </Modal>
  );
};

export default AddPacienteModal;
