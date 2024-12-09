// Login.jsx
import { useState } from "react";
import { Container, Card, Button, Form } from "react-bootstrap";
import { Link, useNavigate } from "react-router-dom"; // Importação do useNavigate
import { useAuthValue } from "../../context/AuthContext"; 
import styles from "./Login.module.css"; 

export default function Login() {
  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [error, setError] = useState("");
  const { login } = useAuthValue(); 
  const navigate = useNavigate(); // Agora é usado aqui

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (email === "" || senha === "") {
      setError("Por favor, preencha todos os campos.");
      return;
    }

    try {
      await login({ email, password: senha });
      navigate("/dashboard"); // Redireciona após login bem-sucedido
    } catch (error) {
      setError("Erro ao fazer login. Verifique suas credenciais.");
    }
  };

  return (
    <Container className={`${styles.login_container} mt-4`}>
      <Card className={styles.login_card}>
        <Card.Body>
          <Card.Title className="login-title">Bem-vindo de Volta!</Card.Title>
          {error && <p className="text-danger login-error">{error}</p>}
          <Form onSubmit={handleSubmit}>
            <Form.Group controlId="formEmail">
              <Form.Label className="login-label">Email</Form.Label>
              <Form.Control
                type="email"
                placeholder="Digite seu email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                className="login-input"
              />
            </Form.Group>
            <Form.Group controlId="formSenha">
              <Form.Label className="login-label">Senha</Form.Label>
              <Form.Control
                type="password"
                placeholder="Digite sua senha"
                value={senha}
                onChange={(e) => setSenha(e.target.value)}
                required
                className="login-input"
              />
            </Form.Group>
            <Button
              variant="primary"
              type="submit"
              className={`"login-button" ${styles.login_button}`}
            >
              Entrar
            </Button>
          </Form>
          <p className="mt-2">
            Não tem uma conta? <Link to="/register">Registre-se aqui</Link>
          </p>
        </Card.Body>
      </Card>
    </Container>
  );
}
