import {Navigate, Outlet} from "react-router-dom";
import { useAuthValue } from "../context/AuthContext";

export default function PrivateRoute() {
    const {user, loading} = useAuthValue();

    if (loading) return <div>Carregando...</div>;

    return user ? <Outlet/> : <Navigate to="/login"/>
}