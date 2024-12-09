import {
  MDBFooter,
  MDBContainer,
  MDBRow,
  MDBCol,
  MDBIcon,
} from "mdb-react-ui-kit";
import { useAuthValue } from "../context/AuthContext";

import styles from "./Footer.module.css";
const Footer = () => {

  const { user } = useAuthValue();

  if (user) return null;
  return (

    <MDBFooter
      bgColor="light"
      className={`text-center text-lg-start text-muted ${styles.footer}`}
    >
      <div className={styles.footer_container}>
        <div className={styles.footer_content}>
          <section className="d-flex justify-content-between p-4 border-bottom">
            <div className="me-5 d-none d-lg-block">
              <span>Conecte-se conosco nas redes sociais:</span>
            </div>

            <div>
              <a href="" className="me-4 text-reset">
                <MDBIcon fab icon="facebook-f" />
              </a>
              <a href="" className="me-4 text-reset">
                <MDBIcon fab icon="instagram" />
              </a>
              <a href="" className="me-4 text-reset">
                <MDBIcon fab icon="linkedin" />
              </a>
              <a href="" className="me-4 text-reset">
                <MDBIcon fab icon="whatsapp" />
              </a>
            </div>
          </section>

          <section className="">
            <MDBContainer className="text-center text-md-start mt-5">
              <MDBRow className="mt-3">
                <MDBCol md="3" lg="4" xl="" className="mx-auto mb-4">
                  <h6 className="text-uppercase fw-bold mb-4">
                    <MDBIcon icon="gem" className="me-3" />
                    Clínica de Fisioterapia
                  </h6>
                  <p>
                    Nossa missão é promover saúde e bem-estar através de
                    tratamentos de fisioterapia especializados. Conte conosco
                    para cuidar de sua reabilitação e qualidade de vida.
                  </p>
                </MDBCol>

                <MDBCol md="2" lg="2" xl="2" className="mx-auto mb-4">
                  <h6 className="text-uppercase fw-bold mb-4">Serviços</h6>
                  <p>
                    <a href="#!" className="text-reset">
                      Fisioterapia Ortopédica
                    </a>
                  </p>
                  <p>
                    <a href="#!" className="text-reset">
                      Fisioterapia Esportiva
                    </a>
                  </p>
                  <p>
                    <a href="#!" className="text-reset">
                      Reabilitação Postural
                    </a>
                  </p>
                  <p>
                    <a href="#!" className="text-reset">
                      Pilates
                    </a>
                  </p>
                </MDBCol>

                <MDBCol md="3" lg="2" xl="2" className="mx-auto mb-4">
                  <h6 className="text-uppercase fw-bold mb-4">Links úteis</h6>
                  <p>
                    <a href="#!" className="text-reset">
                      Agendar Consulta
                    </a>
                  </p>
                  <p>
                    <a href="#!" className="text-reset">
                      Planos e Preços
                    </a>
                  </p>
                  <p>
                    <a href="#!" className="text-reset">
                      Política de Privacidade
                    </a>
                  </p>
                  <p>
                    <a href="#!" className="text-reset">
                      Contato
                    </a>
                  </p>
                </MDBCol>

                <MDBCol md="4" lg="3" xl="3" className="mx-auto mb-md-0 mb-4">
                  <h6 className="text-uppercase fw-bold mb-4">Contato</h6>
                  <p>
                    <MDBIcon icon="home" className="me-2" />
                    Rua maranhão, 330, Santa Efigenia Belo Horizonte
                  </p>
                  <p>
                    <MDBIcon icon="envelope" className="me-3" />
                    contato@agendafisio.com.br
                  </p>
                  <p>
                    <MDBIcon icon="mobile-alt" className="me-3" /> +55 31 99663-5156
                  </p>
                </MDBCol>
              </MDBRow>
            </MDBContainer>
          </section>
        </div>
      </div>

      <div
        className="text-center p-4"
        style={{ backgroundColor: "rgba(0, 0, 0, 0.05)" }}
      >
        © {new Date().getFullYear()} Copyright:
        <a
          className="text-reset fw-bold"
          href="https://www.fisioterapiasaude.com.br/"
        >
          Agenda fisio
        </a>
      </div>
    </MDBFooter>
  )

};

export default Footer;
