import { useState, useEffect } from "react";
import { Modal, Button, Form } from "react-bootstrap";
import { format } from "date-fns";

const AddAgendamentoModal = ({
  show,
  handleClose,
  handleAddAgendamento,
  agendamento,
}) => {
  // Estado inicial com dados vazios
  const [formData, setFormData] = useState({
    nomePaciente: "",
    email: "",
    emailMedicoResponsavel: "",
    data: "",
    horario: "",
  });

  

  // Preenche o formulário com os dados do agendamento para edição
  useEffect(() => {
    if (agendamento) {
      const [dataParte, horarioParte] = agendamento.dataAtendimento.split("T");
      const [ano, mes, dia] = dataParte.split("-");
      const [hora, minuto] = horarioParte.split(":");
      setFormData({
        nomePaciente: agendamento.nomePaciente,
        email: agendamento.email,
        emailMedicoResponsavel: agendamento.emailMedicoResponsavel,
        data: `${ano}-${mes}-${dia}`,
        horario: `${hora}:${minuto}`,
      
      });
    } else {
      // Reseta o formulário se não houver agendamento
      setFormData({
        nomePaciente: "",
        email: "",
        emailMedicoResponsavel: "",
        data: "",
        horario: "",
      });
    }
  }, [agendamento]);



  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

 // Função para combinar data e horário no formato desejado
const formatarDataAtendimento = (data, horario) => {
  const [ano, mes, dia] = data.split("-"); // 'yyyy-MM-dd'
  const [horas, minutos] = horario.split(":"); // 'HH:mm'
  return `${dia}-${mes}-${ano}-${horas}-${minutos}`; // 'dd-MM-yyyy-HH-mm'
};

const handleSubmit = (e) => {
  e.preventDefault();

  // Combina data e horário no formato desejado
  const dataAtendimento = formatarDataAtendimento(
    formData.data,
    formData.horario
  );

  // Cria uma cópia de formData sem 'data' e 'horario'
  const { data, horario, ...formDataSemDataHorario } = formData;

  // Cria o objeto agendamento com 'dataAtendimento' e os demais dados
  const agendamentoFinal = {
    ...formDataSemDataHorario,
    dataAtendimento,
  };

  // Passa o objeto atualizado para a função de adicionar/editar agendamento
  handleAddAgendamento(agendamentoFinal);
  handleClose(); // Fecha o modal
};


  return (
    <Modal show={show} onHide={handleClose}>
      <Modal.Header closeButton>
        <Modal.Title>
          {agendamento ? "Editar Agendamento" : "Adicionar Agendamento"}
        </Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form onSubmit={handleSubmit}>
          <Form.Group className="mb-3" controlId="formNome">
            <Form.Label>Nome do Paciente</Form.Label>
            <Form.Control
              type="text"
              name="nomePaciente"
              value={formData.nomePaciente}
              onChange={handleChange}
              placeholder="Digite o nome do paciente"
              required
              disabled={!!agendamento}
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="formData">
            <Form.Label>Data do Atendimento</Form.Label>
            <Form.Control
              type="date"
              name="data"
              value={formData.data}
              onChange={handleChange}
              required
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="formHorario">
            <Form.Label>Horário do Atendimento</Form.Label>
            <Form.Control
              type="time"
              name="horario"
              value={formData.horario}
              onChange={handleChange}
              required
              disabled={!!agendamento}
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="formEmail">
            <Form.Label>Email do Paciente</Form.Label>
            <Form.Control
              type="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              placeholder="Digite o email do paciente"
              required
              disabled={!!agendamento}
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="formEmailMedico">
            <Form.Label>Email do Médico Responsável</Form.Label>
            <Form.Control
              type="email"
              name="emailMedicoResponsavel"
              value={formData.emailMedicoResponsavel}
              onChange={handleChange}
              placeholder="Digite o email do médico responsável"
              required
              disabled={!!agendamento}
            />
          </Form.Group>

          <Button variant="primary" type="submit">
            {agendamento ? "Salvar Alterações" : "Adicionar"}
          </Button>
        </Form>
      </Modal.Body>
    </Modal>
  );
};

export default AddAgendamentoModal;
