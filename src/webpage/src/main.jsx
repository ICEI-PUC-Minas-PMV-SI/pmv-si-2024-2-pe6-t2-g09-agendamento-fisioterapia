import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import App from "./App.jsx";
import "./index.css";
import "bootstrap/dist/css/bootstrap.min.css";
import "mdb-react-ui-kit/dist/css/mdb.min.css";
import "@fortawesome/fontawesome-free/css/all.min.css";

import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { AuthProvider } from "./context/AuthContext.jsx";

import Home from "./pages/home/Home.jsx";
import Login from "./pages/login/Login.jsx";
import Register from "./pages/register/Register.jsx";
import Dashboard from "./pages/dashboard/Dashboard.jsx";
import Agendamentos from "./pages/agendamentos/Agendamentos.jsx";
import AgendamentoDetails from "./pages/agendamentos/AgendamentoDetails.jsx";
import Pacientes from "./pages/pacientes/Pacientes.jsx";
import PacienteDetails from "./pages/pacientes/PacienteDetails.jsx";
import ErrorPage from "./pages/errors/ErrorPage.jsx";
import PrivateRoute from "./components/PrivateRoute.jsx";

const router = createBrowserRouter([
  {
    path: "/",
    element: <App />,
    errorElement: <ErrorPage />,
    children: [
      {
        path: "/",
        element: <Home />,
      },
      {
        path: "login",
        element: <Login />,
      },
      {
        path: "register",
        element: <Register />,
      },
      {
        path: "/dashboard",
        element: <PrivateRoute />, // Protege a rota
        children: [{ path: "/dashboard", element: <Dashboard /> }],
      },
      {
        path: "/agendamentos",
        element: <PrivateRoute />, // Protege a rota
        children: [{ path: "/agendamentos", element: <Agendamentos /> }],
      },
      {
        path: "/agendamento/:id",
        element: <AgendamentoDetails />,
      },
      {
        path: "/pacientes",
        element: <PrivateRoute />, // Protege a rota
        children: [{ path: "/pacientes", element: <Pacientes /> }],
      },
      {
        path: "/paciente/:id",
        element: <PacienteDetails />,
      },
    ],
  },
]);

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <AuthProvider>
      <RouterProvider router={router} />
    </AuthProvider>
  </StrictMode>
);
