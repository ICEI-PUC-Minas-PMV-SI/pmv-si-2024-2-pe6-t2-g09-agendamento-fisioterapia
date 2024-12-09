import { Link, NavLink } from "react-router-dom";
import { Navbar, Nav, Container, Button, Modal, Form } from "react-bootstrap";
import { useAuthValue } from "../context/AuthContext";
// padrao para importar arquivo css
import styles from "./Navbar.module.css";

const Navbarr = () => {
  const { user, logout } = useAuthValue();

  return (
    <Navbar className={styles.navbar}>
      <NavLink className={styles.brand} to="/">
        Agenda <span>Fisio</span>
      </NavLink>
      <ul className={styles.links_list}>
        {user && (
          <>
            <li>
              <NavLink
                to="/dashboard"
                className={({ isActive }) => (isActive ? styles.active : "")}
              >
                Dashboard
              </NavLink>
            </li>
            <li>
              <NavLink
                to="/agendamentos"
                className={({ isActive }) => (isActive ? styles.active : "")}
              >
                Agendamentos
              </NavLink>
            </li>
            <li>
              <NavLink
                to="/pacientes"
                className={({ isActive }) => (isActive ? styles.active : "")}
              >
                Pacientes
              </NavLink>
            </li>
          </>
        )}

        <li>
          {user ? (
            <NavLink
              to="/login"
              className={({ isActive }) => (isActive ? styles.active : "")}
            >
              <Button onClick={logout}>Sair</Button>
            </NavLink>
          ) : (
            <NavLink
              to="/login"
              className={({ isActive }) => (isActive ? styles.active : "")}
            >
              Login
            </NavLink>
          )}
        </li>
      </ul>
    </Navbar>
  );
};

export default Navbarr;
